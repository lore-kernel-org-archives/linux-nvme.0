From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 4 Aug 2019 17:06:53 +0900
Subject: [PATCH rfc v2 3/6] nvme: make nvme_identify_ns propagate errors
 back
In-Reply-To: <20190803024955.29508-4-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-4-sagi@grimberg.me>
Message-ID: <20190804080653.GC14486@minwoo-desktop>

On 19-08-02 19:49:52, Sagi Grimberg wrote:
> right now callers of nvme_identify_ns only know that
> it failed, but don't know why. Make nvme_identify_ns propagate
> the error back (like nvme_identify_ctrl).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Reviewd-by: Minwoo Im <minwoo.im.dev at gmail.com>
