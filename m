From: osmithde@cisco.com (Oliver Smith-Denny)
Date: Tue, 12 Mar 2019 12:25:19 -0700
Subject: [PATCH 1/2] nvme-tcp: support C2HData with SUCCESS flag
In-Reply-To: <20190308234121.1347-2-sagi@grimberg.me>
References: <20190308234121.1347-1-sagi@grimberg.me>
 <20190308234121.1347-2-sagi@grimberg.me>
Message-ID: <fd0cdbf9-e7e8-3060-de62-a4fb0e2d5e63@cisco.com>

On 03/08/2019 03:41 PM, Sagi Grimberg wrote:
> A C2HData PDU with the SUCCESS flag set indicates that the I/O was
> completed by the controller successfully and means that a subsequent
> completion response capsule PDU will be ommitted.
> 
> If we see this flag, fisrt we check that LAST_PDU flag is set as well,
> and then we complete the request when the data transfer (and data digest
> verification if its on) is done.
> 
> While we're at it, reuse a bit of code with nvme_fail_request.
> 
> Suggested-by: Oliver Smith-Denny <osmithde at cisco.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)

Looks good! I don't see any issues.

Tested-and-Reviewed-by: Oliver Smith-Denny

Thanks Sagi!

Oliver
