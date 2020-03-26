Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1CC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:26:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED9820787
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QkdITMDq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uGFiLwgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED9820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XB3ixXTL4FEoi2C5crY0GbhWYI8osynuhd75sJP8eNI=; b=QkdITMDqWvr4STo9cIfeg8ptB
	ijM3WlLm4ss1EpNXmwvwJEPLx+YY0j2Vr5QdB1OKfC4vWoQKnCNv0vK8tfRKFcKsOrGfqP+C3IQ8q
	JRDnYNFvhtJdmitvLE9bN4xu7WMrC8MTXvBLKo9289sxRx1wsrFGD3aA+yJyY+kY2euA18khyys7w
	7A3pItyhnmoJkgNypaRz/g7hpjJVYR/7zTb0TCZhWC/Wm+tfGTmaO6L9pgA4hdU8EPd4MuyXGrwmE
	k9DoVPDdSBa5AgLbO8o10Fz7LGJ7MOHBi4JDtcCiWxvJgDloUIQ9JjQOJfG9ccKTZJ1D+CcM7jhPF
	1Jo8c8n9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVKq-0006Mf-4T; Thu, 26 Mar 2020 16:26:24 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVKl-0006M7-UR
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:26:21 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGNMnN013882;
 Thu, 26 Mar 2020 16:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZObhCm6a+dm5f26ihsaXYPopIXyLgNmUy1neyi/YFCk=;
 b=uGFiLwgQagHtPWD4XhtLOJKkptg/lIimd2oO7g/OnIW2ZN+ETSO5ysbwSlqG5ZE4GlqW
 WJ5u7Xg/NMYchMh8IoADLMq6KBsaL5KVad187M1OfJFjWjRGbtXr6Zs04ri+g4WpJYtJ
 wNvI8LOwUxNURp5WClYhRNWFW6t4IWohB/ertxlvRGvSavEEmZEUPUTrXxbLMCBfbK3M
 2tsuATuQKWrJimTTalX/fCVMCYmnN2nYnhREFAOq/Z645d1QqEYzA0KYL6SvAdyznK1B
 LeP8NuTR+hG8hDvDgN+oCreZIkwdIKS0+buvBDCK9X0l8ULG0QZADictAzjxLmI+HY1N 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2ywabrgvga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:26:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGLvL4169849;
 Thu, 26 Mar 2020 16:26:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3006r8qkrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:26:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QGQGEO014727;
 Thu, 26 Mar 2020 16:26:16 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:26:16 -0700
