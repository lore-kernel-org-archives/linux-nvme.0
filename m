Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E436CE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mKWDRgdYiCv1JTSaovGDPv8JWZbP6+X4VpNbOHRfkbg=; b=smcZdt+JSFCjn8h9S4/RVS2YIh
	Xrx0dKbzZFQwoPzkPy2kMKt4q7L46FwxgD0HBlXiluRwhx+AxPyteHq/8a3QBZ1UWk6HA5RPAMASt
	Ilek1Ev/Qf5bZkQjZ/+emNnczRTCItP2zdNhriZ46zm2mmHsumjdOkz7kGKbYqPKTMD910vwk6Yfz
	JBoxVmNn4rTyauDnzzUqno2fNevVcgLnmPfYnmj4Sr67IHTxgPDDWrbMMv4roeqMUliM6Wrdr6FoJ
	ARL3kWwjmBwy8hUgFD0CfA/z8FiGGzYCVszXyz+A9svhcMi2/1TWqg2XpyLmKXyU/k56T/vUdkgYt
	icl84pjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVApj-00000005HMN-3Z1i;
	Tue, 07 Jan 2025 14:45:27 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVAko-00000005Fvd-0NNM
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 14:40:26 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D14AE1F385;
	Tue,  7 Jan 2025 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736260820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKWDRgdYiCv1JTSaovGDPv8JWZbP6+X4VpNbOHRfkbg=;
	b=ACXNuNenqZZxLLEME3+VCglgMEGMSrFygTUQ7fN7azPudx7jcxG/iEBxAcZ58wUNn/N+Tq
	yDEiMHouZSLPYKw6/ZBf4kiJqLFRgYk2tWV6bvhmJHcZGqCeS1Rl/KHeRNQOmrMOBCn0PD
	xqGmTxLJZWrYKCZ25GbG87wtBaQeFTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736260820;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKWDRgdYiCv1JTSaovGDPv8JWZbP6+X4VpNbOHRfkbg=;
	b=P9v17S0uc+h6cJsxyPMaESv5ziIqM/+74QJPhjt0B35fM4KnOylP/JeE2hftxbkEXoKmsI
	0NqQoeBIEDco2FBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736260818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKWDRgdYiCv1JTSaovGDPv8JWZbP6+X4VpNbOHRfkbg=;
	b=hg6oiJDThwxfaFv/HsatQEzh4SsSkKg3k7++AQgFiIl5FG9r2X5fCtddphzgWd13KztWUc
	U3rhBouYcg2Ja4szXntuElj3EAIf7G5bzgST5T+dgjYsvGPntrHTnpWjwGtJTeEUTsELYd
	1k9tb+tldUCkZnoRGhHt5sQEGNdPcVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736260818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKWDRgdYiCv1JTSaovGDPv8JWZbP6+X4VpNbOHRfkbg=;
	b=9vJgrGbG/EA3ssquReQYjg1CqwwmBcMo4Btn0UI2q94wpI455v+kQ6/V4nx4o0SRVhS8/X
	Hr0t7BnIsGAyX6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C340613763;
	Tue,  7 Jan 2025 14:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i8mvLtI8fWcaOwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 07 Jan 2025 14:40:18 +0000
Date: Tue, 7 Jan 2025 15:40:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Paul Ely <paul.ely@broadcom.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
Message-ID: <fe5f7ae2-ccd2-4b5c-abb6-a5619813ed5b@flourine.local>
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
 <feeecd49-3dd2-4c23-a4fb-dc4a43e58ff7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feeecd49-3dd2-4c23-a4fb-dc4a43e58ff7@grimberg.me>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_064022_271528_AD17AE59 
X-CRM114-Status: GOOD (  18.02  )
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

On Tue, Dec 24, 2024 at 12:35:23PM +0200, Sagi Grimberg wrote:
> On 17/12/2024 10:35, Daniel Wagner wrote:
> > On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
> > > > +	/*
> > > > +	 * It's either a kernel error or the host observed a connection
> > > > +	 * lost. In either case it's not possible communicate with the
> > > > +	 * controller and thus enter the error code path.
> > > > +	 */
> > > > +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
> > > >    		return status;
> > > >    	/*
> > > > 
> > > Hmm. Maybe checking for NVME_SC_DNR, too?
> > if no one complains I'll update the check to:
> > 
> > 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> > 	    status == NVME_SC_HOST_PATH_ERROR)
> > 		return status;
> > 
> > okay?
> Why do we care about the DNR? are you going to retry based on it?

I don't know if we should care. Hannes brought this up.

