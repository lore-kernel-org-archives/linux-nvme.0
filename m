Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC30CA0EEA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Aug 2025 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=mjSAQNi6czkQwGJI8LlzsufAYb
	Wh5aeOYgdQwIDsTL+GkddDiU7mU1pdzGdlXr/uSfH6P+ErxYdXOZSl1LzwTAC55pfRAxvgjFTtsRJ
	afyf9qPu5E59QBQQxL57ZnCSfPgP7Iy6rx2K3iZbIV5teyWF3d0D38g6HWheW3c12xKsAw7N96Sy3
	akHf+jVTFTtwph5pBUFYODtQADTxjaqBaiN6/kwdyP7+tbhGKjmQ02PFIucNY6KTc3EQb64WQJJ/C
	4tVYNkR9LlYNFAUt8ZTG560l5AMuurqV+ttelQWvzWGJ/WDfv2sTiz1WRrpRwI0KSU6ryQh6Wm6J6
	L3m9VI+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umYku-0000000HCm2-1XYP;
	Thu, 14 Aug 2025 14:16:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umV3e-0000000GZG3-3IAV
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 10:19:44 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250814101939epoutp02abe5da91f1357a766d0d808dd1a7b683~bmuMTR8LX2624526245epoutp02j
	for <linux-nvme@lists.infradead.org>; Thu, 14 Aug 2025 10:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250814101939epoutp02abe5da91f1357a766d0d808dd1a7b683~bmuMTR8LX2624526245epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755166779;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=pNmH0FaBdhJi5GCleaX5YrbEuGgqO8fxI7upRtA8HuWOM79jjZEXvn+9efuQcBrQB
	 dhl9WifHJov4msUDx3jT84I5E1ed8SIYu6un9XKkfGb6zSaLFXZfkZ3qWgJR5gjkSb
	 2VrSw6yARYKwgrVKlON5KgHQvZiqyQwfMwjS2jqc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250814101939epcas5p13414b84e40dd8a4c18acd68113da9556~bmuMEeR2Q2712427124epcas5p1X;
	Thu, 14 Aug 2025 10:19:39 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c2h7G6WsJz2SSKg; Thu, 14 Aug
	2025 10:19:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250814101938epcas5p1ce0b49e258d364f291d60e4205d6f986~bmuK1tAnt3078130781epcas5p1b;
	Thu, 14 Aug 2025 10:19:38 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250814101937epsmtip254567898b8b94fa7c76ed676c70bfe35~bmuKAOqNS0840808408epsmtip2F;
	Thu, 14 Aug 2025 10:19:37 +0000 (GMT)
Message-ID: <9deaa7f5-7142-4ba5-a17a-2f0ffc84df3c@samsung.com>
Date: Thu, 14 Aug 2025 15:49:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 5/9] blk-mq-dma: move common dma start code to a
 helper
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: hch@lst.de, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250813153153.3260897-6-kbusch@meta.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250814101938epcas5p1ce0b49e258d364f291d60e4205d6f986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250813153730epcas5p3b207c1ce658df5a5f5527611540e8362
References: <20250813153153.3260897-1-kbusch@meta.com>
	<CGME20250813153730epcas5p3b207c1ce658df5a5f5527611540e8362@epcas5p3.samsung.com>
	<20250813153153.3260897-6-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250814_031942_972739_BB4E61B4 
X-CRM114-Status: UNSURE (   5.26  )
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

