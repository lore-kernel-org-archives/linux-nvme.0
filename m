Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED28C00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 05:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huBJCEKdQCXP9rcWY2HeWnS2YyXrZWGdxQX9cxjt+Cs=; b=Sl4ycOJBVspza93EpEIisN9NMt
	WVvX8u7OqCpbubP3JIVh8JEPfL3uSK9vWdpthaD40QRDvI17X7WMAP+bD98n4YgxJAKCTwT1pzlnp
	d+OMHy0dOajIxalWNPwKxfe1Fakq4NHW6tHdS1V4kU3x1cctFF/rMAChBUSIZHMLnTik0FDnfAsfb
	vFyjvw1KqeFqvkVKgOGHfdS7APxq9vw1CaU9zOUKcAMqTY8+I4dExqlxKLsSgmZsr40Xpz2DlO4IC
	lz9Ou5n36VaJfJ6HLxAF8eBCLxS9gn9mU3aeQHh/9uRQzrozTTEtYhcOqSbjLv4eNOjBAXGL/sVkF
	CI3zwJLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIkhf-00AhLo-0I; Tue, 02 Aug 2022 05:44:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIkha-00AhIZ-Sk
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 05:44:25 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802054415epoutp048bdcac37be4b5ff138222c75a0314139~HcNa5uKxL2634026340epoutp044
	for <linux-nvme@lists.infradead.org>; Tue,  2 Aug 2022 05:44:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802054415epoutp048bdcac37be4b5ff138222c75a0314139~HcNa5uKxL2634026340epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659419055;
	bh=huBJCEKdQCXP9rcWY2HeWnS2YyXrZWGdxQX9cxjt+Cs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ccDt3ahBIwnMKxSltvnufdow3zggc7XD7U9E7hqhKLh33adNzK1i6TPqkgoMZjDq5
	 3D1dPf2f0u/z8ZLceF/mid9nnrvtCS2B3xy4XT5JBqjhDF2HQkjJGzlCAh0CQYeozG
	 uCOrjbffb2ee5VrWXghQGNF/F8/P3qfs3njeu67s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220802054415epcas5p276d2663ffdfee65931ceff835fcc23fd~HcNavPskU1774717747epcas5p2G;
	Tue,  2 Aug 2022 05:44:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4LxkSs13kfz4x9Q8; Tue,  2 Aug
	2022 05:44:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.18.09639.CA9B8E26; Tue,  2 Aug 2022 14:44:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220802054411epcas5p3c0ad2fd30b3679bb8a7ad61e12656ed7~HcNXy0Cht2967729677epcas5p3Q;
	Tue,  2 Aug 2022 05:44:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220802054411epsmtrp2c0ad9f4ddb9a22102e1f9c8c237559fc~HcNXx8Ihe1579515795epsmtrp2N;
	Tue,  2 Aug 2022 05:44:11 +0000 (GMT)
X-AuditID: b6c32a4b-e6dff700000025a7-37-62e8b9acc59c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B6.3E.08905.BA9B8E26; Tue,  2 Aug 2022 14:44:11 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220802054410epsmtip2f1a21d1d0596a6147790d705ea4b00b8~HcNW4jOPd1083910839epsmtip2m;
	Tue,  2 Aug 2022 05:44:10 +0000 (GMT)
Date: Tue, 2 Aug 2022 11:04:49 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Keith
	Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/5] nvme-pci: iod optimisations
