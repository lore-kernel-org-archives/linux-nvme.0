Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C33F9935A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0tSRHfU8M2qclluh+QUofaYxDvHwhZP3NLldT/N0Ag=; b=OaZDcfBwi135jd8zGqPz4HS4Sx
	Ay8es8qzdsiHYYe8sz3OgzQ2i4KsvbCLOiBFqBEOFROosFXawCHys1kgcJgFVprsQb/a8yom3Dyfv
	JcMk8Vfyzrr9EyO4Q6GvcXSBDR5nTHn2mBqhNDG1FKKdYKlRJJBBzXlQSVaTS4SrjSBYMco5w93wW
	o1sTg7ofgMMMmremyk4dkgXsK4Ykotebkyk9kgjd4l+6bx2UF4hvZu0Djyi6e2zn61im7p4RdMMJX
	bOw0zWYNgK1dyHrpwX7b2np40ChXajfWZOPFXwmfUrKPTFNhWO1p4TihoJ+ymjSgqjKAqym0UL/33
	3pvo40bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFqTh-0000000BPBX-0Khp;
	Thu, 23 Apr 2026 09:36:09 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFqTd-0000000BPAd-2dPz
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 09:36:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43E7B6A833;
	Thu, 23 Apr 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E21593A3;
	Thu, 23 Apr 2026 09:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zhkOCwLo6WlwOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 23 Apr 2026 09:36:02 +0000
Date: Thu, 23 Apr 2026 11:36:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, "willy@infradead.org" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <344dd729-c192-4fc2-a226-851305d70f28@flourine.local>
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local>
 <aY77ogf5nATlJUg_@shinmob>
 <901f4daf-3226-416f-8741-dd15573e736b@linux.ibm.com>
 <aecTw6IYs1fo26EX@shinmob>
 <d6282aa7-4673-4bae-a0ff-fbd84f0a610f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6282aa7-4673-4bae-a0ff-fbd84f0a610f@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 43E7B6A833
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_023605_816130_A3FE4002 
X-CRM114-Status: GOOD (  11.76  )
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

On Thu, Apr 23, 2026 at 01:35:47PM +0530, Nilay Shroff wrote:
> > Taking this chance, I'd like to express my appreciation for the effort to
> > resolve the lockdep issues. It is great that a number of lockdeps are already
> > fixed. Said that, two lockdep issues are still observed with v7.0 kernel at
> > nvme/005 and nbd/002 [1]. I would like to gather attentions to the failures.
> > 
> > [1] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x/
> > 
> I think nvme/005 and nbd/002 failures shall be addressed with this
> patch: https://lore.kernel.org/all/20260413171628.6204-1-kch@nvidia.com/
> 
> It's currently applied to nvme-7.1 and not there yet to mainline kernel.

FWIW, the nightly CI runs for nvme-cli with blktests/master and
linux/master are all green except for the above mentioned nvme/005 tcp
case. Thanks everyone for helping out!

https://github.com/linux-nvme/nvme-cli/actions/runs/24816292836

