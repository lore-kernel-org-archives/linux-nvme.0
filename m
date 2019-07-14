From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jul 2019 17:09:28 +0900
Subject: [PATCH v2 2/3] nvme: enable aen also for discovery controllers
In-Reply-To: <20190712180211.26333-3-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-3-sagi@grimberg.me>
Message-ID: <20190714080928.GC2993@minwoo-desktop>

On 19-07-12 11:02:10, Sagi Grimberg wrote:
> If the controller supports discovery log page change events,
> we want to enable it on the host side as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks,
