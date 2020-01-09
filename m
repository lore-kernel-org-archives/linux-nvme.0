Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A27C33C9E
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:14:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C89B2067D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 03:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MgkVvD0t";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jw0xfeUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C89B2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:In-Reply-To:
	Date:References:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ADAEvrUvSO0EF2Xfae1mVNnV5/BPfb0NcDrMhoWjvGI=; b=MgkVvD0tpEgmki
	jZOE36/19jE+I1azBxM0gQkpSljl7HPgG5q7dcdoFGcfvtt3cQExsXxvEjN2Bv6btCYkY3sfDtKuS
	rzcWtDNpWvx/DrPsD68lMl2Jj7CueY3B9rz80s+EnHHwD36S3JuZftQ1httA9NWQLc5xV36otrB1X
	dG+WadYnRGm+tWMcen47B/mXWyEoRdIXKT2nFrI3gwRYu8qxzd5k8DoIxCC2m9IiEOSObZEZzd9Dm
	ebDzi2xupxOxsCnf4kMGqmM51UX6k9Jw5ws5y6HvNPsjCu+vUKEhl92NFYPCxBzuowum91E6IOqjj
	Ba6gjuDglXJB8/uM/T1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipOHF-0001TP-PK; Thu, 09 Jan 2020 03:14:29 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipOHC-0001Q0-3s
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 03:14:29 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093DLqn173499;
 Thu, 9 Jan 2020 03:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=q2Ev4APVMGC9rwtt5rqKSQNmQq3yV4AMRt8emHwr2sU=;
 b=jw0xfeUyfIEEve6VbtmWFy4iiUr5d/bdWBLCKzEIiYVaFi3BcnFh2/oHwjVP9IWNG5xT
 6iZ5yVNcBjpZ1yenrFZ+ruBYqN4xmDj2unMlmcNLb+J4rQMBeAgBBHb1FVXHYM4IQ8lF
 1Q3zbHSk7bDfYgVZAF3VOzKoYHWZ0iOUiRGpau408JUKAaVY+kKX7jcYE4Pg1Yl+Cqf5
 WZCXs9RUMPx+febJjZxaEJvB9sHbGQV38Y/ggMpvPXC9HBoqfUWzwaMD2g1/8YcCRzYo
 /6gMbgiBygXUVfyz8nsSRnMFpuJmawObuUWvCQTY2ff/X6OQhQ9KW50SxOa2c3kfoAvD GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 2xaj4u83qu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:14:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0093EDDA115700;
 Thu, 9 Jan 2020 03:14:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2xdrx729j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jan 2020 03:14:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0093Dx6x030540;
 Thu, 9 Jan 2020 03:13:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 08 Jan 2020 19:13:58 -0800
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 05/15] nvme: Introduce NVME_INLINE_PROT_SG_CNT
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200106133736.123038-1-maxg@mellanox.com>
 <20200106133736.123038-7-maxg@mellanox.com>
Date: Wed, 08 Jan 2020 22:13:55 -0500
In-Reply-To: <20200106133736.123038-7-maxg@mellanox.com> (Max Gurtovoy's
 message of "Mon, 6 Jan 2020 15:37:26 +0200")
Message-ID: <yq1a76xz5ho.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9494
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_191426_254883_12A5D221 
X-CRM114-Status: GOOD (  12.79  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, martin.petersen@oracle.com,
 shlomin@mellanox.com, israelr@mellanox.com, vladimirk@mellanox.com,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Max,

> SGL size of PI metadata is usually small. Thus, 1 inline sg should
> cover most cases. The macro will be used for pre-allocate a single SGL
> entry for protection information. The preallocation of small inline
> SGLs depends on SG_CHAIN capability so if the ARCH doesn't support
> SG_CHAIN, use the runtime allocation for the SGL. This patch is a
> preparation for adding metadata (T10-PI) over fabric support.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
