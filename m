Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA4DCAC587
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Sep 2025 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=; b=JSL+fwaP4mGUGh2pOcqzHjZJeg
	5jYyHbaE4fCpe+Cp1Vnv1sBbymYojXqzAn8KECEnLAyCkPMzDrI7dXnuivRvV3WCFJuTR2UgoEdnJ
	j32EJ/3Um2w6+FHlV4DQjjeSO7Oaw07OjLqw2BGZaRP3w0hxGO4mI9gIZVckAOEYpaUnMRFQhjZRs
	sPG8X4w85k6J1nnj0bkJjFVCScXJRSJEkKIoq1iIzIpJGsOoMFDHN4YbvTas5WVv8uiUJSbAzkXJG
	9uIv/mp7bR9P5ubOKKmEUcKcYYy04XqZmYw74BjjKsT0ORocV8mKwvos0sGSaTjrBplB7kqavv2Rf
	9zlG68hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw0nO-00000008NPl-2lgB;
	Tue, 09 Sep 2025 16:02:14 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvxTg-000000074gV-1nat
	for linux-nvme@lists.infradead.org;
	Tue, 09 Sep 2025 12:29:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CF962A610;
	Tue,  9 Sep 2025 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757420977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=p+NfiNmgJ0TY7j4tNFRlmO8d6JY1jV/OC7M9f6wWmZj31u7taAxUSF9nAquLGxbfTYrxuo
	AAHq1SiyqEX90oYhCKWTAMvguCRGyhK+6zMTjcQLnRIPXlW3j3D12ny31nbqAsUnYGzlu+
	fJdzV5QPweXAmp88C9DT82P9wbBENm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757420977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=4jDLiLI7pga/yx8KNekLXvF1VYbgr9ekQsLk6L/bj9ytAMiNTY4RMHIXOgGCNAu+4kXfqV
	enbmnnyQrlz6BADg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p+NfiNmg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4jDLiLI7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757420977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=p+NfiNmgJ0TY7j4tNFRlmO8d6JY1jV/OC7M9f6wWmZj31u7taAxUSF9nAquLGxbfTYrxuo
	AAHq1SiyqEX90oYhCKWTAMvguCRGyhK+6zMTjcQLnRIPXlW3j3D12ny31nbqAsUnYGzlu+
	fJdzV5QPweXAmp88C9DT82P9wbBENm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757420977;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RA3OSl7wMdLOgZRMDC7dY66FMH8ogo6BWB6QlPmnqFI=;
	b=4jDLiLI7pga/yx8KNekLXvF1VYbgr9ekQsLk6L/bj9ytAMiNTY4RMHIXOgGCNAu+4kXfqV
	enbmnnyQrlz6BADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DFCA1388C;
	Tue,  9 Sep 2025 12:29:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOFgBrEdwGjHSQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 09 Sep 2025 12:29:37 +0000
Date: Tue, 9 Sep 2025 14:29:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Message-ID: <4de56010-25fb-400c-ac44-c21ebc6d58b0@flourine.local>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: 2CF962A610
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250909_052940_613937_683EE218 
X-CRM114-Status: GOOD (  14.19  )
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

On Tue, Sep 02, 2025 at 12:21:59PM +0200, Daniel Wagner wrote:
> I've added the other two patches I've recenetly send out to this series
> for getting blktests with FC more stable. So this series containts all
> the latest versions of the patches flying around.
> 
> What is missing are the changes for nvme/041. These patches need some
> more work and more review.

ping

