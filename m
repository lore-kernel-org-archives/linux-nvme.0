From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 20 Jul 2019 16:59:23 +0900
Subject: [PATCH 2/4] nvme: move sqsize setting to the core
In-Reply-To: <20190719194546.24229-3-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
 <20190719194546.24229-3-sagi@grimberg.me>
Message-ID: <20190720075923.GC22395@minwoo-desktop>

On 19-07-19 12:45:44, Sagi Grimberg wrote:
> nvme_init_identify reads the cap register right after, so
> no need to do that locally in the transport driver.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

If the first patch is good to be picked up, I'm fine with this patch.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
