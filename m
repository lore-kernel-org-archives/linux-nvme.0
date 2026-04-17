Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A217F8E4A7
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 05:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbfGewpoL+PnuLpz/qYeDC6OZJ0vObhkJxhs5bxg5S4=; b=mW0BjH84RUAo9nfcH1CbUQuo7B
	EPFY0M/iV567iSdujvmG+W5rT4swO4tt+virwCvFJgyT2RYzI1KBmYlhyfi/HWpw47+GbJ8muvViL
	/I07K2oEsMKdDw2/cnDnbfdvdMLlVGVXCB9eyT8HWjVx7OByrOuUHEimgy2M5cgplcmLW5jPt+Oj/
	d5hnyeV7gRQtHeztLlHo1m/yC0GC3UJYo66Di5ZUCNv6thMxK5ll1ueYJnfMZHtfhPAFPXr37PGTg
	E0pctuiBgGtyyUlaqROOcw8Ggcx3cWc++1SsiCKehCHL7lUGUyZbX2DSyRXIKjkIltuORtJkVjhOo
	e+76xI+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDboo-00000003Tm9-3tar;
	Fri, 17 Apr 2026 05:32:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDbom-00000003Tln-12Uo
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 05:32:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C4F35BD49;
	Fri, 17 Apr 2026 05:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776403957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbfGewpoL+PnuLpz/qYeDC6OZJ0vObhkJxhs5bxg5S4=;
	b=kenIRyPpcqxdYeGCLE/T40/YBUIEBHFkJ8nWMV4CCcmJgodHCnSGm0rzcIER+Zhpfn3EUY
	XmXtiQ0VLZGsxG38y24nC/YLxPlhr56eHE61oJe2cJOrj4/i79idyS2MtoPX9xrwJ5dZm7
	U2BJKgMKd9lVrnVQSCR5lAWO6HW3pZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776403957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbfGewpoL+PnuLpz/qYeDC6OZJ0vObhkJxhs5bxg5S4=;
	b=UedMxlAk8ruTXelb93dowberloCHagrAfAsTWfvTBWe4RagJCe/eSTwgx82iRlXCdsAjWz
	7hU27BXo5MgZqbBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kenIRyPp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UedMxlAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776403957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbfGewpoL+PnuLpz/qYeDC6OZJ0vObhkJxhs5bxg5S4=;
	b=kenIRyPpcqxdYeGCLE/T40/YBUIEBHFkJ8nWMV4CCcmJgodHCnSGm0rzcIER+Zhpfn3EUY
	XmXtiQ0VLZGsxG38y24nC/YLxPlhr56eHE61oJe2cJOrj4/i79idyS2MtoPX9xrwJ5dZm7
	U2BJKgMKd9lVrnVQSCR5lAWO6HW3pZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776403957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbfGewpoL+PnuLpz/qYeDC6OZJ0vObhkJxhs5bxg5S4=;
	b=UedMxlAk8ruTXelb93dowberloCHagrAfAsTWfvTBWe4RagJCe/eSTwgx82iRlXCdsAjWz
	7hU27BXo5MgZqbBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE9DB593AE;
	Fri, 17 Apr 2026 05:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ApuWMPTF4WmkEQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 17 Apr 2026 05:32:36 +0000
Message-ID: <0f29183a-96c7-4fbc-b523-263dacd4bc77@suse.de>
Date: Fri, 17 Apr 2026 07:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-auth: Include SC_C in RVAL controller hash
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Chris Leech <cleech@redhat.com>
References: <20260417005048.2898121-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260417005048.2898121-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email,wdc.com:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3C4F35BD49
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_223240_433459_7F95CAE5 
X-CRM114-Status: GOOD (  11.61  )
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

On 4/17/26 02:50, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.
> 
> Fixes: e88a7595b57f2 ("nvme-tcp: request secure channel concatenation")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chris Leech <cleech@redhat.com>
> ---
> v3:
>   - Update Fixes tag
> v2:
>   - Rebase using new nvme_auth_hmac_update() functions
> 
>   drivers/nvme/host/auth.c   | 3 ++-
>   drivers/nvme/target/auth.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

