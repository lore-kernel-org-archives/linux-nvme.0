Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38144C369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+7KfQu0LF93GPIdqlHHA3tJZSrLYJRVNl0akes0NK0=; b=RAAGHgFxFIS05zxs3uMx3+qQD4
	GqjffIScOQR0WTHezhsZpH5l9axopdulBB3bmhC5c2RKiAe6SYIfl/lr4xfb5nww7KAa0aVolZaJd
	qL61BbnUKWhHmbkClZ3HgrGXUe9woaP/HsMPn7rBzJDGAlCvPF7avrvdWe/wUIf35wpVKw4XeMQV2
	u63xWXHVwQHrYuHdeKFB90RCwIrwxqke65X3e6HSK4ucrcLYbxdfdxzrBtXrnFvmb4zs85sBmVXnE
	B8gRUM3yoBVdkW6MIZoadZE3wkqD8RV2r8ejunPf9TyOHcd7tgzZh2L6Yfr/jTOSbDh+XFCRqEPO8
	eNVfY1Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5QEF-0000000DJX1-1okr;
	Thu, 17 Apr 2025 14:28:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5P0G-0000000D5eL-3Rd3
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 13:10:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A00321F7B0;
	Thu, 17 Apr 2025 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744895401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+7KfQu0LF93GPIdqlHHA3tJZSrLYJRVNl0akes0NK0=;
	b=VzcpSjhCalCkZudzoZ+TK13OhJ0/UgRir6hwYiU45HKrHo2n10lLWMANdRx+d6JSGPatyd
	7KD3o405mzCcVVfw4prvx+T+A5R1f74WM8hqFYO6EVK1Buo1yd1WSUtJ2dKomrYkkcKkS5
	jayX5beweqtQ94t1tju7H3msTCCoUTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744895401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+7KfQu0LF93GPIdqlHHA3tJZSrLYJRVNl0akes0NK0=;
	b=vtZ5ClwAg5GwukaB19tgraiDbXhkvuClr1fUiPvmWKYOwl585OsqgvBlyvqYGyNHwjRLVj
	BDt5P9qBQ/kr8UBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VzcpSjhC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vtZ5ClwA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744895401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+7KfQu0LF93GPIdqlHHA3tJZSrLYJRVNl0akes0NK0=;
	b=VzcpSjhCalCkZudzoZ+TK13OhJ0/UgRir6hwYiU45HKrHo2n10lLWMANdRx+d6JSGPatyd
	7KD3o405mzCcVVfw4prvx+T+A5R1f74WM8hqFYO6EVK1Buo1yd1WSUtJ2dKomrYkkcKkS5
	jayX5beweqtQ94t1tju7H3msTCCoUTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744895401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+7KfQu0LF93GPIdqlHHA3tJZSrLYJRVNl0akes0NK0=;
	b=vtZ5ClwAg5GwukaB19tgraiDbXhkvuClr1fUiPvmWKYOwl585OsqgvBlyvqYGyNHwjRLVj
	BDt5P9qBQ/kr8UBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E3581388F;
	Thu, 17 Apr 2025 13:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQe/Ian9AGihOwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 17 Apr 2025 13:10:01 +0000
Date: Thu, 17 Apr 2025 15:10:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <e007b9a8-a5eb-4fd8-9491-8dcfaef394dc@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
 <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
 <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
 <d1d76c7f-e8c7-4554-adf0-663bb49d2d82@grimberg.me>
 <852a4c64-9ed3-41d3-adc0-ae18aa320fa7@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <852a4c64-9ed3-41d3-adc0-ae18aa320fa7@flourine.local>
X-Rspamd-Queue-Id: A00321F7B0
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_061005_017848_8EDFB707 
X-CRM114-Status: UNSURE (   7.82  )
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

On Thu, Apr 17, 2025 at 12:12:26PM +0200, Daniel Wagner wrote:
> I will try the distro config in qemu as next.

No success, can't reproduce it with this either.

