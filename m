Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D111BE77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 07:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=htiklAAu6bOQ7XJrCLtxl1e87pc1u1ygZzZ5r3hu898=; b=MOzBc8ODJKBkdSAv4rxAACsDZb
	Cr3lbouAYGCf54i3DE/HjJXMqgnIwxynlPtuEXeXqZTF0vvFcDEj+2sRaQ8M/IsIXtK22+b6kSAp8
	61qBkUH104WW6Wm+BHBzYBPb+3Bv2yhgZ/YSkfIZ0rkuIrqQgetDvz/M/3fnSkGBCAsfbH9dmPJ+y
	7hd+WU8z1rpOlH5hTqZqTvomjWHDPRtAanZ8Z//t30N4VfdEKaaLDKAknIFofjyCMsqpGXwRRB+Sd
	IN4Z7iPxS3MfCWHWgOVb/QGtMHjDwml05t5Vmd9Rb2/8rksSdZ5oTe8d283RWiYCYlKrdnEQrnYn+
	+PLPY39Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVn3E-0000000B3qQ-3A9j;
	Thu, 09 Jan 2025 07:33:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVn3B-0000000B3px-3PaX
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 07:33:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE0BF1F38E;
	Thu,  9 Jan 2025 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736408031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htiklAAu6bOQ7XJrCLtxl1e87pc1u1ygZzZ5r3hu898=;
	b=aV8a4cRKMYNBFONRyo+Fc3hr6I1Q3u8LgqhV0no2JFlwhb3viI0SsU7hD4GJca1U5jv9dv
	zOXuHmaZu7A/Sv+z2SCPWHPpa29mBnRtn/02RM8bUlz5iGVUWHx4s+wS23qd3CrdHZ0eoY
	PXR5P1yEGMrsEWlgVIm5gfEicnDyYcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736408031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htiklAAu6bOQ7XJrCLtxl1e87pc1u1ygZzZ5r3hu898=;
	b=nE2MuhYH8O5MBtfaGzZnTSbv7gd8E2n3Mv4dCkz8y0VIh2tvB4OnXBsxNja+FOaXW2gOzp
	9gHIcNB0MACFGFCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aV8a4cRK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nE2MuhYH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736408031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htiklAAu6bOQ7XJrCLtxl1e87pc1u1ygZzZ5r3hu898=;
	b=aV8a4cRKMYNBFONRyo+Fc3hr6I1Q3u8LgqhV0no2JFlwhb3viI0SsU7hD4GJca1U5jv9dv
	zOXuHmaZu7A/Sv+z2SCPWHPpa29mBnRtn/02RM8bUlz5iGVUWHx4s+wS23qd3CrdHZ0eoY
	PXR5P1yEGMrsEWlgVIm5gfEicnDyYcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736408031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htiklAAu6bOQ7XJrCLtxl1e87pc1u1ygZzZ5r3hu898=;
	b=nE2MuhYH8O5MBtfaGzZnTSbv7gd8E2n3Mv4dCkz8y0VIh2tvB4OnXBsxNja+FOaXW2gOzp
	9gHIcNB0MACFGFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A5B113876;
	Thu,  9 Jan 2025 07:33:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kQkdHN97f2fGWQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 09 Jan 2025 07:33:51 +0000
Message-ID: <69208b76-71ac-464f-bdb9-50c9c5558ac6@suse.de>
Date: Thu, 9 Jan 2025 08:33:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Eric Biggers <ebiggers@kernel.org>,
 linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org> <Z36o7IqZnwkuckwF@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z36o7IqZnwkuckwF@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE0BF1F38E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_233354_561574_83409EBA 
X-CRM114-Status: GOOD (  13.65  )
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

On 1/8/25 17:33, Keith Busch wrote:
> On Tue, Dec 03, 2024 at 12:02:37PM +0100, Hannes Reinecke wrote:
>> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
>> the generated PSK once negotiation has finished.
> 
> ...
> 
>> @@ -251,7 +267,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>>   
>>   	uuid_copy(&ctrl->hostid, &d->hostid);
>>   
>> -	dhchap_status = nvmet_setup_auth(ctrl);
>> +	dhchap_status = nvmet_setup_auth(ctrl, req);
>>   	if (dhchap_status) {
>>   		pr_err("Failed to setup authentication, dhchap status %u\n",
>>   		       dhchap_status);
>> @@ -269,12 +285,13 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>>   		goto out;
>>   	}
> 
> This one had some merge conflicts after applying the pci endpoint
> series from Damien. I tried to resolve it, the result is here:
> 
>    https://git.infradead.org/?p=nvme.git;a=commitdiff;h=11cb42c0f4f4450b325e38c8f0f7d77f5e1a0eb0
> 
> The main conflict was from moving the nvmet_setup_auth() call from
> nvmet_execute_admin_connect() to nvmet_alloc_ctrl().

I'll give it a spin and check how it holds up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

