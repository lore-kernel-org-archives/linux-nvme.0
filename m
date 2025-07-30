Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85FEC87FC9
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 05:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2rs4IetTmrhrWOGjSKLOyk29J5GcTndOqM9q9HLq08=; b=sLYNS0QbwxRARu6gD5fR2yR8D6
	SopFIrTIOSlriO37/WyG4lhP1o9kmE35oPwF5BfcP/icpG/b+AOCzivg05+fgegJ7Pc8jYkmehXJQ
	/JoMaUK9mpiiLI4elou412dloiifqB+bVCRrI+SQLnd6I0aoctU1MJVVmMsmPmZ1iIaKKnc1EJ8+H
	e4xseeXnpGFO9mZ91rMp6AagpZWa7rI77lJRkroL204uXfeoI1WEkC66OxOdHmfOcUHvNLA0uIVdA
	7gM/DffVvJkh8a7X1eqXrlbCzAX2CFFzeZclyzazMlkj4eCy/R4bwJwhCmVROBgeyqGcFOc9hRqFH
	47H6uTRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugzpz-00000000kvg-34fI;
	Wed, 30 Jul 2025 05:58:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugznv-00000000ke5-0ADW
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 05:56:44 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 615AA21A98;
	Wed, 30 Jul 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2rs4IetTmrhrWOGjSKLOyk29J5GcTndOqM9q9HLq08=;
	b=FEvVFA5dqKrQAVC4235eXBJq+0ZiFX0HEgskwX0SzNM0NotIC0SV6o0WMqSL2jr+AsJqV3
	pJikOaXdnoOFH4q5cMh2+N/8iFhKG5Czi745qN3Kh0kqa9+MMyYV7ScEceOifVIMy4ow4Y
	E2gSttl7wdZIs4o0m1lwfEHeWh5Meps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2rs4IetTmrhrWOGjSKLOyk29J5GcTndOqM9q9HLq08=;
	b=OxfJAsqGMDT9UXguxSbhWIU4ZW6RT8DzSKIMRjAOMkzpnr87fYPCTuh8hy1ZmOXqKV9hUN
	C2fBjmGSQDSvuDAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FEvVFA5d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OxfJAsqG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753855001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2rs4IetTmrhrWOGjSKLOyk29J5GcTndOqM9q9HLq08=;
	b=FEvVFA5dqKrQAVC4235eXBJq+0ZiFX0HEgskwX0SzNM0NotIC0SV6o0WMqSL2jr+AsJqV3
	pJikOaXdnoOFH4q5cMh2+N/8iFhKG5Czi745qN3Kh0kqa9+MMyYV7ScEceOifVIMy4ow4Y
	E2gSttl7wdZIs4o0m1lwfEHeWh5Meps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753855001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2rs4IetTmrhrWOGjSKLOyk29J5GcTndOqM9q9HLq08=;
	b=OxfJAsqGMDT9UXguxSbhWIU4ZW6RT8DzSKIMRjAOMkzpnr87fYPCTuh8hy1ZmOXqKV9hUN
	C2fBjmGSQDSvuDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2220313942;
	Wed, 30 Jul 2025 05:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nY9nBRm0iWgELAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Jul 2025 05:56:41 +0000
Message-ID: <6f8aa545-c368-4135-b7b5-a5806b217f08@suse.de>
Date: Wed, 30 Jul 2025 07:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tools/testing/selftests: add sample nvme bpf path
 selector
To: Geliang Tang <geliang@kernel.org>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250729070653.125258-1-hare@kernel.org>
 <20250729070653.125258-7-hare@kernel.org>
 <2700214e9aa7c7a886c0742826d10f052042ba62.camel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2700214e9aa7c7a886c0742826d10f052042ba62.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 615AA21A98
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_225643_233648_5FCA3815 
X-CRM114-Status: UNSURE (   9.73  )
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

On 7/30/25 04:03, Geliang Tang wrote:
> Hi Hannes,
> 
> I tried to compile this BPF program, but got a compilation error. To
> fix it, NVME_BPF and its dependencies need to be enabled in
> tools/testing/selftests/bpf/config:
> 
> +++ b/tools/testing/selftests/bpf/config
> @@ -121,3 +121,8 @@ CONFIG_XDP_SOCKETS=y
>   CONFIG_XFRM_INTERFACE=y
>   CONFIG_TCP_CONG_DCTCP=y
>   CONFIG_TCP_CONG_BBR=y
> +CONFIG_NVME_CORE=y
> +CONFIG_NVME_FABRICS=y
> +CONFIG_NVME_TCP=y
> +CONFIG_NVME_MULTIPATH=y
> +CONFIG_NVME_BPF=y
> 
Yeah; that's correct.
Thanks for that.

That's one thing I forgot to mention: currently one has to compile in
NVME_CORE and NVME_BPF; one will get linking errors otherwise.
Will see if I can fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

