From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 23 Jul 2019 22:59:20 +0900
Subject: [PATCH v2 3/3] nvme: don't pass cap to nvme_disable_ctrl
In-Reply-To: <20190723000654.6448-4-sagi@grimberg.me>
References: <20190723000654.6448-1-sagi@grimberg.me>
 <20190723000654.6448-4-sagi@grimberg.me>
Message-ID: <20190723135920.GF7148@minwoo-desktop>

On 19-07-22 17:06:54, Sagi Grimberg wrote:
> All seem to call it with ctrl->cap so no need to pass it
> at all.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
