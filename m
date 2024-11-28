Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A877D690FC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2024 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=; b=ZBRhCFTouLaTi5sF+CH/tLkUl1
	UVjpRbPA1impMb3lBFXAsvg1wfgOg2zphBKJimOUdf9RmbMlu/ZbuyVV6cKU95kygPDiu5q/+zgYM
	pK2L9T8FppWfISbbmH2c1EjBz9f/DwNAmMPSGN5JtLeOBcLUX3r581swg3BUdkbkCRfmH+2H6s9L+
	3OIWf9jR7Xu/43hwygUhfis3ITVEL9xkYT0B9rkgCAv/oZzMv+j/WzWGtb/1aY11+MbZw4EIxR8gb
	iUJksZVsFGHommgAAI45OUMUUqZbuoeVKI9xc/GZXFWwAqhQQkxD0rjpghJf1bD5ksjNYAbleXLXO
	3j/N3djQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyM-0000000FO15-0Az1;
	Thu, 28 Nov 2024 11:46:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyK-0000000FNzf-1a6w
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Nov 2024 11:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=; b=Pnh3z1sbn8Kivx528/v2X9vKQ3
	18vmNHIMHGS7DMCpcqCYdVVwzjrhtjhudhDZrkoR1mfO7YT1SJTaCd51BFu5Lvu4i0XNyoJ/EwvgV
	4wXkPjpbKGpgh+DUXtQktXwaZ4LjKoKSF5kqilqZ3Xw88IP22CuHsmbfIhlhtl8UXLLv6iLSszvE4
	X6Mb8Wi7yDnizmLd44Jp2hXUdDsTTXDqAnEG6WeYFzadBdPLn7bJwa9b1VsT5p2hdCJYm4PQIYngV
	/4KqsBJNFcroIgshzL9mbPhgtGqepIpcyxXB36BpmaMNi+Sc45JnxBdbWgUY5mkVq2y/GOdDLvPL9
	rmqfDPLw==;
Received: from [203.254.224.24] (helo=mailout1.samsung.com)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGcyF-00000001awt-05gc
	for linux-nvme@lists.infradead.org;
	Thu, 28 Nov 2024 11:46:11 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241128114555epoutp019eef521917dd6694de28bbdbd177515c~MH0kG14d52980929809epoutp01G
	for <linux-nvme@lists.infradead.org>; Thu, 28 Nov 2024 11:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241128114555epoutp019eef521917dd6694de28bbdbd177515c~MH0kG14d52980929809epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732794355;
	bh=FQM1oME+yjLcszh/NNdlGeevLgEVh+e4WfItNIpaOVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r2RGuylJhHYpxtovtgeiOV8PXusomywuf6dxPTVuD7qsu6x25+7l7nupUO0uQQ9pS
	 OHWViXD4dn1uwF+hGKT964g+3kF8H2ksy5TYSS56ykSi0C8e+yC4l4xHaoBiZVsoYf
	 8I0Is1T8TEBRReviGiuH7+NbR6lBo6nN4uTI3C+c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241128114554epcas5p2c9df787ad8145e598d3817c5db00bcca~MH0jhfO8m1857618576epcas5p28;
	Thu, 28 Nov 2024 11:45:54 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XzZJH2fn4z4x9Pr; Thu, 28 Nov
	2024 11:45:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.B3.19710.FE758476; Thu, 28 Nov 2024 20:45:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241128113058epcas5p1f544aa328a27b59f96b48b94dc0bdf94~MHnhJguS-1316913169epcas5p1r;
	Thu, 28 Nov 2024 11:30:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241128113058epsmtrp2b79823e07685711bd53938c807451bc2~MHnhIiCRN3231632316epsmtrp2k;
	Thu, 28 Nov 2024 11:30:58 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-81-674857efef9e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.58.33707.27458476; Thu, 28 Nov 2024 20:30:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241128113056epsmtip211016eab1dc2a7836a08fd9d6c853c49~MHne1hoN12660826608epsmtip2H;
	Thu, 28 Nov 2024 11:30:56 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v11 02/10] block: copy back bounce buffer to user-space
 correctly in case of split
