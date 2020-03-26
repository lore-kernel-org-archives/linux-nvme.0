Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67E5C43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 19:17:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF9A20719
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k0QFIOsN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zLJ5yWom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF9A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8BcipXrIBhofZBiwG4aoVi1rS9xiZnYUb1czH9tblCc=; b=k0QFIOsNc5m3uvue4ya8ZsPRN
	CZKLHMMeJgYDdYYoALScUkqz2kZyQREhVJXUEppk0CSrT/u9ubRZdkm6v2Y71pcGFPxvocBszEmOC
	VDG1cr1MXTbZnDRZtb/nI5vU+n6Jrt2SABIY9o9rsVjagFxJSBi3ZTmHvFIghELLpq4gTeDWm/aZ6
	qSIPoGpcASNdnfQIVmwBqJcYCTw0D3yyJb+oJH83w47Gzevc8gl0gMXICD3/mtURTV27mGGLMRLX5
	bTnzIsP5SODRqad/W1+PrF8WTTxpXPbE5pbmTtViC1BFW4kalDeE2p0VM1dh83uRPHePW9ScJsjWc
	EYQTnfPzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHXzv-0000n4-Ge; Thu, 26 Mar 2020 19:16:59 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHXzs-0000md-MT
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 19:16:58 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QJAZbl135041;
 Thu, 26 Mar 2020 19:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Uw+bdDEGf2UsC3wv7+R45+YGakXNJrcGj2hAuALNx+4=;
 b=zLJ5yWom2M3Skue3wmtCO/hzs7atXV9GMn80i/QbnItEIahyBS7rxN3OXB9fSlADDG+E
 4T2SVg0U1faNH4+vLfztsXH9gWTOzam4yRFeTf7Taa61wNyAKUVFQ3lQmvaOdRwB3Fjf
 3q0sQDUB0EKTzv55ioKZrBljDwjxaCAXExCM2wvIJJ0kKd+2KOIAqDN5MGt2JKc5FrR+
 RRx/Ae23QwoA/RAfY2f2PsHsYfA1SqFY/W/JeUnbCvEq6sbVAyOoNzaQi29JbjrQAApj
 gJKzTu+Y5iGdHABERl1qv9TGs2mlv0Tk7Sr+zd893zE/9TbXk8Dh/n6ySc40m44ayoNv 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 300urk2fsa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 19:16:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QJ6jAE109206;
 Thu, 26 Mar 2020 19:16:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30073e8x6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2020 19:16:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02QJGqdc014638;
 Thu, 26 Mar 2020 19:16:53 GMT
Received: from [10.154.135.52] (/10.154.135.52)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 26 Mar 2020 12:16:52 -0700
Subject: Re: [PATCH 11/29] nvme-fc: convert assoc_active flag to atomic
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200205183753.25959-1-jsmart2021@gmail.com>
 <20200205183753.25959-12-jsmart2021@gmail.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle Corporation
Message-ID: <df5c4bad-46ec-dd63-0474-5495b0b58f7c@oracle.com>
Date: Thu, 26 Mar 2020 14:16:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200205183753.25959-12-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=2 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_121656_824338_5C00BFB3 
X-CRM114-Status: GOOD (  21.78  )
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
> Convert the assoc_active flag to an atomic to remove any small
> race conditions on transitioning to active and back.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>   drivers/nvme/host/fc.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 8fed69504c38..40e1141c76db 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -131,6 +131,11 @@ enum nvme_fcctrl_flags {
>   	FCCTRL_TERMIO		= (1 << 0),
>   };
>   
> +enum {
> +	ASSOC_INACTIVE		= 0,
> +	ASSOC_ACTIVE		= 1,
> +};
> +
>   struct nvme_fc_ctrl {
>   	spinlock_t		lock;
>   	struct nvme_fc_queue	*queues;
> @@ -140,7 +145,7 @@ struct nvme_fc_ctrl {
>   	u32			cnum;
>   
>   	bool			ioq_live;
> -	bool			assoc_active;
> +	atomic_t		assoc_active;
>   	atomic_t		err_work_active;
>   	u64			association_id;
>   
> @@ -2584,12 +2589,14 @@ static int
>   nvme_fc_ctlr_active_on_rport(struct nvme_fc_ctrl *ctrl)
>   {
>   	struct nvme_fc_rport *rport = ctrl->rport;
> +	int priorstate;
>   	u32 cnt;
>   
> -	if (ctrl->assoc_active)
> +	priorstate = atomic_cmpxchg(&ctrl->assoc_active,
> +					ASSOC_INACTIVE, ASSOC_ACTIVE);
> +	if (priorstate != ASSOC_INACTIVE)
>   		return 1;
>   
> -	ctrl->assoc_active = true;
>   	cnt = atomic_inc_return(&rport->act_ctrl_cnt);
>   	if (cnt == 1)
>   		nvme_fc_rport_active_on_lport(rport);
> @@ -2746,7 +2753,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
>   out_free_queue:
>   	nvme_fc_free_queue(&ctrl->queues[0]);
> -	ctrl->assoc_active = false;
> +	atomic_set(&ctrl->assoc_active, ASSOC_INACTIVE);
>   	nvme_fc_ctlr_inactive_on_rport(ctrl);
>   
>   	return ret;
> @@ -2762,10 +2769,12 @@ static void
>   nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   {
>   	unsigned long flags;
> +	int priorstate;
>   
> -	if (!ctrl->assoc_active)
> +	priorstate = atomic_cmpxchg(&ctrl->assoc_active,
> +					ASSOC_ACTIVE, ASSOC_INACTIVE);
> +	if (priorstate != ASSOC_ACTIVE)
>   		return;
> -	ctrl->assoc_active = false;
>   
>   	spin_lock_irqsave(&ctrl->lock, flags);
>   	ctrl->flags |= FCCTRL_TERMIO;
> @@ -3096,7 +3105,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	ctrl->dev = lport->dev;
>   	ctrl->cnum = idx;
>   	ctrl->ioq_live = false;
> -	ctrl->assoc_active = false;
> +	atomic_set(&ctrl->assoc_active, ASSOC_INACTIVE);
>   	atomic_set(&ctrl->err_work_active, 0);
>   	init_waitqueue_head(&ctrl->ioabort_wait);
>   
> 

Looks Good

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
