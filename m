From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 20 Jul 2019 17:00:10 +0900
Subject: [PATCH 3/4] nvme: don't pass cap to nvme_disable_ctrl
In-Reply-To: <20190719194546.24229-4-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
 <20190719194546.24229-4-sagi@grimberg.me>
Message-ID: <20190720080010.GD22395@minwoo-desktop>

On 19-07-19 12:45:45, Sagi Grimberg wrote:
> All seem to call it with ctrl->cap so no need to pass it
> at all.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
