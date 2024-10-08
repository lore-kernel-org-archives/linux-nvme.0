Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7E2CEF172
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Uv0oHfR0kLPFSCEIUz1RHP5AKIWqSlzgpcUxfX8zBA=; b=GvT1WFlbet6jyDmYb2CzrA5oBo
	vRVtOFNGlSOofOyGLiTNDSzLc5589dytDSFw5kflpRzhFdeRCi0i27Yc8vNzGjOvr2N0r3D/kOzdh
	B+UDKEF/7BZzrPiJcf3z7Fs27XLo/SyU8SdsCoQvc580Gnp58Qj3jvuGAzh6RBmtzwQ9VIUM3UdfO
	6W0vmQKWIGXv/TZJQObQWRnhq+7+NO6HlRyJR6KpCGDtETS00XrF2xs5o1lRueKcOhITpTrrAmYDd
	1+LLOe3W98UNJi82TSdW6O6jdRO9mTexIIu1NcORJDKIcBt+euwfjOIcMjXfPCzpvnFWWRtojsGq2
	H5dGyVvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syBYG-00000006FMg-2IDy;
	Tue, 08 Oct 2024 14:51:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syBRx-00000006DxX-1kIZ
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 14:44:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 771BB5C55AD;
	Tue,  8 Oct 2024 14:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBBDC4CEC7;
	Tue,  8 Oct 2024 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398672;
	bh=2r9KIBLL1cXgHzsof+Mzxlou0eXLychanxOKsDI3Vd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7lrx/3EXHxD5qGecNBPZyiltAIxvOthAw23EzR8+WCK20equjsTRP01hX6d0yJZe
	 +lCbO3N2b6N2rPy4uApYGLvbc0a7dSj5P+HKyEpluOg5RbeRjra1pvCwLgLSsJTOkf
	 QUkrjTnusD3AtnS6p542x05JmpzFHhGyftkzX1SovS+Ooqd9rDya9WVOw5ktixC+7W
	 OeDKwd/ZPmfdo82F/3RhCzgITXnXT2iXFPw644evbv1soENfOTupnQxenfAbStRf6O
	 XhApI494qeYFBOcGv5BTfgr7wZq9X4IjgXisT7w9xlfiQSKtyRXRmrKMDSWjNeSQiA
	 6eLnoFAguPyWA==
Date: Tue, 8 Oct 2024 08:44:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
	bvanassche@acm.org, asml.silence@gmail.com,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-aio@kvack.org, gost.dev@samsung.com, vishak.g@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <ZwVFTHMjrI4MaPtj@kbusch-mbp>
References: <20241003125400.GB17031@lst.de>
 <c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
 <CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
 <20241004053121.GB14265@lst.de>
 <20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
 <20241004062733.GB14876@lst.de>
 <20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
 <20241004123027.GA19168@lst.de>
 <20241007101011.boufh3tipewgvuao@ArmHalley.local>
 <20241008122535.GA29639@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008122535.GA29639@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_074433_519633_244F3C83 
X-CRM114-Status: GOOD (  20.26  )
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

On Tue, Oct 08, 2024 at 02:25:35PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2024 at 12:10:11PM +0200, Javier González wrote:
> > In summary, what we are asking for is to take the patches that cover the
> > current use-case, and work together on what might be needed for better
> > FS support.
> 
> And I really do not think it is a good idea.  For one it actually
> works against the stated intent of the FDP spec.  Second extending
> the hints to per per-I/O in the io_uring patch is actively breaking
> the nice per-file I/O hint abstraction we have right now, and is
> really unsuitable when actually used on a file and not just a block
> device.  And if you are only on a block device I think passthrough
> of some form is still the far better option, despite the problems
> with it mentioned by Keith.

Then let's just continue with patches 1 and 2. They introduce no new
user or kernel APIs, and people have already reported improvements using
it. Further, it is just a hint, it doesn't lock the kernel into anything
that may hinder future inovations and enhancements. So let's unblock
users and refocus *our* time to something more productive, please?

And to be honest, the per-io hints for generic read/write use is only
valuable for my users if metadata is also exposed to userspace. I know
Javier's team is working on that in parallel, so per-io hints are a
lower priority for me until that part settles.

