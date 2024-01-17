Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F899C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=; b=cBNua9dRmnnE+ZExdvt0D9MCPc
	5HWCOVWzlHDEtfDSkNHE89D4KdqB7KHVAPmzM2eMgvBVaGvIMiKBAevf1GGKJLjMBs2uZ+2dZjxKa
	wr4JNZ2StNsME3y3sBqV+Xr2jvPJRIbDPU846uFNbRq9UIHc/mcQ+xDGLQ+4Dm1jalBeUy33iBjvB
	aXZaeQhnnC4cF1P6+I953M1IkmvHpn+PV6rbzTCFufNHMJx97glDSG3xjZwgL6PFFHVCabqdAnhrd
	Vr2PMUsFdMAu5Vy2gH2I51k4ugSPTYzRF+WF0iqnVSVFYoRAebCzt/0j9cWKzZYi0hxEIg8CEZUne
	Ga8vNyIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1dX-00EwUP-08;
	Wed, 17 Jan 2024 08:51:03 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1dT-00EwSB-0Y
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:51:00 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFF331FBEE;
	Wed, 17 Jan 2024 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705481450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=MeR0I8L32aw3vSqrEuwLfOX6oLR9JHRoYQSMNhZIXf50HRs/9oswWprxhtgQpVPBfMd5rv
	qKpHQY1jbs0t3DHrR+yvrNJDPhLccGVfHCQAcGC/1818Mude2ZRhMQwaMWEPctZ1e4IaXr
	tRRKswhYHx19eTtwMe+Db3hsmSmp3ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705481450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=uQiBjgLrobahFM+YXVRzjbTJf36JIYqsekl7lc1F8YV45fgzOJsAPqEoULZ2B0KSE5evMi
	Xr+vCPBKEDWmlFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705481450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=MeR0I8L32aw3vSqrEuwLfOX6oLR9JHRoYQSMNhZIXf50HRs/9oswWprxhtgQpVPBfMd5rv
	qKpHQY1jbs0t3DHrR+yvrNJDPhLccGVfHCQAcGC/1818Mude2ZRhMQwaMWEPctZ1e4IaXr
	tRRKswhYHx19eTtwMe+Db3hsmSmp3ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705481450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HpWVuH5mWEsk7XpDV+ci2ne8S+COL2568w1F4ccB/iU=;
	b=uQiBjgLrobahFM+YXVRzjbTJf36JIYqsekl7lc1F8YV45fgzOJsAPqEoULZ2B0KSE5evMi
	Xr+vCPBKEDWmlFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C527013751;
	Wed, 17 Jan 2024 08:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jVWyLuqUp2UFDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 17 Jan 2024 08:50:50 +0000
Date: Wed, 17 Jan 2024 09:50:50 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
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
Message-ID: <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.33 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.07%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_005059_400791_7FDFA717 
X-CRM114-Status: GOOD (  14.31  )
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

On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> For storage track, I would like to propose a session dedicated to
> blktests. It is a great opportunity for the storage developers to gather
> and have a discussion about:-
> 
> 1. Current status of the blktests framework.
> 2. Any new/missing features that we want to add in the blktests.
> 3. Any new kernel features that could be used to make testing easier?
> 4. DM/MD Testcases.
> 5. Potentially adding VM support in the blktests.

I am interested in such a session.

> Required attendees :-
> 
> Shinichiro Kawasaki
> Damien Le Moal
> Daniel Wanger
> Hannes Reinecke

If I get an invite I'll be there.

Thanks,
Daniel

