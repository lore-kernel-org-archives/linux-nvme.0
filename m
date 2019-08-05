From: jsmart2021@gmail.com (James Smart)
Date: Mon, 5 Aug 2019 12:32:50 -0700
Subject: Fwd: [PATCH rfc v2 0/6] nvme controller reset and namespace scan
 work race conditions
In-Reply-To: <e04be8bf-20cb-db7d-6046-74d8ec6fa485@broadcom.com>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <e04be8bf-20cb-db7d-6046-74d8ec6fa485@broadcom.com>
Message-ID: <e80a1e7a-ab7d-fc89-0f62-2c88b7c75b85@gmail.com>

On 8/5/2019 10:47 AM, James Smart wrote:
> 
> Hey Hannes and Keith,
> 
> This is the second attempt to handle the reset and scanning race saga.
> 
> The approach is to have the relevant admin commands return a proper
> status code that reflects that we had a transport error and
> not remove the namepsace if that is indeed the case.
> 
> This should be a reliable way to know if the revalidate_disk failed
> due to a transport error or not.
> 
> I am able to reproduce this race with the following command (using
> tcp/rdma):
> for j in `seq 50`; do for i in `seq 50`; do nvme reset /dev/nvme0; done 
> ; nvme disconnect-all; nvme connect-all; done
> 
> With this patch set (plus two more tcp/rdma transport specific patches
> that address a other issues) I was able to pass the test without
> reproducing the hang that you hannes reported.
> 
> In the patchset:
> - first make sure that transport related errors (such as
> nvme_cancel_request) reflect HOST_PATH_ERROR status.
> - make NVME_SC_HOST_PATH_ERROR a BLK_STS_TRANSPORT conversion.
> - Make sure that the callers indeed propagate the status back
> - Then simply look at the status code when calling revalidate_disk
> in nvme_validate_ns, and only remove it if the status code is
> indeed a transport related status.
> 
> Please let me know your thoghts.
> 
> Sagi Grimberg (6):
> nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
> nvme: return nvme_error_status for sync commands failure
> nvme: make nvme_identify_ns propagate errors back
> nvme: make nvme_report_ns_ids propagate error back
> nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
> nvme: don't remove namespace if revalidate failed because of a
> transport error
> 
> drivers/nvme/host/core.c | 67 ++++++++++++++++++++++++----------------
> drivers/nvme/host/tcp.c | 2 +-


I have two complaints:

- FC is eliminated from this fix, as FC doesn't use 
nvme_cancel_request() to terminate I/O's on resets/error recovery.

- With this change, any error set by a transport must be either 
NVME_SC_SUCCESS or NVME_SC_HOST_PATH_ERROR or it potentially misses the 
fix. I'm not sure that I like that, although any error from the 
transport is essentially a path error.  Do we lose anything by the loss 
of error clarity ?   Looking at what's present, we don't have much 
diversity when an error is set, so I guess it's ok.

- james

Minimally, include the following fix for FC as well:


Signed-off-by: James Smart <james.smart at broadcom.com>
---
  fc.c.new |   35 +++++++++++++++++++++++++++++------
  1 file changed, 29 insertions(+), 6 deletions(-)

--- fc.c.old	2019-08-05 10:55:51.318627945 -0700
+++ fc.c.new	2019-08-05 11:01:46.278380191 -0700
@@ -1608,9 +1608,13 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req
  				sizeof(op->rsp_iu), DMA_FROM_DEVICE);

  	if (opstate == FCPOP_STATE_ABORTED)
-		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
-	else if (freq->status)
-		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+	else if (freq->status) {
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: io failed due to lldd error %d\n",
+			ctrl->cnum, freq->status);
+	}

  	/*
  	 * For the linux implementation, if we have an unsuccesful
@@ -1638,7 +1642,12 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req
  		 */
  		if (freq->transferred_length !=
  			be32_to_cpu(op->cmd_iu.data_len)) {
-			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+			status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: io failed due to bad transfer "
+				"length: %d vs expected %d\n",
+				ctrl->cnum, freq->transferred_length,
+				be32_to_cpu(op->cmd_iu.data_len));
  			goto done;
  		}
  		result.u64 = 0;
@@ -1655,7 +1664,17 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req
  					freq->transferred_length ||
  			     op->rsp_iu.status_code ||
  			     sqe->common.command_id != cqe->command_id)) {
-			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+			status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: io failed due to bad NVMe_ERSP: "
+				"iu len %d, xfr len %d vs %d, status code "
+				"%d, cmdid %d vs %d\n",
+				ctrl->cnum, be16_to_cpu(op->rsp_iu.iu_len),
+				be32_to_cpu(op->rsp_iu.xfrd_len),
+				freq->transferred_length,
+			     	op->rsp_iu.status_code,
+				sqe->common.command_id,
+				cqe->command_id);
  			goto done;
  		}
  		result = cqe->result;
@@ -1663,7 +1682,11 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req
  		break;

  	default:
-		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: io failed due to odd NVMe_xRSP iu "
+			"len %d\n",
+			ctrl->cnum, freq->rcv_rsplen);
  		goto done;
  	}
