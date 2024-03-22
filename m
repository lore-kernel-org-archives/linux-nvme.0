Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A9DC47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gofUzIeeSlqWzBhWlyHNhR7vSJ+UaNiv+C/mxx6lLMs=; b=VTfj10lGa58WcEUoDFOpSSGfCL
	6BQ57QoYaTfCb9uqV2HPZChVoUpXwPT+dCWOeuSla33qLSMSmYCubPuyk5ci7Dran0SAyOApBn2XC
	ThlHVljodFJmF7laPnZvgvXNjaTup7sdhguKZ1NG7DR6UINRryyuv5Ljc29lR8r36KOGQi6zt2kPd
	t7EQbPSKYSWYl/KzXv2/iJSF4uyd7HSpYVe87hs38qaF4jnXpcPxlPV7NZJD8xYH4MZy0fP7hBkOl
	w+t0UqG7xBHR86TJy3nHEhHM7L0ml+bvCgN9V0JBaHTmbNm127JgW3Jg2QW4OP+0gbJfoI+y4HGCx
	xdV4IU9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rne6b-0000000793X-3Clb;
	Fri, 22 Mar 2024 12:34:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rne6T-0000000792n-49vj
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 12:34:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FBDC38545;
	Fri, 22 Mar 2024 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gofUzIeeSlqWzBhWlyHNhR7vSJ+UaNiv+C/mxx6lLMs=;
	b=ffGqG96R9yrvTLK2kNDN8pn5a3t4+L7chaB7e4Tim/K55LfD7pUdsr8bNcmfuhFx77liKj
	WiYatfipiJOjlcwS0FDhDiiujc4qbiTfAVXtiCy0MptH/YXFK/xzfj0UmB9ZE66xQoLsiW
	110Zh62agUjJPB0OHo7odzR9xekp6bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gofUzIeeSlqWzBhWlyHNhR7vSJ+UaNiv+C/mxx6lLMs=;
	b=JOtxpBmt8HFmkepytlobCSL58gj9QjbiF1a+rXypOClXd053GQS7/YqgLyZ5vZ3/yN9ORY
	JxpJRGhvCh8bxxAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gofUzIeeSlqWzBhWlyHNhR7vSJ+UaNiv+C/mxx6lLMs=;
	b=ffGqG96R9yrvTLK2kNDN8pn5a3t4+L7chaB7e4Tim/K55LfD7pUdsr8bNcmfuhFx77liKj
	WiYatfipiJOjlcwS0FDhDiiujc4qbiTfAVXtiCy0MptH/YXFK/xzfj0UmB9ZE66xQoLsiW
	110Zh62agUjJPB0OHo7odzR9xekp6bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gofUzIeeSlqWzBhWlyHNhR7vSJ+UaNiv+C/mxx6lLMs=;
	b=JOtxpBmt8HFmkepytlobCSL58gj9QjbiF1a+rXypOClXd053GQS7/YqgLyZ5vZ3/yN9ORY
	JxpJRGhvCh8bxxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DC5313688;
	Fri, 22 Mar 2024 12:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e2JYGdZ6/WXXAQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 12:34:30 +0000
Date: Fri, 22 Mar 2024 13:34:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 17/18] nvme: don't assume namespace id
Message-ID: <uwbk75om5h6wedeqh2on72usvi6wck6qsfsri3onaexe7uso6b@cqt7mq5qmwdn>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-18-dwagner@suse.de>
 <trit4eelgig2vdlwq5zgpwqe3az3p7r3smbscrwvhnxx54fqr2@tlpme2knu4kj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trit4eelgig2vdlwq5zgpwqe3az3p7r3smbscrwvhnxx54fqr2@tlpme2knu4kj>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.00 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.97%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ffGqG96R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JOtxpBmt
X-Rspamd-Queue-Id: 7FBDC38545
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_053434_210303_473E5538 
X-CRM114-Status: GOOD (  11.91  )
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

On Fri, Mar 22, 2024 at 09:35:05AM +0000, Shinichiro Kawasaki wrote:
 > --- a/tests/nvme/010
> > +++ b/tests/nvme/010
> > @@ -20,17 +20,16 @@ test() {
> >  
> >  	_setup_nvmet
> >  
> > -	local nvmedev
> > +	local ns
> >  
> >  	_nvmet_target_setup
> >  
> >  	_nvme_connect_subsys
> >  
> > -	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> > -	_check_uuid "${nvmedev}"
> > +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> 
> Currently, _check_uuid() compares the uuid with wwid. On the other hand, the
> modified _find_nvme_ns() does not refer wwid. This looks a relax of test
> condition. Do you think this relax is fine?

We still have the _check_uuid in nvme/008 and nvme/009, so while drop
this part here it is still tested. I think we should try to make the
tests as slim as possible, which includes the removal duplicate tests
snippets. I think it is important to keep an eye on the runtime of each
test.

