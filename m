From: james.smart@broadcom.com (James Smart)
Date: Tue, 27 Nov 2018 09:07:52 -0800
Subject: [PATCH] nvme-fc: initialize nvme_req(rq)->ctrl after calling
 __nvme_fc_init_request()
In-Reply-To: <20181126170130.8591-1-emilne@redhat.com>
References: <20181126170130.8591-1-emilne@redhat.com>
Message-ID: <ac63d3c1-73ce-a96c-fa41-9191b26e96ab@broadcom.com>



On 11/26/2018 9:01 AM, Ewan D. Milne wrote:
> __nvme_fc_init_request() invokes memset() on the nvme_fcp_op_w_sgl structure, which
> NULLed-out the nvme_req(req)->ctrl field previously set by nvme_fc_init_request().
> This apparently was not referenced until commit faf4a44fff ("nvme: support traffic
> based keep-alive") which now results in a crash in nvme_complete_rq():
>
> ...
>
> Fixes: faf4a44fff ("nvme: support traffic based keep-alive")
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---
>

looks good. Thank Ewan.

-- james
