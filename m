Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49965C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:30:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1926A20719
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pEY5HpOP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sh3irDdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1926A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mH+Gxglaz/Q1I4r57B2nytdCfMmzBbocRFlkQsmfccM=; b=pEY5HpOPYp/LrMb4Y1blUMwFD
	2mCKs8kryYV++khc7rqbUsY8QH94U3758Qan7FeZYt/y/HntVehg1Yg2Uv1oBnmSye3dKOf0vVdOE
	mpri7ThuCdMW2xvr7y9cTjdtJ+kC0kpAAlVcBlLAA/QT5Yic2i66c4ie8jx9PLwU14W7ViHcE8x4c
	x8ShyedYuVOPMP8tsHJ32cyUHf+osYITzYaKClPYVZ/JNj0xYrH2Q9vGloz3wU+2FWhix3lYAA3WX
	iynrfgsY7DZpBskHsvjj3eopZ12DztCVBK7YWy6DjDzrpfuHIkceESkYaBMAnAtU53s8gzXfADT8V
	MFgJJPxTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHVOV-0000Lj-Tv; Thu, 26 Mar 2020 16:30:11 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHVOT-0000GJ-Ec
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 16:30:10 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGOPqq101619;
 Thu, 26 Mar 2020 16:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BmtqqcsXjc3q+zHPz7Y/XJ5q6Wk3IkUvZqjO8fWTBJQ=;
 b=sh3irDdoyjpS05uBHZd+JKWWhunk8N7pyCK+YujudZeziMVzRakKMr88U5KKB0QaiudG
 Rz9NmZB6rOzLQl1OoraaTb0EznZ5qzoKTr65hP65diRB/KzUHEezpicyv7hQ42tuJrt1
 qcnMnEVMPtvct1+3f8kaekyRhgmuoNG5vr5lkoOCMuAFkLna/G/yBq+2iWYIBVf/jD7m
 wzoXnHxwzTRdGTjYEEEWWrX8mDFU8ucOTrVa5IXr7XkWmQ/Mb2Ari603bafjy8i/qxlP
 bZjRwhqBPa3+6xVhpCY2SxGFpFMp7q2XKR5cRakhY8yjmJrVhKbkG95qV3bJnbcI8Jmw VA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 300urk1kkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:30:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QGMg5X188701;
 Thu, 26 Mar 2020 16:30:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 30073dvag8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 16:30:06 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QGU6qE016729;
 Thu, 26 Mar 2020 16:30:06 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 09:30:06 -0700
Subject: Re: [PATCH 05/29] lpfc: adapt code to changed names in api header
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-6-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <646ee7f1-1d07-4d69-32d4-09dcf5a22cfc@oracle.com>
Date: Thu, 26 Mar 2020 11:30:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-6-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=2 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_093009_595786_43563D7C 
X-CRM114-Status: GOOD (  21.92  )
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
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 10 +++++-----
>   drivers/scsi/lpfc/lpfc_nvmet.h |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
> index 9dc9afe1c255..47b983eddbb2 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.c
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.c
> @@ -302,7 +302,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
>   			  struct lpfc_wcqe_complete *wcqe)
>   {
>   	struct lpfc_nvmet_tgtport *tgtp;
> -	struct nvmefc_tgt_ls_req *rsp;
> +	struct nvmefc_ls_rsp *rsp;
>   	struct lpfc_nvmet_rcv_ctx *ctxp;
>   	uint32_t status, result;
>   
> @@ -335,7 +335,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
>   	}
>   
>   out:
> -	rsp = &ctxp->ctx.ls_req;
> +	rsp = &ctxp->ctx.ls_rsp;
>   
>   	lpfc_nvmeio_data(phba, "NVMET LS  CMPL: xri x%x stat x%x result x%x\n",
>   			 ctxp->oxid, status, result);
> @@ -830,10 +830,10 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
>   
>   static int
>   lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
> -		      struct nvmefc_tgt_ls_req *rsp)
> +		      struct nvmefc_ls_rsp *rsp)
>   {
>   	struct lpfc_nvmet_rcv_ctx *ctxp =
> -		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_req);
> +		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_rsp);
>   	struct lpfc_hba *phba = ctxp->phba;
>   	struct hbq_dmabuf *nvmebuf =
>   		(struct hbq_dmabuf *)ctxp->rqb_buffer;
> @@ -2000,7 +2000,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
>   	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
>   	 */
>   	atomic_inc(&tgtp->rcv_ls_req_in);
> -	rc = nvmet_fc_rcv_ls_req(phba->targetport, &ctxp->ctx.ls_req,
> +	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ctx.ls_rsp,
>   				 payload, size);
>   
>   	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
> diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
> index b80b1639b9a7..f0196f3ef90d 100644
> --- a/drivers/scsi/lpfc/lpfc_nvmet.h
> +++ b/drivers/scsi/lpfc/lpfc_nvmet.h
> @@ -105,7 +105,7 @@ struct lpfc_nvmet_ctx_info {
>   
>   struct lpfc_nvmet_rcv_ctx {
>   	union {
> -		struct nvmefc_tgt_ls_req ls_req;
> +		struct nvmefc_ls_rsp ls_rsp;
>   		struct nvmefc_tgt_fcp_req fcp_req;
>   	} ctx;
>   	struct list_head list;
> 

FWIW, Looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
