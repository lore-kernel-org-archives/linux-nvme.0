Return-Path: <SRS0=r3NF=XC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A7FC43331
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 06:14:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74D6206BB
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Sep 2019 06:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQFCLYVA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MCVfr7wV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74D6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:
	In-Reply-To:To:From:Subject:Mime-Version:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kjDcx8HCLWY5FzNdof+TSk2cwUryydMrKz3PQG0FDVw=; b=cQFCLYVA49tsGa
	Wbz+M/JHFRrg2Fas36ew3h1VSwwTempM2uREgVFhms9oJbHpe8RiRdfXmVkLHNBcYIRLH2hKd0ABS
	hE+X830DSYrjTqTD8pHsSJ7sMLKKEeZOCQgRcyzYzE3o6Q8kttQpJVZW8E7WDNPPhdHRjgvVbyB0F
	jOOSqcco4VHtyfAnpru5Rc7v/z4uLF46Y1Ry98dfYXvXZ1vnNJ7zmgpqTB+1E9M5eQ0F54slExh6O
	1xV1aNWxWxwq1/iXS2Cs9CGg4LD1W7K2NtO4+cVH/bnHFst3UsofYTwde9viDyyq5sBH/7QLnzyHI
	KYBs1P2NWRvikpgqS2cA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6Tz2-0007Ua-Q7; Sat, 07 Sep 2019 06:14:04 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Tyy-0007U9-5q
 for linux-nvme@lists.infradead.org; Sat, 07 Sep 2019 06:14:02 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20190907061352epoutp022c7e8d3dffff1bc13792b29b0e2a8bb4~CE0rEYUdN3218432184epoutp02Y
 for <linux-nvme@lists.infradead.org>; Sat,  7 Sep 2019 06:13:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20190907061352epoutp022c7e8d3dffff1bc13792b29b0e2a8bb4~CE0rEYUdN3218432184epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1567836832;
 bh=RHAhUw8JyYTsJvg4vmUzKRzM78YLPUMEpN/OZDtpePc=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=MCVfr7wVX4d+qWJL9zLWZo4/jFrUZ14QgyxGlGkTyLePdHh91jyTK7FC4jlmLK5P/
 KHxX6BHyc5rqyf8qsnxsSRDq53TFb2Qlw+WgCkHgKr5H5jgMpeE/NQMhfbS5FXfoRg
 TCnW8JUtSicwg7D1Z72ynYSahBWxBn3k0Ac69QYo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20190907061351epcas2p1c289b7660c2cb94b4edcce4d6fb1f592~CE0qNW_id0282402824epcas2p1L;
 Sat,  7 Sep 2019 06:13:51 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.188]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 46QPJG0HvrzMqYkV; Sat,  7 Sep
 2019 06:13:50 +0000 (GMT)
X-AuditID: b6c32a46-fedff70000001035-5a-5d734a9d573f
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 6B.F8.04149.D9A437D5; Sat,  7 Sep 2019 15:13:49 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCHv2] nvme: Assign subsy instance from first ctrl
From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190905163354.25139-1-kbusch@kernel.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190907061349epcms2p76a7cba4689b2ff2bd5a65640f5529605@epcms2p7>
Date: Sat, 07 Sep 2019 15:13:49 +0900
X-CMS-MailID: 20190907061349epcms2p76a7cba4689b2ff2bd5a65640f5529605
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUgUaRzHe3bG2VGbmDazXwa1TEVXZO0u7jpZRmQnk5ckRP9cmTe4DyrO
 7k4za5TBJUlZ9kIGxt1e5dJtSRqJ24uL28uxWQvVJdgZrNFWkAZaSmUvx1XejqPUfx++fJ/n
 +/s+LzRh6qAy6Aq3FytuUeKoFPLqrcX2zFMFarGl/cxKfuzaHYr3v7pO8edbbxv445FHiH/Y
 eZLim871G/nAvijFN0e/GviBe38R/MWhEXJNijDQO4CEhtpho9AdbyeFYMtBSrgU2COEYzWU
 8Ka/jxSOXm5BQtvlXlJ4F5xblPKztKoci06smLG71OOscJflcj9tKskrsTss1kzrCj6bM7tF
 F87l1m0oysyvkBLTcuYdolSVkIpEVeWWr16leKq82FzuUb25HJadkmy1ystU0aVWucuWlXpc
 OVaLxWZPOH+Ryp/4D1FyF73zw+h7Qw0ao+pRMg1sFoQf9pP1KIU2sSEEv9/oNtYjmmbY6fAl
 NEPzzGDXwp+HjyZpsomdB58GLbq8GIbD95M0pthFUNM4SGqcxubDgaefCG1Lgn1pgCMHIxNZ
 DPxW10/qPAc6mq8gjZPZbAifOD7hmQmx1tfGSR6504R0ToN98b8JnafDs3/DSJsHWID48God
 axF8ztMdhxG0txXonA3/PQ2Pj8mwhfD20ZBBs5PsQrgyquiWdRC9e3Y8lEgU7Hh9ktAsRKJh
 W+dyffP50NVH6o5pcODWF+NkpdDpFwad58ObSGRixNnQ3DM0UUmAax96xnUT+ytEfbfJY8js
 +3bIvu9yfd9y/YhoQelYVl1lWLXJtu/vNYjGH+2S/BAKPNgQQSyNuKkMn6cUm5LEHeouVwQB
 TXBpTFu7XGxinOKuaqx4SpQqCasRZE+0byAyZpZ6El/A7S2x2m0Oh2WFnbc7bDw3iwmmxraa
 2DLRiysxlrEyuc5AJ2fUoC11OUJh6n5m/UWxxe6rrnuXGtgdM7Y27R0b2bTgx42nJEnpOrFt
 s7M7nhGK45ybS9N/6OrrUxd0Ev7qusbRwu3yP717Bl95Yg6LUPtH5QPvc8fd65sLwj3pj/kL
 AfBkBT+nq/KUtcnUhUZ29kd/Gm6sFBqiTNbc6vP3O/MwR6rlonUJoaji/+Pv3vXKAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190905163547epcas5p185b3455e7f33cff005c48a0f25745bab
References: <20190905163354.25139-1-kbusch@kernel.org>
 <CGME20190905163547epcas5p185b3455e7f33cff005c48a0f25745bab@epcms2p7>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_231400_455834_60930BFA 
X-CRM114-Status: GOOD (  15.37  )
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
Reply-To: minwoo.im@samsung.com
Cc: Hannes Reinecke <hare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Subject: [PATCHv2] nvme: Assign subsy instance from first ctrl

I'm not sure but, I have not seen 'subsy' thing before.  Maybe
s/sybsy/subsys/ ?

> 
> The namespace disk names must be unique for the lifetime of the
> subsystem. This was accomplished by using their parent subsystems'
> instances which were allocated independently from the controllers
> connected to that subsystem. This allowed name prefixes assigned to
> namespaces to match a controller from an unrelated subsystem, and has
> created confusion among users examining device nodes.
> 
> Ensure a namespace's subsystem instance never clashes with a controller
> instance of another subsystem by transferring the instance ownership
> to the parent subsystem from the first controller discovered in that
> subsystem.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Keith, Thanks for this patch.  I really like this concept which can
avoid from instance mistakes.

Otherwise looks good to me.

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
