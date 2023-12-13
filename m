Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C369EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=; b=uLrmAu+RyMv39RocBQ6huOStYs
	5foMP5A2ldv/4JJwfeJUYhEvufcQKJg6gbsX6sJVXV7B4zU5i1ckq6t/N34oC0d3UWLjAOLOSLc7l
	qz1BuwWt1g2ET4dM00OA1D0vF83YddaDKucS8NwBDXN7uu09vWiTpm21ZoHn33UmaskMV9cv2vdzn
	IrhLGl7eKpmKe6cgc/YA8zpUpkDLzrHzWGC3YVOy7uZ8cn0voyL11E2MsocUmOm4PowBdzVpqrmwc
	+6S6i/KYcw82ViLk0vXCA+LsmUVTJrjx3bgr7VZV0p9KbXeJJsRaJbAJVmCrXM8/eDLIMZMKCVAdS
	UXBLd/SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQdA-00F6dM-0Q;
	Wed, 13 Dec 2023 14:54:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQd6-00F6bv-2h
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 14:54:34 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6CA01F37E;
	Wed, 13 Dec 2023 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702479266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
	b=ZLoALqRA7L2gn1jUHhWKPZ8FsqgrNIM6zzyojZ1D4YiV8ITCbBKrb5aFWdPaw/7apJ9fRk
	lT7ODM9G05nPdB3ZC336FWoioHhRCETiWDo32fVdBWj6JCfZ5mEHvF1yije1e+Ud5dJl+q
	WSBP+H8o1s4ZuNBROliQ9WmfdwHuHhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702479266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
	b=k4XKNkO1fxpEKthIeJQMcBp+wK+3nQ/0WCeH0Sx3zwlc1RHZ8LHaacGn5FUKsRBXZqcO4F
	V78dTtJRgrWX0BCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702479265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
	b=VmVAVDx8H8WVlFG1gcuTPGHKGXehPgHgjqPQhYcC5EyK5kjeafD0ny4F02VRIaggUrGjF1
	QnEDIRkac87J4DeuoRpTjDsx3DbHkqThYfBhV7+BdwWiqstROJL5vgc49JQxy6M3WN+/25
	vvGDJ0aZYFCHfe225ukIYEdnpq3yUwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702479265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nldF4mWPj3GWv/YePs8qIe+zERatEiFzkl3MDVOY0nM=;
	b=OH+jeGOopi9dzJnHLYPtrzIQXer5nFH5NJ8wiLoUrHFr7zr8aMfcZBYJ9wPvVfBjQio7oz
	tD5qOAHujtfNw4Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CA25113240;
	Wed, 13 Dec 2023 14:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 87LxL6HFeWUGSgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 13 Dec 2023 14:54:25 +0000
Date: Wed, 13 Dec 2023 15:54:25 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-2-dwagner@suse.de>
 <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VmVAVDx8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OH+jeGOo;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-7.84 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.33)[75.75%]
X-Rspamd-Queue-Id: E6CA01F37E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_065433_048887_C4CB1ABE 
X-CRM114-Status: GOOD (  13.53  )
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

On Wed, Dec 13, 2023 at 03:27:12PM +0200, Sagi Grimberg wrote:
> > @@ -841,7 +841,7 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
> >   	u64 ref48;
> >   	/* both rw and write zeroes share the same reftag format */
> > -	switch (ns->guard_type) {
> > +	switch (ns->head->guard_type) {
> 
> I think that the whole PI stuff needs to be taken with a bit more
> consideration because if not all paths agree on the pi (as we have
> hbas with fabrics) we can't just override or do a logical or on
> the capabilities/attributes.

So should the PI variables stay in nvme_ns at this point? Or should I
add some checks which avoid an override and warn in this case?

