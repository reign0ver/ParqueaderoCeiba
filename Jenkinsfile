node('Slave4_Mac') {

    stage('Checkout/Build/Test') {

        // Checkout files.
        checkout([
            $class: 'GitSCM',
            branches: [[name: 'master']],
            doGenerateSubmoduleConfigurations: false,
            extensions: [], submoduleCfg: [],
            userRemoteConfigs: [[
                name: 'github',
                url: 'https://github.com/reign0ver/ParqueaderoCeiba.git'
            ]]
        ])

        // Build and Test!
        sh 'xcodebuild -scheme Parqueadero -configuration Debug build test \
  -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max''

    }
}
