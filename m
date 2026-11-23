Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C1606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IUdnU3uG;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=XV/b7lph
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=akrhacg0cFqsWcufz/98MzPSnTNhvwT4AO9anWTNIAA=; b=IUdnU3uGR6Yf+ORH7VEDmvCytl
	CGPLQUvOlvsokmyFG+9UryBbg8F55b57aEJDnZ7PWeqKEJiQG9DTeSghJtvx5Tan5aCFZ4bPpm8kB
	Ju77CUjxe3rs1ahQq17afVCTjxVJ+C2Hzg2smJm/XH6N3z3GSoWhoKHblpYIyjsavL+56UPeFJ/IW
	1HJl5XyZce91WLMGQ2rb6F7NrAkyOn+kmt04DEmI39OD6ljROK+mF3Uwq64XO2dzm7C/8zvYROg2c
	8sC7G4Gsk9vNT8lmUs4q6X2APPu8MImlQWftLSLDyEt6LLSlQqcd+NpBLqBuLc5kdeVvlJ9XlRGQi
	8MZvcoVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSqJ-00000003Hdj-3YSu;
	Mon, 23 Nov 2026 12:08:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSqC-00000003HbH-3y3G
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:08:18 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261123120805epoutp0153388e408dee33ec4953818e48ba58cf~qqz5GfoOO1300313003epoutp01V
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 12:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261123120805epoutp0153388e408dee33ec4953818e48ba58cf~qqz5GfoOO1300313003epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795435685;
	bh=akrhacg0cFqsWcufz/98MzPSnTNhvwT4AO9anWTNIAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XV/b7lphJyyKfcaX/THzVnSHnMj4tx+l95LECMiyorjl7jEYL0pdofA4bdueEyqxI
	 p53/N/1UBqAtBBAYDsHa4t8Im4exzQBF+Lq+BvbMqlD/aYwa0N4fyW/BZM8kAPmnr2
	 7cEa7yfqgOcEO6YY/LaXP7DIOlTWYDRnVQLFPJJA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261123120804epcas5p3788cac14b0f09cb98132ffe169443142~qqz4pzvFC0180301803epcas5p3W;
	Mon, 23 Nov 2026 12:08:04 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jY4TH6rdNz6B9m9; Mon, 23 Nov
	2026 12:08:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20261123111745epcas5p17516b453f15308229dde84316befc59f~qqH8P0YiZ0439404394epcas5p11;
	Mon, 23 Nov 2026 11:17:45 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261123111743epsmtip1a4e1c759b0126a595d8444f1f5a558a2~qqH6w5V0s0525305253epsmtip1R;
	Mon, 23 Nov 2026 11:17:43 +0000 (GMT)
Date: Mon, 23 Nov 2026 16:46:55 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, jgg@ziepe.ca, leon@kernel.org, asml.silence@gmail.com,
	joshi.k@samsung.com, anuj1072538@gmail.com, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC 4/4] nvme-rdma: support dma-buf backed requests
Message-ID: <20261123111040.7b2q7fe2xd6k6777@green245.gost>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261121003730.GB14598@lst.de>
X-CMS-MailID: 20261123111745epcas5p17516b453f15308229dde84316befc59f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vhhXPwE56qUOnQTJq0qPMy__lLDvQDDlUWfIrVOyiFlHsdqU=_68caa_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261118103457epcas5p17770752b910960b84cc259d007120965
References: <20261118103327.1788667-1-anuj20.g@samsung.com>
	<CGME20261118103457epcas5p17770752b910960b84cc259d007120965@epcas5p1.samsung.com>
	<20261118103327.1788667-5-anuj20.g@samsung.com>
	<20261121003730.GB14598@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_040814_247813_5F0E8CFE 
X-CRM114-Status: GOOD (  12.58  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

------vhhXPwE56qUOnQTJq0qPMy__lLDvQDDlUWfIrVOyiFlHsdqU=_68caa_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 21/11/26 01:37AM, Christoph Hellwig wrote:
>How does this work with rxe/siw or non-PCIe based HCAs?
>
rxe/swi do not provide a DMA device, so registration fails with
-EOPNOTSUPP (patch 3).

For hardware HCAs, the dma-buf is attached to the DMA device of the
ib_device. Nothing in the mapping path is PCI specific, and if P2P is
not possible for non-PCI device, we expect the exporter's
pci_p2pdma_distance() check to take care of it. We do not have access to
non-PCI HCA setup, so that path is untested.

Thanks,
Nitesh

------vhhXPwE56qUOnQTJq0qPMy__lLDvQDDlUWfIrVOyiFlHsdqU=_68caa_
Content-Type: text/plain; charset="utf-8"


------vhhXPwE56qUOnQTJq0qPMy__lLDvQDDlUWfIrVOyiFlHsdqU=_68caa_--

