Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0311C5475B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xW++avgOvwabHDYONG/62mgYKbdj4y4vZRBcAY5fTQY=; b=N4wyQcYoR9TKN/ifHCGX4MItZX
	2RI0/HebnyVFYhEX89N/R36QeMweKthBwXmx9F4KigUzJOzzsrLFTzKnD3kblPpiaYLQVJNNiMWYr
	ZAdXZO4wxp+MhlsWaOxFbEcg7dgmgC/7e5oLwheckOxyLTDQYF+AddZzHkCoVGn99gFzfSfXlS1DB
	zDoLdn0hViu2wu8DEoFlOcXgb5Cn2Q3gN9GB4ToLq9cKKyZ3tk7UAvg57pri1JJLlVpS/aRaRHR81
	800u4I+hhIO5enmdQEMs5an4lc+aYzx6po2KCaFqVCVXyNUq/A9jU0HVQshVI8wMDpCfJGLoi++iC
	zBkmZ5JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg1wR-0000000090E-3fjW;
	Fri, 01 Mar 2024 12:24:43 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg1wM-000000008xk-3zUy
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 12:24:42 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0759533905;
	Fri,  1 Mar 2024 12:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709295876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW++avgOvwabHDYONG/62mgYKbdj4y4vZRBcAY5fTQY=;
	b=BG9KPBYBHBpjX6aYUZklQp5gsE1nhdA+KggWpt4sc2YjMHCOE3g27z5ctIvWzrBpYz6i88
	BIPrn25Rvs2XRUN7pl0+Qb6wBCSM9wuGY/y1p5z5iRbuEbsHcdMsIZkO0dDTnZzvGhhc4E
	x3nAWx9G8vMghbMU5i3n58pupEjxsTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709295876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW++avgOvwabHDYONG/62mgYKbdj4y4vZRBcAY5fTQY=;
	b=ert+dDOP9+PCErWl7H0L81cUVYXn9Hjvc2HGRYCPI9FZZgChaOgwUe0Z7PwH9JxeR0phiv
	q81rXmmSsLzEPnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709295876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW++avgOvwabHDYONG/62mgYKbdj4y4vZRBcAY5fTQY=;
	b=BG9KPBYBHBpjX6aYUZklQp5gsE1nhdA+KggWpt4sc2YjMHCOE3g27z5ctIvWzrBpYz6i88
	BIPrn25Rvs2XRUN7pl0+Qb6wBCSM9wuGY/y1p5z5iRbuEbsHcdMsIZkO0dDTnZzvGhhc4E
	x3nAWx9G8vMghbMU5i3n58pupEjxsTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709295876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xW++avgOvwabHDYONG/62mgYKbdj4y4vZRBcAY5fTQY=;
	b=ert+dDOP9+PCErWl7H0L81cUVYXn9Hjvc2HGRYCPI9FZZgChaOgwUe0Z7PwH9JxeR0phiv
	q81rXmmSsLzEPnBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E996C13581;
	Fri,  1 Mar 2024 12:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yTCXNwPJ4WUWRAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 12:24:35 +0000
Date: Fri, 1 Mar 2024 13:24:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/4] nvme: fixes for authentication errors
Message-ID: <a7ihwblvakwllis5v3qwt2vte2v4kqovhhn3r3k4gfokxo7xuq@olxcg3ncyd52>
References: <20240301112823.132570-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301112823.132570-1-hare@kernel.org>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.35 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.55)[80.82%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_042439_169838_49719C61 
X-CRM114-Status: GOOD (  14.55  )
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

On Fri, Mar 01, 2024 at 12:28:19PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> here's a set of fixes we've encountered during blktest runs.
> Turns out that any authentication error we're generating
> internally a in fact non-retryable, so we should map them
> onto the appropriate NVMe status.
> That caused some fallout on the target side, which gets
> fixed with the remainder of this patchset.
> 
> As usual, comments and reviews are welcome.

I've tested this with all transports and the results are pretty good.
Only rdma has some random fallouts (UAFs and lockdep warnings) but this
has nothing to do with this series.

With this series applied and my nvme/048 fixes from today, we finally
have fully working blktests for all transports.

Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

