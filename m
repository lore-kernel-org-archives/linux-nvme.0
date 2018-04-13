From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:01:37 +0200
Subject: [PATCH v1 2/5] nvme: remove association between ctrl and
 keep-alive
In-Reply-To: <1523380689-17151-3-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
 <1523380689-17151-3-git-send-email-maxg@mellanox.com>
Message-ID: <20180413170137.GB23178@lst.de>

On Tue, Apr 10, 2018@08:18:06PM +0300, Max Gurtovoy wrote:
> Keep-alive mechanism is an admin queue property and
> should be activated/deactivated during admin queue
> creation/destruction.

On its own this patch looks bogus.  You later fix this up but the move
really needs to be in one patch instead of splitting it in parts that
make things unusable inbetween.

Also please use your 74 or whatever chars available for the commit log,
please.
