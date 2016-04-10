From: hch@lst.de (Christoph Hellwig)
Date: Sun, 10 Apr 2016 16:59:30 +0200
Subject: [PATCH] nvme/host: Add missing blk_integrity tag_size + flags
 assignments
In-Reply-To: <1460171082-7212-1-git-send-email-nab@daterainc.com>
References: <1460171082-7212-1-git-send-email-nab@daterainc.com>
Message-ID: <20160410145930.GA21909@lst.de>

Does NVMe really force ATO=1?  Sorry, didn't have much time to spend
with that part of the spec.
