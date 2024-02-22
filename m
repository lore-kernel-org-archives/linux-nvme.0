Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D07C48BF8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=; b=BpDb9ioIfkSRsv8vORWkJcjy2H
	lVL1a9pxdVsaXV+17wTwI42nM8h4uVpg2+LMACW3q1yGQlNX5Q6/Xa/EatwcJioA5bK+RGxFCqUkL
	zZapLUGYXns08q1j5ItzOC1IbU8Jh6RI7IKLGJekiUEy2VKnfShT5ce2ncQKV+QpqEGlh4UA9EYD2
	71PjV0rN67hn5SrHZdAbeAkk1mWsudqCGRMvJPzvcrnneY5xD5As18iFp60eUneMMtLGSLLpHTWJW
	xm5FyptFQtbIyfzaTiRGik32TvACyhgcQ0m/BA6liU2pm2/5/gpORmidRaQx5PVryEMby/Tfv10IW
	XfrnVaSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBkV-00000005Zsl-2ssz;
	Thu, 22 Feb 2024 16:16:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBkP-00000005Zrl-0n8L
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 16:16:35 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ABE41FB9A;
	Thu, 22 Feb 2024 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708618591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=1IPtTC1BlUpNz+Rkqo4Yxv3I+yStxpqoMioqayy1m4KZWUa/XPFfAtd7oBX0vSUu8MlhIn
	fBjyF96Y1tc4QXQNkBOSksngMIJX7o+eSxopjZAqMCOp3DYezazk5qWC31vpDVKN45c7fV
	tMnLvrxcoaK/jfLAWKY1Jp+mk+Yhvyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708618591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=s5rnFZTLttmF3tC9S5WDuuKboJl7/2Sq8PlCDfBYFRpVr1Ts17KrRiwYn3MiCz0ePNSfju
	xhppSBXF+Ym+LmAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708618591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=1IPtTC1BlUpNz+Rkqo4Yxv3I+yStxpqoMioqayy1m4KZWUa/XPFfAtd7oBX0vSUu8MlhIn
	fBjyF96Y1tc4QXQNkBOSksngMIJX7o+eSxopjZAqMCOp3DYezazk5qWC31vpDVKN45c7fV
	tMnLvrxcoaK/jfLAWKY1Jp+mk+Yhvyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708618591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=s5rnFZTLttmF3tC9S5WDuuKboJl7/2Sq8PlCDfBYFRpVr1Ts17KrRiwYn3MiCz0ePNSfju
	xhppSBXF+Ym+LmAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CAE613A6B;
	Thu, 22 Feb 2024 16:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FXYpCl9z12XIfAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 16:16:31 +0000
Date: Thu, 22 Feb 2024 17:16:30 +0100
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
Message-ID: <6spltrohwisctoeowctyyneyrqolzyvcd3riozbczj2c2o5pcw@lmtrghutbgwx>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
 <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
 <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.99%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_081633_410588_55E27D93 
X-CRM114-Status: GOOD (  13.29  )
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

On Thu, Feb 22, 2024 at 07:54:18AM -0800, Luis Chamberlain wrote:
> > I should have been more precise here, I was trying to say supporting
> > real fabrics targets. blktests already has some logic for PCI targets
> > with $TEST_DEV but I haven't really looked into this part yet.
> 
> Do fabric targets have a symlink which remains static?

A pretty typical nvme fabric test is:

setup phase target side:
 - create backing device (file/block)
 - create loopback device
 - create nvme subsystem

setup phase host side:
 - discover
 - connect to the target

test phase
 do something like reading/writing from '/dev/nvmeX'
 or 'nvme id-ctrl /dev/nvmeX', etc.

cleanup phase host side:
 - disconnect from the target

cleanup phase target side:
 - remove nvme subsystem
 - remove loopback device
 - remove backing device

I'd like to make the setup and cleanup target side more flexible. The
host side will not be affected at all by exchanging the current soft
target side (aka nvmet) with something else. This means it's not about
any device links in /dev.

Hope this makes it a bit clearer.

