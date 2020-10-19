Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43EBC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:56:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0BE222D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y1E07Rm3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oNdCLVYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0BE222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oLpLa0TAqvQdqP7UYfAvULIfQiwwydXo56rUE1Or4Y4=; b=y1E07Rm3RpjalIsGE0gWU4RLF
	QxzJ7dTyQ8lE5ROWIIpUpYhUQciWgKP6lmULLWzHEu9C2XhfKc6GJ3CmWsvwfVR7KwmAU8W1lWqTZ
	G8ud9ddmC14UP8NE5CT7kRICL1Rttd5veSgDnTopqysUVngoMerdopVH7J9KPrdms9//9i0IUJSdB
	nMrRD1SxuedxbgvJAdig1EIiwk0MQRu1SzHX+LT4PdC5vsco2tMXD1FfAUIRyEjSNqqQPZoP14jwb
	ceO4BCkReLodj7zTvmXtSz4bozknadUMSTvl95FO5l5Rmjx6dyVcx1+OsHG+IYQulNj4+l2Z65fsw
	ykni5tbRw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWaW-0007mT-3H; Mon, 19 Oct 2020 14:56:40 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWaT-0007lf-KK
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:56:38 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEtPAV008765;
 Mon, 19 Oct 2020 14:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=TPD5Vv6CVykSTUPNU6MwxeIQwtjx+ecx+dSu59TxZc8=;
 b=oNdCLVYU+J3tOEH4qTNC3yRTbPTkTTEI6HaIxUQkGc5iPjhap/1uS8hKgZGRC/TVSpIP
 hZlxtVcbBMTfAjYjWERNBK298MhbWTdwxvl9V2UOmVu8S1i/978ZZzVNS76btczz0t1X
 xnQmJLH0U4ED/Ly2Hc+L9ZrJ4jnZWNj2MN7n9p3UYTvTi38N/nBt2xEgTsvqQQaglaHz
 LP00g0KGKKediIQLSgfquni5uhCoCAi9FI+5gmEQ0KDPN8XG09wdqDSEuoRbdAcgIWD1
 VMzkH0P6BMP14wb4OaSTtWdtl/Bp3gxq0NrRRC3oY2tVtku3ONUXs3Fc3hH2cFwTzecj ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 347rjknxwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:56:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEjWP5010924;
 Mon, 19 Oct 2020 14:54:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 348agw83h9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:54:35 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JEsZDu017477;
 Mon, 19 Oct 2020 14:54:35 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:54:35 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 4/4] nvme_fc: track error_recovery while connecting
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016212729.49138-5-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:54:33 -0500
Message-Id: <8332227D-4103-42D6-B40F-772EE1C2871C@oracle.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
 <20201016212729.49138-5-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_105638_060711_5FA7F8AB 
X-CRM114-Status: GOOD (  29.99  )
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
> Whenever there are errors during CONNECTING, the driver recovers by
> aborting all outstanding ios and counts on the io completion to fail them
> and thus the connection/association they are on.  However, the connection
> failure depends on a failure state from the core routines.  Not all
> commands that are issued by the core routine are guaranteed to cause a
> failure of the core routine. They may be treated as a failure status and
> the status is then ignored.
> 
> As such, whenever the transport enters error_recovery while CONNECTING,
> it will set a new flag indicating an association failed. The
> create_association routine which creates and initializes the controller,
> will monitor the state of the flag as well as the core routine error
> status and ensure the association fails if there was an error.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b2f9b3752df7..6352068c0c4a 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -142,7 +142,8 @@ struct nvme_fc_rport {
> 
> /* fc_ctrl flags values - specified as bit positions */
> #define ASSOC_ACTIVE		0
> -#define FCCTRL_TERMIO		1
> +#define ASSOC_FAILED		1
> +#define FCCTRL_TERMIO		2
> 
> struct nvme_fc_ctrl {
> 	spinlock_t		lock;
> @@ -2498,6 +2499,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> 	 */
> 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
> 		__nvme_fc_abort_outstanding_ios(ctrl, true);
> +		set_bit(ASSOC_FAILED, &ctrl->flags);
> 		return;
> 	}
> 
> @@ -3030,6 +3032,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> 		ctrl->cnum, ctrl->lport->localport.port_name,
> 		ctrl->rport->remoteport.port_name, ctrl->ctrl.opts->subsysnqn);
> 
> +	clear_bit(ASSOC_FAILED, &ctrl->flags);
> +
> 	/*
> 	 * Create the admin queue
> 	 */
> @@ -3058,7 +3062,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> 	 */
> 
> 	ret = nvme_enable_ctrl(&ctrl->ctrl);
> -	if (ret)
> +	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
> 		goto out_disconnect_admin_queue;
> 
> 	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
> @@ -3068,7 +3072,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> 
> 	ret = nvme_init_identify(&ctrl->ctrl);
> -	if (ret)
> +	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
> 		goto out_disconnect_admin_queue;
> 
> 	/* sanity checks */
> @@ -3113,9 +3117,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> 			ret = nvme_fc_create_io_queues(ctrl);
> 		else
> 			ret = nvme_fc_recreate_io_queues(ctrl);
> -		if (ret)
> -			goto out_term_aen_ops;
> 	}
> +	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
> +		goto out_term_aen_ops;
> 
> 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> 
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks fine. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
