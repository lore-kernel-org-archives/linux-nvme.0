From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Apr 2017 19:44:56 +0200
Subject: update ->init_request and ->exit_request prototypes
Message-ID: <20170427174501.18965-1-hch@lst.de>

Hi Jens,

this series (against for-4.12/post-merge) updates the blk-mq
->init_request and ->exit request methods to drop a now harmful
parameter, and update one to pass a little more information.  It
then cleans up the nvme drivers based on that.
