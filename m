From: hch@lst.de (Christoph Hellwig)
Date: Mon, 9 Nov 2015 11:12:37 +0100
Subject: [PATCH 2/8] nvme: move enable/disable/shutdown_ctrl to common code
In-Reply-To: <563F7ADD.9010502@dev.mellanox.co.il>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-3-git-send-email-hch@lst.de>
 <563F7ADD.9010502@dev.mellanox.co.il>
Message-ID: <20151109101237.GA29661@lst.de>

On Sun, Nov 08, 2015@06:39:57PM +0200, Sagi Grimberg wrote:
> Maybe it'd be better to split this to two patches.
> 1. pass ctrl to enable/disable/shutdown_ctrl
> 2. move enable/disable/shutdown_ctrl to common code
>
> Other then that looks good.

I haven't really done that for any of the previous split patches either
as it sees a bit confusing.
