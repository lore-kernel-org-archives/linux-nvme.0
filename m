From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:03:58 -0700
Subject: [PATCH v6 1/7] nvme: fail cancelled commands with
 NVME_SC_HOST_PATH_ERROR
In-Reply-To: <20190813064304.7344-2-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-2-sagi@grimberg.me>
Message-ID: <b5d5c95b-c63d-a285-e9b8-836d240274f4@broadcom.com>



On 8/12/2019 11:42 PM, Sagi Grimberg wrote:
> NVME_SC_ABORT_REQ means that the request was aborted due to
> an abort command received. In our case, this is a transport
> cancellation, so host pathing error is much more appropriate.
>
> Also, convert NVME_SC_HOST_PATH_ERROR to BLK_STS_TRANSPORT for
> such that callers can understand that the status is a transport
> related error. This will be used by the ns scanning code to
> understand if it got an error from the controller or that the
> controller happens to be unreachable by the transport.
>
> Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
