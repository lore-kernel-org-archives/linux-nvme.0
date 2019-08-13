From: kbusch@kernel.org (Keith Busch)
Date: Tue, 13 Aug 2019 08:15:10 -0600
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <1f2025d7-b79e-ad46-df73-66fdff1b5f28@grimberg.me>
References: <20190812075147.79598-1-hare@suse.de>
 <a8b400cf-94ef-a4a1-e196-a74e115357ea@intel.com>
 <1f2025d7-b79e-ad46-df73-66fdff1b5f28@grimberg.me>
Message-ID: <20190813141510.GB32686@localhost.localdomain>

On Mon, Aug 12, 2019@11:32:20PM -0700, Sagi Grimberg wrote:
> On 8/12/19 4:37 PM, Nadolski, Edmund wrote:
> > On 8/12/2019 1:51 AM, Hannes Reinecke wrote:
> >> If the DNR bit is set we should not retry the command, even if
> >> the standard status evaluation indicates so.
> >>
> >> Signed-off-by: Hannes Reinecke <hare at suse.com>
> >> ---
> >> ? drivers/nvme/host/core.c | 21 +++++++++++++--------
> >> ? 1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index cc09b81fc7f4..5e1309709917 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -267,15 +267,20 @@ void nvme_complete_rq(struct request *req)
> >> ????? if (nvme_req(req)->ctrl->kas)
> >> ????????? nvme_req(req)->ctrl->comp_seen = true;
> >> -??? if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> >> -??????? if ((req->cmd_flags & REQ_NVME_MPATH) &&
> >> -??????????? blk_path_error(status)) {
> >> -??????????? nvme_failover_req(req);
> >> -??????????? return;
> >> +??? if (unlikely(status != BLK_STS_OK)) {
> >> +??????? if (nvme_req_needs_retry(req)) {
> >> +??????????? if ((req->cmd_flags & REQ_NVME_MPATH) &&
> >> +??????????????? blk_path_error(status)) {
> >> +??????????????? nvme_failover_req(req);
> >> +??????????????? return;
> >> +??????????? }
> >> +??????????? if (!blk_queue_dying(req->q)) {
> >> +??????????????? nvme_retry_req(req);
> >> +??????????????? return;
> >> +??????????? }
> >> ????????? }
> >> -
> >> -??????? if (!blk_queue_dying(req->q)) {
> >> -??????????? nvme_retry_req(req);
> >> +??????? if (nvme_req(req)->status & NVME_SC_DNR) {
> >> +??????????? blk_mq_end_request(req, BLK_STS_TARGET);
> >> ????????????? return;
> >> ????????? }
> >> ????? }
> > 
> > This seems redundant, to re-check the NVME_SC_DNR here, after just 
> > checking it in nvme_req_needs_retry().
> 
> Indeed, why do we need this at this point? we can simply continue and
> end the request down in the func (after we trace it as well).

We need to override the default nvme_error_status() to BLK_STS_TARGET
when DNR is set to prevent upper layers from their own retries/failover.
I suggested adding that check in the existing unlikely() case, but maybe
it's more obvious if we teach nvme_error_status() to default to return
BLK_STS_TARGET for this condition?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8f3fbe5ca937..50adcdde44d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -199,6 +199,9 @@ static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 
 static blk_status_t nvme_error_status(struct request *req)
 {
+	if (unlikely(nvme_req(req)->status & NVME_SC_DNR))
+		return BLK_STS_TARGET;
+
 	switch (nvme_req(req)->status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
--
