Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C8CD1A429
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 06:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pKgsjoLG8AEDnNnQBjZTPzosfq/5V8VTxw8uguF4ym8=; b=aQ24JfkoNK0yZeqUd9ZvhnCeRU
	dJEeb/ECt8MPYlTXpgF8ERXLvidsL7l9G9tvB0ltHDPUvI87dEs1E/dfkwesSqsKKbyt7YBgqzT4k
	b50SBOprt0TJIbPNlN8QTOl1oCUiAQSuTvxb8iMEBti/hIkDAovw9jSV8q/90Hc/rFuTy0jJakdu3
	Ab1sY8NqZ9lCxthMJLTWPHflUBCdwO5nykBnZz+rQFEzj54/r+WpVSBbyPAasPYzzVFKswUVuK5cx
	vCZcPBHIwQ+8HX2NEQ4s0+6WOSqCajGmzdCDI98qOg9XLOiuxKHILBNOEiTyLgiwiAjVYZ0g4gU1c
	UfFQUZ6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0EVf-00000003siU-2y4x;
	Mon, 14 Oct 2024 06:24:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ESR-00000003sDU-1Z7d
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 06:21:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA246227AAC; Mon, 14 Oct 2024 08:21:25 +0200 (CEST)
Date: Mon, 14 Oct 2024 08:21:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241014062125.GA21033@lst.de>
References: <20241008122535.GA29639@lst.de> <ZwVFTHMjrI4MaPtj@kbusch-mbp> <20241009092828.GA18118@lst.de> <Zwab8WDgdqwhadlE@kbusch-mbp> <CGME20241010070738eucas1p2057209e5f669f37ca586ad4a619289ed@eucas1p2.samsung.com> <20241010070736.de32zgad4qmfohhe@ArmHalley.local> <20241010091333.GB9287@lst.de> <20241010115914.eokdnq2cmcvwoeis@ArmHalley.local> <20241011090224.GC4039@lst.de> <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9f7f1c-48fd-477f-b4ba-c94e6b50b56f@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_232131_582783_6214AB32 
X-CRM114-Status: GOOD (  12.52  )
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

On Fri, Oct 11, 2024 at 11:08:26AM -0600, Jens Axboe wrote:
> 
> I think that last argument is a straw man - for any kind of interface
> like this, we've ALWAYS just had the rule that any per-whatever
> overrides the generic setting.

And exactly that is the problem.  For file systems we can't support
that sanely.  So IFF you absolutely want the per-I/O hints we need
an opt in by the file operations.  I've said that at least twice
in this discussion before, but as everyone likes to have political
discussions instead of technical ones no one replied to that.


