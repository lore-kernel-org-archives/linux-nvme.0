Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F7C2B9F4
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 01:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521161358
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 01:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521161358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y3Hpvum/xJK1gbyVbrcIv2qVYBU5W2Qx+GJSIqzWhzU=; b=X202uwW76w+dlC
	LOkjwHMjKmGeO/MEOaa6RHLbif8ucuxpJ8QHdKuxy+yMj/IDqLN5qitw9Q1UbzN6zZd2GITALOBGF
	NBEmP6ZDL92Ox594qACbLUABJJn1PgS8v947NyUCi4mleCotOh0poGdrYMCR1H5py0b0lRWViAeXv
	n3Kz9qz5E27AfCNsee7K2muaBINF17td7T3dqjl32KvlUiEl6f7RBDOm+UriOF97M6085XjVvJUl+
	x7gAssjDR0+cn/9V988Mly4OzxngG+tFMoHOnPIu21zn/D3H2KTPSiXyFdA9UgK31Fth4PW4/8nsL
	JwDAU5lFrI6wPwk51t7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvs5J-008ymO-Q7; Wed, 23 Jun 2021 01:53:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvs58-008ykB-Sl
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 01:53:36 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D155861358;
 Wed, 23 Jun 2021 01:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624413214;
 bh=gDVdAo1Hg19JJCWvSaSiRQra5621FIBmt0I0czU20ZA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LnBgAKjM9hytuZNiKvhLaxtTL4qjlf8j5DYXAPRp1o4dwG8N9okk6OP2ygDawEUPe
 +XivfGr5wHRBtPxYMijN6GrA+2gGo+Qbe4jH7aKLt6E1AHqtL7hDM/VbUSpKOPcxYT
 LYS8ap+4Y4kEs4H/ejDAejvA2onBJ854NbxUjA3r8NdlXzruidjVYV2eMFw9JlAgn4
 FO7r/zwtvINi/lqXLsB9eTKSnvppvknhqLzXfrvJd+xXAdBq/ptcgoUdg2jfeGy3Qv
 QI9QJ58ved7LQ3qADF6M8t3gSNyp54c6aTl1B0i0lh6RG/5jS0XAl6k5MXIVgnc/H/
 Qk82J2SRsKDZw==
Date: Tue, 22 Jun 2021 18:53:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210623015331.GB2360166@dhcp-10-100-145-180.wdc.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
 <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
 <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33919248-6c62-0974-ce88-3c0d0885e837@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_185334_993609_BE5640F1 
X-CRM114-Status: GOOD (  28.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 22, 2021 at 05:59:30PM -0700, Casey Chen wrote:
> On 6/22/21 8:06 AM, Keith Busch wrote:
> > On Mon, Jun 21, 2021 at 05:27:09PM -0700, Casey Chen wrote:
> > > +	/*
> > > +	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
> > > +	 * from set to unset. If there is a window to it is truely freed,
> > > +	 * pci_free_irq_vectors() jumping into this window will crash.
> > > +	 * And take lock to avoid racing with pci_free_irq_vectors() in
> > > +	 * nvme_dev_disable() path.
> > > +	 */
> > > +	mutex_lock(&dev->shutdown_lock)
> > Sorry, I wasn't clear in previous review. All of the shutdown_locks
> > taken after initialization need to by mutex_trylock()'s. If you have to
> > wait to get the lock, the device is not going to be suitable for
> > continuing initialization after the lock is available.
> > 
> > And looking at this again, if trylock is successful, I think you need to
> > verify controller state is suitable for continuing the initialization.
> I assume you mean all the mutex_lock() except the one in nvme_dev_disable(),
> right ? I agree with replacing all mutex_lock() with mutex_trylock() except
> the one in nvme_dev_disable(). 

I only mean the locks you are adding. The existing usages are correct
as-is.

> But I doubt about checking controller state
> after lock being acquired. Two reasons:
>
> 1. What state can use to check ?

If the state is not NVME_CTRL_CONNECTING after successfully taking the
shutdown_lock, then the controller is not in a state that can proceed
with IO queue setup.

> Suppose there is a state set on surprise
> removal, what if the state check happen before it is set while surprise
> removal is on its way ?
> 
> 2. Even we don't check controller state after acquiring lock, the
> initialization still fail fairly soon if surprise removal happens. We don't
> sacrifice any performance.

Nothing to do with performance; we're not in io path. The suggestion is
about avoiding access to a non-existent device. The timing of a surprise
removal can always defeat such a check, so my suggestion is not critical
since we expect that to be handled anyway, but in my experience,
platforms work better if the OS prevents such access when it knows it
will fail. It's not full-proof.

But as I said, everything should work even without the check, so feel
free to omit it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
