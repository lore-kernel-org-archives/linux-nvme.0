Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51435C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFhAU/sHwsYWWMedO/UVt8yR0JweIBC+U7mid294VGs=; b=SjNPy3ne5LeuWbDTZOeE9mO/xR
	2cdYUx/mx5WJsXv0Uyr3j3DC/ByH9L1EoEkyeYA1X6J16AqtWp4CvfL7QPjhIcfUIj85rwPxM623u
	qsoSOgIDeDoO9vRYTzoa5+APYgE7QAbAbzdhjc6TgHobXhBFuXEnnJ+4j0AJYcLld2YkXxWXwapLM
	Z/p7Ra6196jZ6WJsD+xca5nhjdNRYTdXlStyfyLqbjaxOXHfbjTNz2qY2mVPNnRgDvSDw3WsfeSOa
	zpa0sObZQ46c2XwjOy/FMw4aaOL15yPPhI6+WdoS5lLEDQTwMO6WSnizv7+UOkuHB7naXDRo/hqld
	zvRz1NeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGiaR-00EqZ8-4l; Wed, 27 Jul 2022 15:04:35 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGiaO-00EqWu-1l
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 15:04:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6690DB82194;
	Wed, 27 Jul 2022 15:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A1EC433C1;
	Wed, 27 Jul 2022 15:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658934269;
	bh=HFb8X/HqRK8bv/tpwPJwNOjVs0MnycxP/qMIKdDeQEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxEh6TKqeAqFSEzKhR+k+oDo+uy9ugBHqZ/VOptXoQdug5xACDoifBV91s9ymijBq
	 27B0sKfoXUEUz82oR2d5xOZWUjo4ioDlcgnCEslJZsn0jyVo5PSqx/tOQQffBNx4s1
	 Wg3Zy8meB3ivWuM8x07/vBxXmcOX5/ErXCKHyS0nJ4kyrpKq/5gNbX8e6cMd0eLi7s
	 hi1eXTmrFLmZpocwqHm90sgKqcF61Y2YBDmf9+KUoJSYiyeaztfJFoRqJOV9EOfiKO
	 xkbD8+kfSo/NNj/lZgvJA/1hh24m291WuBg7N11PosfB17RVIv2vhqYvYE9X6uPN+v
	 zARmtezSmldcw==
Date: Wed, 27 Jul 2022 09:04:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFGCO7M29fr3bVB@ZenIV>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_080432_258019_6FDA2DA2 
X-CRM114-Status: GOOD (  21.65  )
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

On Wed, Jul 27, 2022 at 03:04:56PM +0100, Al Viro wrote:
> On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> > On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > > 
> > > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > > +		bdev = I_BDEV(file->f_mapping->host);
> > > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > > +		bdev = file->f_inode->i_sb->s_bdev;
> > > 
> > > *blink*
> > > 
> > > Just what's the intended use of the second case here?
> > 
> > ??
> > 
> > The use case is same as the first's: dma map the user addresses to the backing
> > storage. There's two cases here because getting the block_device for a regular
> > filesystem file is different than a raw block device.
> 
> Excuse me, but "file on some filesystem + block number on underlying device"
> makes no sense as an API...

Sorry if I'm misunderstanding your concern here.

The API is a file descriptor + index range of registered buffers (which is a
pre-existing io_uring API). The file descriptor can come from opening either a
raw block device (ex: /dev/nvme0n1), or any regular file on a mounted
filesystem using nvme as a backing store.

You don't need to know about specific block numbers. You can use the result
with any offset in the underlying block device.

This also isn't necessarily tied to nvme-pci; that's just the only low-level
driver I've enabled in this series, but others may come later.

