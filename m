Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31D9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ru1K9AnUQO1xWhO54+k3fzCBUb972pickNuOuoi2/4=; b=0/AkXj7qNHai/O0NhFsgF3YYae
	j/U6lhAUWJreXaTXLsAVz110yQpbki9gyi/Gn6W6TEENAiMzXd1cbollHtPonu/Rx+KgJXV2tQKc8
	BlDSZboHyDjBPyWMhqRTmkXMUoQMiTEzexctwIHzK5Fe23uBHVUT3BSzqaq5gW3WHmfmd9k+L+HlU
	zgSl8fJxFi2h5wzQFLkaG71mW2bCaHotta53/JAoJvaFZyhNw5z6SRsUjEyQVtTntq4yhUet/VHKT
	wrJ9g2/6unUCpu6hR/n3bDNGLqOy98oiAzpAJYWV5pPfaHqvcTDUbOCd65zFqeYoiR0QiTY5De131
	akRwTnLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcc2-00HIRR-D1; Tue, 05 Apr 2022 06:24:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcbr-00HIPn-Ch; Tue, 05 Apr 2022 06:24:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A727D68AFE; Tue,  5 Apr 2022 08:24:07 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:24:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <20220405062407.GA24330@lst.de>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
 <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
 <20220404155924.GA9764@lst.de> <367fe64f-0e57-b264-969a-c7cee6344f05@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367fe64f-0e57-b264-969a-c7cee6344f05@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_232411_614033_E569DE01 
X-CRM114-Status: GOOD (  11.15  )
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

On Mon, Apr 04, 2022 at 12:29:08PM -0600, Jens Axboe wrote:
> Please reconsider how you phrase these objections. Saying the code is
> "completely unreadable" because it's _1_ character over your hard limit
> is just nonsense, and not a very productive way to deal with this.

Agreed and sorry.  I actually had a piece of code in mind that formatted
all the comments way to long that really tripped me off, but it wans't
this one.  Too much going on right now.

