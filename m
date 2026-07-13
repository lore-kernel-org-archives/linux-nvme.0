Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FACC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=guS3Z5PUuUhJ0dM8H6iEOK9I7l
	hxTd+DEcZIvfUdQllr26WCPcOABxuh01eR74gWlRF3m8RyZ6SaOuN292UqqwzeQ3c/bGE3/h3ILER
	OwuvoV4KIYNfVxLb4+SfkJKxlZoklmzrr9JDlPQfToyK5to3l77uirBYyXPdN2RixPp+Fng5JQOOw
	pi05HvFW7Y5kJi/FPGNQCx1VurbqsRkj3R9rU8Hawa3o+X2UNPGNuydsBzHEKlM07rQR4Nmtb1Lr7
	T5PbDgKDluDMGD8IR2/BTHF598YoS+XZceVYCPgc90y6+MyqmupsM/p5Jf6wvunnSVLzHgjjWsLGY
	Hmf498fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFQo-000000097Ha-1hDX;
	Mon, 13 Jul 2026 12:06:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFQm-000000097Gz-0xzK
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 12:06:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A0C168BFE; Mon, 13 Jul 2026 14:06:37 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:06:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme: fix cdev lifetime
Message-ID: <20260713120637.GD19607@lst.de>
References: <20260713104238.3034640-1-john.g.garry@oracle.com> <20260713104238.3034640-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713104238.3034640-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_050640_408516_8C6E9438 
X-CRM114-Status: UNSURE (   9.05  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


