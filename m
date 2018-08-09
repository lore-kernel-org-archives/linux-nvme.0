From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 9 Aug 2018 16:59:39 +0000
Subject: [PATCH] Fix typo in nvme_identify_ns_descs
In-Reply-To: <20180809161924.GA13201@machine1>
References: <20180809161924.GA13201@machine1>
Message-ID: <C8C6F382-64D2-4918-8EDE-C1FB2ACB44E6@wdc.com>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 8/9/18, 9:19 AM, "Linux-nvme on behalf of Milan P. Gandhi" <linux-nvme-bounces@lists.infradead.org on behalf of mgandhi@redhat.com> wrote:

    Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
    ---
     drivers/nvme/host/core.c | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index bf65501e6ed6..21d5d597b328 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -959,7 +959,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
     			uuid_copy(&ids->uuid, data + pos + sizeof(*cur));
     			break;
     		default:
    -			/* Skip unnkown types */
    +			/* Skip unknown types */
     			len = cur->nidl;
     			break;
     		}
    -- 
    2.14.3
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
