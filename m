Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8652AC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:51:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4B22224D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wWYphpQp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxX6xM3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4B22224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=76sAGabzgP9+BXD33nBYPS6yLMfiMe0O3tL/xS9t5PQ=; b=wWYphpQp2D2LU+AaV2fJA8Kv8
	RGa0ptoe7iIdJWFHePVTdRWpaCZD2G8Sg3fxk8j830zLXI0pgjS5uSxPEng03kxVAsyxD7rkf9L7+
	7AsKOXtzE2OGNNcjd7OOMwAKqYaZsLQSlDnsOTGkZrPkXDnEkbvwlLXYKPynmuTpva9CTAMVPkvkG
	fcWg5DKlZ91YHEZGlfHeCwuDkGd8g6P8W3Y3T8Cn+c2n1+48imwtc8uGOMUCWak+tQfy2u0w2JpAa
	/nWNwRpTeLxALCKx21OcJ+/8xJCHBvGcokMd/KwW8RRgb8RiL4ZzsBkSLWXmefcbWqnimbwdSLwTX
	oQX7+FSZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWVj-00071d-0e; Mon, 19 Oct 2020 14:51:43 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWVg-00070z-Vv
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:51:41 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEmktR196091;
 Mon, 19 Oct 2020 14:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NF9XWOwcFZ86CpyxW+RQIP1FvDwl4Kvzgdc+qymUjcc=;
 b=kxX6xM3fl8v75xf5eT7uyxG44xv2u1+2l+vmS7vNO35FmKT2ayl+3ZFXh3dgP1YkeHeg
 ckxKmpGAsx0czil1evgvwqx3EYSdN8ocwe4vEF8/oXx8fdBO7NQVn03+vR21/51+TgQT
 6BAgcuC9Gwx9Ibews+qg64jHJAgxPM1f4/nb7hRpUCCw5tM9yCgmKWNAFtkXyno1rq5Y
 NV+oWVIaz07JhmPdBvAUTWAjssBgTxvu94e4NQtqKa5JEwKarhVXAqBPly7iNFGNp+ec
 Id2aJe7fXpHq4HgqtXay7LXqCBIxqHGGVCPEOU/ap/XHIelGpUirtHmXIzXT0dqKo9i+ Qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 347rjknwwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 14:51:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JEjwSC144180;
 Mon, 19 Oct 2020 14:51:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 348a6m088g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:51:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09JEpcD4015677;
 Mon, 19 Oct 2020 14:51:38 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:51:38 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 3/4] nvme-fc: remove nvme_fc_terminate_io()
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016212729.49138-4-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:51:36 -0500
Message-Id: <00E40C1E-9374-4E3D-BB63-BDE1DFFAB46F@oracle.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
 <20201016212729.49138-4-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_105141_129808_EB45ADA9 
X-CRM114-Status: GOOD (  28.98  )
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
> __nvme_fc_terminate_io() is now called by only 1 place, in reset_work.
> Consoldate and move the functionality of terminate_io into reset_work.
> 
> In reset_work, rather than calling the create_association directly,
> schedule the connect work element to do its thing. After scheduling, flush
> the connect work element to continue with semantic of not returning until
> connect has been attempted at least once.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 49 ++++++++++++++----------------------------
> 1 file changed, 16 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index d65a4a9f4808..b2f9b3752df7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3279,49 +3279,32 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
> }
> 
> static void
> -__nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
> +nvme_fc_reset_ctrl_work(struct work_struct *work)
> {
> -	/*
> -	 * For any other state, kill the association. As this routine
> -	 * is a common io abort routine for resetting and such, after
> -	 * the association is terminated, ensure that the state is set
> -	 * to CONNECTING.
> -	 */
> +	struct nvme_fc_ctrl *ctrl =
> +		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> 
> -	nvme_stop_keep_alive(&ctrl->ctrl);
> +	nvme_stop_ctrl(&ctrl->ctrl);
> 
> 	/* will block will waiting for io to terminate */
> 	nvme_fc_delete_association(ctrl);
> 
> -	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
> -	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> +	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
> 		dev_err(ctrl->ctrl.device,
> 			"NVME-FC{%d}: error_recovery: Couldn't change state "
> 			"to CONNECTING\n", ctrl->cnum);
> -}
> -
> -static void
> -nvme_fc_reset_ctrl_work(struct work_struct *work)
> -{
> -	struct nvme_fc_ctrl *ctrl =
> -		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
> -	int ret;
> -
> -	__nvme_fc_terminate_io(ctrl);
> 
> -	nvme_stop_ctrl(&ctrl->ctrl);
> -
> -	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
> -		ret = nvme_fc_create_association(ctrl);
> -	else
> -		ret = -ENOTCONN;
> -
> -	if (ret)
> -		nvme_fc_reconnect_or_delete(ctrl, ret);
> -	else
> -		dev_info(ctrl->ctrl.device,
> -			"NVME-FC{%d}: controller reset complete\n",
> -			ctrl->cnum);
> +	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
> +		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
> +			dev_err(ctrl->ctrl.device,
> +				"NVME-FC{%d}: failed to schedule connect "
> +				"after reset\n", ctrl->cnum);
> +		} else {
> +			flush_delayed_work(&ctrl->connect_work);
> +		}
> +	} else {
> +		nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
> +	}
> }
> 
> 
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Okay. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
