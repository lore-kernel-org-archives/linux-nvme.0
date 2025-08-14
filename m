Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB9CA0EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=IC4v6faf4rMTkTUr9hOyfwDGwc
	QvLPEkxezZuTEKPiXUzh5J5wSOcnBNrVQHGwvqsDjigL3V3gMrcDYWVQXIa9KW1ZUd2jv3rSCo7mg
	+1uAxZ4iFPL9W+RzOk5sg7ALsnZ5mKbx7uzyr6BS1ZrMfTiyZZBLHo6Y0AMW3vODng87ngp3E4ZbX
	sJoqzkYioLWAyls2VrbSOjloCA2etkHzfKfPcX9wZzsTkyjr0W/MmPA2p0i+QT5jhTU6yrtRqh1dR
	vzQpr6HvujF2wVK35YOcM0V3frzCiNCDQR3DHRAQkh61VEXd8LXZGfzhThBNFmWrCBXA/S7PZEWwo
	Fts7YXsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYkt-0000000HClb-2stU;
	Thu, 14 Aug 2025 14:16:35 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV36-0000000GZ7s-1wI4
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:19:09 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250814101904epoutp04f94e1519b36d9182b3e61967bd9efecf~bmtrTVCxC0197501975epoutp04A
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:19:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250814101904epoutp04f94e1519b36d9182b3e61967bd9efecf~bmtrTVCxC0197501975epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166744;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=KRm9SZuHBOVsFXAPjbcBWiYNxbyOLjoQpbc1oXnG6nj7R9mMmT9exP0xg0/cOD0ab
	 npMikj0Ya3Lzf5T5bp2WnPtwMGWe+fwtE0ok5xJj+zpfigS0qEgwMyhnD/hnji/UtI
	 YFq6W0SQrV3PSGn6S3YRTMCebIfvqm4DO37yKAMA=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101903epcas5p1fb57ac49a123584de124e99553427e3d~bmtqyRzr51323713237epcas5p1X;
	Thu, 14 Aug 2025 10:19:03 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4c2h6b3Hpjz6B9mB; Thu, 14 Aug
	2025 10:19:03 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101903epcas5p42d87b111af021856d5f2a228164b2706~bmtqAslX_3044630446epcas5p47;
	Thu, 14 Aug 2025 10:19:03 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101902epsmtip2c41dd11d771c993a9e159c6a87857bcb~bmtpLjtWd0731907319epsmtip2R;
	Thu, 14 Aug 2025 10:19:02 +0000 (GMT)
Message-ID: <96e4c31a-6184-4456-b2e9-a5bb61cfc93c@samsung.com>
Date: Thu, 14 Aug 2025 15:49:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 4/9] blk-mq: remove REQ_P2PDMA flag
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-5-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101903epcas5p42d87b111af021856d5f2a228164b2706
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153223epcas5p4f1ee75d1bfb98a338ffe65348631b731
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153223epcas5p4f1ee75d1bfb98a338ffe65348631b731@epcas5p4.samsung.com>
	<20250813153153.3260897-5-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_031908_660357_CEFA79AC 
X-CRM114-Status: UNSURE (   4.87  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

