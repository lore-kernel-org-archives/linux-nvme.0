Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BB7C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:02:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A006222D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2ICZmLlZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bZzXmrSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A006222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9Q6loGKKZPtBcymJjyKpwDU7i2a0gWuH76hs7L2Ic8g=; b=2ICZmLlZxAxLzvHMABdxpTO6M
	M+1gfQifNyYS68H3eW2CutGSY+C1Pkkmyvwx5AiUB3cNKwgEzrTnupIczrhZHv2y0RW50MJ2AOpfb
	tML8lf0wL9oJHnG9RGqlIXWVje0pUpcaAviERv98hwSWzM7ok5soJiGmZUrdYll/DV72WzDSQuexT
	KTTNM0Pq7dBcBXjJI4d6xAdFpeCtUDq/l6VJHB8D2TDtRNW1S2a+XKIwnIX+3NdfdspnyHNrRV5dN
	cn1jpo7hP+fdm2sC+OG4WkG9PZ0s6LEf+g4YZGIeMAQYJ7b8vgYLOkst5fPiQ6MzVNUZzYk6AypQ6
	d8odaR9EA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWfe-0000BD-Ak; Mon, 19 Oct 2020 15:01:58 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWfb-0000Ah-Dd
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 15:01:56 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JF0Eja190652;
 Mon, 19 Oct 2020 15:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=NwCgnJCOgOLN0nBE1yn3u1s/cNMfcnW1K7iY3LFp3W4=;
 b=bZzXmrSVlkOn8UfV7SXpUWkPHHdrME9SC4pyuQU0pUv7ZcMUBv2pcNLCli0Jg4PcUMCs
 /tumpVM07uXa8+dCh660wZeZXlUsnuhPRlLaKJXuk3p9vO6tNb4HuQ7VK0+NXe6fHCae
 ZseDiUXlQzWEMqhzRqjKES4vTTI4l8uZgi0tLSQX3EBaVViWS7PE7Rm+avHz0GKvG4Z6
 sxLr01E4q/VGe9pXHmEIJ09b2IfOIhZV6tSxt0nKd3jV94teuUhvhMBIqmccaA9wIy4B
 MjldvUSQpKrd9s2T0A1CBnfZD68Ow9KFC7nKrV2NFHe5wJ4LBbrlKKyCR1h0fKGPy1Ym Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 347s8mnyep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 19 Oct 2020 15:01:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JExpm9137288;
 Mon, 19 Oct 2020 14:59:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 348acpjuxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2020 14:59:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JExpEr030218;
 Mon, 19 Oct 2020 14:59:52 GMT
Received: from [192.168.1.25] (/70.114.128.235)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 19 Oct 2020 07:59:51 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nvme-fc: shorten reconnect delay if possible for FC
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20201016212928.49429-1-james.smart@broadcom.com>
Date: Mon, 19 Oct 2020 09:59:51 -0500
Message-Id: <11A701E9-B011-402F-9B78-BD5CD265D27B@oracle.com>
References: <20201016212928.49429-1-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=2 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9778
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=2
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_110155_634871_F1549EEF 
X-CRM114-Status: GOOD (  34.76  )
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



> On Oct 16, 2020, at 4:29 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> We've had several complaints about a 10s reconnect delay (the default)
> when there was an error while there is connectivity to a subsystem.
> The max_reconnects and reconnect_delay are set in common code prior to
> calling the transport to create the controller.
> 
> This change checks if the default reconnect delay is being used, and if
> so, it adjusts it to a shorter period (2s) for the nvme-fc transport.
> It does so by calculating the controller loss tmo window, changing the
> value of the reconnect delay, and then recalculating the maximum number
> of reconnect attempts allowed.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 19 ++++++++++++++++++-
> 1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6352068c0c4a..1af7c6f358f5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -26,6 +26,10 @@ enum nvme_fc_queue_flags {
> };
> 
> #define NVME_FC_DEFAULT_DEV_LOSS_TMO	60	/* seconds */
> +#define NVME_FC_DEFAULT_RECONNECT_TMO	2	/* delay between reconnects
> +						 * when connected and a
> +						 * connection failure.
> +						 */
> 
> struct nvme_fc_queue {
> 	struct nvme_fc_ctrl	*ctrl;
> @@ -3387,7 +3391,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> {
> 	struct nvme_fc_ctrl *ctrl;
> 	unsigned long flags;
> -	int ret, idx;
> +	int ret, idx, ctrl_loss_tmo;
> 
> 	if (!(rport->remoteport.port_role &
> 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
> @@ -3413,6 +3417,19 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> 		goto out_free_ctrl;
> 	}
> 
> +	/*
> +	 * if ctrl_loss_tmo is being enforced and the default reconnect delay
> +	 * is being used, change to a shorter reconnect delay for FC.
> +	 */
> +	if (opts->max_reconnects != -1 &&
> +	    opts->reconnect_delay == NVMF_DEF_RECONNECT_DELAY &&
> +	    opts->reconnect_delay > NVME_FC_DEFAULT_RECONNECT_TMO) {
> +		ctrl_loss_tmo = opts->max_reconnects * opts->reconnect_delay;
> +		opts->reconnect_delay = NVME_FC_DEFAULT_RECONNECT_TMO;
> +		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
> +						opts->reconnect_delay);
> +	}
> +
> 	ctrl->ctrl.opts = opts;
> 	ctrl->ctrl.nr_reconnects = 0;
> 	if (lport->dev)
> -- 
> 2.26.2
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks good.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
