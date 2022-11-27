Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D567C4321E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Nov 2022 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k91cwp2owQqNnhP3QOFwCjsb8Bnm3zsAaMVmFzCOAlc=; b=4a6jGql1vhjxYbmsB0HUHHsbCW
	XsZiswxTIPz/7vCpN8Nbq0aXvQ0hibNzSiV/0mDjW2haV9aDTxANXBaHOlggdjEADjRj/zbYR5Np5
	dttrsj8hQ2NBi2xFTuMQ+Ui+W4BQrNXt9s/v81YwmwiodS+PxzdJ4Q6JE8owPKqStHbxP7IZ1qgZ9
	TPphFVdUbga1zD7ufvnCSv2282pZiX//DFi3cOxAYJha4oIvRZWr6mhahWzAGMnw4lXBCg6++XaHf
	AxTeXIx77EztiA5iVBrjDfCXE3x9jDk8nyxAYIO+cHGiwNtuRCj9GZKsJBgeIOQFqBY6FPDWR2pIZ
	84nBFK3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozWR7-00GENN-QO; Mon, 28 Nov 2022 05:12:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozI7T-00BYeO-Qz
	for linux-nvme@lists.infradead.org; Sun, 27 Nov 2022 13:54:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 977E660C96;
	Sun, 27 Nov 2022 13:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D01C433D6;
	Sun, 27 Nov 2022 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1669557294;
	bh=yBXFwdf6dHy6NKqLSbFuwY2ODTarq/fHEqUCJbDArGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nk7s5lWEAiKkbiHApH4KVdNYo+dE77wMv9el27gVNLV6vJ8bqio04oPle12nog6/N
	 QZJnMGnTpuchNmx+393MIhVm5To4LYwv2fgwAWxLOKa3Wbo2x7CZmTxpFABdw+u3gk
	 BKlc2ytv29xRY3fdiySvnZCwugu9Z2Y1dflPI6q8=
Date: Sun, 27 Nov 2022 14:45:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russell.h.weight@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, Johan Hovold <johan@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Sebastian Reichel <sre@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Raed Salem <raeds@nvidia.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Avihai Horon <avihaih@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Colin Ian King <colin.i.king@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jakob Koschel <jakobkoschel@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Wang Yufen <wangyufen@huawei.com>, linux-block@vger.kernel.org,
	linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] driver core: make struct class.dev_uevent() take a
 const *
Message-ID: <Y4NqAJW5V0tAP8ax@kroah.com>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <d448b944-708a-32d4-37d7-0be16ee5f73c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d448b944-708a-32d4-37d7-0be16ee5f73c@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221127_055455_998198_F32F7B72 
X-CRM114-Status: GOOD (  19.11  )
X-Mailman-Approved-At: Sun, 27 Nov 2022 21:11:51 -0800
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

On Fri, Nov 25, 2022 at 03:51:11PM -0800, Bart Van Assche wrote:
> On 11/23/22 04:25, Greg Kroah-Hartman wrote:
> > diff --git a/include/linux/mISDNif.h b/include/linux/mISDNif.h
> > index 7dd1f01ec4f9..7aab4a769736 100644
> > --- a/include/linux/mISDNif.h
> > +++ b/include/linux/mISDNif.h
> > @@ -586,7 +586,7 @@ extern struct mISDNclock *mISDN_register_clock(char *, int, clockctl_func_t *,
> >   						void *);
> >   extern void	mISDN_unregister_clock(struct mISDNclock *);
> > -static inline struct mISDNdevice *dev_to_mISDN(struct device *dev)
> > +static inline struct mISDNdevice *dev_to_mISDN(const struct device *dev)
> >   {
> >   	if (dev)
> >   		return dev_get_drvdata(dev);
> 
> Why does the dev_to_mISDN() function drop constness? I haven't found an
> explanation for this in the cover letter.

I agree, this is going to be fixed up, see the thread starting here:
	https://lore.kernel.org/r/Y34+V2bCDdqujBDk@kroah.com

I'll work on making a const / non const version for these so that we
don't loose the marking.

Oh wait, no, this function is fine, it's not modifying the device
structure at all, and only returning the pointer in the private data
stored in the device.  There is no loss of const-ness here.

thanks,

greg k-h

