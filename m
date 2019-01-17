From: james.smart@broadcom.com (James Smart)
Date: Thu, 17 Jan 2019 09:17:27 -0800
Subject: [PATCH 2/2] lpfc: nvmet: avoid hang / use-after-free when
 destroying targetport
In-Reply-To: <20190117161445.25671-3-emilne@redhat.com>
References: <20190117161445.25671-1-emilne@redhat.com>
 <20190117161445.25671-3-emilne@redhat.com>
Message-ID: <3e508a2a-5756-1a6a-26a2-a80c53f17f6b@broadcom.com>



On 1/17/2019 8:14 AM, Ewan D. Milne wrote:
> We cannot wait on a completion object in the lpfc_nvme_targetport structure
> in the _destroy_targetport() code path because the NVMe/fc transport will
> free that structure immediately after the .targetport_delete() callback.
> This results in a use-after-free, and a hang if slub_debug=FZPU is enabled.
>
> Fix this by putting the completion on the stack.
>
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 8 +++++---
>   drivers/scsi/lpfc/lpfc_nvmet.h | 2 +-
>   2 files changed, 6 insertions(+), 4 deletions(-)
>
>

Reviewed-by:?? James Smart? <james.smart at broadcom.com>

Thank you Ewan

-- james
