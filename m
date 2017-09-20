From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Sep 2017 19:55:31 +0200
Subject: [PATCH 2/2] nvme-rdma: give up reconnect if state change fails
In-Reply-To: <1505905573-25371-2-git-send-email-sagi@grimberg.me>
References: <1505905573-25371-1-git-send-email-sagi@grimberg.me>
 <1505905573-25371-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170920175531.GB18161@lst.de>

Looks ok, but I'd also prefer the additional WARN_ON.
