From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 4 Aug 2019 16:57:58 +0900
Subject: [PATCH rfc v2 2/6] nvme: return nvme_error_status for sync
 commands failure
In-Reply-To: <20190803024955.29508-3-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-3-sagi@grimberg.me>
Message-ID: <20190804075758.GB14486@minwoo-desktop>

Hi Sagi,

On 19-08-02 19:49:51, Sagi Grimberg wrote:
> callers should not rely on raw nvme status, blk_status_t
> is more appropriate.

May I ask why caller should not rely on the nvme status?

Thanks!
