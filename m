From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Wed, 7 Dec 2016 12:09:40 -0700
Subject: [PATCH] nvmet: fix KATO offset in Set Features
In-Reply-To: <20161207183947.128897-1-daniel.verkamp@intel.com>
References: <20161207183947.128897-1-daniel.verkamp@intel.com>
Message-ID: <138d5098-5d12-9a06-66c4-14f53770b0ba@intel.com>

On 12/07/2016 11:39 AM, Daniel Verkamp wrote:
> The Set Features implementation for Keep Alive Timer was using the wrong
> structure when retrieving the KATO value; it was treating the Set
> Features command as a Property Set command.
> 
> The NVMe spec defines the Keep Alive Timer feature as having one input
> in CDW11 (4 bytes at offset 44 in the command) whereas the code was
> reading 8 bytes at offset 48.
> 
> Since the Linux NVMe over Fabrics host never sets this feature, this
> code has presumably never been tested.
> 
> Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 6fe4c48..bdae9ef 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -391,8 +391,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
>  			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
>  		break;
>  	case NVME_FEAT_KATO:
> -		val = le64_to_cpu(req->cmd->prop_set.value);
> -		val32 = val & 0xffff;
> +		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
>  		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
>  		nvmet_set_result(req, req->sq->ctrl->kato);
>  		break;
> 

I just noticed that this makes val unused, introducing a warning.
I'll fix that on the next version.

However, I also see that this Set Features is actually sending back
the KATO value in the result (completion Dword 0).  Returning the
actually chosen (rounded) value from Set Features would make sense
to me, but it's not what the spec actually says - it only defines
Dword 0 of the completion for Get Features, not Set Features.

If we do want to return the KATO value, it should presumably be the
value in milliseconds, not seconds (currently Get Features returns
ctrl->kato * 1000 and Set Features returns just ctrl->kato).

Should I remove the nvmet_set_result() or fix it to at least return
the correct units?

Thanks,
-- Daniel
