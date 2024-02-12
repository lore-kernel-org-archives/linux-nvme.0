Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89455C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=; b=XiqrclxUXdUUZbO4wjrQI227vX
	0DHRVa3BbY+E8urR+p3/r5D748yLchifbvwZi4LYhbOZi2/yM7/rK24X5u89/l2t+Z+tyQMlKUHQ5
	bCknokqLBOFyN/s2/gvGbNyWWZU0zaxVU2a+Rp/X7BfLGEsFXFskicdSftt9DUEI0jTSg7aNHpmGL
	Rd8QSaDcS5S1prvMs6f8ih1pYNQdc13YkhaRnCaNWoEm9QNDYRFPWesv7NHZMMCuHnnnR7LmVK4ap
	99gqsoQ8eh8zX3rCGlXOXfQzf4f+DlAlN4vi+ux/sD9VeUF3ZMPjSADBCke37ksV2xn2VCRmMdyvB
	DPdh6WLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTan-00000004tAN-0VNR;
	Mon, 12 Feb 2024 10:31:17 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTag-00000004t86-0NZ8
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:31:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE93922150;
	Mon, 12 Feb 2024 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=pOhO/3JdQaXLpYApqTZSH8xxg2XOuI9uLnL6Htd2aZVny8ClVeaJT8STJeCK/R6Z0EuwIf
	6Z2/hFB3sOEwyNxOn5SRGiXMVut6/IsTb0Pig1o3rbpBPa5OIlSBaTgPd3OR5R9ltOCGHX
	VQ8jhAC64ORNcW+70T7hMublScVcOcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=NeUOnyoAlr116GKVt4Qmx/2tGtja7xZ5TOeZ9xTAceoEA9B/Tl5duJAvWJvv/N02BtYe3K
	/uQTc9H4xTmfUdCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=pOhO/3JdQaXLpYApqTZSH8xxg2XOuI9uLnL6Htd2aZVny8ClVeaJT8STJeCK/R6Z0EuwIf
	6Z2/hFB3sOEwyNxOn5SRGiXMVut6/IsTb0Pig1o3rbpBPa5OIlSBaTgPd3OR5R9ltOCGHX
	VQ8jhAC64ORNcW+70T7hMublScVcOcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KQsUMRuvZ9A1LtHxdaXPH5EiJdnjk1zjtv1t86DCpQ=;
	b=NeUOnyoAlr116GKVt4Qmx/2tGtja7xZ5TOeZ9xTAceoEA9B/Tl5duJAvWJvv/N02BtYe3K
	/uQTc9H4xTmfUdCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1C913A0E;
	Mon, 12 Feb 2024 10:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id paoQKWzzyWWqCQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:31:08 +0000
Date: Mon, 12 Feb 2024 11:31:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>, 
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for
 assoc_list
Message-ID: <hpcmiagru7r2uuajov6a6fuakitx77na4susy7qrzofts7atyd@rcu4dmxqnfih>
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-13-dwagner@suse.de>
 <b19e0b0f-6b1c-4126-931b-d7b0d01fb3da@suse.de>
 <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKHCXtXWVCdi9Ae@kbusch-mbp.mynextlight.net>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.98)[99.92%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_023110_329179_6B42E4BB 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

On Tue, Feb 06, 2024 at 11:22:49AM -0800, Keith Busch wrote:
> That said, the rcu_read_lock() seems like it should be moved to
> nvmet_fc_assoc_exits() since that's the only part reading rcu protected
> structures.

FTR, here is a fix:

https://lore.kernel.org/linux-nvme/20240212102940.11137-1-dwagner@suse.de/

