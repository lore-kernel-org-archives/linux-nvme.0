From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  4 Sep 2018 12:32:52 -0700
Subject: [PATCH V2 blktests 00/12] nvme: new testcases for NVMeOF
Message-ID: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>

Hi,

This adds Dataset Management, write-zeroes, smart-log and several
small command specitic new testcases for block device and file backed
namespace when NVMeOF target is configured with loop mode
(nvme-loop.ko).

Please note that I'm leaving out "018" for Hannes's ANA realted testcase :-
http://lists.infradead.org/pipermail/linux-nvme/2018-August/019553.html.

Regards,
Chaitanya

Changes since V1:-

1. Addition of new testcases.
2. Test the code on 4.19.0-rc2.
# git log -12 --oneline
bcdac08 (HEAD -> master) nvme: add NVMeOF reset test for file-ns
4455a3a nvme: add NVMeOF list test for file-ns
0cb2c82 nvme: add NVMeOF list-subsys test for file-ns
249883d nvme: add NVMeOF ns-rescan test for file-ns
c8f1876 nvme: add NVMeOF ns-desc test for file-ns
5972074 nvme: add NVMeOF effects-log test for file-ns
d5b2ef4 nvme: add NVMeOF smart-log test for file-ns
5bd0bee nvme: add NVMeOF smart-log test for bdev-ns
c749e08 nvme: add NVMeOF write-zeroes test for file-ns
3ef94d3 nvme: add NVMeOF write-zeroes test for bdev-ns
140833b nvme: add NVMeOF DSM discard test for file-ns
cb52922 nvme: add NVMeOF DSM discard test for bdev-ns

nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.818s  ...  0.832s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.767s  ...  0.766s
nvme/021 (test NVMe write-zeroes command on NVMeOF block-device ns) [passed]
    runtime  0.819s  ...  0.819s
nvme/022 (test NVMe write-zeroes command on NVMeOF file-backed ns) [passed]
    runtime  0.782s  ...  0.770s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.815s  ...  0.823s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  0.776s  ...  0.773s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  0.783s  ...  0.753s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  0.774s  ...  0.766s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  0.783s  ...  0.784s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  0.772s  ...  0.775s
nvme/029 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  0.768s  ...  0.760s
nvme/030 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.026s  ...  1.003s

Chaitanya Kulkarni (12):
  nvme: add NVMeOF DSM discard test for bdev-ns
  nvme: add NVMeOF DSM discard test for file-ns
  nvme: add NVMeOF write-zeroes test for bdev-ns
  nvme: add NVMeOF write-zeroes test for file-ns
  nvme: add NVMeOF smart-log test for bdev-ns
  nvme: add NVMeOF smart-log test for file-ns
  nvme: add NVMeOF effects-log test for file-ns
  nvme: add NVMeOF ns-desc test for file-ns
  nvme: add NVMeOF ns-rescan test for file-ns
  nvme: add NVMeOF list-subsys test for file-ns
  nvme: add NVMeOF list test for file-ns
  nvme: add NVMeOF reset test for file-ns

 tests/nvme/019     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/019.out |  6 ++++
 tests/nvme/020     | 72 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/020.out |  6 ++++
 tests/nvme/021     | 78 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/021.out |  6 ++++
 tests/nvme/022     | 72 ++++++++++++++++++++++++++++++++++++++++
 tests/nvme/022.out |  6 ++++
 tests/nvme/023     | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/023.out |  5 +++
 tests/nvme/024     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/024.out |  5 +++
 tests/nvme/025     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/025.out |  5 +++
 tests/nvme/026     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/026.out |  5 +++
 tests/nvme/027     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/027.out |  5 +++
 tests/nvme/028     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/028.out |  5 +++
 tests/nvme/029     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/029.out |  5 +++
 tests/nvme/030     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/030.out |  5 +++
 24 files changed, 985 insertions(+)
 create mode 100755 tests/nvme/019
 create mode 100644 tests/nvme/019.out
 create mode 100755 tests/nvme/020
 create mode 100644 tests/nvme/020.out
 create mode 100755 tests/nvme/021
 create mode 100644 tests/nvme/021.out
 create mode 100755 tests/nvme/022
 create mode 100644 tests/nvme/022.out
 create mode 100755 tests/nvme/023
 create mode 100644 tests/nvme/023.out
 create mode 100755 tests/nvme/024
 create mode 100644 tests/nvme/024.out
 create mode 100755 tests/nvme/025
 create mode 100644 tests/nvme/025.out
 create mode 100755 tests/nvme/026
 create mode 100644 tests/nvme/026.out
 create mode 100755 tests/nvme/027
 create mode 100644 tests/nvme/027.out
 create mode 100755 tests/nvme/028
 create mode 100644 tests/nvme/028.out
 create mode 100755 tests/nvme/029
 create mode 100644 tests/nvme/029.out
 create mode 100755 tests/nvme/030
 create mode 100644 tests/nvme/030.out

-- 
2.17.0
