Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F88C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 31 May 2022 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJNK0c5mX6YX+CKVjOyKTa9QgWojDcOFC9rcet7m5hU=; b=aUkqy5cXpDAIGTpV4PJMqO6WZu
	IXnZi5ru34AEaw8FalM4cyHXsKZUvIOC0+MJBzC5ne482+pZTYlG6iAlHKeUwIL9ugF3II3UM4gpM
	pERzXUqST7arfqSz6Z+ELcIQmh9fjBW6ZPXRFihB9JDqk1z4OFxxX8fIZ8i4V5mOBUQLMQGAY0n3g
	FAzR4yJbc77dRhrgSmiLcAsRAyimTae6YE5XC+K7utL9MxEU+HJcqbCppFzHQneadlgbVjun4JoZE
	IC/qPlzXKSsogloVRQEx3ExMDFtd73ZUfZQ+UOE+BP4G8hMujcM40eCa0EK5LoWm9eMsvTFaoyTeQ
	SN/ZMHiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7SG-00CJuR-Ns; Tue, 31 May 2022 19:23:00 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nw7SE-00CJtI-De
	for linux-nvme@lists.infradead.org; Tue, 31 May 2022 19:22:59 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24VFiGmP013556
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=HJNK0c5mX6YX+CKVjOyKTa9QgWojDcOFC9rcet7m5hU=;
 b=BuF77ijzBIeFP7An/UKT7vCVFgYp5c8MuNjrmaK+lhkJkE+fju4+Hv7iKKAH0u8oAClK
 rCCxDNDT7ow+RvTJ8G0gV2uO0r61UTCbjP1VK9FB5r9I4iSdbTgy77gHjjY13T6hOih2
 agtJgKQV9GGwdJZ0l5sLQC3tCyOzxHoA9LI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3gbfdtg6nv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 31 May 2022 12:22:57 -0700
Received: from twshared8508.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 31 May 2022 12:22:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 221AC4924B1B; Tue, 31 May 2022 12:11:38 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <damien.lemoal@opensource.wdc.com>,
        <ebiggers@kernel.org>, <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv5 11/11] fs: add support for dma aligned direct-io
Date: Tue, 31 May 2022 12:11:37 -0700
Message-ID: <20220531191137.2291467-12-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220531191137.2291467-1-kbusch@fb.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OXPkv8GQDEKY8bFVa--pOJxDmdFt7fL8
X-Proofpoint-GUID: OXPkv8GQDEKY8bFVa--pOJxDmdFt7fL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_07,2022-05-30_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_122258_608807_46F1D1AB 
X-CRM114-Status: GOOD (  16.68  )
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

Use the address alignment requirements from the block_device for direct
io instead of requiring addresses be aligned to the block size.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 80f9b047aa1b..dd78549d9fd6 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -233,7 +233,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	struct inode *inode =3D iter->inode;
 	unsigned int blkbits =3D blksize_bits(bdev_logical_block_size(iomap->bd=
ev));
 	unsigned int fs_block_size =3D i_blocksize(inode), pad;
-	unsigned int align =3D iov_iter_alignment(dio->submit.iter);
 	loff_t length =3D iomap_length(iter);
 	loff_t pos =3D iter->pos;
 	unsigned int bio_opf;
@@ -244,7 +243,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_i=
ter *iter,
 	size_t copied =3D 0;
 	size_t orig_count;
=20
-	if ((pos | length | align) & ((1 << blkbits) - 1))
+	if ((pos | length) & ((1 << blkbits) - 1) ||
+	    !bvev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
=20
 	if (iomap->type =3D=3D IOMAP_UNWRITTEN) {
--=20
2.30.2


