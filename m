Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EED33994
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhShoql4Yz9MGIL2bJ3foyTv3oy24bHPYGhlCzqDzwI=; b=ja3sP03SgskWhWy+RXxcaxnZ8U
	f3fpTM2oBmfGB3lVAtEL/kCUle+FKY+fJjqsqTAiKGdDlz84OPBBMT+U+ojmqjTeeqm2VRFHDaeMB
	9RFtxTHVmhyO6Q3gf+u7s74cNbp//dxjj7//mOfJHQ1ZksYHVj4IGS79X7Xpj4JrCWosHZI1Tw8IM
	7DzkJDVX2f3BYLvEaX83MIKOL00Oq2aw3p9/h9eVVV5jZCslQXp6eNVob3NVCmgnNdH6r3YQkgVPI
	0HzdB0kdmPUJ9d5gicgMYW3M+SlkxPqZE0WX1gnzffKCWq+nY1vd1aNFMcYkY9I2Bk9OqN3dkt29X
	8PO7/WbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5RL1-0000000BFVt-05y8;
	Mon, 28 Oct 2024 15:07:23 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Qsj-0000000B9Hy-1FNk
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 14:38:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DAD70A41CDF;
	Mon, 28 Oct 2024 14:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA5FC4CEC3;
	Mon, 28 Oct 2024 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126287;
	bh=WBihszhgpbdEbKDk5fhd5HVOlYkYO0uSU5+sDIILYF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kidl4wY2iDvB2eVMqxFD1HjOWFIatEISx40q3eIVQmoJ60Ua9in6X6dMDgGM/WxZS
	 8coUkV8wt04cObM2LFKTdywh2xaSXAbrEGMiQ2ue5yqx4gLWeaCRysN/YkR6Aq3u0C
	 w5s1X/5Plpe8d/q0isevYMBzy+nsJfK4XVvrfXQ8++AJ8WkwWkgzt8F6FE3NPEhuV+
	 B3ohC5T7rdS3p89s/r9xhSRxmR+Oq5/WEIFpr1A1EiX3DDm3iyLHwgdxY0Py1+MkA+
	 l54v2oPnMsXsRZBWHAi+MGn3Yo8e/s/VyELqL+t8EWvkguEF99LJhg01Zm1YFzla0J
	 UYqpZOnKUwZqA==
Date: Mon, 28 Oct 2024 08:38:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv9 4/7] block, fs: add write hint to kiocb
Message-ID: <Zx-hzSwkkUMeuA5C@kbusch-mbp>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-5-kbusch@meta.com>
 <20241028115932.GE8517@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028115932.GE8517@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_073809_464607_43F40575 
X-CRM114-Status: GOOD (  11.70  )
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

On Mon, Oct 28, 2024 at 12:59:32PM +0100, Christoph Hellwig wrote:
> On Fri, Oct 25, 2024 at 02:36:42PM -0700, Keith Busch wrote:
> > +static u16 blkdev_write_hint(struct kiocb *iocb, struct block_device *bdev)
> > +{
> > +	u16 hint = iocb->ki_write_hint;
> > +
> > +	if (!hint)
> > +		return file_inode(iocb->ki_filp)->i_write_hint;
> > +
> > +	if (hint > bdev_max_write_hints(bdev))
> > +		return file_inode(iocb->ki_filp)->i_write_hint;
> > +
> > +	if (bdev_is_partition(bdev) &&
> > +	    !test_bit(hint - 1, bdev->write_hint_mask))
> > +		return file_inode(iocb->ki_filp)->i_write_hint;
> 
> I would have expected an error when using an invalid stream identifier.

It's a hint. fcntl doesn't error if you give an unusable hint, so
neither should this. You get sane default behavior.

