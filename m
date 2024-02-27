Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E57C5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WAOKOJaWvb7gDT+W1eg0JnHFNkR17d+Zuegi6ACctSo=; b=Dc/vOlhFnLSfuru6LHa+MkduSV
	xZ5iKR51uNsunBwJ2xEh0hv0FhftpTuyswPLxvLpIRp1ujmRIUoEqVJ7jSLN8CcsAEiJuf4j+9wkL
	6iit0p8Yck7xdzosbvQ0F66mIJs9VT8bDAHFCwW8EFfZkI2v/vYx5zb+yyqANhSU2SXfRIzlOiTkR
	xmu6uuXIrLTaB1ZUX+C//MIlMuFHAqcRves8IagZJCjIAIxJdcgY4kcc8bhqW7kWdXzhtOA4R4wme
	pCurF0YPhL6F2CXr2lm2Mq/ewPsiBheh58MRjAORAyuaIE/+8o2FOjVONPp7aqdhooVMLCF1b3Jof
	W8YmohUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retBf-00000004Ofx-1Gru;
	Tue, 27 Feb 2024 08:51:43 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1retBL-00000004OVR-2qGU
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 08:51:42 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74D371F449;
	Tue, 27 Feb 2024 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709023877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WAOKOJaWvb7gDT+W1eg0JnHFNkR17d+Zuegi6ACctSo=;
	b=PdaEOUDeIv8c1E1K3sRkDj8gieBTgxz0Sqo3TvBjEqP/k+c+KgWWJ04c2OOwV4m0BK9XzU
	BM+W/uSHYq1382CwFRTWCwN9bTivQ3y7SOnFrkjiLoqLJ0G0Cqei4DW4a4hMHFNcXLTP91
	xanTjJ7XjzmmCC7nJuuJjbfA6A+zK8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709023877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WAOKOJaWvb7gDT+W1eg0JnHFNkR17d+Zuegi6ACctSo=;
	b=K51PmJJ4ubRPx6UqxEuOJpeQU0skdLc6EytwXE/oD+F8psb5OzvcfHZ9QgsDT7KlE/Y9T7
	AtOvZIQ8xIvlsACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709023877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WAOKOJaWvb7gDT+W1eg0JnHFNkR17d+Zuegi6ACctSo=;
	b=PdaEOUDeIv8c1E1K3sRkDj8gieBTgxz0Sqo3TvBjEqP/k+c+KgWWJ04c2OOwV4m0BK9XzU
	BM+W/uSHYq1382CwFRTWCwN9bTivQ3y7SOnFrkjiLoqLJ0G0Cqei4DW4a4hMHFNcXLTP91
	xanTjJ7XjzmmCC7nJuuJjbfA6A+zK8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709023877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WAOKOJaWvb7gDT+W1eg0JnHFNkR17d+Zuegi6ACctSo=;
	b=K51PmJJ4ubRPx6UqxEuOJpeQU0skdLc6EytwXE/oD+F8psb5OzvcfHZ9QgsDT7KlE/Y9T7
	AtOvZIQ8xIvlsACg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B0BC13419;
	Tue, 27 Feb 2024 08:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EWg8FYWi3WUDKQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 27 Feb 2024 08:51:17 +0000
Date: Tue, 27 Feb 2024 09:49:03 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvme: authentication error are always non-retryable
Message-ID: <pk2oeie4d5blevrkljm6fro5fvuiqtlwvm4ldingh2bmgutxoh@5dshhbsxoy7i>
References: <20240226143013.39119-1-hare@kernel.org>
 <qdv47uxmz4n5vvsxyzh56iexjlznnvovilp2tvhwiqfvqcblqw@43x77wt3yxgq>
 <c5513762-1759-4cd3-8933-7d77fdf4d2ba@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5513762-1759-4cd3-8933-7d77fdf4d2ba@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.37)[77.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_005123_960092_2DA12958 
X-CRM114-Status: UNSURE (   9.22  )
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

On Tue, Feb 27, 2024 at 08:54:32AM +0100, Hannes Reinecke wrote:
> Ouch.
> 
> Does this help?

Yes, this helps. I am running the whole test suite for all transport a
few times just a few times now. Just to make sure.

