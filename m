Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC17CD6E44
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u6bDNB2VRw04jTLm2HXVwn98cjhg5mUaN35N0g7+xas=; b=3OetOZcvovyPwR/SMhKE8l/gSY
	DB/qjySL7v1exVYQog65nm3yvsyK2VC6gDDtni9VUOT+qOGkd+zq1mgQGThcdOHkwcWD+O7O6/sRE
	Od0115RyGVHpYYHJ7LiziM2sLVAmW0vdwUP8vukj/wLZExHtKQ/+D6g20FYZjNL13Ll+KcRDruNNX
	f+qzQPIHjJ4ht/eBuCjGLXMkPtTrvlmVckP1cu6toHW5fG4TfPjKdTmqfJfpSIUmQmmhkz0OyOQhv
	1QxygcPXTxdqgLgmekqYipXa48eJS36xUzMxO+12rzwKPAR+wbfiMsCMCpVbiMVuofMUe/zOZJwmX
	xF6EvryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7b-00000004vBM-22wK;
	Thu, 28 May 2026 01:01:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSP7Y-00000004v9m-2308
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:01:13 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKkthv2812561
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=u6bDNB2VRw04jTLm2H
	XVwn98cjhg5mUaN35N0g7+xas=; b=Dp2LTjlgi0TNq0k4S2pcL5TfaB2iPFgVXO
	ftBNKMN1yB+l/1IKFDcJYeOfAR8KGikjhqWJdQ5baOWJHQFDSjZsZFuWRdo+g+zt
	K7iYuUT+xJEbSGyfUtNXHwz6kSCWsT4O37xRbgkiqul3oUBfolsanq1pkvIhUXEU
	a9mZf9pjsLMYqPs/+pvC5+j17AEJOOQX5L1r4aY9XRJBqrRvwfnDaj5wjM90ds7J
	vyy2BeWfeGINo5TpEgea4YQU334umy0CDNzwxgf9Wlb22iy5FbcCY91xAM0FLa+m
	lWo/BLvtUiBZxD5zY1IjdUZazG1Bz0d9kTAiT0w9hFbrsUyRsmfw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x898pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:01:12 -0700 (PDT)
Received: from twshared12601.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 28 May 2026 01:01:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 0A07F1D39B573; Wed, 27 May 2026 18:00:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] block, nvme: enable passthrough iostats
Date: Wed, 27 May 2026 18:00:39 -0700
Message-ID: <20260528010041.1533124-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a1793d8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=D1VwSchhwDu8_UvpV7sA:9
X-Proofpoint-ORIG-GUID: Pe_2lgF4SGBgatPB0fCP1PZCVbbUVrhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAwNyBTYWx0ZWRfX5HzMo6YxOWdN
 wFmtVruR+XxYFgt0SYOQcVLXiLlQx4qKkGz2ngT23q1AKA4X1D9P4gcVxUuOPwsAHJ6J3fBm9CP
 MFOIcQW7yeK7ZS1GhkI5PRso816Pb3o64PnxDedEllrsZ4gPP0VqJf/mInle7LE57RX4DT5Vl1Q
 VloKVvG7Ziv6wBfgICNC8xQ7b4JJ0GVtxBFqqdDpJ+aY7ccIFM0n/poSqyjQ5Oncr+RafVgIWEl
 BpSw24xl//JdgnaAiN9RsffhWw1Zqg/4Rw1wQGdKJVRwRBMDnZ9NqQcC7N3oox61Z5BxAniRSAr
 7hMhHIifawUZXQyoTLvYWP2z3eOfY1ap6aMsGeidpigIG8t9UK6YHIT4RWlQ12W5egesshWaVnf
 FkbWb7oQ2ygjQ3tLZ6CftuDJSiFpuen3B0EzpV7vFXAQBuxj/KmAsGjxHtJ3cHXbZ3ovGKfVt4p
 68z3vCbN7QVjpeqV3rg==
X-Proofpoint-GUID: Pe_2lgF4SGBgatPB0fCP1PZCVbbUVrhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_180112_530897_F897ABA0 
X-CRM114-Status: UNSURE (   7.18  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

v2->v3:

  Added kerneldoc for the exported API

  Added code comment for the passthrough safety

  Added reviews.

Keith Busch (2):
  block: export passthrough stats enabled
  nvme: add support multipath passthrough iostats

 block/blk-mq.c                | 32 +---------------------------
 drivers/nvme/host/ioctl.c     |  9 ++++++++
 drivers/nvme/host/multipath.c |  5 ++++-
 include/linux/blk-mq.h        | 40 +++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 32 deletions(-)

--=20
2.53.0-Meta


