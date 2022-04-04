Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9612C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evBhdi/pQUVg74HXNizvNTEVH91RmVnGyBEh/ZaQEnQ=; b=w286Ia6Lr70pBczPB2AJitUxCO
	55qiv+yei0odk4ejug+qyzAnNzmbsYj8hVb/9Uqf/pd/oqKziY3FKS8iK0usIg0TN4eXZPjfdPIsX
	xG4oJMqxdd7ldesyHEoFNIBfZJlX1ufouAIZEKLeB80I3IwYlCe5B8bXBTPknLrrTn889E5pNYjBM
	KbG9PB8BgwXi41kvSzFc85AsFEhzJspD9pjp5JyaJy//EeBK9yJPOQJ4M9aQdhncI2/znI6w2yL9s
	OlLhP/JU7Fj9/EcbJVpEj/t6geCSXxX/5lFGusm3wV5Ay4iv0e2LPWqeqpvmleTEb+ypekVZ6/Rrr
	6czl5E5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbP7N-00FezY-0I; Mon, 04 Apr 2022 15:59:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbP76-00FeqJ-70; Mon, 04 Apr 2022 15:59:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB6CB68AFE; Mon,  4 Apr 2022 17:59:24 +0200 (CEST)
Date: Mon, 4 Apr 2022 17:59:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220404155924.GA9764@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_085932_453388_B20552DE 
X-CRM114-Status: GOOD (  14.89  )
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

On Tue, Apr 05, 2022 at 12:57:33AM +0900, Hector Martin wrote:
> The kernel hard limit is 100-character lines, not 80-character lines.
> Maintainers for existing drivers are certainly free to stick to 80 chars
> if they like it that way, but I don't see why we should still be
> enforcing that for new code. See bdc48fa11e46.

Because 100 is completely utterly unreadable if is not for individual
lines like strings, and that is actually how Linus stated it in CodingStyle.

Your code as-is is completely unreadable and will not go into
drivers/nvme/ in that form.

