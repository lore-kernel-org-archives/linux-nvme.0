Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ADC33C9E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 02:34:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFEA207FF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 02:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGBE7dcA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CRM0Iywu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFEA207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gtzp8ABHYHK0n3XS9pMsjGB3HyxhWEol4hOIaBNqnwM=; b=EGBE7dcApon1jN
	mdl7MYffLeIphqa3x63JdxEVXhCi02OvG2THVpe+g4JTY+NHG8B1o/Cvap2CUa2Ze3AWCShb+muLs
	WDVIRgHOriTaO2+tPzg0surbGubJiIiwJNd7FdboFsKJJ2JMXtzh5DaROUk37sz6/1iP+PbMKbB1l
	UHwqS6OzRCWjdAyP+IxzZQROuNYbPYEK64oAn5gpDy/2qdZByHH8KrH9pjESZHkNrIv/I9e0x+JNM
	ybUJgoYpEiKNWVo7RW7j+MXazhymDXX6JnOmUL4153aJaf5smyGKQLHrcqrD6e5ZvWf47ingzAHT0
	50rVAw7pK/xjfqcRWHaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwdBJ-0002CA-9h; Wed, 29 Jan 2020 02:34:17 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwdBG-0002Bd-1T
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 02:34:15 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T2WxHO111356;
 Wed, 29 Jan 2020 02:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=vRZ9IMeJi6N/rUoL25r46Tnp7wBRn1/l8H/25AfcG1w=;
 b=CRM0IywuPA0EFlagh3izHmTXD4+df6RPO2KPpPrZBqVqB9EJMsi6UPu7Jqg8e72novra
 nbrYzmLpGD32hgLSNTSFMND1pTjJn5Vo7L6WkPkBRdurDP+ii/atSvIhnwnA/Oe+7nqJ
 toNRVMgGlMMvC6TyFRlaz3666+T0moBiqLAIkdi9cG+TB5A6C6y2avz4wcMTl92jXNoY
 DBCYMwMA+JJSzR7HryIA3AC4w3zcQcUrrk12oN/Ha0aInhog9+pUoI/6ZqRmxAzM53is
 JpXmwrCR/a2ifzWn6PhZpYAb21YnEbr61/5dHzCFh0PhwIjbp+5e+MvQjcfQqjSuID4S 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2xreara2jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 02:33:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00T2XeRE008751;
 Wed, 29 Jan 2020 02:33:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2xtmr5x7u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2020 02:33:48 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00T2WsRF022713;
 Wed, 29 Jan 2020 02:32:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 28 Jan 2020 18:32:54 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 13/15] nvmet: Add metadata/T10-PI support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-15-maxg@mellanox.com>
 <yq1sgkpxqf5.fsf@oracle.com>
 <99c92a01-be7b-fd47-3d28-b75e5372c3a6@mellanox.com>
Date: Tue, 28 Jan 2020 21:32:51 -0500
In-Reply-To: <99c92a01-be7b-fd47-3d28-b75e5372c3a6@mellanox.com> (Max
 Gurtovoy's message of "Mon, 27 Jan 2020 19:17:30 +0200")
Message-ID: <yq14kwf8018.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200128_183414_169064_F7D94C43 
X-CRM114-Status: GOOD (  19.04  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 "Martin K. Petersen" <martin.petersen@oracle.com>, shlomin@mellanox.com,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> 2. There is some unclear (to me) behavior in the block layer regarding
> splitting integrity bios. We get guard error over the fabric
> transaction in case we need to split a bio (the error is at the target
> side).
>
> maybe you have an idea how to overcome this ?

I'm working on bringing our data integrity qualification tooling up on
an upstream kernel. The tooling has been stuck in the past for a while
and consequently I haven't tripped over this yet. Will get there soon.

> 3. The maximum_integrity_segments = 1 for NVMe devices, so we can use
> 4096/8=512 integrity sectors before reaching the limit of
> max_integrity_segments. This leads to mdts=6 (256KB) if the bs=512
> . I'm afraid that we might have issues with the fact that the target
> prot_sgl 1 and the NVMe driver set maximum_integrity_segments = 1.

> Therefore, I suggest to limit the mdts per transport (and internally
> check if this ctrl is pi_enabled).

Makes sense. That's kind of what I was fishing for when I asked where
this came from.

> All the above is happening when using submit_bio --> ... --> bio_split
> function that call bio_advance as well (that is called from completion
> context as well). This path is not used in local NVMe IO.

The splitting approach has changed since we cut our last production
kernel. Can't rule out regressions in this area, although I would have
hoped that blktests had caught them.

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
