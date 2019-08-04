From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 4 Aug 2019 16:56:30 +0900
Subject: [PATCH rfc v2 1/6] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
In-Reply-To: <20190803024955.29508-2-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-2-sagi@grimberg.me>
Message-ID: <20190804075630.GA14486@minwoo-desktop>

On 19-08-02 19:49:50, Sagi Grimberg wrote:
> NVME_SC_ABORT_REQ means that the request was aborted due to
> an abort command received. In our case, this is a transport
> cancellation, so host pathing error is much more appropriate.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
