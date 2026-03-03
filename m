Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F22E67A8D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCe0HhvjfsmsyUpfn1rnpGdGlfwWEh/nCLYQZiPY7iw=; b=XYp/jKXOWp41NFfEv1NQ6N2Tgq
	lm+l7r5KDxAdjLEElHAjnuY85syAHF3EXNlcy3HB9sClg4fLZQHM1ENf3Zun0qJ8iLtj478nqxPAM
	U4DfUk7wc0xmQloifRhQ/aOzXXcmpoqVhrQ6Z3frQC1YR2lNmKl5zp0S5NH+1aO98Kz1qbhSKCKTn
	XIBgySVNCv3bXEoEzHY1BNnXNoK2yZJ3oZ9WuhE+jP9oCkJ8PG8+tSrJzC8m1oEF6M2c/LV6xwx4B
	iz4OUadNcGmig9z66rmDCxmE+DXmttZW+6vubAMCkMnCVS1AsSirEwOCGM167RU9eLniJqmWtM6/M
	MlwWhcQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKCE-0000000Efni-2nf2;
	Tue, 03 Mar 2026 07:29:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKCC-0000000EfnB-0dJU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:29:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50A283F86E;
	Tue,  3 Mar 2026 07:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772522968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCe0HhvjfsmsyUpfn1rnpGdGlfwWEh/nCLYQZiPY7iw=;
	b=jyGzDJ1DD49q+2/f2B9AnEFjwX7F8umz/AH3qg9Zrb/uFGdgn7Kx0IlSiHgosU/TNGucGA
	mNV6tACheMkEtcaXITVH+5JzGnrtXizRmJgh+5IQrvrgzdRbzWhOuzxaNoRRT/1l6niF81
	bs44e3nX8ilDQFoCX7HPFfgzQPXa+BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772522968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCe0HhvjfsmsyUpfn1rnpGdGlfwWEh/nCLYQZiPY7iw=;
	b=2C3HiyfjFlz8xzNWlVQ8dMRHy6Kvft0jfnNiXuuAR+3vOCPZ6q/okCI12lPjszqdreB737
	75B+/dWq6OC12iBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jyGzDJ1D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2C3Hiyfj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772522968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCe0HhvjfsmsyUpfn1rnpGdGlfwWEh/nCLYQZiPY7iw=;
	b=jyGzDJ1DD49q+2/f2B9AnEFjwX7F8umz/AH3qg9Zrb/uFGdgn7Kx0IlSiHgosU/TNGucGA
	mNV6tACheMkEtcaXITVH+5JzGnrtXizRmJgh+5IQrvrgzdRbzWhOuzxaNoRRT/1l6niF81
	bs44e3nX8ilDQFoCX7HPFfgzQPXa+BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772522968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCe0HhvjfsmsyUpfn1rnpGdGlfwWEh/nCLYQZiPY7iw=;
	b=2C3HiyfjFlz8xzNWlVQ8dMRHy6Kvft0jfnNiXuuAR+3vOCPZ6q/okCI12lPjszqdreB737
	75B+/dWq6OC12iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 119C33EA69;
	Tue,  3 Mar 2026 07:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TzilAtiNpmlQSAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:29:28 +0000
Message-ID: <97a0a2b0-1d75-4d9c-9d79-f57c5d481a81@suse.de>
Date: Tue, 3 Mar 2026 08:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH 1/2] nvme-multipath: delete gendisk under subsys lock
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, mlombard@redhat.com
Cc: jmeneghi@redhat.com, Keith Busch <kbusch@kernel.org>
References: <20260302222532.3400786-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302222532.3400786-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 50A283F86E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_232932_344288_AD9735A0 
X-CRM114-Status: GOOD (  11.26  )
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

On 3/2/26 23:25, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> To maintain symmetry with the disk add side, perform the disk deletion
> under the nvme subsystem lock. This will ensure consistent ordering of
> device naming when adding namespaces while concurrently deleting stale
> references.
> 
> The deferred removal requires special attention to the nvme_subsystem:
> the head may be holding the final reference in the deferred path, so
> take a reference on it while removing the head.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c      |  3 +--
>   drivers/nvme/host/multipath.c | 28 +++++++++++-----------------
>   drivers/nvme/host/nvme.h      |  1 +
>   3 files changed, 13 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

