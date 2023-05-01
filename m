Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919FDC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zN8/BtsC/plhymDR0YrBtDqGFWFnMyTPOQP4TEUp75M=; b=P123flFCCOReW7tVjaxcsvB5eU
	Nltv0TFmgUJ31u+ml22G+iW+MOPHjfT67MvxvILyHHrIy0YWmvBQTre6ppGCo14pKphpkVlAqX4Sl
	akK3iexfoK4KykmLFB5nDWcFbpK4Zow4uMwosQ2cXJXPQvCPJ4MWjcmS7DRJtXl8MTi/m+sP2p2Ce
	LYWNQjnyfa3FdKncupKZaMc9NKKkHADsGMabWcMzw6sM4jj5hPt2YPBC2kn2BS+/ee2znv413xpZl
	hEXoRnfQ5Bo24aWTX+44nMfdmlwprHGYCUIxaQ7ibba0A8e5i6bMDwW+xYtnEFej1OelM5/FASJGA
	7qhPipzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWs-00GEW2-2L;
	Mon, 01 May 2023 15:33:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWo-00GEU0-2b
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 15:33:28 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341F8QIS015484
	for <linux-nvme@lists.infradead.org>; Mon, 1 May 2023 08:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=zN8/BtsC/plhymDR0YrBtDqGFWFnMyTPOQP4TEUp75M=;
 b=S6ViWi9cUN+4SgBa2tW65yG8O+QQIE2M56i9br1p8gVXJgHHoJHN3aUBlL2PQ7aAPPP6
 mT7ZGljVKdOn9WibudbrkVZCkaQxyY8EAyDMNA42wy1uyArfFc3aJvsIoIodSMqITQh8
 IKYDAhYwvvIhHpBjJuZhPL1ftTboUiBFMHv7LqnNzRxS8w/8MwUBwvfeG1FHTwWV9F71
 Z+9KcCFMZPAAvFbvxLzYl1MlFjmqPkHa0ElSrgiwXPf2T/UnolqDbyfz3mWg84WlPYHQ
 QGDpoLGLuR0au6iEb7zKgZrIbIXPT6vhqoLtEqURZPvYZe6kA4Pq2bUOJf2gO6yOSwV7 uQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qaft2g58g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 08:33:25 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:24 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:23 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 46DA71777ADBD; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [RFC 1/3] nvme: skip block cgroups for passthrough commands
Date: Mon, 1 May 2023 08:33:04 -0700
Message-ID: <20230501153306.537124-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
References: <20230501153306.537124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fYwAwe_CAiDnxDiRC5QsL0fOQmjsnUPX
X-Proofpoint-GUID: fYwAwe_CAiDnxDiRC5QsL0fOQmjsnUPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_083326_850511_ED8C0813 
X-CRM114-Status: GOOD (  16.67  )
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

Passthrough requests don't go through the submit_bio() path, so all the
overhead of setting up the bio's cgroup is wasted cycles. Provide a path
to skip this setup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 +-
 include/linux/bio.h       | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..3804e5205b42b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -192,7 +192,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		goto out;
 	bio =3D req->bio;
 	if (bdev)
-		bio_set_dev(bio, bdev);
+		__bio_set_dev(bio, bdev);
=20
 	if (bdev && meta_buffer && meta_len) {
 		meta =3D nvme_add_user_metadata(req, meta_buffer, meta_len,
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e15..bf003412653dc 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -509,12 +509,17 @@ static inline void bio_clone_blkg_association(struc=
t bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
=20
-static inline void bio_set_dev(struct bio *bio, struct block_device *bde=
v)
+static inline void __bio_set_dev(struct bio *bio, struct block_device *b=
dev)
 {
 	bio_clear_flag(bio, BIO_REMAPPED);
 	if (bio->bi_bdev !=3D bdev)
 		bio_clear_flag(bio, BIO_BPS_THROTTLED);
 	bio->bi_bdev =3D bdev;
+}
+
+static inline void bio_set_dev(struct bio *bio, struct block_device *bde=
v)
+{
+	__bio_set_dev(bio, bdev);
 	bio_associate_blkg(bio);
 }
=20
--=20
2.34.1


