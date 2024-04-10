Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33DBCD1296
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=; b=wvsCSmq9cwkCuslw94TZ4p3Q4C
	RPo7zGUfSGCS71oTbrJd4CstVvh7fLNGOdfQnaSZ7EL7wzq+MKKu8Zu8wfgRDT1AZYZ6THaU+BGh4
	Bp205EJpCKreVjWKly44Gsv682hWZqQl6YbKArDgg5HOjmVyNfCnaDjA5jwaof/ihlZZ51aPs8n9Z
	4WhrDXYRpZ/aEndjH9gTRX22fCDxAKmFo9OFPYiNe1Qqefeylx+APYleOBYPR2PXwh0BTyrFt33B9
	Hk40Z9zRXy3awioq0CBObVAW8/J/yNXVJrlOlPGlBD9xXd7kwT5zpGlRqmwLO+M1fnOSHaL5LCZWR
	5+YGBbbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUqX-00000006IXf-1qEf;
	Wed, 10 Apr 2024 10:06:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruUqR-00000006ISz-1lUB
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 10:06:23 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAACE5CA2C;
	Wed, 10 Apr 2024 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712743577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=lPB1FYWVxPMycAN8jS+EPKYsLaR0LuMfBUqgvQ/+sDdU2UMR7/CDXktQ+WvkD86V5ezca/
	1JrY9pvYxiwSjB3R1hwJiZmlTMFh39JmC4WLYEPmVmZpbZehT6AMh0OtWgU3C+4X3l0nbv
	pGymrKLOHMKxPDKqPLX6dX1G6WS0xBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712743577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=BGqfAdXlNIhgRpo6x/D1j1Z1wF1oFhMcxl69GYYP+zJMTIch16TkOFPq9k7CvGYyckNRSH
	gfGCTXLUSj9z24Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712743577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=lPB1FYWVxPMycAN8jS+EPKYsLaR0LuMfBUqgvQ/+sDdU2UMR7/CDXktQ+WvkD86V5ezca/
	1JrY9pvYxiwSjB3R1hwJiZmlTMFh39JmC4WLYEPmVmZpbZehT6AMh0OtWgU3C+4X3l0nbv
	pGymrKLOHMKxPDKqPLX6dX1G6WS0xBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712743577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=BGqfAdXlNIhgRpo6x/D1j1Z1wF1oFhMcxl69GYYP+zJMTIch16TkOFPq9k7CvGYyckNRSH
	gfGCTXLUSj9z24Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B69AE13A92;
	Wed, 10 Apr 2024 10:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qxcfK5lkFmYmaAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 10 Apr 2024 10:06:17 +0000
Date: Wed, 10 Apr 2024 12:06:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
Message-ID: <ejsaj5wnhlukb5rbjtnxh7vxpakcd62ee5cimb35mcvv7jqxod@5cnmbyfmnnwn>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
 <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_030619_640970_A10DCB07 
X-CRM114-Status: GOOD (  21.23  )
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

On Tue, Apr 09, 2024 at 11:40:03PM +0300, Sagi Grimberg wrote:
> > +/*
> > + * Evaluate the status information returned by the LLDD
> 
> We usually say transport, less so LLDD.

Updated the documentation accordingly.

> > + * 1) The LLDD reports an negative status. There was an error (e.g. no
> > + *    memory) on the host side and thus abort the operation.
> > + *    Note, there are exception such as ENOTCONN which is
> > + *    not an internal driver error, thus we filter these errors
> > + *    out and retry later.
>
> What is this ENOTCONN here? From what I see its just a random
> escape value to bypass the status check. I think that 0 would do the same
> wouldn't it?

ENOTCONN is issued by the reset handler. Sure, 0 will work as well, so
if the consense is that the reset handler should do that. see below.

> > -	if (nvmf_should_reconnect(ctrl)) {
> > +	if (recon && nvmf_should_reconnect(ctrl)) {
> 
> its weird to have a condition that checks _and_ condition
> of two different "should reconnect" conditions.
> 
> Why don't we simply pass the status to nvmf_should_reconnect()
> and evaluate there?

Sure, makes sense.

> >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > @@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   		return;
> >   	}
> > -	nvme_tcp_reconnect_or_remove(ctrl);
> > +	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);

Here is the source of ENOTCONN.

