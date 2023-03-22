Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF32C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e8pcB4NyNpnbjjVyVqPZjee1OMgx7fIK0IQ+AayPDOI=; b=07Et8vKVHec6MMVrp8PEcIUoBS
	vWjIrPyAlLCs5v11uP/xXb4RtmWKL8cBKHXxWQCDmxIUkL1KrXIldVE7ahRZCIT7aiLKZr7OoGv32
	HyRAlLtq20Mdjt8s9KasG4nXPTwF1xca2iBqeqiglffg9OgrFW+MHm54jMfBoxUFLeG09RrWFnEdV
	UZgjGmQ6Rlqf+FPfokn+lROkjYA4s6+bbmBO8V4YmialS3FLbyXqZcBmD0ZSyBGCsYFjOLjpNRoUw
	eOgtgZ8zlIfJ0WpqEY4eOvE8c0B9hVMZ+GMGrzknxRuemtq7vP4ptDlPqZDcd1GiJFvDlUXKRGjHF
	aHzWhJog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peu7U-00FEka-2H;
	Wed, 22 Mar 2023 08:46:56 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peu7R-00FEjf-0g
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:46:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B33D20B7A;
	Wed, 22 Mar 2023 08:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679474811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8pcB4NyNpnbjjVyVqPZjee1OMgx7fIK0IQ+AayPDOI=;
	b=E9g230bnlx+122H2nzMrW/4y80qlg+h4ZxmzlsB1j7O2jjyfGVbE6ojSSo76pTID9cM2cY
	saFdCdUVfVLSZQmntQ0o6yrhzLhuCeCDJ8LHMhqWDXToWB7AUhktx/Ps5PqzAt5zL4/83c
	6wgjpkC63fZOFUnBMl6A6MTJj3E3Xz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679474811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8pcB4NyNpnbjjVyVqPZjee1OMgx7fIK0IQ+AayPDOI=;
	b=uDAsXIuPu62sIaf6OYJkb5nFzZ63jnm7YNfFAR7gZhXrH/QEVmi7S/jPMB9bnvpaotHT+3
	N1rf9jG0kSBwUXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C17F138E9;
	Wed, 22 Mar 2023 08:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Lv4ZInvAGmQ6SQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:46:51 +0000
Date: Wed, 22 Mar 2023 09:46:51 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322082310.GA22782@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_014653_393890_48537007 
X-CRM114-Status: GOOD (  14.32  )
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

On Wed, Mar 22, 2023 at 09:23:10AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 21, 2023 at 05:23:49PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > This is for mostly for testing purposes.
> 
> I have to admit I'd rather not merge this upstream.  Any good reason
> why we'd absolutely would want to have it?

The blktest I have written for this problem fails for loop without something
like this. We can certaintanly teach blktests not run a specific test for loop
but currently, the _require_nvme_trtype_is_fabrics check is including loop.

