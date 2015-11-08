From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 8 Nov 2015 18:39:57 +0200
Subject: [PATCH 2/8] nvme: move enable/disable/shutdown_ctrl to common code
In-Reply-To: <1446915643-21175-3-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1446915643-21175-3-git-send-email-hch@lst.de>
Message-ID: <563F7ADD.9010502@dev.mellanox.co.il>

Maybe it'd be better to split this to two patches.
1. pass ctrl to enable/disable/shutdown_ctrl
2. move enable/disable/shutdown_ctrl to common code

Other then that looks good.
