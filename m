From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Sep 2015 09:07:22 +0200
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
In-Reply-To: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20150929070722.GA15110@lst.de>

Hi Ming,

from a quick gance this looks very useful.  Please split the callback
into two instead of overloading them with the bool mapped parameter.

Please keep Akinobu Mita in the loop, as this should go on top of his blk-mq
fixes.
