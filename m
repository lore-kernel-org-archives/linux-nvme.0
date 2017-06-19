From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 08:59:26 +0200
Subject: [PATCH v2 1/2] nvme-core: change commas to semicolons in
 nvme_get_log_page
In-Reply-To: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170619065926.GB12938@lst.de>

This looks ok, but I think it's just too much churn at the moment.
We already have one patch that moves it to scsi.c as part of the
fw activation without reset patchset, and we if the scsi emulation
removal goes in it should just go away entirely..
