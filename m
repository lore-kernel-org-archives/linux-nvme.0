Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yruR0wuSzWrvfal920J1ZZ4jHZsrjMVAKAFlEFd1Src=; b=4oq1u9dnCrKz1DaNhvi22PQD4g
	imbQXE7Jj1af8MoGzHETPpsfAh3RD1GhVTfvjJ3aXJaFKO1I29mDI1WEQsAmdLti1PAeek9TQt27a
	f7XVDSJaISV+BJxJmcX0WFhK7/WLIPOSrcRZLQnQG1bcYOuruBLkihw4WeoDFh116JBbYSdVRZWwp
	T6rHHIpfpG7zd6hsI2JQXPbzPuwPPEpfB2h277KDO8z/098B62X4gEHKTsZgxwm/ZXF4wNkPO0xZQ
	MfUjy1jQpYfWEv/Sh83fnTQDe/8bwoP0V3ICvG74wC4/XzJuiQsubX80IpPynOQKQGGBlMXJEHO2z
	5hBz3yOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKOlO-00841A-A5; Wed, 16 Feb 2022 18:10:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKOlL-0083yh-0z
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 18:10:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F027268B05; Wed, 16 Feb 2022 19:10:40 +0100 (CET)
Date: Wed, 16 Feb 2022 19:10:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <Markus.Bloechl@ipetronik.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216181040.GA21665@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
 <20220216170919.GA20782@lst.de>
 <20220216180850.fjcmj5yinaqolskt@ipetronik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216180850.fjcmj5yinaqolskt@ipetronik.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_101047_236553_782FBBC5 
X-CRM114-Status: GOOD (  12.74  )
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

On Wed, Feb 16, 2022 at 07:08:50PM +0100, Markus Blöchl wrote:
> I noticed that set_capacity() is also called most of the time when
> a disk is killed. Should we also move that into blk_mark_disk_dead()?
> Any reasons not to?

I thought about that and I think it is a good idea.  But for now I'd
keep the regression fix minimal and then do that as a next step.


