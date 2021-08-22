mvn = Sys.iswindows() ? "mvn.cmd" : "mvn"
which = Sys.iswindows() ? "where" : "which"

try
    run(`$which $mvn`)
catch
    error("Cannot find maven. Is it installed?")
end

SPARK_VERSION = get(ENV, "BUILD_SPARK_VERSION", "3.1.1")
SCALA_VERSION = get(ENV, "BUILD_SCALA_VERSION", "2.12.11")
SCALA_BINARY_VERSION = match(r"^\d+\.\d+", SCALA_VERSION).match

cd(joinpath(dirname(@__DIR__), "jvm/sparkjl")) do
    run(`$mvn clean package -Dspark.version=$SPARK_VERSION -Dscala.version=$SCALA_VERSION -Dscala.binary.version=$SCALA_BINARY_VERSION`)
end