Date: Thu, 28 Nov 2024 16:52:32 +0530
Message-Id: <20241128112240.8867-3-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmuu77cI90g4mX+S0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7N4ffgTo8XNAzuZLFauPspk8a71HIvF7OnNTBaTDl1jtNh7S9tiz96TLBbz
	lz1lt+i+voPNYvnxf0wW5/8eZ7U4P2sOu4Ogx85Zd9k9Lp8t9di0qpPNY/OSeo/dNxvYPD4+
	vcXi0bdlFaPHmQVH2D0+b5Lz2PTkLVMAV1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGh
	rqGlhbmSQl5ibqqtkotPgK5bZg7QO0oKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpSc
	ApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzPs5uYClbzVaxqmMbWwDiJp4uRk0NCwETi0LJ9
	TF2MXBxCArsZJe70nGeFcD4xShy5fpgFzunpOcII03LqxUtmiMRORomXB3awQzifGSXuT/vN
	BlLFJqAuceR5KyNIQkRgD6NE78LTYLOYBV4ySixdtYgFpEpYIEXi/J+P7CA2i4CqxI0Ph8G6
	eQUsJFa8PcEKsU9eYual72A1nAKWErOvfWOFqBGUODnzCdgcZqCa5q2zwW6SEDjDIfF8dSvU
	sS4Sb479YIKwhSVeHd/CDmFLSXx+t5cNwk6X+HH5KVRNgUTzsX1QvfYSraf6gYZyAC3QlFi/
	Sx8iLCsx9dQ6Joi9fBK9v59AtfJK7JgHYytJtK+cA2VLSOw91wBle0g8vLeKDRJcPcAQ7rjM
	NIFRYRaSf2Yh+WcWwuoFjMyrGCVTC4pz01OTTQsM81LL4RGdnJ+7iRGcyrVcdjDemP9P7xAj
	EwfjIUYJDmYlEd4Cbvd0Id6UxMqq1KL8+KLSnNTiQ4ymwACfyCwlmpwPzCZ5JfGGJpYGJmZm
	ZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwbX0QfKD8el6QlKe/oEgPD/ukzbuP
	KniXbuVX1jnXaxaisKReU/dVYdWvCaZzla9s5YgV0HllyWC2dV/u7X7F0NeN9zqT/rD8mPw4
	c1/Hm6fZO5Rnt8/0O1WusPQCC89i87dVM6zMxKUEZ3685Xvx4unMpT8md35/xDIjPfRP/oQL
	c9Ntz3yQ3OiofMXIOP3W6wO/tp8sPzjBtG7q5MjFiq9293T6rOnMLRDsWXrog9bmsl2tU+KY
	DZqt9+dsia84sbfa5/mEG3aPq/YHR6m8kco4V86/uvbRp5sS/8utuoMjOmce3WFtd81/5pOD
	Vvk7N+2/ox5gw1lqeKX34vTVU//t0FeZKm3yfJ7CNPl/R5RYijMSDbWYi4oTAeQLVXFuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXrcoxCPdYMpKOYuPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8WkQ9cYLfbe0rbYs/cki8X8
	ZU/ZLbqv72CzWH78H5PF+b/HWS3Oz5rD7iDosXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49P
	b7F49G1ZxehxZsERdo/Pm+Q8Nj15yxTAFcVlk5Kak1mWWqRvl8CV8Xl2E1PBar6KVQ3T2BoY
	J/F0MXJySAiYSJx68ZK5i5GLQ0hgO6PE3ye/2SESEhKnXi5jhLCFJVb+e84OUfSRUeLfzg6w
	IjYBdYkjz1vBikQETjBKzJ/oBlLEDFI04ctsFpCEsECSxMM7LWANLAKqEjc+HGYDsXkFLCRW
	vD3BCrFBXmLmpe9gNZwClhKzr30DiwsB1Vx+fJ0Vol5Q4uTMJ2AzmYHqm7fOZp7AKDALSWoW
	ktQCRqZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMERphW0g3HZ+r96hxiZOBgPMUpwMCuJ
	8BZwu6cL8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MNno
	pP9VfOB4/6PV8fkHMidMq/31/YhhS8TkefkXdXw77f5L+Lq4zBSZ+tfrDUOziqPV6ivvueXX
	VuxnDbE8t7pr2d0/fNaXPfQjUy4vKO8VZ5R8+28+w/LQqbEa29bPcg97f7x+wZ5JLypdn701
	1dXY8XiughXPK6fu9Nd3Cti/Xr8cnH176ez1h65rvH+imfFRo5TVVPbs5ML0zeJ+CxSNln/s
	OznzaLesdOPm+JrreessCuc5HNkmdJDxIH/Liqf5SWd+vShvCVp+LsDkSu8B/jTPeRt1TatF
	5zQJHAi133D8Zoe05LslTUaHRMTOr3okrexjNv2yReZhH7NDAms7Q0onyXLu/1IpOv2ac4oS
	S3FGoqEWc1FxIgB2wfXMHwMAAA==
X-CMS-MailID: 20241128113058epcas5p1f544aa328a27b59f96b48b94dc0bdf94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241128113058epcas5p1f544aa328a27b59f96b48b94dc0bdf94
References: <20241128112240.8867-1-anuj20.g@samsung.com>
	<CGME20241128113058epcas5p1f544aa328a27b59f96b48b94dc0bdf94@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241128_114607_860748_39948ED1 
X-CRM114-Status: GOOD (  17.83  )
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

From: Christoph Hellwig <hch@lst.de>

Copy back the bounce buffer to user-space in entirety when the parent
bio completes. The existing code uses bip_iter.bi_size for sizing the
copy, which can be modified. So move away from that and fetch it from
the vector passed to the block layer. While at it, switch to using
better variable names.

Fixes: 492c5d455969f ("block: bio-integrity: directly map user buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index a448a25d13de..4341b0d4efa1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -118,17 +118,18 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 {
-	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
-	struct bio_vec *copy = &bip->bip_vec[1];
-	size_t bytes = bip->bip_iter.bi_size;
-	struct iov_iter iter;
+	unsigned short orig_nr_vecs = bip->bip_max_vcnt - 1;
+	struct bio_vec *orig_bvecs = &bip->bip_vec[1];
+	struct bio_vec *bounce_bvec = &bip->bip_vec[0];
+	size_t bytes = bounce_bvec->bv_len;
+	struct iov_iter orig_iter;
 	int ret;
 
-	iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
-	ret = copy_to_iter(bvec_virt(bip->bip_vec), bytes, &iter);
+	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
+	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(copy, nr_vecs, true);
+	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
 }
 
 /**
-- 
2.25.1


