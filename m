Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1F3C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aLK1t9GhAjMei60rnYyortl9gHs4JAWuHopIYIhRu+g=; b=I5ukGtcIANUyl3zXn61p5/WIRr
	EtV4d04Gc+/iQGPri7Isg7bH5KcJzUJihGLQdnh6TrwqiPCXuxqo9CY+JpTn8xYYpaH3RX7QIzU3v
	FFVpdraBW+NOw45bGq/4Krf1ykkQwnFXVa4Zta54yO7ukoy69V+MmWNyxfjqX5c/imfgR37QLplfu
	dXR1lJzNVf9Pe945P+7Wkff7oT3pxuGeLV3IwToQY2m3AclGo9YoDn6ZJGFc1BlDKYzgE5KCOQTJg
	OAEKcaVxoOD0M2QAxq/wrLVAEAORKtf2MvsP55BXWg/67usPjk1aoF1vCrxgdjGFGV13tE/rVpIYL
	kmsKmrEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSzv-00AU8H-5Z; Fri, 15 Jul 2022 21:37:19 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSzt-00AU7v-Mw; Fri, 15 Jul 2022 21:37:17 +0000
Date: Fri, 15 Jul 2022 14:37:17 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com,
	joshi.k@samsung.com, linux-security-module@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, a.manzanares@samsung.com,
	javier@javigon.com
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd
 file op
Message-ID: <YtHeDa+rqXCFsd97@bombadil.infradead.org>
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
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

On Fri, Jul 15, 2022 at 02:00:36PM -0600, Jens Axboe wrote:
> I did author the basic framework of it, but Kanchan took over driving it
> to completion and was the one doing the posting of it at that point.

And credit where due, that was a significant undertaking, and great
collaboration.

> It's not like I merge code I'm not aware of, we even discussed it at
> LSFMM this year and nobody brought up the LSM oversight. Luis was there
> too I believe.

I brought it up as a priority to Kanchan then. I cringed at not seeing it
addressed, but as with a lot of development, some things get punted for
'eventually'. What I think we need is more awareness of the importance of
addressing LSMs and making this a real top priority, not just, 'sure',
or 'eventually'. Without that wide awareness even those aware of its
importance cannot help make LSM considerations a tangible priority.

We can do this with ksummit, or whatever that's called these days,
because just doing this at security conferences is just getting people
preaching to the choir.

We can also do this through sessions at different companies.

  Luis

