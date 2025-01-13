Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C45C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=; b=R+d9BqgI9DaLt3mYMLQ/PUtHAB
	NWFdoI7uOQlUNRPafjjyCncIp2+6ZPpeUhDORJKAWI2FGxo/qzhhex10XM8vnU41SmMDO6URuMgQC
	HWu5+2GGFzHlemHs7liiizMVuoX2h7UEukT8hAH2JvoSNr4s80z5be5fbU62mlZEyZhH93HIGefDy
	AOBNRS4XxEqC3UXwmkNHz+BMKGaSxYa0G6Vt7+34fUgFDwc+mr95yb2dvz/5JVgacVzj2tun6W9rI
	efPP+bl89c94pyi6zTUhbaMc6y99J9hkoE2o2vTt0Kg4PNsUu36K9OFiw4HIH9m+rL4CkMKqkYrLo
	jJ4MdryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXNEV-00000005pmf-0m62;
	Mon, 13 Jan 2025 16:24:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMrn-00000005lFE-1vD5
	for linux-nvme@bombadil.infradead.org;
	Mon, 13 Jan 2025 16:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=; b=RLgT4gj0uRl9V0gQlhVtBhviRp
	jakHuTYwGBEyAGUprajQzSgYQBupPM6IMx9vCdKkortfoVhvpA0GMfzRnixkfpBzStgyfpd9cO5Aq
	BTIo2nOzgbftAWEb/NyNiLIwwhic889kakwxQweZS6bUi/RjDFvhSSHQi9uBLG25jDp3KOx9lhM3p
	M1U0zVFcdjXO7CmJO+O06O7j9qA2iyM+7dc2QalKdAD1eAb7saqA1Ayciz3gaIRHxa7+EA5EcKYWf
	FE/xw+hOg2KPGG7tLAmngk1GGryayh4Wl2nwaRMp5GExUEWzt+EcD3mcLdfdInf0uS6TwwKOsIf61
	frsCSAAw==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXMrk-0000000AJ3G-2wDb
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 16:00:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EFC11F390;
	Mon, 13 Jan 2025 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736784032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=;
	b=Ue7kVBv+AVwwvjtt12jUemftedVZJbo0yUx32fPMNSKaY9leQFNNQ4hIYkb0HBFUoyJUV4
	TvI03BAcpUfFo6ebLV5d2EdwBqETBcka3l+X7i8DY5fcv1s4R4yQ9y4N41QHzeSWls6nQn
	wuCAz+GWzJ5dN0j+h2fHYd9ZDC5+4DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736784032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=;
	b=X6AHweaCDF2OPHqvDaboeIdivQ+RzMF58BEySs4HLZTtHuONcOk2it1iyQ4JS5MYG0oPTj
	UAPF9RMLqpAowrAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ue7kVBv+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X6AHweaC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1736784032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=;
	b=Ue7kVBv+AVwwvjtt12jUemftedVZJbo0yUx32fPMNSKaY9leQFNNQ4hIYkb0HBFUoyJUV4
	TvI03BAcpUfFo6ebLV5d2EdwBqETBcka3l+X7i8DY5fcv1s4R4yQ9y4N41QHzeSWls6nQn
	wuCAz+GWzJ5dN0j+h2fHYd9ZDC5+4DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1736784032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vda4nrcULrd5MJxsVAvxNAt0W2dXKm/1uYcjULq4nnw=;
	b=X6AHweaCDF2OPHqvDaboeIdivQ+RzMF58BEySs4HLZTtHuONcOk2it1iyQ4JS5MYG0oPTj
	UAPF9RMLqpAowrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3331713310;
	Mon, 13 Jan 2025 16:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2moSDKA4hWejWAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jan 2025 16:00:32 +0000
Message-ID: <fdd92f24-d581-4d81-b0eb-7780f7ae2971@suse.de>
Date: Mon, 13 Jan 2025 17:00:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] nvmet-tcp: support secure channel concatenation
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-11-hare@kernel.org> <Z36o7IqZnwkuckwF@kbusch-mbp>
 <69208b76-71ac-464f-bdb9-50c9c5558ac6@suse.de> <Z4REeAUzXi3z2jeb@kbusch-mbp>
 <f5772112-abdd-4b20-a505-3ce71fe8d7ba@suse.de> <Z4U2cEhXMkwZeEDm@kbusch-mbp>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <Z4U2cEhXMkwZeEDm@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5EFC11F390
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_160036_870378_ADEADCC2 
X-CRM114-Status: GOOD (  14.95  )
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

On 1/13/25 16:51, Keith Busch wrote:
> On Mon, Jan 13, 2025 at 10:34:48AM +0100, Hannes Reinecke wrote:
>> On 1/12/25 23:38, Keith Busch wrote:
>> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
>> index 486afe598184..10e453b2436e 100644
>> --- a/drivers/nvme/host/Kconfig
>> +++ b/drivers/nvme/host/Kconfig
>> @@ -109,7 +109,7 @@ config NVME_HOST_AUTH
>>          bool "NVMe over Fabrics In-Band Authentication in host side"
>>          depends on NVME_CORE
>>          select NVME_AUTH
>> -       select NVME_KEYRING if NVME_TCP_TLS
>> +       select NVME_KEYRING
>>          help
>>            This provides support for NVMe over Fabrics In-Band Authentication in
>>            host side.
>>
>>
>> which obviously needs to be folded into patch 'nvme-tcp: request
>> secure channel concatenation' (the cited patch is a red herring;
>> it only exposes the issue, but the issue got introduced with the
>> patch to nvme-tcp).
>>
>> Can you fold it in or shall I resubmit?
> 
> Sure, I can fold it in.
> 
> Were you okay with my merge conflict resolution on this patch too?

Yeah, go for it.

At worst I'll need to fix it up later on :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

