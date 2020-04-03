Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527D9C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 16:39:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E2E206F5
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 16:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D+B7HPVg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="br/O1UPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E2E206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HBYW8ExdkW8iwok3dc23wJ90ilkLY8LzAXPjWxVUQe4=; b=D+B7HPVgO16W4xh0KRRAZ1a4V
	lldUw1iUDIG+hGmLC7oWIEyVd7cPuzYq4/xojU5NdGAi2fAF9cMe81OdgxUGDVgPbbPTpOjIzL+Fc
	1X+wVl4S1L+1bjXeyXbJnUeDEiiH5wTx+ywKOM8W/JR1X9yv7u5ylm6ecVWY9V0ibEGMPzW+XxVpO
	TJxK+9sUg2NuSlQw8t39mHg9GjEFBarxWUCrXa6lGKA9pBH4wOp0lFDu/mn0VINBE1upchIQ0iXiS
	70Kilwxgahcrz4M0xtTz1vyKOb3OtuM5Zm+jwiIFS4HYxVBelwcwAoIfVUwjotscqlG5WoaAAqnsc
	Qti0N4xPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKPLp-0004Gp-FB; Fri, 03 Apr 2020 16:39:25 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKPLm-0004GQ-Oe
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 16:39:24 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033GO48e119034;
 Fri, 3 Apr 2020 16:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ba/j5CbMc04KuK6mlsaQvN5EhmuP6zjq0aHHSv/ALJI=;
 b=br/O1UPJeP2JGbAkX+MZVbHYoAe7v6C7Lfaj6VYknT2RlvrbE4IghWO3GFcH3x5BY8eB
 7ollf3Lu94EbI9Y9ykPYsSn4SWcJ0neeNfaFRSnuw6qF/hI/rtRXA8qdlgxmJSUvueFE
 06qAFzb++FuUZpWyow1x7g9u6pS/iM8wOzJb8W+U+WglkpNuHVBzdPEnzQecjK9aNyyT
 vSsmWx+mrbvSCcUB3GE7GnRRnIRDoFPNVhdAafaS22dLvkljAPCxjTPpkLRIVutQ9onW
 eTHIswAtG+pXM4JHJdDukHFS3oi3en6LtdL1FiaYhpjk5T4xilT+GyHvOBHTdj+unPfV HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 303cevj3x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Apr 2020 16:39:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033GcMZa033604;
 Fri, 3 Apr 2020 16:39:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 302ga55699-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Apr 2020 16:39:12 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033GdB18026063;
 Fri, 3 Apr 2020 16:39:11 GMT
Received: from [10.154.129.193] (/10.154.129.193)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 03 Apr 2020 09:39:11 -0700
Subject: Re: [PATCH] nvme-fc: Revert - add module to ops template to allow
 module references
