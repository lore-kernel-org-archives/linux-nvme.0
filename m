From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 20 Sep 2017 12:32:09 +0300
Subject: [REPOST][PATCH v3] nvmet: implement valid sqhd values in
 completions
In-Reply-To: <20170918160829.895-1-jsmart2021@gmail.com>
References: <20170918160829.895-1-jsmart2021@gmail.com>
Message-ID: <8d14cd31-5cfb-1f15-727f-2c1950bf2ddf@mellanox.com>



On 9/18/2017 7:08 PM, James Smart wrote:
> To support sqhd, for initiators that are following the spec and
> paying attention to sqhd vs their sqtail values:
> - add sqhd to struct nvmet_sq
> - initialize sqhd to 0 in nvmet_sq_setup
> - rather than propagate the 0's-based qsize value from the connect message
>    which requires a +1 in every sqhd update, and as nothing else references
>    it, convert to 1's-based value in nvmt_sq/cq_setup() calls.
> - validate connect message sqsize being non-zero per spec.
> - updated assign sqhd for every completion that goes back.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>    v2: assignment corrected for endianness
> v3:
>    removed if test on req->sq that is unneeded
> 
>    repost fixed the "comment" indicator in the patch header


Looks good thanks,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
