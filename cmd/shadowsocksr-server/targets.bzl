load("//release/bazel:build.bzl", "foreign_go_binary")
load("//release/bazel:gpg.bzl", "gpg_sign")

def gen_targets(matrix):
  pkg = "github.com/ProxyPanel/VNet-SSR/cmd/shadowsocksr-server"
  output = "vnet"

  for (os, arch) in matrix:
    bin_name = "vnet_" + os + "_" + arch
    foreign_go_binary(
      name = bin_name,
      pkg = pkg,
      output = output,
      os = os,
      arch = arch,
    )

    gpg_sign(
      name = bin_name + "_sig",
      base = ":" + bin_name,
    )

    if os in ["windows"]:
      bin_name = "vnet_" + os + "_" + arch + "_nowindow"
      foreign_go_binary(
        name = bin_name,
        pkg = pkg,
        output = "w" + output,
        os = os,
        arch = arch,
        ld = "-H windowsgui",
      )

      gpg_sign(
        name = bin_name + "_sig",
        base = ":" + bin_name,
      )

    if arch in ["mips", "mipsle"]:
      bin_name = "vnet_" + os + "_" + arch + "_softfloat"
      foreign_go_binary(
        name = bin_name,
        pkg = pkg,
        output = output+"_softfloat",
        os = os,
        arch = arch,
        mips = "softfloat",
      )

      gpg_sign(
        name = bin_name + "_sig",
        base = ":" + bin_name,
      )
    
    if arch in ["arm"]:
      bin_name = "vnet_" + os + "_" + arch + "_armv7"
      foreign_go_binary(
        name = bin_name,
        pkg = pkg,
        output = output+"_armv7",
        os = os,
        arch = arch,
        arm = "7",
      )

      gpg_sign(
        name = bin_name + "_sig",
        base = ":" + bin_name,
      )

      bin_name = "vnet_" + os + "_" + arch + "_armv6"
      foreign_go_binary(
        name = bin_name,
        pkg = pkg,
        output = output+"_armv6",
        os = os,
        arch = arch,
        arm = "6",
      )

      gpg_sign(
        name = bin_name + "_sig",
        base = ":" + bin_name,
      )
