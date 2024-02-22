Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B5DC48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=; b=AX+hUH2zKvjoI/D5WsEP5PQ4gV
	oJvQWuvTGQi9ojJ7BFOW+klHV+gmXWEMuJ2REnnOkRqgmoFncJwHgSUBGKFm93LzF5CO+l4ul6td6
	WNAfXJkVUqRZXiD1oRGECqRg664Cz6KCMn07IeYMjQMkn+pR0OClz0zEGkC6DIYNzGFn11lZYkrTU
	AbNViVCTnlJMsQCuLD4VkdfUIowuW5kJ4PX+7Y7h88BeFJ8WJn2JDp+Xh2hQk7rPL+ewfghr6/e/N
	fohT2kpnK5iVsW4xmBbmqFE5F1FS2DlWsGtyZceO0EFWb4Lshz76P798+oDHxdv8PYGO9ZCIpcpgD
	8dQS1bFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5R2-00000004G0p-1WeB;
	Thu, 22 Feb 2024 09:32:08 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd5Qq-00000004Fzu-3EgL
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 09:32:01 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 602DC1F452;
	Thu, 22 Feb 2024 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708594314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=Auj3nCYbyfzn3C+J5lEUtdrxnsnSwqPyxqZBPi7vz5mDYASxc2bmkliMZ9KgLv+1CD2YIP
	fnYssxjk2keTd+MAvjI27G8apoen6uBX2sCBE5XU/QmliXED5GAiFW5BcMY0x34nIVBWQo
	gActl/kAoGwiGer1JyJd9Ou+4yBvYVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708594314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=8P71PZvf2kH7oAeqPBPWGNbtn1aQ42d3yD88rWaBqOoSBLp59C2CpHSdYvAayzxUKzGUPz
	IF+fGimQleP9xDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708594314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=Auj3nCYbyfzn3C+J5lEUtdrxnsnSwqPyxqZBPi7vz5mDYASxc2bmkliMZ9KgLv+1CD2YIP
	fnYssxjk2keTd+MAvjI27G8apoen6uBX2sCBE5XU/QmliXED5GAiFW5BcMY0x34nIVBWQo
	gActl/kAoGwiGer1JyJd9Ou+4yBvYVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708594314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=8P71PZvf2kH7oAeqPBPWGNbtn1aQ42d3yD88rWaBqOoSBLp59C2CpHSdYvAayzxUKzGUPz
	IF+fGimQleP9xDDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4506313A6B;
	Thu, 22 Feb 2024 09:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oa75D4oU12XQIQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 09:31:54 +0000
Date: Thu, 22 Feb 2024 10:31:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, Dan Williams <dan.j.williams@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.92 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[66.79%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_013159_227891_61770BDA 
X-CRM114-Status: GOOD (  16.66  )
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

On Wed, Feb 21, 2024 at 10:32:05AM -0800, Luis Chamberlain wrote:
> > One discussion point I'd like to add is
> > 
> >   - running blktest against real hardare/target
> 
> We've resolved this in fstests with canonicalizing device symlinks, and
> through kdevops its possible to even use PCIe passthrough onto a guest
> using dynamic kconfig (ie, specific to the host).
> 
> It should be possible to do that in blktests too, but the dynamic
> kconfig thing is outside of scope, but this is a long winded way of
> suggestin that if we extend blktests to add a canonon-similar device
> function, then since kdevops supports blktests you get that pcie
> passthrough for free too.

I should have been more precise here, I was trying to say supporting
real fabrics targets. blktests already has some logic for PCI targets
with $TEST_DEV but I haven't really looked into this part yet.

