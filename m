From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 25 Mar 2019 18:07:06 +0800
Subject: [PATCH 0/2] nvme: target: build bvec from sg directly
Message-ID: <20190325100708.24172-1-ming.lei@redhat.com>

Hi,

The 1st patch fixes nvmet_file_init_bvec() for building bvec from
sg list.

The 2nd patch converts to build bvec from sg directly, given multi-page
bvec is ready.


Ming Lei (2):
  nvme: target: fix nvmet_file_init_bvec()
  nvme: target: build bvec from sg directly

 drivers/nvme/target/io-cmd-file.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


-- 
2.9.5
