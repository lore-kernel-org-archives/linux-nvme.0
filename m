From: kbusch@kernel.org (Keith Busch)
Date: Wed, 7 Aug 2019 08:47:25 -0600
Subject: [PATCHv2] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <20190807071208.101882-1-hare@suse.de>
References: <20190807071208.101882-1-hare@suse.de>
Message-ID: <20190807144725.GB25621@localhost.localdomain>

On Wed, Aug 07, 2019@12:12:08AM -0700, Hannes Reinecke wrote:
> If the DNR bit is set we should not retry the command, even if
> the standard status evaluation indicates so.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cc09b81fc7f4..2c6c9460adea 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -274,6 +274,10 @@ void nvme_complete_rq(struct request *req)
>  			return;
>  		}
>  
> +		if (nvme_req(req)->status & NVME_SC_DNR) {
> +			blk_mq_end_request(req, BLK_STS_TARGET);
> +			return;
> +		}
>  		if (!blk_queue_dying(req->q)) {
>  			nvme_retry_req(req);
>  			return;
> -- 

Ah, that's unreachable code since it wouldn't get past the
nvme_req_needs_retry() check for this branch. We'd need to reshuffle
this a bit, but at least it gets all the error handling in a single
case. Something like this:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5ca937..50522267247d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -267,17 +267,23 @@ void nvme_complete_rq(struct request *req)
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
-		    blk_path_error(status)) {
-			nvme_failover_req(req);
-			return;
-		}
+	if (unlikely(status != BLK_STS_OK)) {
+		if (nvme_req_needs_retry(req)) {
+			if ((req->cmd_flags & REQ_NVME_MPATH) &&
+			    blk_path_error(status)) {
+				nvme_failover_req(req);
+				return;
+			}
 
-		if (!blk_queue_dying(req->q)) {
-			nvme_retry_req(req);
-			return;
+			if (!blk_queue_dying(req->q)) {
+				nvme_retry_req(req);
+				return;
+			}
 		}
+
+		if (blk_path_error(status) &&
+		    nvme_req(req)->status & NVME_SC_DNR)
+			status = BLK_STS_TARGET;
 	}
 	blk_mq_end_request(req, status);
 }
--