Subject: Re: [PATCH 04/29] nvme-fc nvmet_fc nvme_fcloop: adapt code to changed
 names in api header
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-5-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <a97e3a31-b090-9e62-843e-c28a0eb31177@oracle.com>
Date: Thu, 26 Mar 2020 11:26:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-5-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=2
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=2
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_092620_109623_DBA6E21E 
X-CRM114-Status: GOOD (  35.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: martin.petersen@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/5/2020 12:37 PM, James Smart wrote:
> deal with following naming changes in the header:
>    nvmefc_tgt_ls_req -> nvmefc_ls_rsp
>    nvmefc_tgt_ls_req.nvmet_fc_private -> nvmefc_ls_rsp.nvme_fc_private
> 
> Change calling sequence to nvmet_fc_rcv_ls_req() for hosthandle.
> 
> Add stubs for new interfaces:
> host/fc.c: nvme_fc_rcv_ls_req()
> target/fc.c: nvmet_fc_invalidate_host()
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c       | 35 ++++++++++++++++++++
>   drivers/nvme/target/fc.c     | 77 ++++++++++++++++++++++++++++++++------------
>   drivers/nvme/target/fcloop.c | 20 ++++++------
>   3 files changed, 102 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5a70ac395d53..f8f79cd88769 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1465,6 +1465,41 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
>   		kfree(lsop);
>   }
>   
> +/**
> + * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
> + *                       upon the reception of a NVME LS request.
> + *
> + * The nvme-fc layer will copy payload to an internal structure for
> + * processing.  As such, upon completion of the routine, the LLDD may
> + * immediately free/reuse the LS request buffer passed in the call.
> + *
> + * If this routine returns error, the LLDD should abort the exchange.
> + *
> + * @remoteport: pointer to the (registered) remote port that the LS
> + *              was received from. The remoteport is associated with
> + *              a specific localport.
> + * @lsrsp:      pointer to a nvmefc_ls_rsp response structure to be
> + *              used to reference the exchange corresponding to the LS
> + *              when issuing an ls response.
> + * @lsreqbuf:   pointer to the buffer containing the LS Request
> + * @lsreqbuf_len: length, in bytes, of the received LS request
> + */
> +int
> +nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
> +			struct nvmefc_ls_rsp *lsrsp,
> +			void *lsreqbuf, u32 lsreqbuf_len)
> +{
> +	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
> +	struct nvme_fc_lport *lport = rport->lport;
> +
> +	/* validate there's a routine to transmit a response */
> +	if (!lport->ops->xmt_ls_rsp)
> +		return(-EINVAL);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_fc_rcv_ls_req);
> +
>   
>   /* *********************** NVME Ctrl Routines **************************** */
>   
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index a8ceb7721640..aac7869a70bb 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -28,7 +28,7 @@ struct nvmet_fc_tgtport;
>   struct nvmet_fc_tgt_assoc;
>   
>   struct nvmet_fc_ls_iod {
> -	struct nvmefc_tgt_ls_req	*lsreq;
> +	struct nvmefc_ls_rsp		*lsrsp;
>   	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
>   
>   	struct list_head		ls_list;	/* tgtport->ls_list */
> @@ -1146,6 +1146,42 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>   	spin_unlock_irqrestore(&tgtport->lock, flags);
>   }
>   
> +/**
> + * nvmet_fc_invalidate_host - transport entry point called by an LLDD
> + *                       to remove references to a hosthandle for LS's.
> + *
> + * The nvmet-fc layer ensures that any references to the hosthandle
> + * on the targetport are forgotten (set to NULL).  The LLDD will
> + * typically call this when a login with a remote host port has been
> + * lost, thus LS's for the remote host port are no longer possible.
> + *
> + * If an LS request is outstanding to the targetport/hosthandle (or
> + * issued concurrently with the call to invalidate the host), the
> + * LLDD is responsible for terminating/aborting the LS and completing
> + * the LS request. It is recommended that these terminations/aborts
> + * occur after calling to invalidate the host handle to avoid additional
> + * retries by the nvmet-fc transport. The nvmet-fc transport may
> + * continue to reference host handle while it cleans up outstanding
> + * NVME associations. The nvmet-fc transport will call the
> + * ops->host_release() callback to notify the LLDD that all references
> + * are complete and the related host handle can be recovered.
> + * Note: if there are no references, the callback may be called before
> + * the invalidate host call returns.
> + *
> + * @target_port: pointer to the (registered) target port that a prior
> + *              LS was received on and which supplied the transport the
> + *              hosthandle.
> + * @hosthandle: the handle (pointer) that represents the host port
> + *              that no longer has connectivity and that LS's should
> + *              no longer be directed to.
> + */
> +void
> +nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
> +			void *hosthandle)
> +{
> +}
> +EXPORT_SYMBOL_GPL(nvmet_fc_invalidate_host);
> +
>   /*
>    * nvmet layer has called to terminate an association
>    */
> @@ -1371,7 +1407,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Create Association LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				FCNVME_RJT_RC_LOGIC,
>   				FCNVME_RJT_EXP_NONE, 0);
> @@ -1384,7 +1420,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
>   
>   	/* format a response */
>   
> -	iod->lsreq->rsplen = sizeof(*acc);
> +	iod->lsrsp->rsplen = sizeof(*acc);
>   
>   	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(
> @@ -1462,7 +1498,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Create Connection LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				(ret == VERR_NO_ASSOC) ?
>   					FCNVME_RJT_RC_INV_ASSOC :
> @@ -1477,7 +1513,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
>   
>   	/* format a response */
>   
> -	iod->lsreq->rsplen = sizeof(*acc);
> +	iod->lsrsp->rsplen = sizeof(*acc);
>   
>   	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)),
> @@ -1542,7 +1578,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   		dev_err(tgtport->dev,
>   			"Disconnect LS failed: %s\n",
>   			validation_errors[ret]);
> -		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
> +		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
>   				(ret == VERR_NO_ASSOC) ?
>   					FCNVME_RJT_RC_INV_ASSOC :
> @@ -1555,7 +1591,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
>   
>   	/* format a response */
>   
> -	iod->lsreq->rsplen = sizeof(*acc);
> +	iod->lsrsp->rsplen = sizeof(*acc);
>   
>   	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
>   			fcnvme_lsdesc_len(
> @@ -1577,9 +1613,9 @@ static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
>   static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
>   
>   static void
> -nvmet_fc_xmt_ls_rsp_done(struct nvmefc_tgt_ls_req *lsreq)
> +nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
>   {
> -	struct nvmet_fc_ls_iod *iod = lsreq->nvmet_fc_private;
> +	struct nvmet_fc_ls_iod *iod = lsrsp->nvme_fc_private;
>   	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
>   
>   	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
> @@ -1597,9 +1633,9 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>   	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
>   				  NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
>   
> -	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsreq);
> +	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
>   	if (ret)
> -		nvmet_fc_xmt_ls_rsp_done(iod->lsreq);
> +		nvmet_fc_xmt_ls_rsp_done(iod->lsrsp);
>   }
>   
>   /*
> @@ -1612,12 +1648,12 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
>   	struct fcnvme_ls_rqst_w0 *w0 =
>   			(struct fcnvme_ls_rqst_w0 *)iod->rqstbuf;
>   
> -	iod->lsreq->nvmet_fc_private = iod;
> -	iod->lsreq->rspbuf = iod->rspbuf;
> -	iod->lsreq->rspdma = iod->rspdma;
> -	iod->lsreq->done = nvmet_fc_xmt_ls_rsp_done;
> +	iod->lsrsp->nvme_fc_private = iod;
> +	iod->lsrsp->rspbuf = iod->rspbuf;
> +	iod->lsrsp->rspdma = iod->rspdma;
> +	iod->lsrsp->done = nvmet_fc_xmt_ls_rsp_done;
>   	/* Be preventative. handlers will later set to valid length */
> -	iod->lsreq->rsplen = 0;
> +	iod->lsrsp->rsplen = 0;
>   
>   	iod->assoc = NULL;
>   
> @@ -1640,7 +1676,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
>   		nvmet_fc_ls_disconnect(tgtport, iod);
>   		break;
>   	default:
> -		iod->lsreq->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
> +		iod->lsrsp->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
>   				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
>   				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
>   	}
> @@ -1674,14 +1710,15 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
>    *
>    * @target_port: pointer to the (registered) target port the LS was
>    *              received on.
> - * @lsreq:      pointer to a lsreq request structure to be used to reference
> + * @lsrsp:      pointer to a lsrsp structure to be used to reference
>    *              the exchange corresponding to the LS.
>    * @lsreqbuf:   pointer to the buffer containing the LS Request
>    * @lsreqbuf_len: length, in bytes, of the received LS request
>    */
>   int
>   nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
> -			struct nvmefc_tgt_ls_req *lsreq,
> +			void *hosthandle,
> +			struct nvmefc_ls_rsp *lsrsp,
>   			void *lsreqbuf, u32 lsreqbuf_len)
>   {
>   	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
> @@ -1699,7 +1736,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
>   		return -ENOENT;
>   	}
>   
> -	iod->lsreq = lsreq;
> +	iod->lsrsp = lsrsp;
>   	iod->fcpreq = NULL;
>   	memcpy(iod->rqstbuf, lsreqbuf, lsreqbuf_len);
>   	iod->rqstdatalen = lsreqbuf_len;
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 1c50af6219f3..130932a5db0c 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -227,7 +227,7 @@ struct fcloop_lsreq {
>   	struct fcloop_tport		*tport;
>   	struct nvmefc_ls_req		*lsreq;
>   	struct work_struct		work;
> -	struct nvmefc_tgt_ls_req	tgt_ls_req;
> +	struct nvmefc_ls_rsp		ls_rsp;
>   	int				status;
>   };
>   
> @@ -265,9 +265,9 @@ struct fcloop_ini_fcpreq {
>   };
>   
>   static inline struct fcloop_lsreq *
> -tgt_ls_req_to_lsreq(struct nvmefc_tgt_ls_req *tgt_lsreq)
> +ls_rsp_to_lsreq(struct nvmefc_ls_rsp *lsrsp)
>   {
> -	return container_of(tgt_lsreq, struct fcloop_lsreq, tgt_ls_req);
> +	return container_of(lsrsp, struct fcloop_lsreq, ls_rsp);
>   }
>   
>   static inline struct fcloop_fcpreq *
> @@ -330,7 +330,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
>   
>   	tls_req->status = 0;
>   	tls_req->tport = rport->targetport->private;
> -	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
> +	ret = nvmet_fc_rcv_ls_req(rport->targetport, NULL, &tls_req->ls_rsp,
>   				 lsreq->rqstaddr, lsreq->rqstlen);
>   
>   	return ret;
> @@ -338,15 +338,15 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
>   
>   static int
>   fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
> -			struct nvmefc_tgt_ls_req *tgt_lsreq)
> +			struct nvmefc_ls_rsp *lsrsp)
>   {
> -	struct fcloop_lsreq *tls_req = tgt_ls_req_to_lsreq(tgt_lsreq);
> +	struct fcloop_lsreq *tls_req = ls_rsp_to_lsreq(lsrsp);
>   	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
>   
> -	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
> -		((lsreq->rsplen < tgt_lsreq->rsplen) ?
> -				lsreq->rsplen : tgt_lsreq->rsplen));
> -	tgt_lsreq->done(tgt_lsreq);
> +	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
> +		((lsreq->rsplen < lsrsp->rsplen) ?
> +				lsreq->rsplen : lsrsp->rsplen));
> +	lsrsp->done(lsrsp);
>   
>   	schedule_work(&tls_req->work);
>   
> 


Looks Good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