To: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org
References: <20200403143320.49522-1-jsmart2021@gmail.com>
From: himanshu.madhani@oracle.com
Organization: Oracle Corporation
Message-ID: <6ad66e15-4815-146a-9921-c776559e3c75@oracle.com>
Date: Fri, 3 Apr 2020 11:38:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403143320.49522-1-jsmart2021@gmail.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=2 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_093922_933603_C416A398 
X-CRM114-Status: GOOD (  27.96  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/3/20 9:33 AM, James Smart wrote:
> This patch reverts the commit for
>     nvme_fc: add module to ops template to allow module references
>
> The original patch was to resolve the lldd being able to be unloaded
> while being used to talk to the boot device of the system. However, the
> end result of the original patch is that any driver unload while a nvme
> controller is live via the lldd is now being prohibited. Given the module
> reference, the module teardown routine can't be called, thus there's no
> way, other than manual actions to terminate the controllers.
>
> -- james
>
> Fixes: 863fbae929c7 ("nvme_fc: add module to ops template to allow module  references")
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> CC: Christoph Hellwig <hch@lst.de>
> CC: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/fc.c          | 14 ++------------
>   drivers/nvme/target/fcloop.c    |  1 -
>   drivers/scsi/lpfc/lpfc_nvme.c   |  2 --
>   drivers/scsi/qla2xxx/qla_nvme.c |  1 -
>   include/linux/nvme-fc-driver.h  |  4 ----
>   5 files changed, 2 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a8bf2fb1287b..7dfc4a2ecf1e 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -342,8 +342,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
>   	    !template->ls_req || !template->fcp_io ||
>   	    !template->ls_abort || !template->fcp_abort ||
>   	    !template->max_hw_queues || !template->max_sgl_segments ||
> -	    !template->max_dif_sgl_segments || !template->dma_boundary ||
> -	    !template->module) {
> +	    !template->max_dif_sgl_segments || !template->dma_boundary) {
>   		ret = -EINVAL;
>   		goto out_reghost_failed;
>   	}
> @@ -2016,7 +2015,6 @@ nvme_fc_ctrl_free(struct kref *ref)
>   {
>   	struct nvme_fc_ctrl *ctrl =
>   		container_of(ref, struct nvme_fc_ctrl, ref);
> -	struct nvme_fc_lport *lport = ctrl->lport;
>   	unsigned long flags;
>   
>   	if (ctrl->ctrl.tagset) {
> @@ -2043,7 +2041,6 @@ nvme_fc_ctrl_free(struct kref *ref)
>   	if (ctrl->ctrl.opts)
>   		nvmf_free_options(ctrl->ctrl.opts);
>   	kfree(ctrl);
> -	module_put(lport->ops->module);
>   }
>   
>   static void
> @@ -3074,15 +3071,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   		goto out_fail;
>   	}
>   
> -	if (!try_module_get(lport->ops->module)) {
> -		ret = -EUNATCH;
> -		goto out_free_ctrl;
> -	}
> -
>   	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
>   	if (idx < 0) {
>   		ret = -ENOSPC;
> -		goto out_mod_put;
> +		goto out_free_ctrl;
>   	}
>   
>   	ctrl->ctrl.opts = opts;
> @@ -3232,8 +3224,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   out_free_ida:
>   	put_device(ctrl->dev);
>   	ida_simple_remove(&nvme_fc_ctrl_cnt, ctrl->cnum);
> -out_mod_put:
> -	module_put(lport->ops->module);
>   out_free_ctrl:
>   	kfree(ctrl);
>   out_fail:
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 9861fcea39f6..f69ce66e2d44 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -875,7 +875,6 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   #define FCLOOP_DMABOUND_4G		0xFFFFFFFF
>   
>   static struct nvme_fc_port_template fctemplate = {
> -	.module			= THIS_MODULE,
>   	.localport_delete	= fcloop_localport_delete,
>   	.remoteport_delete	= fcloop_remoteport_delete,
>   	.create_queue		= fcloop_create_queue,
> diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
> index f6c8963c915d..db4a04a207ec 100644
> --- a/drivers/scsi/lpfc/lpfc_nvme.c
> +++ b/drivers/scsi/lpfc/lpfc_nvme.c
> @@ -1985,8 +1985,6 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
>   
>   /* Declare and initialization an instance of the FC NVME template. */
>   static struct nvme_fc_port_template lpfc_nvme_template = {
> -	.module	= THIS_MODULE,
> -
>   	/* initiator-based functions */
>   	.localport_delete  = lpfc_nvme_localport_delete,
>   	.remoteport_delete = lpfc_nvme_remoteport_delete,
> diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
> index bfcd02fdf2b8..941aa53363f5 100644
> --- a/drivers/scsi/qla2xxx/qla_nvme.c
> +++ b/drivers/scsi/qla2xxx/qla_nvme.c
> @@ -610,7 +610,6 @@ static void qla_nvme_remoteport_delete(struct nvme_fc_remote_port *rport)
>   }
>   
>   static struct nvme_fc_port_template qla_nvme_fc_transport = {
> -	.module	= THIS_MODULE,
>   	.localport_delete = qla_nvme_localport_delete,
>   	.remoteport_delete = qla_nvme_remoteport_delete,
>   	.create_queue   = qla_nvme_alloc_queue,
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 6d0d70f3219c..10f81629b9ce 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -270,8 +270,6 @@ struct nvme_fc_remote_port {
>    *
>    * Host/Initiator Transport Entrypoints/Parameters:
>    *
> - * @module:  The LLDD module using the interface
> - *
>    * @localport_delete:  The LLDD initiates deletion of a localport via
>    *       nvme_fc_deregister_localport(). However, the teardown is
>    *       asynchronous. This routine is called upon the completion of the
> @@ -385,8 +383,6 @@ struct nvme_fc_remote_port {
>    *       Value is Mandatory. Allowed to be zero.
>    */
>   struct nvme_fc_port_template {
> -	struct module	*module;
> -
>   	/* initiator-based functions */
>   	void	(*localport_delete)(struct nvme_fc_local_port *);
>   	void	(*remoteport_delete)(struct nvme_fc_remote_port *);
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
