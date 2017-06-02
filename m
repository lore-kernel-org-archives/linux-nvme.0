From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 2 Jun 2017 15:18:17 +0800
Subject: [PATCH 0/2]nvme-cli: id-ctrl supports NVMe 1.3 spec
Message-ID: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT, MXTMT, SANICAP
into the idenfity controller data structure. The KAS field is included in the previous 
NVMe 1.2.1 spec, but not itemized in the nvme-cli.Those two patch add support to show 
those fileds in the nvme id-ctrl command.



Guan Junxiong (2):
  nvme-cli: add fields into identify controller data structure
  nvme-cli: show more fields for id-ctrl

 linux/nvme.h | 10 ++++++++--
 nvme-print.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.11.1
