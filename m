Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTth+ppG1ZjwXraXMR+U8AMElWzxev/HoVAAn9Cuo0g=; b=egIC/RB6qxQYO2biHDwiokL2E3
	wNk8mn55KzVs1HHEkCIbNOow3YBPm75HeXayvTBEx+HyKkeZYA/B8nljed8o0WzaM6xDPo++FwkHk
	uG4zbDa9GtBhzUQCIDCqAtzAoiaJ1YxFfGqxmNlBl6v8+rudTr4ZR9AUDSED5IArHfN+a6qtr1XGE
	h5ij7xgM51Rty0kJd7u+oGZq5mqNY1njD5KFh/fIUbtdq5AOUFnJaa3CFI9skaRCFdQ33hTsjAzH1
	9bX3MGeKdC2wM1XXSOQ4IkKssayCXoZoLy1k0bST7z6VEYvqx8u/U4gu4o87L4/Bg5i2jY4BVr3S4
	TaaU0fFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl89-009hJn-2f; Fri, 10 Jun 2022 20:21:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzl86-009hJN-5T
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 20:21:15 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AIAKDB020120
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:21:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qTth+ppG1ZjwXraXMR+U8AMElWzxev/HoVAAn9Cuo0g=;
 b=eEWccvzobcg0vZw/OguU4JlSyQCcm2H9YJ4Uh40cFBtk6auUnyjt95EUpW/F0Aza8R1Y
 4t3yZUkDcqYSFCWZAP8hIVmFV5iELmjqbvca7BR2/4PYP7jawS11+5TT3diWiNMPiMLw
 lqjwfW2ahm3nidn08hQ2mKYRq/t1pRcMizE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmb0hgruq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 13:21:13 -0700
Received: from twshared5131.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 10 Jun 2022 13:21:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 467E84E9D68A; Fri, 10 Jun 2022 12:58:31 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCHv6 01/11] block: fix infinite loop for invalid zone append
Date: Fri, 10 Jun 2022 12:58:20 -0700
Message-ID: <20220610195830.3574005-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220610195830.3574005-1-kbusch@fb.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SjfHVpYhr61zAZNvn0xzJB9m-CyL1GI3
X-Proofpoint-ORIG-GUID: SjfHVpYhr61zAZNvn0xzJB9m-CyL1GI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_08,2022-06-09_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_132114_256163_3D4C00B1 
X-CRM114-Status: GOOD (  16.09  )
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

Returning 0 early from __bio_iov_append_get_pages() for the
max_append_sectors warning just creates an infinite loop since 0 means
success, and the bio will never fill from the unadvancing iov_iter. We
could turn the return into an error value, but it will already be turned
into an error value later on, so just remove the warning. Clearly no one
ever hit it anyway.

Fixes: 0512a75b98f84 ("block: Introduce REQ_OP_ZONE_APPEND")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f92d0223247b..d481d5e4fe47 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1229,9 +1229,6 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)
 	size_t offset;
 	int ret =3D 0;
=20
-	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
-
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far a=
s
 	 * possible so that we can start filling biovecs from the beginning
--=20
2.30.2


