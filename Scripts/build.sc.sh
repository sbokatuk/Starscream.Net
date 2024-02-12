#!/bin/sh

# ./Scripts/build.sc.sh BUILD="1-beta1" VERSION="6.0.0" IOSVERSION="6.0.0" ANDROIDVERSION="6.0.0" MACVERSION="6.0.0"
for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

if [ -z "$VERSION" ]
then
echo "No target Argument for nuget version"
else
echo "$IOSVERSION" > Bindings/Starscream.Net.iOS/Readme.md
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$IOSVERSION.7/" Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-ios/<TargetFramework>net7.0-ios/" Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj
dotnet pack Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$IOSVERSION.8/" Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-ios/<TargetFramework>net8.0-ios/" Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj
dotnet pack Bindings/Starscream.Net.iOS/Starscream.Net.iOS.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
cd NugetPackages
rm -rf scios
unzip -n -q Starscream.Net.iOS.$IOSVERSION.7.nupkg -d scios
unzip -n -q Starscream.Net.iOS.$IOSVERSION.8.nupkg -d scios
rm Starscream.Net.iOS.$IOSVERSION.7.nupkg
rm Starscream.Net.iOS.$IOSVERSION.8.nupkg
cd ..
echo "ios part nugets generated"
echo "$MACVERSION" > Bindings/Starscream.Net.Mac/Readme.md
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$MACVERSION.7/" Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-maccatalyst/<TargetFramework>net7.0-maccatalyst/" Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj
dotnet pack Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$MACVERSION.8/" Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-maccatalyst/<TargetFramework>net8.0-maccatalyst/" Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj
dotnet pack Bindings/Starscream.Net.Mac/Starscream.Net.Mac.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
cd NugetPackages
rm -rf scmac
unzip -n -q Starscream.Net.Mac.$MACVERSION.7.nupkg -d scmac
unzip -n -q Starscream.Net.Mac.$MACVERSION.8.nupkg -d scmac
rm Starscream.Net.Mac.$MACVERSION.7.nupkg
rm Starscream.Net.Mac.$MACVERSION.8.nupkg
cd ..
echo "mac part nugets generated"
echo "$ANDROIDVERSION" > Bindings/Starscream.Net.Android/Readme.md
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$ANDROIDVERSION.7/" Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-android/<TargetFramework>net7.0-android/" Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj
dotnet pack Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
sed -E -i "" "s/<Version>([0-9]{1,}\.)+[0-9]{1,}/<Version>$ANDROIDVERSION.8/" Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj
sed -E -i "" "s/<TargetFramework>net([0-9]{1,}\.)+[0-9]{1,}-android/<TargetFramework>net8.0-android/" Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj
dotnet pack Bindings/Starscream.Net.Android/Starscream.Net.Android.csproj --output NugetPackages --force --verbosity quiet --property WarningLevel=0 /clp:ErrorsOnly
cd NugetPackages
rm -rf scandroid
unzip -n -q Starscream.Net.Android.$ANDROIDVERSION.7.nupkg -d scandroid
unzip -n -q Starscream.Net.Android.$ANDROIDVERSION.8.nupkg -d scandroid
rm Starscream.Net.Android.$ANDROIDVERSION.7.nupkg
rm Starscream.Net.Android.$ANDROIDVERSION.8.nupkg
cd ..
echo "android part nugets generated"
cd NugetPackages

cp -R scandroid/Readme.md scandroid/Readme.txt
cp -R scmac/Readme.md scmac/Readme.txt
cp -R scios/Readme.md scios/Readme.txt
cp -R sc/Readme.md sc/Readme.txt

# mkdir Voice/native
# mkdir Voice/native/lib
# mkdir Voice/native/lib/ios
# cp -R webrtc/lib/net8.0-android34.0/webrtc.aar webrtc/native/lib/android
# 
# rm webrtc/lib/net8.0-android34.0/webrtc.aar
# rm webrtc/lib/net7.0-android33.0/webrtc.aar 


sed -E -i "" "s/<version>([0-9]{1,}\.)+[0-9]{1,}/<version>$ANDROIDVERSION.$BUILD/" Starscream.Net.Android.nuspec
sed -E -i "" "s/<version>([0-9]{1,}\.)+[0-9]{1,}/<version>$IOSVERSION.$BUILD/" Starscream.Net.iOS.nuspec
sed -E -i "" "s/<version>([0-9]{1,}\.)+[0-9]{1,}/<version>$MACVERSION.$BUILD/" Starscream.Net.Mac.nuspec
sed -E -i "" "s/<version>([0-9]{1,}\.)+[0-9]{1,}/<version>$VERSION.$BUILD/" Starscream.Net.nuspec

nuget pack Starscream.Net.Android.nuspec
nuget pack Starscream.Net.iOS.nuspec
nuget pack Starscream.Net.Mac.nuspec
nuget pack Starscream.Net.nuspec

rm -rf scandroid
rm -rf scios
rm -rf scmac

# if  [ -z "$3" ]
# then
# echo "package ready"
# unzip -n -q OpenTok.Net.webrtc.Dependency.Android.$VERSION.$2.nupkg -d webrtc
# else 
# dotnet nuget push OpenTok.Net.webrtc.Dependency.Android.$VERSION.$2.nupkg --api-key $3 --source https://api.nuget.org/v3/index.json --timeout 3000000
# # rm OpenTok.Net.webrtc.Dependency.Android.$VERSION.$2.nupkg
# fi
# cd ..
fi