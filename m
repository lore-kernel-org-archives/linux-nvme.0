Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA653E9A744
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 09:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2ThvMgQ5hhsmhVI5SwD9GEZx+IrkVx0DJMmjKGt/Kc=; b=zCMFfoFkdeUOE8wKnz0PKZARgX
	fGU2b2yDSUxw0tiNGoELioILDkfrQPtRs2q02l4/Zm4Jf9ZphgWLRoJIH8Ach8ee0a94mdofSEXUA
	3tXnRwYWOMyA4Zd/AQ2aCa7Lwrdewi8+epmn9o1ikJnSFQBHXnrCMq7rUyiRK6VVmC6B4MbyIV85y
	l7+6SFODxD+9y3JPBGLBs7/7P9yx4/PsOPwnA8C6NAls7T1wS14/jvN1F2TcYRPuU4G1BkQhSaFjh
	xvxtYOBlvBw+3T7OIrjwasoGRlmezKpsrmjzqVKZwm1JUXD+ADcslUgJSc3EvG4yKkAvAp8CQSwgg
	MMrRia6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xtt-000000014Sr-3xU0;
	Tue, 24 Mar 2026 09:18:13 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4xtq-000000014R2-3yCV
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 09:18:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA3234D1C6;
	Tue, 24 Mar 2026 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ThvMgQ5hhsmhVI5SwD9GEZx+IrkVx0DJMmjKGt/Kc=;
	b=Q9+5y3TmDxgB8Kd2gdw/Y/r7mYO+LNqdLVG6ypKQEldgj4Xx7k+uvLKWDaEXhV2rrEself
	QPmIGlsa4HQekWvockcRADK5jo1uFMGxijlt39paF5/cFHAo1hRET6pb+cXmxZ2441e42f
	qAhRlIxKYxzhvmVk7zHUj8iKyUaNsQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ThvMgQ5hhsmhVI5SwD9GEZx+IrkVx0DJMmjKGt/Kc=;
	b=K/8RZtZmsG9DTcIhR4u1kFSoIlCaq3ADdPUNjR7k9HLPJnEq8oKppZmGwxitDLSZJ+F2ly
	U13GZ8+VySS9j9Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774343888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ThvMgQ5hhsmhVI5SwD9GEZx+IrkVx0DJMmjKGt/Kc=;
	b=lgw+hY52vlEp7b6uUbpMLP6GRwjtQGiRbNxt0SxwsS7s0XXAV9AVTUvYl5xJTZiLp2RDgi
	8m1TlsWDwgUNIS4BLSimN2+mi/IH8BSBcFmmQLC58jb/TevpGVTC7Gcc5AliqMHJF09H9y
	AgTcyNAEfI7w4XUMgYMZjmMONojIu2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774343888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2ThvMgQ5hhsmhVI5SwD9GEZx+IrkVx0DJMmjKGt/Kc=;
	b=qv9RHUJNrtyihVMSx9vEkR1sBhFPdNfKWn35fP+iCW11W1rboXBIzUFflpnrLmahndTQPw
	K6omeKgKl2APHGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D977343D73;
	Tue, 24 Mar 2026 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NMQNNNBWwmluFwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Mar 2026 09:18:08 +0000
Date: Tue, 24 Mar 2026 10:18:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org, 
	hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
Subject: Re: [PATCH 6/9] libnvme: add support for per-path diagnostic counters
Message-ID: <8b123263-297b-43bb-b9ea-272a9dd419c5@flourine.local>
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-7-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321152823.3197870-7-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_021811_133348_8A198BDC 
X-CRM114-Status: GOOD (  13.18  )
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

On Sat, Mar 21, 2026 at 08:58:05PM +0530, Nilay Shroff wrote:
> Add support for retrieving per-path diagnostic counters such as
> command_retry_count, command_error_count, and multipath_failover_count.
> These counters improve visibility into NVMe native multipath behavior
> and can be useful for tools such as nvme-top to display real-time
> statistics.
> 
> Unlike other sysfs attributes, these counters can change dynamically.
> Annotate them with "!accessors:none" and provide custom implementations
> to always retrieve the latest (non-cached) values.

If I got this right, this and the next patches depend on

   https://lore.kernel.org/all/20260220175024.292898-1-nilay@linux.ibm.com

Should we wait with interfaces here until they are ready? As we
currently still in the development phase of nvme-cli 3 and thus the API
is not stable, we can touch it again. In the past we also added support
for kernel feature which weren't there yet. I don't mind too much, just
asking what would be best here.

The whole series looks pretty good, just my nitpicks and the question
on exposing 'cur'/'this'.

