Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E12C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=IAuuI4KmPgvXGGmPerEFyRoNxI
	vcuuuIa2QNEAZqmdPHj3VsLcgldvR1Y6it1XDPd+MpM5ueQ5eOnoECGkyzJTsT0QC1j2YwVqoTPbT
	mgjDVjcPWU3MaBOUIyAD+eNKhQyxEFaZbZC7fW855ghCs+uG4jr71EyqASmHY7NCsaH52ug+E3Ems
	g3mTZUTONBuY6kowS9GOkZ+Hyg9jiuekgZLoPpiqckZCNkiTc+ga+zIkiSSvnzBPntEPK0bjGb8kj
	HLVHr4ch14vmQr2snJVcQoCZ6fcK4bpINjXlzr/Lql9MLL0hADi8E5V/vaL+1jCj8LFIZoqbtXDFH
	pMh0ADrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5NJj-00Egmp-RH; Wed, 14 Dec 2022 08:40:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5NJh-00Eglq-9Y
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 08:40:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73AED67373; Wed, 14 Dec 2022 09:40:37 +0100 (CET)
Date: Wed, 14 Dec 2022 09:40:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	Klaus Jensen <k.jensen@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] nvme-pci: fix doorbell buffer value endianness
Message-ID: <20221214084037.GA4988@lst.de>
References: <20221213085807.90656-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213085807.90656-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_004041_489790_224FF8AC 
X-CRM114-Status: UNSURE (   8.47  )
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

Thanks,

applied to nvme-6.2.

