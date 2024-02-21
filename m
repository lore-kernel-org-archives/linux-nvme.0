Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52899C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=; b=oeMQvqC3HNuoiD1sTFNkyYDMgU
	jQQU7tOkFBG9VSrfUKqyL21O47MNUuw/KVffjGW2/aTYWGjTDRJJnNw285zRV3aQfCw6RIj5mKClH
	Q1uNbdt8wTj9nzWWkmIxwlBxCl7EkkNthaJqUbtTowBH75hQsbDp8sjK+c4qu8Y/WwjMEW8rEBfYA
	HLYv8OzlFPmxIUbCjYcy3aRRzzWIWMefyyMMOS3xOkFsbPI8KdmehbcWPgv+2SeJUlcU8cNPWo8vp
	1uV3p42Gd0i+nAZrQyIGYflsS82tPNBP07FoEfWmuPNra9by0FzSBK2hz4ogdsZSsPQytD1fuPK+R
	E1CPMJhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcpb6-00000001ktB-2ZUM;
	Wed, 21 Feb 2024 16:37:28 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcpb1-00000001kpx-3A2B
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 16:37:26 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 339921F385;
	Wed, 21 Feb 2024 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708533442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=liGWQtuXZJPv7A+jBkq/WX+XRLCPGZYfe1MbDQV1dSNULqRJLsSB/FiLXSgq6LsiRkqbpj
	UuQuXoywQpuaFBVswpW4TFzVM+sGqgs+WA/iGaMwelyafnps7EWGeVnEx8MYMGScbxSV/J
	FprnRurv2mcgWzjHHtyoDepJdmlQT4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708533442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=WCrNkXMELaMqI3nLAgcjgoRdKoPqqZDY00z/BYJbdn+ZvZU6zk/yMideo+q5ONMWUfzkwz
	6mkRbWBci5LTIeAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708533441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=ySjyfA4K3Iuubxrj7IU4ouJ+ZyXbaKAkuDUPOsSTFG6i2/KxqlkRCTgH19oSvVqFGtobWa
	KwddicJFWhYjTTaNq3SQC5FQbKGxbZPRO8L2Zii+KC5WmnI3zkU1Hr8+0uuIMYfC/JMiMM
	9JfMrxV4jjlXFajZcMMmErA53noaRss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708533441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSrgyzhrgoj3J1Jz96Fbq8RIb5QyNeDIaHMGnX2VQaI=;
	b=NcXkLAsfECxbqPIfK/iOjA+/bZ+xh+KEh5F62y1HI7YOWNXqFKCZ5rv9M0sIKkSzsZGizg
	uyXlBXvOu6C9hfAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A154139D1;
	Wed, 21 Feb 2024 16:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NqXaBMEm1mVcaAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 16:37:21 +0000
Date: Wed, 21 Feb 2024 17:37:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Message-ID: <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.61 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[49.31%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_083723_998211_D42A197E 
X-CRM114-Status: GOOD (  23.25  )
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

On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
> On 2/21/24 14:24, Daniel Wagner wrote:
> > There is no point in retrying to connect if the authentication fails.
> > 
> > Connection refused is also issued from the authentication path, thus
> > also do not retry.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   drivers/nvme/host/fc.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> > index a5b29e9ad342..b81046c9f171 100644
> > --- a/drivers/nvme/host/fc.c
> > +++ b/drivers/nvme/host/fc.c
> > @@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
> >   			ctrl->cnum, status);
> >   		if (status > 0 && (status & NVME_SC_DNR))
> >   			recon = false;
> > +		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
> > +			recon = false;
> >   	} else if (time_after_eq(jiffies, rport->dev_loss_end))
> >   		recon = false;
> Is this still required after the patchset to retry authentication errors?

Do you mean

  48dae46676d1 ("nvme: enable retries for authentication commands")

?

In this case yes, I've tested on top of this patch. This breaks the loop
where the provided key is invalid or is missing. The loop would happy
retry until reaching max of retries.

