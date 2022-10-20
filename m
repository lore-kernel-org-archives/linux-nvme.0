Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6504C43217
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 08:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=to4DbwJx3oz7CqI2tuzRbVpHYmwd1kF8Y2c2ffWKNmU=; b=HCuXN3RnsLQ6qAIAPxOgdfSbTW
	X4JY/ruLmrTqke7S1OAPYkhs/ZIZyB/aQAKTPbxkMs5CofphgLPInPfLoIGCW7iMT4tnnJR0xeIbP
	l/ueNkh/VUHc+03SgszzUhizBXyqlWUTUl0csjrvJpV98VJVzkSVRCiD4Ko1fFqbFiAO/YxVL14xq
	fbziIfA/AstEmi6fOM7885IXjkfPzTEv+e43dpt6IXJjmZ0PF73yzSK0sSpzGG2OwvOQKdgmyKSLZ
	V7engBxhy5ufJ29c3kRkCnm6HpAVRz9b58ho5lUf/iH+LO2Bn0sB3j9WtjQRJpw74crsp4EN7Z5lW
	ySRfFN2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olQdN-00C4px-4h; Thu, 20 Oct 2022 08:10:33 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olQdK-00C4nQ-6a
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 08:10:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 716D8229C6;
	Thu, 20 Oct 2022 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666253420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=to4DbwJx3oz7CqI2tuzRbVpHYmwd1kF8Y2c2ffWKNmU=;
	b=fvE741JJPwiErSL0Biyr/jsD5+i1ZIM8Sp+TGuNbnMvQ56PZnUmijN3pxvjZztgqRQ6dDR
	wSOIK4UGXlM8NWFyUEkaA8DBcwrCX7tY8MzlVapFcgy6dnM8JCW6jRnT53fTNWus9kKwV7
	dwH+rV8HfSr+WEZWeFstdaP0sauXUog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666253420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=to4DbwJx3oz7CqI2tuzRbVpHYmwd1kF8Y2c2ffWKNmU=;
	b=EQTs2/O1gmKMLzpGnng9XdDRUyiUtvS2DPyGuq2qLcGuqlFVTqF9x7V9XGehR4TKNC9z5x
	TmNIL6djqYT0HVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B28B313B75;
	Thu, 20 Oct 2022 08:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id OH+OK1oCUWMoEQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Oct 2022 08:10:02 +0000
Date: Thu, 20 Oct 2022 10:10:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
 <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_011030_449842_398431CE 
X-CRM114-Status: GOOD (  13.44  )
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

On Wed, Oct 19, 2022 at 08:43:43PM +0300, Sagi Grimberg wrote:
> 
> > > > Still able to trigger though I figured out how I am able to
> > > > reproduce it:
> > > > 
> > > >    VM 4M memory, 8 vCPUs
> > > 
> > > thats small...
> > 
> > Just a test VM. But I think this is actually the key to reproduce the
> > lockdep splat. The fio command is eating up a lot of ram (I guess any
> > other memory hog would do the job as well) and forces the mm subsystem
> > to use the swap.
> 
> Is that 4MB of memory? or 4GB?

Ah sorry... it is 4GB indeed.

