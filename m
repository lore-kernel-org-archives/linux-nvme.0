Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9296AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=0z1F02MBYpGDoMEMgKLZWx9Kfi
	mgXHsVb7sbZGZOwiZCzKhcXl2N5mJtA7OZW1YEQeD3qCNGKkhGGc4LH/ZknfhoO8MjLcgg+QJull4
	h6QIh4yRgYCAZTW5+CvXqbN85FvgLpl9riIJ0vmGiQdwI93md0KBlwOxFa/l1RwJ+pwOIAL+5LOMa
	/DuM9OwJ0p9i/qMPSVXp1ADFJTMVhz9lxM3DiwovYp+RzqwmQ6QWAINAhE63gy4sEmdvKnSD5eSl3
	+QTW7W2zNe4sO6B5m6xcezJTmI92nzTPhSQ6uI4gzzP3ksmFRyGZ7/qdITM0fb7opbTj7Y3g1vhOb
	L31UBtQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoBe-0001EL-Cz; Mon, 10 Oct 2022 08:30:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoBX-0001CW-H2
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:30:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2B5968AA6; Mon, 10 Oct 2022 10:30:48 +0200 (CEST)
Date: Mon, 10 Oct 2022 10:30:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xi Ruoyao <xry111@xry111.site>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Ning Wang <ningwang35@outlook.com>, Chang Feng <flukehn@gmail.com>
Subject: Re: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro5000 SSDs
Message-ID: <20221010083048.GB24401@lst.de>
References: <20220928093913.45905-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928093913.45905-1-xry111@xry111.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_013051_724321_DB6F0C6D 
X-CRM114-Status: UNSURE (   8.74  )
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

applied to nvme-6.1.

