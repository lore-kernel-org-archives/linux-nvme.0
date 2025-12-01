Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46702D116F8
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTZUSe5KhS0v/BRQCcgUcuhgsNFELuZ+Lngt0JLTv+k=; b=OJ7yIMfL1gGqXdx2N1G/R8bZqz
	p3C5R2DJfafB8jo+10VWEP6Mbh2JIbzPHZr5tWYY/WLotirz0JygS3J11222ZuYGpdn2wpPzKaKKH
	4uX6r5msW7hMSqu6+6+RvRAC1Ts8Zs5zE+FCeP4QUenzUmN0JIb+GQiGFFNqelPOrp5c6KdSooq4s
	WHg3FCW0IrCiLLzd0c7mfp6F6C/hnVrSesV0fzgtlvRog0If1Vu2HLvgHKvFZBxcCoUJleJ1IDTph
	Mh0rfaOgCIwSqyI9rrnVr0TLkpNQdmwV50c3NdqWPwNTl7O+KhzgRtjFBFlaD5gZIwACQxtJnLFjc
	anZrWNBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPznx-00000003BEr-2tgs;
	Mon, 01 Dec 2025 09:02:45 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPzns-00000003BDz-34Zf
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 09:02:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EC6433793;
	Mon,  1 Dec 2025 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTZUSe5KhS0v/BRQCcgUcuhgsNFELuZ+Lngt0JLTv+k=;
	b=rv/mu9YOO+aMhOyOcDo3xK+fOJi1FzW8Sdr2QnkXLIgucZJURd1YSFPEn7Tzf/P47R6CY1
	8C657bj0j22TQvRHlLESxJU+JPPbfz/VRLgkJL+cywT6tJ0mQJJGOKr3d5Ropj2ynZfGD1
	C0p0tsIDnUdvhbxSmp6lfii5FPco53I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTZUSe5KhS0v/BRQCcgUcuhgsNFELuZ+Lngt0JLTv+k=;
	b=6aMNGhgYL2YXRo+gTFGfu4LjKXEMxC3o8dmUxVxniPOa5Uq5bIkLdDXTe9hrNxvM92t6fu
	ZyzaLHy3aUQdfgAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rv/mu9YO";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6aMNGhgY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764579759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTZUSe5KhS0v/BRQCcgUcuhgsNFELuZ+Lngt0JLTv+k=;
	b=rv/mu9YOO+aMhOyOcDo3xK+fOJi1FzW8Sdr2QnkXLIgucZJURd1YSFPEn7Tzf/P47R6CY1
	8C657bj0j22TQvRHlLESxJU+JPPbfz/VRLgkJL+cywT6tJ0mQJJGOKr3d5Ropj2ynZfGD1
	C0p0tsIDnUdvhbxSmp6lfii5FPco53I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764579759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTZUSe5KhS0v/BRQCcgUcuhgsNFELuZ+Lngt0JLTv+k=;
	b=6aMNGhgYL2YXRo+gTFGfu4LjKXEMxC3o8dmUxVxniPOa5Uq5bIkLdDXTe9hrNxvM92t6fu
	ZyzaLHy3aUQdfgAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D48D03EA63;
	Mon,  1 Dec 2025 09:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPs3Mq5ZLWkXQAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Dec 2025 09:02:38 +0000
Message-ID: <f484da62-d297-4eb5-90eb-d3b794f6caac@suse.de>
Date: Mon, 1 Dec 2025 10:02:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] nvmet-auth: parse dhchap key from configfs attribute
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-6-hare@kernel.org>
 <76f11024-341a-4aff-a7b6-e268d2fe04ad@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <76f11024-341a-4aff-a7b6-e268d2fe04ad@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0EC6433793
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251201_010240_915473_2DF5F495 
X-CRM114-Status: GOOD (  11.78  )
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

On 11/30/25 22:53, Sagi Grimberg wrote:
> 
> 
> On 28/05/2025 17:05, Hannes Reinecke wrote:
>> When writing a new dhchap key to the 'dhchap_secret' attribute
>> we should be parsing it directly and only use the pointer to the
>> inserted key. This avoids having to pass around a pointer with the
>> actual key material.
> 
> Hannes, is this an intermediate phase? one that will be replaced by a 
> keyring?
> If so, its good to indicate this in the patch description.

Yes, this is an intermediate step before we switch to use the kernel
keying. Will be updating the description.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

