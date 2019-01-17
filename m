From: james.smart@broadcom.com (James Smart)
Date: Thu, 17 Jan 2019 09:17:17 -0800
Subject: [PATCH 1/2] lpfc: nvme: avoid hang / use-after-free when
 destroying localport
In-Reply-To: <20190117161445.25671-2-emilne@redhat.com>
References: <20190117161445.25671-1-emilne@redhat.com>
 <20190117161445.25671-2-emilne@redhat.com>
Message-ID: <16ded540-5ab8-eb83-6f56-d5b36f5073c6@broadcom.com>



On 1/17/2019 8:14 AM, Ewan D. Milne wrote:
> We cannot wait on a completion object in the lpfc_nvme_lport structure
> in the _destroy_localport() code path because the NVMe/fc transport will
> free that structure immediately after the .localport_delete() callback.
> This results in a use-after-free, and a hang if slub_debug=FZPU is enabled.
>
> Fix this by putting the completion on the stack.
>
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvme.c | 16 +++++++++-------
>   drivers/scsi/lpfc/lpfc_nvme.h |  2 +-
>   2 files changed, 10 insertions(+), 8 deletions(-)
>
>

Reviewed-by:?? James Smart? <james.smart at broadcom.com>

Thank you Ewan

-- james
