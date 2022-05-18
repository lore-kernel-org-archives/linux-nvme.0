Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D594C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KrOGjE8ph4fsDqFnPoybk0p+WwHmXP/l4xSU8S8a9Pg=; b=0KVf9zlzFfl+QyuEEmfEqZJwFM
	I9fUjENS/7axUgMi9SisbhkUmdqlC/cdOIL0upI0idLNfcFkAsnlro0gTwq2qwacHKh5gQQ5iavH5
	eC9P4MSB+eFkY9euXZCO9JzDCxuYq44apLTQ+xqzmnGRqEqhJ614G9xGBcBUc6UEAuPVxTeJsuNLr
	ldyUKcz79zzBJT670FtVfK92lx8Zggc9m9gQ2dNmLPYYGj7PvPQiM9cPTY8JFM4WXUtIPqpbAvFtR
	zyqXDU7Ld55QW9Btd06ak2JJ4xULXDsOsc5VR1gD9QSf3mGmHMeBTSeW7anjBqxa4ZfEz/tjZplzR
	5yCkGjHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrE5a-0004hT-To; Wed, 18 May 2022 07:27:22 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nrE5Z-0004h0-7W; Wed, 18 May 2022 07:27:21 +0000
Date: Wed, 18 May 2022 00:27:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Message-ID: <YoSf2UvYcW9fHebf@infradead.org>
References: <YoSWZoB1/38DdP4S@infradead.org>
 <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
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

On Wed, May 18, 2022 at 09:23:45AM +0200, Hannes Reinecke wrote:
> On 5/18/22 08:47, Christoph Hellwig wrote:
> > The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> > 
> >    loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> > 
> Hmm. So how do we progress with the authentication patches?
> Shall I resubmit them?
> Will you be picking them up?
> Is there anything I need to fix up?

I'm a little worried adding it this late in the cycle, especially with
the (although rather trivial) crypto patches not having any reviews from
the crypto maintainers.  If you can get those we should be ready early
for the next merge window which is going to start in just a few days.

