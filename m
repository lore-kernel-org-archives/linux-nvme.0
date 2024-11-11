Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7FCD2E9C9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 09:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v099hRsyDNUvAYjxqPyiUxYilVKM5wWdcMizVKXaUas=; b=WwgIzPErpTLmBdpEZTPffQnyiR
	3cz3GU+zNazNWxHPu9+KBBqLo/w9IRyBjaKE2L1HI/n+5VxQSELotvz+gKdr21nO4H6PffmgLsRh0
	2xhR1hcKbFj1ZdNdJWos3o0WpoGt6gyk92I/BgHByDZGOsNEoEce0HQxvHZacfGsQgpGeeB+MbSo3
	ecFOZ7zOK1HsDQUcD6NYY+0qBcYvFBbEU61oqdWeVURUlyrxUmpDeQA/JP4H2mhnjAF0IzuQBHr3J
	7M2lgfOKi8I4WswQrKC7zxrMQ017PNdeVhiZLzucdU8l7XCVUKjmlpzOHspUsHytITszctth6YI9J
	SHXt1oZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQx2-0000000H9CY-262Y;
	Mon, 11 Nov 2024 09:43:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAQwa-0000000H975-01iE
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 09:42:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E2E868D05; Mon, 11 Nov 2024 10:42:42 +0100 (CET)
Date: Mon, 11 Nov 2024 10:42:42 +0100
From: hch <hch@lst.de>
To: Javier Gonzalez <javier.gonz@samsung.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, hch <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241111094241.GA27090@lst.de>
References: <Zy0k06wK0ymPm4BV@kbusch-mbp> <20241108141852.GA6578@lst.de> <Zy4zgwYKB1f6McTH@kbusch-mbp> <CGME20241108165444eucas1p183f631e2710142fbbc7dee9300baf77a@eucas1p1.samsung.com> <Zy5CSgNJtgUgBH3H@casper.infradead.org> <d7b7a759dd9a45a7845e95e693ec29d7@CAMSVWEXC02.scsc.local> <20241111065148.GC24107@lst.de> <20241111093038.zk4e7nhpd7ifl7ap@ArmHalley.local> <81a00117-f2bd-401c-b71e-1c35a4459f9a@wdc.com> <20241111094133.5qvumcbquxzv7bzu@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111094133.5qvumcbquxzv7bzu@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_014248_221670_BC08F263 
X-CRM114-Status: UNSURE (   9.83  )
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

On Mon, Nov 11, 2024 at 10:41:33AM +0100, Javier Gonzalez wrote:
> You are right. Sorry I forgot.
>
> Would this be through copy_file_range or something different?

Just like for f2fs, nilfs2, or the upcoming zoned xfs the prime user
would be the file system GC code.

