Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125CEC43464
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 16:38:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860A42074B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 16:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vMtuyPcR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v70Z4T/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860A42074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ehQk1quNlmjXJczk0GwE6RSejpqyuJOMfEX2cNC0ydQ=; b=vMtuyPcRCI53w6uo0xNdjJz4W
	mcaIN+Nu6tbvvvOVKLckhgZelhTnyhYj/K2BIr7nd7GlIkrZTSteChEt3/R9Cx97aGES2O4fDucHx
	CdHFFnWAPn/4IHUGulBHr50KzyM71HbDuBMwW0IizezRIsjVda1WgbrR9cjmYBDhXgcXMdCA/K49M
	P1hu7HRDMmpbeWu9mHrZQ0DrcuAm3ynzL8serSBnqe/OaUd0D7nR10ezGnpQGI2HdEyAU2o68IPLJ
	EVwHFUW2w/ArqY/ENe1usXHrekpuErH/btcoG8LWbiLddx/vGEHOFiWtJCGEGNqIuGyCQX6/Yvljb
	o7a74362A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJJPG-0005jp-Ob; Fri, 18 Sep 2020 16:38:42 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJJPD-0005jC-Pu
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 16:38:40 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IGXmBu123179;
 Fri, 18 Sep 2020 16:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=ynKKWItDgn28TUwwgDgyL+R+ER5dl/mT5hL3cDO4GE8=;
 b=v70Z4T/goD4LYnX9Pa9RKIAUyPlLZmo8E4rmkPTexzAfx82Hcq1nCI12GLF83OZBIJ3f
 Wz3ndYfDATHj6+CaIfsHTwR8O6B6NxdHMbOr5umFeUDU7BLmEwwSif5WSBy08nbGBYBX
 PDHkP79hkRkZdBJh56ORMcGzsWPKY1a487Ho33aCj/NKtr9fSYZepIr2AfO5d1t6DoYr
 iI/lWEue8/82hJ5ZWPFPVwRTAwjueg5UTQJa9PX07UYDqWsCubQ/yTYwgXRQskxTu1va
 r9poWV2XlCPf9dXwrulvk8q5tMXnBHXG3Kx4RSu9td0KkyYOmjfRDmnu+60b6ROpCewZ cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 33gnrrga1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Sep 2020 16:38:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IGZbXJ178945;
 Fri, 18 Sep 2020 16:38:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 33h88eynf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2020 16:38:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08IGcS2P022364;
 Fri, 18 Sep 2020 16:38:28 GMT
Received: from dhcp-10-154-149-240.vpn.oracle.com (/10.154.149.240)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 18 Sep 2020 16:38:28 +0000
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nvme-fc: fail new connections to a deleted host or remote
 port
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200917203322.57405-1-james.smart@broadcom.com>
Date: Fri, 18 Sep 2020 11:38:27 -0500
Message-Id: <8C47B7DD-E299-4E01-AFB6-40FD5A232F60@oracle.com>
References: <20200917203322.57405-1-james.smart@broadcom.com>
To: James Smart <james.smart@broadcom.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 suspectscore=4 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=4
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200918_123839_991693_6EC7C3D5 
X-CRM114-Status: GOOD (  24.14  )
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



> On Sep 17, 2020, at 3:33 PM, James Smart <james.smart@broadcom.com> wrote:
> 
> The lldd may have made calls to delete a remote port or local port and
> the delete is in progress when the cli then attempts to create a new
> controller. Currently, this proceeds without error although it can't be
> very successful.
> 
> Fix this by validating that both the host port and remote port are
> present when a new controller is to be created.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
> drivers/nvme/host/fc.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index bc4e1af587cc..3f9eb37fe779 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3671,12 +3671,14 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
> 	spin_lock_irqsave(&nvme_fc_lock, flags);
> 	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> 		if (lport->localport.node_name != laddr.nn ||
> -		    lport->localport.port_name != laddr.pn)
> +		    lport->localport.port_name != laddr.pn ||
> +		    lport->localport.port_state != FC_OBJSTATE_ONLINE)
> 			continue;
> 
> 		list_for_each_entry(rport, &lport->endp_list, endp_list) {
> 			if (rport->remoteport.node_name != raddr.nn ||
> -			    rport->remoteport.port_name != raddr.pn)
> +			    rport->remoteport.port_name != raddr.pn ||
> +			    rport->remoteport.port_state != FC_OBJSTATE_ONLINE)
> 				continue;
> 
> 			/* if fail to get reference fall through. Will error */
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
