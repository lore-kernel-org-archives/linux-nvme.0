From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 21 Jun 2017 13:09:21 +0800
Subject: [PATCH 0/3] nvme-cli: supplement and fixup for smart-log
Message-ID: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 introduces new thermal management temperature related
fields into the smart log page. The first patch adds those fields
into smart-log command.

Besides, next two patches address some fixup for smart-log such as
adding temperatature sensor fields in json_smart_log and synchronizing
the documenation for smart-log with the implementation of output-format
option.


Guan Junxiong (3):
  nvme-cli: add thermal management fields for smart-log
  nvme-cli: add temperature sensor fields in json_smart_log
  nvme-cli: add output-format discription for smart-log documents

 Documentation/nvme-smart-log.1    |  8 ++++++++
 Documentation/nvme-smart-log.html | 12 ++++++++++++
 Documentation/nvme-smart-log.txt  |  5 +++++
 linux/nvme.h                      |  6 +++++-
 nvme-print.c                      | 24 ++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.11.1
