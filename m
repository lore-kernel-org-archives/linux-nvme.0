From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 17:50:23 -0700
Subject: [PATCH v2 2/7] nvme: revise nvme_set_queue_count to return error on
 some nvme status codes
In-Reply-To: <20180512005028.29661-1-jsmart2021@gmail.com>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
Message-ID: <20180512005028.29661-3-jsmart2021@gmail.com>

If the SET_FEATURES command failed with an nvme completion failure only,
the current code ignores the failure and lets the controller continue to
initialize but with the io queue count degraded (not existent).

In cases where the failure may have been due to the transport detecting
an error condition or a connectivity loss, the nvme status failure was
manufactured and not a valid representation of the controller. It is better
to fail the command so that a subsequent (re)connect can resolve the state.

The status codes that transports may generate are NVME_SC_ABORT_REQ and
NVME_SC_INTERNAL. In those cases, return a positive error value with the
value being the status code.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2:
  replaced logic in fc.c which checked for io queue count of zero
  and recognized failure with change to nvme_set_queue_count() to
  return error if one of the transport error completion values

 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3779f350769..7a39ce8d9d5e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1007,7 +1007,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 
 	status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count, NULL, 0,
 			&result);
-	if (status < 0)
+	if (status < 0 ||
+	    status == NVME_SC_ABORT_REQ || status == NVME_SC_INTERNAL)
 		return status;
 
 	/*
-- 
2.13.1
