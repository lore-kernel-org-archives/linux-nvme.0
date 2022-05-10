Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060ADC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 07:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hZkm+z6ATwUyyjFBDGVi+OtVFyCNBa2dm/ashhOTAU=; b=JNfd+XdWu7Kx63i7aBOfB8OLeC
	qUYdcKnAiJM7rJE2i2gPS8AKHKIuhxLD4CyStVjV9HKIhBdoWSDvt9VNeLqfeafdTZGblfi5pGo18
	QDGbbUtaBtIzymEwPxKE1Wv0YXFMoSKE0lgByBVEQIznno1Pqohxgy8V60RzTAQS1ad5FX6B4Dk8P
	rzFA846Jxu3m8/NQLmihTNGBC8p00JskMIr9LVzoRhWtX+D7qIh7H/H94dJSP/7n4D41lkqdxTlOb
	LOD2DGRSyOaPaHJa8lTrY1dtx8Jkb7SOm6aOzyGOhSIzXx6MJySKOHhz2qQ0uC5KE/JszjoYBeR3l
	fYT5kyow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noKAN-000KHl-K9; Tue, 10 May 2022 07:20:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noKAK-000KGk-7s
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 07:20:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B4A6F68BEB; Tue, 10 May 2022 09:20:11 +0200 (CEST)
Date: Tue, 10 May 2022 09:20:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org,
 shr@fb.com, joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
Message-ID: <20220510072011.GA11929@lst.de>
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
 <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_002016_463922_74408FC7 
X-CRM114-Status: GOOD (  14.53  )
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

On Thu, May 05, 2022 at 12:20:37PM -0600, Jens Axboe wrote:
> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
> > This iteration is against io_uring-big-sqe brach (linux-block).
> > On top of a739b2354 ("io_uring: enable CQE32").
> > 
> > fio testing branch:
> > https://github.com/joshkan/fio/tree/big-cqe-pt.v4
> 
> I folded in the suggested changes, the branch is here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough
> 
> I'll try and run the fio test branch, but please take a look and see what
> you think.

I think what is in the branch now looks pretty good.  Can either of you
two send it out to the lists for a final review pass?

