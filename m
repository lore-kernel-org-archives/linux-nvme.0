Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07205C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QALdouqfmcaGfDwLDh7Un5xWb0URwm0mhAuIVhPmIF8=; b=B/eOJQ51mSi4FeW2bLTRyd3XVy
	6Wm/SLB4qrw0CivKAXaQEHKTzAFB9uQEDzRBJUd7FqpUKxGC0J1wz7n/mW3r56rkULOtwDRxiWV/J
	JmK8BrmxhNws6a9M+fhcNz/R+G7zy/1JhCpI89GYhWz8OubjmDHq5lv0V7kAN0f0C4fP5JOHtZHoe
	4p6472txUNMt6yNV6nBidbpED/2qzzDuBWAOIrwGGHWdyFel8v9c8rRzK3BH15BCkeocQSb6jyYbp
	K6jdzxyjdl0Fi90G2LsxwDd/+vqXPlyWJKBJzpbQ96z/4+xvScH57bYukB3rYknS3Ej2Bq9jhkvaR
	NsXa/hIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfQR-0041Ay-0H;
	Wed, 24 Jan 2024 15:44:27 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfQO-00419P-1A
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:44:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6D8B3CE30EE;
	Wed, 24 Jan 2024 15:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D96EC433C7;
	Wed, 24 Jan 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706111059;
	bh=XUVYGutZnX/aj4Zc4p8aaUAv8j90EpK8WCQ5Xf58mLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSE/qG+lJOHta/yUc1nd3IPR6nM5p+j9OzpJE1MY2e6a28x31ny2HbHYpkWczyCzE
	 6msQW7PfXO1FnssRD5V7s6xED9FVNCDlij1HVwsICV+4sq5leli3DFJivzW4M65dDb
	 RqkPt9Ezyetiz34V+ALYEIgeprapOxIPgwIkFR71FVYX3MVL41228gbbpb94G4oZbF
	 UEUN/euua5FZRooooNpZhVJ94fJaar/JVZbunH8Sm57SfDmqW+/m65Be9SNLFQGl6g
	 MORBWbXzJGMXnwE5VtT094wUm6/UkPhloEZaRSHMKYkO7XowuQAdwOAQU8VrUm/nyS
	 ydOoRVCcW7TKA==
Date: Wed, 24 Jan 2024 08:44:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 05/15] block: add a max_user_discard_sectors queue limit
Message-ID: <ZbEwUDrmTlWTfK75@kbusch-mbp.dhcp.thefacebook.com>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-6-hch@lst.de>
 <Za6zg-pA8IJkIb_b@kbusch-mbp.dhcp.thefacebook.com>
 <20240122183857.GA7029@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122183857.GA7029@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_074424_576624_6A772280 
X-CRM114-Status: GOOD (  13.15  )
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

On Mon, Jan 22, 2024 at 07:38:57PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 11:27:15AM -0700, Keith Busch wrote:
> > > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > > +	q->limits.max_discard_sectors =
> > > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > > +			     q->limits.max_user_discard_sectors);
> > 
> > Shouldn't writing 0 disable discards?
> 
> I mirror the max_user_sectors behavior here, where 0 disables the
> user limiting.  But yes, that would be a behavior change.

But a user should be able to disable discards, right? Unless you really
want to match max_user_sectors, I think you could default the user
setting here to UINT_MAX and use "min" instead of "min_not_zero".

