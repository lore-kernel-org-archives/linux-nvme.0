Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E1EC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:43:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE92C222E9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TmAqiXrE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gMKj6Qd1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE92C222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=c4qGU3S5gUuA8G0kugbvIr7mjlawzmTZ/Rz23sIAiAM=; b=TmAqiXrEhf9UcTm6Rd31f/JSi
	8RtkzKyIE9WYIqEr2jr4+b80MGj3KTchx22it7Uo7c053Y8mxknjmUKaDTo8sc/ouHYrQSzzFisJp
	A6/vsf3fHMcOZ9KIUnWzLTn4ApKKkksDo6UUomRBCCpdPr3lL8tCKRGzqZTWNKRSuUgP1HpSBiZfO
	l61osXzCx5Em1VxQL8VzPrd+Crqk8m/X01YUOXDO2OTBXgPgTCBNG/2nM1GUyiqNu6YuG49CQD9Ma
	3INoMIe16N3X70hakNo7InYlnAYpfBNJcxY8/6B7piD10F/TbtyIV+6R4F8jh1WbVJKQ59WM22y9/
	XxJA2KM2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWNo-0004DY-Cs; Mon, 19 Oct 2020 14:43:32 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWNf-00048S-Hm
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:43:26 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEeQGL135089;
 Mon, 19 Oct 2020 14:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=mPNwR3tJT4viiZyWqiVWwjmFa3l7Ekngi7gzDRdVLYM=;
 b=gMKj6Qd1Exff8CaKPnt112XA/Hrrzk/sNj8JNnpbsp1EpCdiXue6y7c31fmtHx+nDWrF
 UIXdteQgqiiG+skxZZpnRxExX9z4Z5iHL6/UK9DQWc075yUWS/s8FxIEQubnHhBhZYJC
 VT0GKnwCQl9X2AoYjutmfZO1wYkZFYEgAChB2d+4L9N2KLuvijO7ppVDMrP5qZyQOpBA
 uE2jzA75QfDOZr2IQcZuOCrE1FVjxvyuoNcCup/cEcleHczyjl10ydlzWvvJ9Tw6qOr+
 dKOlvWSpqiBRtkcuBxrY0jZ8lwdmXwKJBjUJpuAGNlxAi+uGvrF/hz2pZ+7S2wY7L1EI xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 347s8mntpe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:43:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEdwJw126817;
 Mon, 19 Oct 2020 14:43:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 348a6kyxyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:43:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JEhHWN012924;
 Mon, 19 Oct 2020 14:43:17 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:43:17 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/4] nvme-fc: remove err_work work item
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016212729.49138-2-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:43:16 -0500
Message-Id: <60D3B57C-3F14-4E39-9709-A4316105BBC9@oracle.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
 <20201016212729.49138-2-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_104323_751242_5E49994F 
X-CRM114-Status: GOOD (  33.64  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Oct 16, 2020, at 4:27 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> err_work was created to handle errors (mainly io timeout) while in
> CONNECTING state. The flag for err_work_active is also unneeded.
> 
> Remove err_work_active and err_work.  The actions to abort ios are moved
> inline to nvme_error_recovery().
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 40 ++++++++++------------------------------
> 1 file changed, 10 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 7067aaf50bf7..06fb208ab350 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -153,7 +153,6 @@ struct nvme_fc_ctrl {
> 	u32			cnum;
> 
> 	bool			ioq_live;
> -	atomic_t		err_work_active;
> 	u64			association_id;
> 	struct nvmefc_ls_rcv_op	*rcv_disconn;
> 
> @@ -163,7 +162,6 @@ struct nvme_fc_ctrl {
> 	struct blk_mq_tag_set	tag_set;
> 
> 	struct delayed_work	connect_work;
> -	struct work_struct	err_work;
> 
> 	struct kref		ref;
> 	unsigned long		flags;
> @@ -2410,11 +2408,11 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
> 	nvme_fc_ctrl_put(ctrl);
> }
> 
> +static void __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl);
> +
> static void
> nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> {
> -	int active;
> -
> 	/*
> 	 * if an error (io timeout, etc) while (re)connecting,
> 	 * it's an error on creating the new association.
> @@ -2423,11 +2421,14 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> 	 * ios hitting this path before things are cleaned up.
> 	 */
> 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
> -		active = atomic_xchg(&ctrl->err_work_active, 1);
> -		if (!active && !queue_work(nvme_fc_wq, &ctrl->err_work)) {
> -			atomic_set(&ctrl->err_work_active, 0);
> -			WARN_ON(1);
> -		}
> +		__nvme_fc_terminate_io(ctrl);
> +
> +		/*
> +		 * Rescheduling the connection after recovering
> +		 * from the io error is left to the reconnect work
> +		 * item, which is what should have stalled waiting on
> +		 * the io that had the error that scheduled this work.
> +		 */
> 		return;
> 	}
> 
> @@ -3233,7 +3234,6 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
> {
> 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> 
> -	cancel_work_sync(&ctrl->err_work);
> 	cancel_delayed_work_sync(&ctrl->connect_work);
> 	/*
> 	 * kill the association on the link side.  this will block
> @@ -3343,23 +3343,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
> 			ctrl->cnum);
> }
> 
> -static void
> -nvme_fc_connect_err_work(struct work_struct *work)
> -{
> -	struct nvme_fc_ctrl *ctrl =
> -			container_of(work, struct nvme_fc_ctrl, err_work);
> -
> -	__nvme_fc_terminate_io(ctrl);
> -
> -	atomic_set(&ctrl->err_work_active, 0);
> -
> -	/*
> -	 * Rescheduling the connection after recovering
> -	 * from the io error is left to the reconnect work
> -	 * item, which is what should have stalled waiting on
> -	 * the io that had the error that scheduled this work.
> -	 */
> -}
> 
> static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
> 	.name			= "fc",
> @@ -3474,7 +3457,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> 	ctrl->dev = lport->dev;
> 	ctrl->cnum = idx;
> 	ctrl->ioq_live = false;
> -	atomic_set(&ctrl->err_work_active, 0);
> 	init_waitqueue_head(&ctrl->ioabort_wait);
> 
> 	get_device(ctrl->dev);
> @@ -3482,7 +3464,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> 
> 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
> 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
> -	INIT_WORK(&ctrl->err_work, nvme_fc_connect_err_work);
> 	spin_lock_init(&ctrl->lock);
> 
> 	/* io queue count */
> @@ -3575,7 +3556,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> fail_ctrl:
> 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
> 	cancel_work_sync(&ctrl->ctrl.reset_work);
> -	cancel_work_sync(&ctrl->err_work);
> 	cancel_delayed_work_sync(&ctrl->connect_work);
> 
> 	ctrl->ctrl.opts = NULL;
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
