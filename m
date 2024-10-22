Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F163AD2C55E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f51YX11LruCHfbP9XR5DZpek7V0Sb2TEwW/Ei84OqnY=; b=h0ga06bf992uegVmadKSmuSnt+
	XSUDtHDMUzBQ2HhrvVe+F3Uicke7HgAJecvfIYjoX6KAvl9H4uuLMm3E2G4X9QxFOlJvt+i7lJuBZ
	ygunBqs5MorBZ/VmQ5Okyi5GqkJ95WzpEmcMHxXunVj7hAuSL2VamwTS6fQWSzpWR0RXZ01YAFx4j
	1upEBtgXtvBL25GYKI8mnXVUA6VIcu4NHjqbziJ9xfw4OAb3fDc4XEtpblL1i8KeT2pNu3mJbm6oD
	19KTv8itkBzSsbaM/t7DOUC0Fs/PsV0K1sp/PXBh07vUkL4/9d6WpDGjWjpX+fq6ihURcD6NZjebr
	utP8ZV+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3FyM-0000000B7S4-27iq;
	Tue, 22 Oct 2024 14:34:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3FyJ-0000000B7Rc-0SwZ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 14:34:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 06E3A5C5C75;
	Tue, 22 Oct 2024 14:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C174C4CEC7;
	Tue, 22 Oct 2024 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729607694;
	bh=f51YX11LruCHfbP9XR5DZpek7V0Sb2TEwW/Ei84OqnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8hLWl6+mtfCba5AR/9ltdAfYXimJ7g86bSdF/0UTJ2W6ilRwChg8qBpE0hD3c53d
	 nvE6gTvRlqKstGJPJi0+h9rdDAOmWmxth21AUQPv1rtWVfMT2K5NfSqmiWVHfI9uAp
	 1fhWNePSSEmiGCauNOhP1P2zB9ZfH+0+gFLGSqbz9cbvWIdNW9huDT/F6azWRyJ618
	 1wS7tye6nHwgwGRboOhyV0sR7uT1P55Q4PHjy/C8j1A7m91NkFU3XT2vcrAETC7o/K
	 6J1LrIqQh0nihWWXXiAQzPF+KdDX0JQfKrGgs0UTl7b+QtG8Ol4BVOPySLYUcmY7IX
	 lh4F6sg1DHnAg==
Date: Tue, 22 Oct 2024 08:34:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>,
	sagi@grimberg.me, kch@nvidia.com, shinichiro.kawasaki@wdc.com,
	d.bogdanov@yadro.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <Zxe4C-CwlhDnJvS3@kbusch-mbp>
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
 <ZxbWxuzH3u6hAezr@kbusch-mbp>
 <b4bde72c-7123-4594-a064-a39aef7fa7ec@linux.alibaba.com>
 <ZxcIxhQMYt2fsPiY@kbusch-mbp>
 <20241022060639.GA10510@lst.de>
 <7e573e58-39b3-45c3-afde-0cfec3911326@kernel.dk>
 <9f42c09f-4082-4578-812f-62ba006c1c05@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f42c09f-4082-4578-812f-62ba006c1c05@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_073455_213831_3D25B9CB 
X-CRM114-Status: UNSURE (   6.53  )
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

On Tue, Oct 22, 2024 at 08:18:10AM -0600, Jens Axboe wrote:
> It's on 6.12-rc4 now.

And nvme-6.13 is now rebased to that as well.

