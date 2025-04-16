Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E8C369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7HphwoQ3UYl+riquXvw/1AG2UvmNxPhU5HdcbJfi5K0=; b=DXMqNUCRMdTKGxEhy2KUK6s2os
	gcwF2Fc89+JkY0utN9M3WRoLoa5WW4GMj+b+rQyTminHyXCcHW6DgIHqz1Y2nKp+vqQQUOJ94f6z2
	SMGQ+Op2vR/74ISq+ne4BjvSPU6KNRydjZzhGyiokRBhVFwUTA1qoplM1Mm4L3RxInnA2OZSHfpAy
	PoOgI6hMd1RVCysRAV+lfHgJ5bKUjnCABfao6BWXDQaHK1JU9OTTAGMMDDrVRgpNXsbLa6qKIPTPR
	lWG3CDY2pRXOWpQbSuXpEC8V85HjtfejlHHjzU73AEVJF60WkCVFGgI8C0DpM5lV7JmkRjMuc8au1
	kbFK9wSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wTO-00000008RuX-1YLD;
	Wed, 16 Apr 2025 06:42:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4wQm-00000008REq-1hEG
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 06:39:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 88EFB1F445;
	Wed, 16 Apr 2025 06:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744785570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HphwoQ3UYl+riquXvw/1AG2UvmNxPhU5HdcbJfi5K0=;
	b=ysYjk1If8DkB3i97C3/qCJEky6KRWqrNL9DgyuyGTZcBqd1fipZ6lq1wgSk76DGeo2xTvb
	UMASCronoEgMqGo80E5yMWoEvVJQAxThAoI2+za7jyJtXk/bou4oEExIDRDxaGIgg9Wc2A
	MtJtUlF7ssStu8xxUy3PTTGXc1tWDj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744785570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HphwoQ3UYl+riquXvw/1AG2UvmNxPhU5HdcbJfi5K0=;
	b=XHEM3KqCwyrgKeDqCE7e07XJZi8z6qDqK4aWj7ZY0BLzW8QrvOubigk0SkZe4iehmts6K6
	2n+Bg0CYfWUDTIBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744785570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HphwoQ3UYl+riquXvw/1AG2UvmNxPhU5HdcbJfi5K0=;
	b=ysYjk1If8DkB3i97C3/qCJEky6KRWqrNL9DgyuyGTZcBqd1fipZ6lq1wgSk76DGeo2xTvb
	UMASCronoEgMqGo80E5yMWoEvVJQAxThAoI2+za7jyJtXk/bou4oEExIDRDxaGIgg9Wc2A
	MtJtUlF7ssStu8xxUy3PTTGXc1tWDj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744785570;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7HphwoQ3UYl+riquXvw/1AG2UvmNxPhU5HdcbJfi5K0=;
	b=XHEM3KqCwyrgKeDqCE7e07XJZi8z6qDqK4aWj7ZY0BLzW8QrvOubigk0SkZe4iehmts6K6
	2n+Bg0CYfWUDTIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792B6139A1;
	Wed, 16 Apr 2025 06:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gjumHKJQ/2cBPgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 16 Apr 2025 06:39:30 +0000
Date: Wed, 16 Apr 2025 08:39:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Randy Jennings <randyj@purestorage.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>, 
	Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Message-ID: <7d94aa46-8176-4ed6-8937-b6aed3639afc@flourine.local>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <CAPpK+O3QXTEe0BV5M+P644Xs-0rFvxg8w2MR51kwG7_7374Emw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpK+O3QXTEe0BV5M+P644Xs-0rFvxg8w2MR51kwG7_7374Emw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_233932_594225_6EF9FAB2 
X-CRM114-Status: GOOD (  21.48  )
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

On Tue, Apr 15, 2025 at 03:56:13PM -0700, Randy Jennings wrote:
> 2*/3*KATO is from when the host has detected a loss of communication
> to when the host knows (given some assumptions) that the target has
> detected a loss of communication.  A command timeout on the host is a
> fine time for the host to decide that it has lost communication with
> the target, but there are other events.  At the time the host has
> detected a loss of communication, it needs to tear down the
> association (which includes stopping KATO & starting disconnect on
> _all_ the connections in the association).  CQT does not start until
> the host knows that the target has detected a loss of communication.
> So, Mohamed's delay is correct.

I was answering the question why I have chosen the values
nvme_schedule_failover and wanted to point out these values are not
related to the timeout detection.

> > > - What about requests that do not go through nvme_failover_req(), like
> > >   passthrough requests, do we not want to hold these requests until it
> > >   is safe for them to be retried?
> >
> > Pasthrough commands should fail immediately. Userland is in charge here,
> > not the kernel. At least this what should happen here.
> This is not correct according to the spec, and, I believe, not a good
> implementation choice.  The driver (in the spec) is instructed _not_
> to return an error for any request until it knows (given some
> assumptions) that the target is no longer processing the request (or
> that processing does not matter; as in the case of a READ).

I was not precise enough: admin commands should fail.

I suggest to keep this topic separated for the time being. It makes
this discussion even more complex.

