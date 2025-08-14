Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA99CA0EDC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=lIQRxlBQGV62oYtWGjPC/jnWeh
	pK6OvxAm0B5Uz2dEkuOPjdnHsAvjeMJC5+N4wlLxt7Kc+/fQpXXJhjJdMUg0wUdaluGIDUN734viy
	lJeYHFZy069tdf2JIBgN8pzPsmo5qy76OkIhjfuiXIMJxx6umsL6xt9GwHN0BSm0g2umd/hbRFQH1
	GQiAkJsKLumPiLHHc0evFtdpMZfk0RKu4XrC6cis4OVOln+U89PHgJpbeej6IQ+PjqIiuW8RPa2g1
	/kjygeBuM81iDwaGJAHbZ/mj2ncT+QJjspUlR50/wutSxnrkH/XnGRFrsaSXSOVNZrEk3qgssnE1G
	TauFzXkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYks-0000000HCkn-1hgS;
	Thu, 14 Aug 2025 14:16:34 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV29-0000000GYvG-09cK
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:18:10 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250814101802epoutp02d6d33ffa65338997b9b91eabdf27a6c6~bmsxuyhqi2306023060epoutp02Q
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250814101802epoutp02d6d33ffa65338997b9b91eabdf27a6c6~bmsxuyhqi2306023060epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166682;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=p/iMwl8WRiKK20aKvvNVks9OQM5jZmGTFIRi6rOohBHyuLIIYracWUDS3pS13Gm47
	 m/GnQjyzoAYmU9f6vwqr37+RQcE/jOblxbnGhs4PHY1ngk5cbA3XChjbbChGWdx7Dz
	 AnNaSPlrEtTcui4UP93hUETO4RQj0ltXluQTqBdc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250814101802epcas5p3d52659ba0690d317226906d2f82b8435~bmsxgaxND1763617636epcas5p3D;
	Thu, 14 Aug 2025 10:18:02 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h5P4gnjz2SSKX; Thu, 14 Aug
	2025 10:18:01 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250814101801epcas5p45dd331437f58bf8471ca3b31d29ce377~bmswVmCEl1575315753epcas5p4N;
	Thu, 14 Aug 2025 10:18:01 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250814101800epsmtip14995173e0b70524de737c14130df23cd~bmsveYB5f1533815338epsmtip1J;
	Thu, 14 Aug 2025 10:18:00 +0000 (GMT)
Message-ID: <fa08192a-6fb2-4ac4-a426-a70adf20b9de@samsung.com>
Date: Thu, 14 Aug 2025 15:47:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 2/9] blk-mq-dma: provide the bio_vec array being
 iterated
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-3-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101801epcas5p45dd331437f58bf8471ca3b31d29ce377
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153211epcas5p43fa34d5d05a24e605eb1884f601ecbde
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153211epcas5p43fa34d5d05a24e605eb1884f601ecbde@epcas5p4.samsung.com>
	<20250813153153.3260897-3-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_031809_232534_9906DBE3 
X-CRM114-Status: UNSURE (   4.80  )
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

