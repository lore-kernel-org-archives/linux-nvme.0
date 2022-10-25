Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D04DC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=F+IpX9QDjpHG9PBeyvLgkNUkA0
	ZvHNWTAxT3LYfD9BSMwOGAb5TN5CCTuMOyRJi1KBu2gbpYv6p8Va7qG2Ya3jJNytnILKh65ITkSVj
	12vTzPF9uC6pl4zlHTDNjixALGAnOQ5hseZHcmxlnR22TRx+Wdz+qhXOJbppUZV3pP+aFlvEj09pP
	UIRy8ZD2t3KJ1ID0AKogQm3vkkeuU20waWNdNuLltIfOg2+Kq9sYW7qtBG1twwcX86Bfcjv7p06RV
	NbfT4uj45WBNlUt4Ew9PwBWj7Yd9Bu8he0fdxm3g+BRiIRX0BgIgyoKN3Y9kvWK9vb64HPTzVMndg
	gfK1nSlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLaZ-0060xT-3b; Tue, 25 Oct 2022 15:11:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLaX-0060wT-5b
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:11:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E2A668B05; Tue, 25 Oct 2022 17:11:30 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:11:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-multipath: set queue dma alignment to 3
Message-ID: <20221025151130.GC22870@lst.de>
References: <20221024185745.3164002-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024185745.3164002-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_081133_359224_9EA73886 
X-CRM114-Status: UNSURE (   7.97  )
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

