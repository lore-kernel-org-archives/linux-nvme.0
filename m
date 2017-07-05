From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jul 2017 01:06:21 +0200
Subject: [PATCH v3 5/8] nvme: kick requeue list when requeueing a
 request instead of when starting the queues
In-Reply-To: <1499274037-17438-6-git-send-email-sagi@grimberg.me>
References: <1499274037-17438-1-git-send-email-sagi@grimberg.me>
 <1499274037-17438-6-git-send-email-sagi@grimberg.me>
Message-ID: <20170705230621.GA12043@lst.de>

I wonder if we should simply always kick the list and remove the
parameter and blk_mq_kick_requeue_list.  It seems like this split
has caused a lot more harm then good, and the other drivers using
it that way are probably having issues as well.
