# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

def rx_pods
	pod 'RxSwift',    '~> 4.3'
	pod 'RxCocoa',    '~> 4.3'
end

target 'Weather' do
	use_frameworks!
	rx_pods
	pod 'GooglePlaces'
	pod 'GooglePlacePicker'
	pod 'GoogleMaps'

  # Pods for Weather
end

target 'ForecastTodayView' do
	use_frameworks!
	rx_pods
end
