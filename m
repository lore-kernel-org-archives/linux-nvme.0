Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4570C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 21:50:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36886206BE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 21:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yos4jxoM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NH0EyW1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36886206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ymywi2pobNk+FJpRYT3foSBMym3Zd0/F/Ilik+nDq2s=; b=yos4jxoMN8IvGeAkwApSe52sV
	g0zPCSm4YOfFPBhJsKA7UZi+PS6Jz7MYWfO4y46R0bt2FLLD5Kkw/cQ04i+bMcVaGRO7whn+Y/HoI
	9QtWVOsKVkSXr0pmQndelfM3qeQ7vu9fHHyW7folAWTltvqwm0nJadluVzyE0/QNoyXfLwzExzTSb
	v1DBrjr/4FgZ7Nv7wcw4cUprW2v99/sCsFYTxqBazEe2Ifd3iXM0UtTu2VpGqAgZVMpn7KabLvN16
	xTEXE0fIgQBm/dZJW0ro0n1Mwx1sj6h1mcE5hP7c+hb24RXAOnEfH7ntddfXmJ4wW0QqwDY8Ke5ET
	HlWyAxzGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGqwJ-0003nK-K5; Fri, 11 Sep 2020 21:50:39 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGqwG-0003mw-2L
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 21:50:37 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BLjZTj185724;
 Fri, 11 Sep 2020 21:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=h6zVHSWa0W1YdyR4dQ5FId8QcGDuT8Ra0FIk8VkaLMI=;
 b=NH0EyW1bvChAbjzf4vhfTtB0//B8sBB2Y689AJIpzHV3/hA7tCxQca7KKtn/XFKIdsJj
 g1mt+uLdsDc7zE5zhgLWDPmer4sHUuetjD6IlIviYZDwG5UO5XFnk4K2CioUZ6+dfBAj
 UIvgdeHca+OYEfHmgrO5Jmr3OS77Iy9l/V9Vq4NwglHd9637eYYFQld+unXoFlZCWP5e
 kHy2z0DR87NV6z+tyzdqB8MPiTRk9h2D6ASqFgsMwKf3EBCLuyb7maAso52K85JCiW3S
 BZEAuOP25LKu48Z1fTrXcNQAHtUg3zVny8vu+5/9wtLT2LLGTA/xAPFB7oE8OqOiQO61 IQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 33c23rgqf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Sep 2020 21:50:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BLjjcU120210;
 Fri, 11 Sep 2020 21:50:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 33dacqk28e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2020 21:50:28 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08BLoQUi015525;
 Fri, 11 Sep 2020 21:50:27 GMT
Received: from dhcp-10-154-143-201.vpn.oracle.com (/10.154.143.201)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 11 Sep 2020 14:50:26 -0700
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nvme-fc: soften messages logged by error_recovery
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200911200254.111005-1-james.smart@broadcom.com>
Date: Fri, 11 Sep 2020 16:50:26 -0500
Message-Id: <29E6AB12-E105-4AC1-BBE2-6676FE0855A6@oracle.com>
References: <20200911200254.111005-1-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=4 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110176
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=4 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110176
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_175036_253612_22BE1614 
X-CRM114-Status: GOOD (  23.23  )
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



> On Sep 11, 2020, at 3:02 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> Several of the messages logged vi nvme_fc_error_recovery() come across
> as rather strong events due to the use of the word "error". This is
> causing some interpretations to be overly worried.
> 
> Soften the wording of the messages.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e8ef42b9d50c..bc4e1af587cc 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2433,7 +2433,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
> 		return;
> 
> 	dev_warn(ctrl->ctrl.device,
> -		"NVME-FC{%d}: transport association error detected: %s\n",
> +		"NVME-FC{%d}: transport association event: %s\n",
> 		ctrl->cnum, errmsg);
> 	dev_warn(ctrl->ctrl.device,
> 		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
> @@ -2454,7 +2454,7 @@ nvme_fc_timeout(struct request *rq, bool reserved)
> 	 * the host/io stack, terminate the association on the link,
> 	 * and recreate an association on the link.
> 	 */
> -	nvme_fc_error_recovery(ctrl, "io timeout error");
> +	nvme_fc_error_recovery(ctrl, "io timeout");
> 
> 	/*
> 	 * the io abort has been initiated. Have the reset timer
> -- 
> 2.26.2
> 
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
