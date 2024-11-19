Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D58D44153
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 12:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9+ZDxijXSamM0opTNvZWa2wymbHgCSq+0HqVDTHHR8=; b=AkzHSBktJYFkHxlUILASvIJeHL
	qMfy9ngM+YobmJclCDn6UpL4a7xDtPdMVZCPhz4hO9Q+eWXJF7zJKq2TY/+lpvbNTbortgFKGqPZk
	zFNVYlBdzqp4R3wxBDnbGHXN+yEUPDhXA+v6L0abssAqcinV9ybhZQzz1L38tFrUpE//OSseNNvTP
	U4RJ6ttfyXwijJlBTnk022n4jLDToRLzZXD1D7g39wLixBsYApLvBG/HCboNyIo2VPbJiuHUJ8Hj2
	d3Si7raEuatjMFx2NuA7PeUO+maDJcfnKEloWgToYYh96u1JNF7JbJHeo5/MBIXa2ozsng7BmMIYs
	s19RghBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNfu-0000000CPeW-1RNa;
	Tue, 19 Nov 2024 12:49:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDNfs-0000000CPdt-0ZUd
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 12:49:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 62AAE68D81; Tue, 19 Nov 2024 13:49:38 +0100 (CET)
Date: Tue, 19 Nov 2024 13:49:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241119124938.GA30988@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com> <b61e1bfb-a410-4f5f-949d-a56f2d5f7791@gmail.com> <20241118125029.GB27505@lst.de> <2a98aa33-121b-46ed-b4ae-e4049179819a@gmail.com> <20241118170329.GA14956@lst.de> <4f5ef808-aef0-40dd-b3c8-c34977de58d2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5ef808-aef0-40dd-b3c8-c34977de58d2@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_044944_321490_494BC0C8 
X-CRM114-Status: GOOD (  11.30  )
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

On Mon, Nov 18, 2024 at 05:45:02PM +0000, Pavel Begunkov wrote:
> Exactly, _fast path_. PI-only handling is very simple, I don't buy
> that "complicated". If we'd need to add more without an API expecting
> that, that'll mean a yet another forest of never ending checks in the
> fast path effecting all users.

Well, that's a good argument for a separate opcode for PI, or at least
for a 128-byte write, isn't it?  I have real hard time trying to find
a coherent line in your arguments.