Message-ID: <20220802053449.GA22436@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTXXfNzhdJBp1HBSxWrj7KZLF2L7vF
	pEPXGC3mL3vKbrHu9XsWB1aPic3v2D3O39vI4rFpVSebx+Yl9R67bzawBbBGZdtkpCampBYp
	pOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAO1WUihLzCkFCgUkFhcr
	6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnG06wFZwTbii
	efoWtgbGCfxdjJwcEgImEs9/b2DqYuTiEBLYzShxeedJKOcTo8SSDytZIZxvjBLrNh9mh2nZ
	eOcEO0RiL6PE7OUnWSCcZ4wSy55MYwWpYhFQkXj6ZjlQFQcHm4CmxIXJpSBhEQF5ifkPetlA
	bGaBZImvp4+ADRUWMJO4se4PWCuvgK7Ew/Z2dghbUOLkzCcsIDangKnEmYmrGUFsUQFliQPb
	joOdKiHwll1i54S3TBDXuUjcOrqNGcIWlnh1fAvU1VISn9/tZYOwkyUuzTwHVV8i8XjPQSjb
	XqL1VD8zxHEZEnNuTYWy+SR6fz9hAvlFQoBXoqNNCKJcUeLepKesELa4xMMZS6BsD4kvaz8x
	QsKkg1Hi7vK1LBMY5WYh+WcWkhUQtpVE54cm1llAK5gFpCWW/+OAMDUl1u/SX8DIuopRMrWg
	ODc9tdi0wDgvtRweycn5uZsYwclRy3sH46MHH/QOMTJxMB5ilOBgVhLhvePyPEmINyWxsiq1
	KD++qDQntfgQoykweiYyS4km5wPTc15JvKGJpYGJmZmZiaWxmaGSOK/X1U1JQgLpiSWp2amp
	BalFMH1MHJxSDUzapsLTX/oy2zOsrEzau5/VJ3O9xEr7K68DPVMSAuZ6mJnK+752nfmy/tnx
	a0WdO1n4fpieu59U7Kjgl/rv9mT2LoaX12fa7ri0VMKGsWrviktrt34/utxCVPnWlu+CT/I1
	DdnmR29gfvOT6bx0tcbPnE1ZQpeVU++9jZt/SvXTrk/ZH1yYja/diIkt4DzI0jAlyPD83q1x
	ZnmvV1stkT35er//F9tPzf6Tp91dXhya8vLFWrcjh3mO6i5N5f32P+UvR5pQpZHBmgklB6W8
	fp/7HXFkl/aGj1HOhWqnDs5qioyfWf7+s8XHR8oeK8wnntR6s4JHodCzxLbGTPnN3BmzPpht
	Cp5iFXt06bKFbtMPKrEUZyQaajEXFScCAGJJHdgXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvO7qnS+SDKYv1LNYufook8XavewW
	kw5dY7SYv+wpu8W61+9ZHFg9Jja/Y/c4f28ji8emVZ1sHpuX1HvsvtnAFsAaxWWTkpqTWZZa
	pG+XwJWx8Nc/9oIOwYrmcx+ZGhjv8HQxcnJICJhIbLxzgr2LkYtDSGA3o8TX1u+MEAlxieZr
	P9ghbGGJlf+eQxU9YZSYuvQnM0iCRUBF4umb5UAJDg42AU2JC5NLQcIiAvIS8x/0soHYzALJ
	Er+bW1lBbGEBM4kb6/6A2bwCuhIP29uhZnYwSvz7eYkJIiEocXLmExaIZjOJeZsfMoPMZxaQ
	llj+jwMkzClgKnFm4mqwO0UFlCUObDvONIFRcBaS7llIumchdC9gZF7FKJlaUJybnltsWGCY
	l1quV5yYW1yal66XnJ+7iREc7FqaOxi3r/qgd4iRiYPxEKMEB7OSCO8dl+dJQrwpiZVVqUX5
	8UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCt8m5XYTy6p3figXCTw++i
	v945p/JgrsnG2/1tH2Nf6CbaeZ1oqe8z92yVOpj7lT8kctWlM2eEV0UWdiw7crldYc0h53r/
	F0H6xi4C706Xtuzbc0Hl+NK0uxK2N1fybC6+WLXir9+O86YXl33c8/XlvOM3GhNkynJFE32y
	mU4cWydp8kPj+6mVNx6zzy0Xdj4ruzZi028JLlfXlgzBU92/NrfOZJnFNnHd15V/s3cZb7sk
	ePvhBQe9ZSl8evXXPxfcuer3vqM7mutsUZdr6PXJt9n9lScfkIl4G2E99+nkc3JVi01fnf5Q
	wZV7/uy6+jOX4t/FlD0Jy2ntV4vx8lZVi3redk7CpqB/fo3cU+d0JZbijERDLeai4kQA8smv
	TeUCAAA=
X-CMS-MailID: 20220802054411epcas5p3c0ad2fd30b3679bb8a7ad61e12656ed7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_3be21_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729163601epcas5p1c869a72416f1ec91c2f78c8a906bebe3
References: <CGME20220729163601epcas5p1c869a72416f1ec91c2f78c8a906bebe3@epcas5p1.samsung.com>
	<20220729162851.1574210-1-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_224423_517219_E3593765 
X-CRM114-Status: GOOD (  15.11  )
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

------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_3be21_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Jul 29, 2022 at 09:28:46AM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>The series adjusts the struct nvme_iod fields for optimal sizing. The
>end result on 64-bit arch removes 24 bytes, from 152 down to 128. We
>typically allocate many thousands of these, and the cache aligned size
>is a nice bonus.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

But would you like to reduce 8 more bytes by killing meta_dma field?
This one:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06b7ec0d5558..119192363b31 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -232,7 +232,6 @@ struct nvme_iod {
        u8 nents;               /* Used in scatterlist */
        unsigned int dma_len;   /* length of single DMA segment mapping */
        dma_addr_t first_dma;
-       dma_addr_t meta_dma;
        struct scatterlist *sg;
 };

@@ -889,13 +888,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
                struct nvme_command *cmnd)
 {
-       struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+       dma_addr_t meta_dma;

-       iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
+       meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
                        rq_dma_dir(req), 0);
-       if (dma_mapping_error(dev->dev, iod->meta_dma))
+       if (dma_mapping_error(dev->dev, meta_dma))
                return BLK_STS_IOERR;
-       cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+       cmnd->rw.metadata = cpu_to_le64(meta_dma);
        return BLK_STS_OK;
 }

@@ -1030,8 +1029,9 @@ static __always_inline void nvme_pci_unmap_rq(struct request *req)

        if (blk_integrity_rq(req)) {
                struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+               dma_addr_t meta_dma = le64_to_cpu(iod->cmd.rw.metadata);

-               dma_unmap_page(dev->dev, iod->meta_dma,
+               dma_unmap_page(dev->dev, meta_dma,
                               rq_integrity_vec(req)->bv_len, rq_data_dir(req));
        }


------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_3be21_
Content-Type: text/plain; charset="utf-8"


------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_3be21_--

