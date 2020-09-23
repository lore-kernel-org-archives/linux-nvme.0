Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26946C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 14:08:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B064721D92
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 14:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h3N82oHX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRQRDqxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B064721D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9VaVOFk1JCiWrDE1zyHxENocITKliyx/s+VqSd3BTZE=; b=h3N82oHXn6uCeswnoNvrkvufj
	PB9+85vthRoI1aAVRF+JWALzwrWXFzyAnvRZcRfu60VA9nBT9a4EtRlP6sfXuU9VQ8xsBIx/7htET
	PfekNRYmjYfLf5W6IVXFqyVO/+ri9P7DyPa0pYsTCbOh9tKrHdDr3uYTAc83UKW4mALFKhaiMYXzi
	fkKDe/3ZlrjCh7jtgWn4g/uMFaXqg4JM37JEIYPXCH5EhDCFZJUwpdZEWsshDDLB9b3BkiNJqUdIX
	xKs6Xhmkt3qTova7Hx+L0P1ySg1eGOB5HKp+l7U1OvzsMTUaH9S/pWAeFFC0gQVT6mKSAWIIQ0YoA
	aiwKci1FA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL5R9-0004Zp-DL; Wed, 23 Sep 2020 14:07:59 +0000
Received: from aserp2130.oracle.com ([141.146.126.79])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL5R5-0004YU-DW
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 14:07:56 +0000
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NE3USu132313;
 Wed, 23 Sep 2020 14:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=xYweH1JCGqcx15ydFpDL3sntGwXUzSAnzGIoCiSHqGM=;
 b=nRQRDqxKih0hfD634gbMZm+b1w1KSzkv3A8mHEzEBjFs4iSNTbUfjRwWGrF5kn/5GS5G
 mSTYnA8WdiKKSfK6SWwuttDD1NuKnQ7wsxV2YQoliq80L52JSIualVQ5Dvn+uB61SjDJ
 pnlPmt/1NQ0td8qm6FRNCncuHZb86GEPjrmJk+Cy2u2tvcNniqcYWd8rRdad2ptbsXOx
 m/chGhOAUNDeM2GwSGhEWGNedSKKdXSG2n/tyVh3Qz6/VrMLyldzNcaPK7JVcYgIPzlv
 RvICz5bPHFr2cQEwo7LvnIi4oZ9B73YbEwjyM/xQmGoceOtnYh2EPtmVX6j3K1NCwmMK qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2130.oracle.com with ESMTP id 33qcptyks0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Sep 2020 14:07:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08NE5O5Q039322;
 Wed, 23 Sep 2020 14:07:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 33nux16kb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2020 14:07:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08NE7mKb022087;
 Wed, 23 Sep 2020 14:07:48 GMT
Received: from [10.154.189.113] (/10.154.189.113)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 23 Sep 2020 07:07:48 -0700
Subject: Re: [PATCH] nvmet-fc: fix missing check for no hostport struct
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20200922215412.126070-1-james.smart@broadcom.com>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Message-ID: <b050942b-85a0-28eb-0411-1349be37b429@oracle.com>
Date: Wed, 23 Sep 2020 09:07:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200922215412.126070-1-james.smart@broadcom.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009230113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_100755_551488_9C27ED28 
X-CRM114-Status: GOOD (  26.94  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/22/20 4:54 PM, James Smart wrote:
> A hostport port pointer is allowed to be NULL as it is not allocated if
> the lldd does not support the new interfaces for NVME LS request support.
> The hostport free routine validates the handle but forgot to validate the
> hostport pointer.
> 
> Validate the hostport pointer before using it to validate the handle.
> 
> Signed-off-by: James Smart <james.smart@broadcom.com>
> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index e6861cc10e7d..cd4e73aa9807 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1019,7 +1019,7 @@ static void
>   nvmet_fc_free_hostport(struct nvmet_fc_hostport *hostport)
>   {
>   	/* if LLDD not implemented, leave as NULL */
> -	if (!hostport->hosthandle)
> +	if (!hostport || !hostport->hosthandle)
>   		return;
>   
>   	nvmet_fc_hostport_put(hostport);
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

Looks fine.

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                         Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
