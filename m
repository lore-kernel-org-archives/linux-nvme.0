Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462FDC3DA7E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jul 2024 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxVuumq6MCDz0mazfZPvi/d2kgTQinoP4feehe0yo+s=; b=z4/aqdmBMn7hHXugxMzdf687Sy
	jmGIIopSzvXJYJPWxxXf33g/W45W010Yiwsq3THWsPLbNlnlHQrfl+WGPI/nKVAHA+Vyuf6Yy7qZV
	iRSzHCe1QNUI0DRc9CvhJOICkBwxCk5nDK29lmnTUaG9nEGMClvutNO56O9Imbmb5ZxsQ85F4Sdu4
	oQto3/lVpNEsPCYzsnTQmt5EY8iKDk3o8OYfNg5pV4Lujm9RNwiCbIDz/ABmrOiDTgtA4FtSe0coG
	dVAO9YgzdzydTuaQ/eOgolJleXF64ACbOa2SIO7mYZGipgr1bp+1dqn02SYLhypAGgDvrl2omOrLY
	5r+rzyaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcF6-0000000FTYt-3sj1;
	Wed, 24 Jul 2024 13:41:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWcF0-0000000FTWJ-3BkT
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jul 2024 13:41:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0CBD68CFE; Wed, 24 Jul 2024 15:41:06 +0200 (CEST)
Date: Wed, 24 Jul 2024 15:41:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/9] nvme: split off TLS sysfs attributes into a
 separate group
Message-ID: <20240724134106.GA12516@lst.de>
References: <20240722120226.88737-1-hare@kernel.org> <20240722120226.88737-6-hare@kernel.org> <20240723144905.GC20994@lst.de> <210a37b2-cc26-43ee-99f3-19dee796e677@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <210a37b2-cc26-43ee-99f3-19dee796e677@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_064114_966893_C5923C17 
X-CRM114-Status: GOOD (  18.94  )
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

On Tue, Jul 23, 2024 at 07:29:59PM +0200, Hannes Reinecke wrote:
>> I would have also kinda expected that this attribute group lives in
>> tcp.c, is there a good reason to keep it in the core code?
>>
> I knew this argument would be coming.
> Thing is: these options depend on CONFIG_NVME_TCP_TLS, so
> they will always be encapsulated in some #ifdef, be it in sysfs.c
> or in tcp.c.

I don't really mind the ifdefs per se.  It's just that we'll have
this code built into nvme-core.ko for common kernel setups where no
one uses nvme-tcp at all.

> And as we always will have to have an #ifdef in one of the files
> I thought it easier to keep it in sysfs.c, and save us having to
> have an exported attribute_group which might even be empty.

I'm ok with this series of fixes going forward without it for now,
but in the long run I'd like to keep the core code as lean as
possible.


