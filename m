Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E89C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 21:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqMqtG++CkfQtzmIiGllKtTQNWwMJSNpQBGVKmsC6yE=; b=DrhefYLBHuVdd6YDaFs8SJBy6S
	Dalt8ye8droRO1/zJB6maYunrxK6NDglLC6+lMm7rjJAhOEcrJUExHlXXuMLrUohd6y3CS/2yug/T
	ICYM3jKuHsB5kNwqEloQ4zdPRAOipTtU4pS2dFY5b93DDc82AjiZNcos7BST54iuwzazw9jL9qgL4
	Cg0Jr91rd8Lb4AApMCw3b9jF72RiZ555hXu9qSl5M4glWHIwF+EpKi8Y0S7m0wkfDngYhtEnmKRIo
	Nu5TrxKIoPqAFrhbVNt7GV5qIwHOPwu+CJrzurnipDkBjmXwDC/+2CU54vCaBdJtMrpJsJiQtMWmw
	ZMh8j9CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMcX1-00BdyB-2J; Tue, 22 Feb 2022 21:17:11 +0000
Received: from relay3.hostedemail.com ([64.99.140.34])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMcWx-00BdxA-Sd
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 21:17:09 +0000
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay11.hostedemail.com (Postfix) with ESMTP id 7DEC1801C5;
 Tue, 22 Feb 2022 21:17:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf02.hostedemail.com (Postfix) with ESMTPA id B720F80013; 
 Tue, 22 Feb 2022 21:16:32 +0000 (UTC)
Message-ID: <84ccd9ca57a9aab520062eab392b4b96143e9708.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From: Joe Perches <joe@perches.com>
To: Keith Busch <kbusch@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, Christoph Hellwig <hch@lst.de>, 
 "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "colyli@suse.de" <colyli@suse.de>, Bart Van
 Assche <bvanassche@acm.org>
Date: Tue, 22 Feb 2022 13:17:02 -0800
In-Reply-To: <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
 <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
 <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
 <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rz4j893t8y7qoqm4mdmsq1oeb7sqh6rf
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B720F80013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/MQBIBJ3ak6FHbOobHD8P9oS5MQ2QXiHI=
X-HE-Tag: 1645564592-46478
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_131708_012033_4DD7E573 
X-CRM114-Status: GOOD (  11.52  )
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

On Tue, 2022-02-22 at 13:12 -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 12:31:30PM -0800, Joe Perches wrote:
> > > I'd only use something GENMASK() for bit ranges.
> > > Even then it is often easier to just write the value in hex.
> > 
> > Mostly it's the count of the repeated f that's difficult to
> > quickly verify visually.
> 
> I admit I made this counting mistake in earlier versions of this series.

It's simply hard for humans to do...

https://en.wikipedia.org/wiki/Subitizing



