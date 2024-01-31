Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7350C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hR0oLR1/p6NWvnXXg/wS49czgR67mm1Yvr6Vbc0oEak=; b=XoqNSlFv/Hf/B/aG3HVxweftel
	/74rRcK84tqaS9Zk+Lx1bkXCxWtjeTO/RFXo3xiCIU1SnQDlogou0z47lIkwtFo5wWh3ba8URFYNg
	dlTmdhVBGw+VBXGzFsLufj4dYpPfD0Hz+BV+Xb1CnmczfJJ+ir+RV8Vb3l8/MMhvbiSKQurchzJy2
	RP1htooLHeuXZnDjp6oBjxPFWWhL66DqGJZPxpqiV6vAbmrGk+il6TpXDwPNZurk3ncwBifzWqf9u
	oLTkH8nOzs6FETdKccFEiJktbvhkSSilj+vtYnM1rAmmH9IcTXYi/LXxhMCWHIq5ie+2Kw1LUNqzk
	EwQu5pSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV42P-00000001dq0-1jE5;
	Wed, 31 Jan 2024 06:25:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV42M-00000001dp9-2IDG
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:25:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED9DF68B05; Wed, 31 Jan 2024 07:25:26 +0100 (CET)
Date: Wed, 31 Jan 2024 07:25:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jirong Feng <jirong.feng@easystack.cn>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org, peng.xiao@easystack.cn
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR
 instead of BLK_STS_NOTSUPP so that multipath(both native and dm)
 can failover on the failure?
Message-ID: <20240131062526.GA16177@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me> <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn> <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn> <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me> <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn> <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me> <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn> <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me> <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn> <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222530_748900_104F5706 
X-CRM114-Status: GOOD (  12.97  )
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

On Tue, Jan 30, 2024 at 01:29:33PM +0200, Sagi Grimberg wrote:
> As mentioned, afair (Hannes can correct me if I'm wrong) you can
> make an nvmet subsystem span more than 1 server assuming that the
> backend device is consistent (i.e. using drbd). The only thing that
> you need to pay attention is that the cntlid range is not overlapping
> in each of the servers that expose the nvmet subsystem (cntlid_min/max
> configfs attributes).

You can even make a subsystem span multiple "servers" without shared
storage, but in that case you'd better now allow simultaneous access to
any given namespace through path pointing to the different "servers".
ANA comes in pretty handy for that.

