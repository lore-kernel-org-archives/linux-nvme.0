Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8AAC77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 05:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:To:From:Subject:
	Mime-Version:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=v5oUq0SppcnCED62w1178jYoqlFl81B5r/ZCTfebK3s=; b=FV1imXILG5oxLtQVE30FaiKNDV
	pbtGXpF57OEgzce3GGGD583Bjh89hwrHFdU1NAfK9/ysz1im/PcJY5y9bgrU0vw/v9jkTdUDbzWX5
	TUQiP/YOBXqH1AUkC36ByflEuoNH4gYFO8NNJO3ryq+/pyQQN5Neo3FVKl/WRFGKaA9NS7ut6ZGep
	aOKBJfUAWiWiay6GhoQH70pX187k5QMQNwr18vODR9bHuhSzWCdf8h1RMTNwpNNlgnuDv194M+p7a
	JNaokrXkwrCuHXkyIkfZJ6UQM/9/Yc0mQ9v2TVmJEinpdVoPblFCfAxhRJsjEoovnfWG/1/T98M8w
	0Ym1aRRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmSyW-001qMz-2x;
	Wed, 12 Apr 2023 05:24:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmSyS-001qLq-2i
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 05:24:55 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230412052444epoutp0253243200c025c9ddb38bdfd94f9d05cc~VGJm7zBDb1069610696epoutp02g
	for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 05:24:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230412052444epoutp0253243200c025c9ddb38bdfd94f9d05cc~VGJm7zBDb1069610696epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681277084;
	bh=v5oUq0SppcnCED62w1178jYoqlFl81B5r/ZCTfebK3s=;
	h=Subject:Reply-To:From:To:Date:References:From;
	b=lepOsG0GWxMn++duGTgxr26jCjHYAbSziTezcjXMMSw2lbWI8/btOCC1X6RGQNPCh
	 hqII/M/hejWKhfkXRII3OOYO01VtYrBNX9oRYag250pnAjK+l1C6+i0VOM0btktar+
	 8UvvW74xiTCgGyt04Wf7aOipFj85hf7VQIS1EthY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20230412052444epcas2p2a8c7973e807db9d214cdc074a1a168e3~VGJmqP0Sk2476624766epcas2p2v;
	Wed, 12 Apr 2023 05:24:44 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4PxB3b3Z9Dz4x9Px; Wed, 12 Apr
	2023 05:24:43 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-fb-6436409bf158
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.E0.09650.B9046346; Wed, 12 Apr 2023 14:24:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/2] nvme-pci: fix metadata mapping length
From: Jinyoung CHOI <j-young.choi@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
Date: Wed, 12 Apr 2023 14:24:43 +0900
X-CMS-MailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhe5sB7MUg4PzxCz+7znGZjHr9msW
	i5eHNC1Wrj7KZNHbv5XNYtKha4wWl3fNYbOYv+wpu8W61+9ZHDg9Jja/Y/c4f28ji8emVZ1s
	HpuX1HvsvtnA5tG3ZRWjx+dNch7tB7qZAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0M
	DHUNLS3MlRTyEnNTbZVcfAJ03TJzgK5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak
	5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnbLl2ir3gAk/F01Ur2BsYt3J1MXJySAiYSDzZ
	cYSpi5GLQ0hgB6NEw4Ve9i5GDg5eAUGJvzuEQWqEBawkDj//ywpiCwkoSZxbM4sRpERYwEDi
	Vq85SJhNQE/i55IZbCBjRAQuMkm0db1ghpjPKzGj/SkLhC0tsX35VkYIW0Pix7JeqBpRiZur
	37LD2O+PzYeqEZFovXcWqkZQ4sHP3VBxSYlDh76ygdwgIZAvseFAIES4RuLt8gNQJfoS1zo2
	gq3lFfCVmLd8GdgYFgFVie2bFzNB1LhIHJx6HOwtZgF5ie1v5zCDjGQW0JRYv0sfYrqyxJFb
	LBAVfBIdh/+ywzzVsPE3VvaOeU+YIFrVJBY1GUGEZSS+Hp4PVeIhcfXaQcYJjIqzEKE8C8kJ
	sxBOWMDIvIpRLLWgODc9tdiowAQescn5uZsYwYlUy2MH4+y3H/QOMTJxMB5ilOBgVhLh/eFi
	miLEm5JYWZValB9fVJqTWnyI0RTo+YnMUqLJ+cBUnlcSb2hiaWBiZmZobmRqYK4kzvuxQzlF
	SCA9sSQ1OzW1ILUIpo+Jg1OqgUmpu+jwm4SljnYpuyyOt3o8WbuY9eytad/m5HdlnT9Tmriy
	Suj678yMrTPS40P2yer+nirhtXFVyOerKXc98pqP8l+bne30wJv9+qOFviztK1ccT5i7L9sz
	hPfDuoViRjavJSdwdP2SWKA+uZexJ2/OMXaFIt3K0HdeMzd6Kb17NPMX59dv8+71u2TfvMfd
	ulDwBPus83Fxlytvbte9evNk94MPa2/90pQXPr9735ozQpV7uQJT/PbXlZX1fnshJPXV6spM
	PiHVzWxXhDOX2itJFVpOyDTSmHxlJkuE/IHlouy1wS6Jonz7GzK2/3rAtLNrNceqbcnh15XE
	W6Ov6X5l1hZWYJ/Eqj3t0OcrjruUWIozEg21mIuKEwFzI74WLQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
References: <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_222453_984565_C52CC5AF 
X-CRM114-Status: GOOD (  18.26  )
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
Reply-To: j-young.choi@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Even if the memory allocated for integrity is physically continuous,
struct bio_vec is composed separately for each page size.
In order not to use the blk_rq_map_integrity_sg(), the length of the
DMA mapping should be the total size of integrity payload.

Fixes: 783b94bd9250 ("nvme-pci: do not build a scatterlist to map metadata")
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/nvme/host/pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 593f86323e25..611c677add67 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -827,8 +827,10 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_page(dev->dev, rq_integrity_vec(req)->bv_page,
+				     rq_integrity_vec(req)->bv_offset,
+				     rq_integrity_payload_size(req),
+				     rq_dma_dir(req));
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -968,7 +970,8 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
+			       rq_integrity_payload_size(req),
+			       rq_data_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
-- 
2.34.1

