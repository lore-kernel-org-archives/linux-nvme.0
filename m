Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27D7C67861
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=; b=xXutLAxLAJQhrveBQCJtigS6vG
	JLIpadv4STVmmiEfprAr7cuXofQZyE+GLzZSdZxtlY3B6T1ZRT78ZYI0y6n6D7TrGkcw35+TYFfQT
	wqUcGPju/27y4HdcKKiPgAlNLcTaiy3PMRhSZfDdcFiJ9K+3n52Tt7i9djvTcUIvKnkV6OBPeI42C
	vmdL2h5BPHXje7XxhegwoIzXiotd1arN8bHGurJ0fLthYx186joK1TCvTTkmLCGOVFnXusnAaFrEU
	TKBRN2PpZP8CcJQdOOc8JIQi+FHs791Pxd3W3ZQKYxr9FJgxw8sceVbUSIpLgc9RuBJs6C6ewoliC
	PjSjSRmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsjZT-00000007D68-0NIa;
	Fri, 05 Apr 2024 13:25:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsjZM-00000007D4f-3kHc
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 13:25:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9629A21A41;
	Fri,  5 Apr 2024 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712323522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=lFBNLNUbFnYkutVradXzW3rkfxETWkp10yjx4uOPAAovCfUzOSt14yLOw4yCxI5CoDIeXk
	Yv4X7qGxtc7LFCsfRJlI8RlTAE6MN55mq4GA+uYCbakhPmtEJ3dZXNs3Kku3nlflh19BWz
	AxvhCTREQ2QUi6aqJ0QU5K61ZeAB8k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712323522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=fcOxNc9hAkvQdUSSb/A5XSl4e8oEUWkmK31vPNqb8uhPfrNt+XntR/T1ZijH4b22MPIU/X
	80LQdXPwvXVmgwDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lFBNLNUb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fcOxNc9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712323522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=lFBNLNUbFnYkutVradXzW3rkfxETWkp10yjx4uOPAAovCfUzOSt14yLOw4yCxI5CoDIeXk
	Yv4X7qGxtc7LFCsfRJlI8RlTAE6MN55mq4GA+uYCbakhPmtEJ3dZXNs3Kku3nlflh19BWz
	AxvhCTREQ2QUi6aqJ0QU5K61ZeAB8k0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712323522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJC3Z1irT0+nnttWGlCwrHW635IJ8lN25LyXL+82QFU=;
	b=fcOxNc9hAkvQdUSSb/A5XSl4e8oEUWkmK31vPNqb8uhPfrNt+XntR/T1ZijH4b22MPIU/X
	80LQdXPwvXVmgwDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 83844139F1;
	Fri,  5 Apr 2024 13:25:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id b/qrHsL7D2blLAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 05 Apr 2024 13:25:22 +0000
Date: Fri, 5 Apr 2024 15:24:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <b2wntzlxa62nj7abvgsfc36tqbhuhun2e6ugqlvfs7lzfegzzm@q5mydisb7vaf>
References: <20240405062055.GC3107@lst.de>
 <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9629A21A41
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240405_062525_116589_4A8AAF0D 
X-CRM114-Status: GOOD (  20.20  )
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

On Fri, Apr 05, 2024 at 12:02:52PM +0200, Daniel Wagner wrote:
> On Fri, Apr 05, 2024 at 08:20:55AM +0200, Christoph Hellwig wrote:
> > > @@ -131,7 +131,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
> > >  	int ret = 0;
> > >  	struct nvmet_host_link *p;
> > >  	struct nvmet_host *host = NULL;
> > > -	const char *hash_name;
> > >  
> > >  	down_read(&nvmet_config_sem);
> > >  	if (nvmet_is_disc_subsys(ctrl->subsys))
> > > @@ -149,13 +148,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
> > >  	}
> > >  	if (!host) {
> > >  		pr_debug("host %s not found\n", ctrl->hostnqn);
> > > -		ret = -EPERM;
> > > +		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> > >  		goto out_unlock;
> > 
> > This is now returning returning random on the wire fields that aren't
> > even the NVMe status codes from a function otherwise returning Linux
> > errno values.  I can't see how this works or is maintainable long term.
> 
> This is the target side and we generate the on wire return code here.
> Are you sure I should map this to errno codes and the back to NVME
> status codes? Sure, this is possible but don't really think it makes
> sense.

I think I start to understand your feedback. I'll try to address it.

