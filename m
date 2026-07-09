Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17210C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 13:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=; b=IPPEKplzmZVAImM4C6YwtNwjI2
	sRIgUY7YgwVFn4cMxD1RwnHviQzr5JVRoQtSTmJGQb7GPdeE9y2GSf+gydy4ZWWuQ8QMoCKpLjP46
	nCgIwrEjvS227Vt3e6hpveWr7HpMD2MWERgVUJyPVfmNvh1pBhHM9OpdoEb9yYFx/NI7VxQW0pW7a
	gay8isQ9IbkLi0u51DMyMCECWLpX3iC5ZVwdl8phPL5nlkD9A8+fi/WnCyhhVtcIqgXGZuuCOngjJ
	lbaXF4XcZPBEl28oLpg1Q5ZVaghW1kxKWykUObgFAg9DWhFKoUvQjeurVXuCYgCMfO4weNlDv0Z52
	x+Fj5smA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoaz-00000002WP1-0DMn;
	Thu, 09 Jul 2026 13:15:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoax-00000002WOQ-3eKo
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Jul 2026 13:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=; b=HQy/zXB8sVnI24FfLUJVK7n4y+
	yrEYuvCAxfCeV8ikSCxAxfOnFF5NvKx4+8y9QsCnPKVEQqYcGTZfOKIV9sNUrYhZy0USp7jHQuGXD
	Wbls63TY0bd3+lYeV8acAfT+aMaMpn2vl7QebbecCF68KoX1JJO53fc32q875i7qBdZ23SQr5h8G3
	zIXrsc7i85kA9EECdN6i6fs/sumJIdqdHD2X4jWMLred4ejfeyG5V8tmXpr+SFGzfvhBd4erNYw7F
	Yt+NjdESCa/6QEW+aJcIlKrDTjaO6dlf2C/tHFsmtvLd9eunLltiSJ0TgTNT7hqENvpik+PhBRCyF
	rf4ITeNw==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1whoat-00000009EmW-2sr3
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 13:15:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1103076200;
	Thu,  9 Jul 2026 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783602908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=;
	b=DG6ay+bD3066YCWHTI5enZKR9RQWPuRLaM/ErToITkUVswEfDxI3znw4X+gViY3TJeb/rq
	G+gU/Pzc7ta71loVer/X+OQ4WFVVIxZ5Zmmg+laRsEwCHPR74Qt9jLAjeyUyqu3cu6OUKu
	GmTv68EaC5oduMdqIEktbemYoyAwBmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783602908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=;
	b=gnaru9z4klVZnJoInytx4ZK/6eg0Uq9cRab+gv7XztIePFs4GFFFHlKtOEVdHhOu4Xn0dD
	QCFQo/5lu/AL87Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783602908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=;
	b=DG6ay+bD3066YCWHTI5enZKR9RQWPuRLaM/ErToITkUVswEfDxI3znw4X+gViY3TJeb/rq
	G+gU/Pzc7ta71loVer/X+OQ4WFVVIxZ5Zmmg+laRsEwCHPR74Qt9jLAjeyUyqu3cu6OUKu
	GmTv68EaC5oduMdqIEktbemYoyAwBmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783602908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M+sEQ/yADNF/qsKyRCGaX5zDaMnadduE1mggm82rf58=;
	b=gnaru9z4klVZnJoInytx4ZK/6eg0Uq9cRab+gv7XztIePFs4GFFFHlKtOEVdHhOu4Xn0dD
	QCFQo/5lu/AL87Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A4C779AA;
	Thu,  9 Jul 2026 13:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P9phOdueT2q2IwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 09 Jul 2026 13:15:07 +0000
Date: Thu, 9 Jul 2026 15:15:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2 0/2] nvmet: add namespace-level debugfs for
 reservation state
Message-ID: <ef8744cf-b291-4f95-9081-c24ceb4784ba@flourine.local>
References: <20260707121114.2273629-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707121114.2273629-1-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_141511_898222_563C3F66 
X-CRM114-Status: UNSURE (   9.90  )
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

On Tue, Jul 07, 2026 at 08:11:12PM +0800, Guixin Liu wrote:
> This series adds debugfs support for inspecting NVMe target reservation
> (PR) state at the namespace level.
> 
> Patch 1 introduces per-namespace debugfs directories under each subsystem,
> providing the infrastructure for namespace-specific debug entries.
> 
> Patch 2 adds a 'reservation' file that exposes the persistent reservation
> state including enable status, generation counter, notification mask,
> holder information, and the full registrant list.

Looks alright, thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

