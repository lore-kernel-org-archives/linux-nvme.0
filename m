Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A31CCD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=; b=aophYdHuJpmZqZ5Is6ys7IwL+Q
	cqZicg3mj00bdsACYb3wJQok77B8Am3am7aR2Lfu5BZd6RQguyCvGriHZBvQu0Cx8y1gdr+s8vl/q
	ZFFfaVexs4RGvjLvFxUCO4t04BGjlrndH0YMmdD4Q3QCnowQNH/u8Mg/lUzFSDvycIV9XQMEun0wy
	1YIyS1usEocqWhnTMml3E+Q3ZhkDSiVhVS6UZ8JkLOoNSPtuU3bUIdDidA934v7E6pB7uv4o7lzGn
	9IiIeOWYX/K4gSj1rdrLE1WVStZ48ybsBq0NHY+fy58Eu8pEaqbRiV1VU3/fhSl/eMGBsYANcLt5z
	/vcRdr0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsdKD-00000005Vmc-394v;
	Fri, 05 Apr 2024 06:45:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsdK9-00000005VlL-1okX
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:45:20 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 700791F770;
	Fri,  5 Apr 2024 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712299512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=mQHmbUDNQmnsHL6VPclu3G7dj3z77GJGRcyeTCNMy3WLSiusogps0VWjzWuBVDaereqrrF
	UJs2zUFH5xbEf19dF80o1UlvJQnDnx2oNujE3iBf7TNF2r9BEOjKBGw6H72uthGZvX7rqo
	sGFLJeHR2Gal2AYD1pUu7R6ObS1BzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712299512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=ugDJCoviWUBQWFZsukwjOOknAhKXpg5mStCXbQ/fRAhatwsXA6CNUo1rd3yNl72aQr2H/b
	5/1HaHeKfisB3mDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mQHmbUDN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ugDJCovi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712299512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=mQHmbUDNQmnsHL6VPclu3G7dj3z77GJGRcyeTCNMy3WLSiusogps0VWjzWuBVDaereqrrF
	UJs2zUFH5xbEf19dF80o1UlvJQnDnx2oNujE3iBf7TNF2r9BEOjKBGw6H72uthGZvX7rqo
	sGFLJeHR2Gal2AYD1pUu7R6ObS1BzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712299512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huP0MdNq2/qxlE6Y5h6Dudv0RfoY9kd5EhXZLo2os34=;
	b=ugDJCoviWUBQWFZsukwjOOknAhKXpg5mStCXbQ/fRAhatwsXA6CNUo1rd3yNl72aQr2H/b
	5/1HaHeKfisB3mDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C53139E8;
	Fri,  5 Apr 2024 06:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OLOqFPidD2aJIAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 05 Apr 2024 06:45:12 +0000
Date: Fri, 5 Apr 2024 08:45:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
References: <20240404154500.2101-1-dwagner@suse.de>
 <20240404154500.2101-2-dwagner@suse.de>
 <20240405061624.GA3107@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405061624.GA3107@lst.de>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 700791F770
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_234517_652180_B2B3F2EB 
X-CRM114-Status: GOOD (  18.64  )
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

On Fri, Apr 05, 2024 at 08:16:24AM +0200, Christoph Hellwig wrote:
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
> >  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
> >  			dev_warn(ctrl->device,
> >  				 "qid 0: secure concatenation is not supported\n");
> > -			ret = NVME_SC_AUTH_REQUIRED;
> > +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
> 
> This is still abusing on the wire status code for in-kernel return
> codes.  Can we please sort this out properly?

Okay, though I am not really sure how to do it correctly.

So the current mapping is

  ret < 0: kernel errors
  ret = 0: all good
  ret > 0: wire status incl DNR

In order to split the internal DNR away, we could attach it to the cmd.
Is this what you had in mind? Or do you mean we should not return
NVME_SC_AUTH_REQUIRED at all. Instead just a negative value and update
the error handling on the callers?

