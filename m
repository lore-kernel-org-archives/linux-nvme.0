From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Thu, 13 Jul 2017 10:54:38 -0700
Subject: nvme : add Scatter-Gather List (SGL) support in NVMe driver. 
Message-ID: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>

Hi,

	Following patch adds the SGL support in the NVMe driver.
	We observed approximately 5% performance improvement in the
	IOPs, bandwidth, and latency as block size gets larger ( >= 32k).

	In the current implementation, we add "sgl_threshold" module parameter to decide
	whether to use SGL or PRP for IO requests, we set the default value for sgl_threshold to 32k.
	This value is exported and configurable via sysfs.

Regards,
-Chaitanya


[PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe driver.
