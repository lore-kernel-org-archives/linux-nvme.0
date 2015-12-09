From: keith.busch@intel.com (Keith Busch)
Date: Wed,  9 Dec 2015 11:42:55 -0700
Subject: [PATCHv2 0/2] NVMe namespace identification
Message-ID: <1449686577-6319-1-git-send-email-keith.busch@intel.com>

Here's version 2 exposing unique namespace identification to sysfs.

This is simpler thanks to feedback from Willy, Christoph, and Dan.

There are two identification attributes displayed in ASCII instead of
binary. Each method has its own file so parsers will know the format.

The first patch in the series adds a new print format since EUI-64
didn't have a specifier. It's essentially an extented MAC identifier,
so appending a specifier for the longer format to that.

I don't know who owns lib/vsprintf, so copying Greg & LKML.

Keith Busch (2):
  Print: Add print format for 8-byte EUI-64 type
  NVMe: Expose namespace identity attribute to sysfs

 Documentation/printk-formats.txt | 13 +++++++--
 drivers/nvme/host/core.c         | 60 ++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h         |  3 ++
 lib/vsprintf.c                   | 17 ++++++++----
 4 files changed, 83 insertions(+), 10 deletions(-)

-- 
2.6.2.307.g37023ba
