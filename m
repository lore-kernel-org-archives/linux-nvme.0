Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B17BC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i24KnqJApkopw7kNTweh+DpLZY58ExOGVXrEq6f3wU8=; b=dy8gmWMBN3HGcHPbeNFXDLcO8D
	Q5nZYGz7AtuyK2tz9/nZ86ZAhh3NwfNmiVdPpVx6EQ+To089v8CW9xQ6xizZjvZ0B6RdgU/5t2ndM
	rBv2kqsKYjBa2tZWkLX1GWBZ0EM6o1rGlumD7kzXi9yEFwJ2rwu5WiTp4xY/K4CWzHWJ5jOLF0KAk
	pUMbwW8Q0bp/t6Ot8p9MV74Vw4w3D2qnbP104TkYgFHkv1rb0II73+U5ohAB30FlZRTmGEtU6ivYl
	pwSZRHmqfZ6ygd2N9Yeo56TICBmcHaI1IV0NFn0meAcnPRvnIv9rxbFRc+9/DHDLyPOT8OrMb+Ru0
	ZEo2Al0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4RvD-00GNwj-Io; Thu, 23 Jun 2022 18:51:19 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4RvB-00GNwF-Ah
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 18:51:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BD8A161EEC;
	Thu, 23 Jun 2022 18:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B8C341C6;
	Thu, 23 Jun 2022 18:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656010273;
	bh=cbD20UwC8oOUpq5UYj5xBgop/ExPATTZ6FsYqYNjLi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKT6NC+nP8k5wRC0GlhXy6y6DX7KB7fs606SVycppCPL2vCd5OocUHlWm5lUC0Fn7
	 tyaV8Y3JcNuX1LvOOZ6lFqmiG/RzDdXcge0ySuZjK7HjVfVlMtt7LC4ePQRn/uu4a6
	 QdZPwg4GiwUGFQkyfP7xNRtA7sdymY0onWh7rKG0yMHZuBJjdA9DFOg7slhP3E+OID
	 Lr4RBB9Jj5RVkpSWflzAuENevdnbiEXvRTkAPEkVlHL1GF/AxsU3oitVSviohKKOTI
	 e3AdsEEjuzDfzOii4IQC6MEbV/fUZTnmdSyUROsSbnm9/YcHncb4126Owty2uDfJ+j
	 mqVjD/KULrh3A==
Date: Thu, 23 Jun 2022 12:51:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrS2HLsYOe7vnbPG@kbusch-mbp>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_115117_448631_503C3BBB 
X-CRM114-Status: GOOD (  22.58  )
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

On Thu, Jun 23, 2022 at 02:29:13PM -0400, Eric Farman wrote:
> On Fri, 2022-06-10 at 12:58 -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the address alignment requirements from the block_device for
> > direct
> > io instead of requiring addresses be aligned to the block size.
> 
> Hi Keith,
> 
> Our s390 PV guests recently started failing to boot from a -next host,
> and git blame brought me here.
> 
> As near as I have been able to tell, we start tripping up on this code
> from patch 9 [1] that gets invoked with this patch:
> 
> >	for (k = 0; k < i->nr_segs; k++, skip = 0) {
> >		size_t len = i->iov[k].iov_len - skip;
> >
> >		if (len > size)
> >			len = size;
> >		if (len & len_mask)
> >			return false;
> 
> The iovec we're failing on has two segments, one with a len of x200
> (and base of x...000) and another with a len of xe00 (and a base of
> x...200), while len_mask is of course xfff.
> 
> So before I go any further on what we might have broken, do you happen
> to have any suggestions what might be going on here, or something I
> should try?

Thanks for the notice, sorry for the trouble. This check wasn't intended to
have any difference from the previous code with respect to the vector lengths.

Could you tell me if you're accessing this through the block device direct-io,
or through iomap filesystem?

