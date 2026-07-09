Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB17C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x9zSepfnsxO6z4iI82ggzlfe6byk7IEM2eoSEzFDh0g=; b=F6Pe+sTxOSpOvj3R3K1lYVogG1
	Ud/p3cu2plXen3z4q8hzY26jg/oggogbdejGP9FE/qQpkjPKqaCIeps2KEHwYH7hziAoicRXHush1
	9LnRxrOU4EYID9KGLT1NBk2oKiyjPZN2bT3qfrJzEx/zrl1zHxs4C/o1TV4NyipNQS0seei55Q+9r
	Lv8Y5knm0MzbveAFu5i4x9WXGQVL8lNuxZdTq0asFJJHiE6YL+uaVlc2PSlaf94XPHYKwhws9KsPq
	TdZFUjLosYxv33adPWS3wQ8DIutIfVKtZpfW6tqtBTZ8R5qr3jxOBnuc2VSHI7DO5dkBM1OADJ3Rh
	43NraPUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi7Q-000000018gL-0ITq;
	Thu, 09 Jul 2026 06:20:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whi7N-000000018fi-3sK8
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:20:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1646F68BFE; Thu,  9 Jul 2026 08:20:15 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:20:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
Message-ID: <20260709062014.GA17526@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-8-nilay@linux.ibm.com> <20260626064335.GG10731@lst.de> <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com> <20260629124703.GB23417@lst.de> <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_232018_110553_E9337D22 
X-CRM114-Status: GOOD (  12.82  )
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

On Tue, Jun 30, 2026 at 01:12:55AM +0200, Marco Elver wrote:
> Initialization of guarded objects has gone through a few iterations,

And all of them suck badly, with the current one being the worse.

> so I don't want to open that can of worms again. I think the
> infrastructure we have now provides various options (the scoped guard
> machinery isn't the only way). You could just write:
> 
> /* Initializes unpublished lock-guarded variables. */
> context_unsafe(
>     INIT_LIST_HEAD(&subsys->nsheads);
>     // ... other guarded var init in same block ...
> );

Using all these silly context makes it total mess unfortunately.


