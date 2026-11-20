Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15875606A332
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aLDKMO/H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MpAFJKoRLBHWua5zVfwBOUWeo6j4cvTXzjQs1AqjA18=; b=aLDKMO/HwR0HH7ZyTKHkoB5vbA
	UzhjOjC1JQXH6aIpUyFObHWe6P03q4fk5PNZeU7yXoLrg9Sf6nICyFT2BsX122PNxuqV3oXsalN/0
	xAegB786Ms/GBHYNQZ370iQIMdWuqZbPIEDxVWUPCb9ELc2Q3JUSZw472yV9Mpk8wRkliO2PgDS3M
	Pj/Qa042/ttoyRDQJ9BaQMMlY8kByfL4XpoqCfBE1m2Sf3Ve5BNFce8RHOEdvM0YUX44Ua3ZsP5MB
	V5L/kExQc/EKtaUN4S8KR+RHEY0sf2oPkss1LGnPjBRPOtTOpGi6IO2aoDnKlABXagypaPJ3vibQ+
	fJGgy0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQmk-0000000FSvD-0lxq;
	Fri, 20 Nov 2026 15:44:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQmg-0000000FSu0-0d69
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 15:44:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A190E68AFE; Fri, 20 Nov 2026 16:44:09 +0100 (CET)
Date: Fri, 20 Nov 2026 16:44:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
	linux-nfs@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 07/12] zloop: take freeze protection when recording
 write pointers
Message-ID: <20261120154409.GD28611@lst.de>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org> <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org> <20261116064820.GB2964@lst.de> <20261116-biegen-flaute-flanke-cebddae97444@brauner> <t73376p7ip4bvetjbqijzugvglhi2rdxsqt62l3uuqtmt3tqgk@2rlkkdy33hwk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t73376p7ip4bvetjbqijzugvglhi2rdxsqt62l3uuqtmt3tqgk@2rlkkdy33hwk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_074418_427157_C9E438FC 
X-CRM114-Status: GOOD (  19.40  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:57:09PM +0100, Jan Kara wrote:
> On Mon 16-11-26 10:41:49, Christian Brauner wrote:
> > Fwiw, the check can't go into __vfs_setxattr(), __vfs_setxattr_noperm()
> > or __vfs_removexattr(). cap_inode_killpriv(), IMA and EVM call those
> > from ->write_iter() via file_remove_privs() and kiocb_start_write()
> > hides the freeze protection from lockdep for aio and io_uring. I have
> > not bothered to figure out why. Maybe you already know? In any case,
> > until that's fixed we can't place it there which means this doesn't
> > catch IMA/EVM at which point this patch becomes pointless.
> 
> It's because of AIO and io_uring - if you don't hide the protection from
> lockdep, it will complain about it when returning to userspace while IO is
> still in flight (and thus protection is held). Sadly lockdep does not
> support releasing resources by anybody else than the process which acquired
> it so we fool it in this way...

Can we try to escalate this to the lockdep folks instead of piling hacks
deeper and deeper?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
---end quoted text---

