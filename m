From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Apr 2019 19:40:39 -0700
Subject: [PATCH 0/2] nvme: improve logging
Message-ID: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>

Hi,

These code changes are originally posted by Hannes Reinecke <hare at suse.com> :-
http://lists.infradead.org/pipermail/linux-nvme/2019-April/023336.html

I've added all the comments posted on this patch-series along with my signoff
to the patches. Please keep my sign off if Hannes is okay with it.

Regards,
-Chaitanya

Chaitanya Kulkarni (2):
  nvme: improve logging
  nvme-multipath: improve logging

 drivers/nvme/host/core.c      | 42 ++++++++++++++++++++++-------------
 drivers/nvme/host/multipath.c |  9 +++++++-
 2 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.17.0
