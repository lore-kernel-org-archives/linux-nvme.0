Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43EFCFD626
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EjSM/OmqNAQPRkFiGmCpXmY1C9OGAoxEq/z/SuTL6l8=; b=PIkNMkcErDH2H5BsZgAEBe7h7o
	12lji0a8WYwg4mt2eKpbsjld3hpB0REk2DBB6iBaZYaEI+j3ZvTQtW77/c/LsNC2y7wkLv3wK4ZRB
	CsGak3Y1B8ipkaOg/NOQfCECeyYuyQqTDaVWrNkb8/DsEUicdUtj3yEAZqx1er9i+bBwm1LcjjOAC
	AmYyWsisqmZNKf+eUmnbvFTNMWaC7hLnTEk1m7g85yIQLZVeaUOie+9qjFNR1LM1o/wE4mHLZLy17
	OfD7EecpbxPckiCgOHY8gpudElAntoczwbAjpP2my+txGA57NugIb06tp5w/Ls0J+s6AiFHSQBNxA
	kzrzEpZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdTNl-0000000EzLr-3NYk;
	Wed, 07 Jan 2026 13:15:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdTNi-0000000EzL5-2LJu
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 13:15:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 683F4227AAC; Wed,  7 Jan 2026 14:15:16 +0100 (CET)
Date: Wed, 7 Jan 2026 14:15:15 +0100
From: hch <hch@lst.de>
To: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Cc: hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme/host: fixup some typos
Message-ID: <20260107131515.GB7575@lst.de>
References: <20260105040829.732046-2-wilfred.opensource@gmail.com> <20260107100920.GA26943@lst.de> <7db5ef3b6980270c948f6bd5dd9685e15493302c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7db5ef3b6980270c948f6bd5dd9685e15493302c.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_051522_735289_EC7322BE 
X-CRM114-Status: GOOD (  12.25  )
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

On Wed, Jan 07, 2026 at 10:33:37AM +0000, Wilfred Mallawa wrote:
> > I don't see a typo here, just a reformatting to a different comment
> > style not very commonly used in the nvme code.
> 
> It's just the extra white space before the "This avoids". Is that not a
> typo?

Double spaces after the end of a sentence is common style for fixed
width font text and recommended by various (usually older) coding
guidelines.  But even typesetting for variable-sided fonts sometimes
add extra space, in TeX this is known as "french spacing"



