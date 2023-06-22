Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF97EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jun 2023 03:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czH88Kn+nqmZTzNwgoZksKh07PH4Iiat8FNrd6w2ivU=; b=Y9XD60SzDQjEh1VekDAz0Ce0us
	FayGYp8JcKgLBa/HmvIlGUPMrmP2rggRSEk+f52vHh5n3LFId+KW07WNIrbOHFCaiaaHG1Xy1YoES
	vDJav4JCMkJIox8cbIrMqslPNR1ixHo7Jku4MLLO1QWcya4GE9FBHYPf1nRKOIhflbDHZZKVBfejk
	682W2cHGsOX7iaWPcvlhVu5qnGl+Vibea/6bIaAF+TQHdQNXviN8eR14bl7nRgKX3iH52bMxXTN7d
	0td++nO1VKwZj7cv5VTpfK/jUW315mZ/7qNPoj8BIKHGbE7tsXwsL8Ce7mDtiWR/BTmr77W4j2+mV
	XjWcr7xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCBSN-00Gj6V-1y;
	Thu, 22 Jun 2023 03:58:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCBSI-00Gj5p-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jun 2023 03:57:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33A7D68AFE; Thu, 22 Jun 2023 05:57:53 +0200 (CEST)
Date: Thu, 22 Jun 2023 05:57:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	leit@fb.com,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <20230622035753.GA4736@lst.de>
References: <20230615094903.1341683-1-leitao@debian.org> <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMpWaMxKMFE8hmK@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_205758_674407_1C72A1C8 
X-CRM114-Status: GOOD (  18.54  )
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

On Wed, Jun 21, 2023 at 10:46:17AM -0600, Keith Busch wrote:
> On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
> >  	if (effects & NVME_CMD_EFFECTS_CCC) {
> > -		dev_info(ctrl->device,
> > +		if (!test_and_set_bit(NVME_CTRL_DIRTY_CAPABILITY,
> > +				      &ctrl->flags)) {
> > +			dev_info(ctrl->device,
> >  "controller capabilities changed, reset may be required to take effect.\n");
> > +		}
> >  	}
> 
> Thanks, patch applied to nvme-6.5.
> 
> A question for Christoph and future consideration: I *think* the
> complications that had the driver stop refreshing the controller
> attributes are largely mitigated by the fact we now handle effects
> after the request is freed. Perhaps I'm missing something. Is there
> a risk in just bringing that feature back into the driver?

No, the main issue was and is that we can't just call
nvme_init_ctrl_finish on a live controller.

