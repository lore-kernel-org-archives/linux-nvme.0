Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36441C02190
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AsyOv0MbCVIeUkg+6VQKQCTMCe1byuAue53bHagMKSg=; b=mV4JaOYowGbXaxMNnjbwjpyE42
	OG2ly/qnmREeiWjI39hC42cgMw/AQ0VpgkzMwFMIkHUAenkOlJl8JON+vTpplaM8rCU0bD4LQ9ZBL
	/WjhCJQsmu9OSb2KKwwqwScfdfdv7gUn57GCkV6NBk2Cn4teHmy60EjbmvLUZw+84EDsQ9QfDd9Qi
	+BtFOuhcltGWOwDslLVR29RmAuKh/NjArKgAEnfRvEMT7wYwV9SQdLFjNGasBb1xNTauo+o4lS3cZ
	hf6309pT4tqLHherEOU7zFQtTCNrlY3RveWHkV9D54CezgdutTz3KbsgR+LgeU3yIDPLUwL4Dj3nx
	wG/cigLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgEE-00000004I5j-2wEL;
	Tue, 28 Jan 2025 07:41:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcgE8-00000004I5L-27Oz
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 07:41:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4549968D05; Tue, 28 Jan 2025 08:41:33 +0100 (CET)
Date: Tue, 28 Jan 2025 08:41:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
	Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250128074133.GA22435@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_234140_690437_ADD3CFAC 
X-CRM114-Status: GOOD (  13.25  )
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

On Mon, Jan 20, 2025 at 03:31:28PM +0100, Thorsten Leemhuis wrote:
> My former colleague Christian Hirsch (not CCed) can reproduce the
> problem reliably. He today switched the CPU to a Ryzen 7 7700 and later
> to some Ryzen 9600X – and with those things worked just fine, e.g. no
> corruptions. But they came back after putting the 8600G back in.

So basically you need a specific board and a specific CPU, and only
one M.2 SSD in the two slots to reproduce it?  Puh.  I'm kinda lost on
what we could do about this on the Linux side.


