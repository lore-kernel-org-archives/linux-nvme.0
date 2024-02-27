Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBAFC5478C
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Feb 2024 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Di0G+eNBOUrl9euKBJZEFFRUrJ4VbLQs5XifOW3ylY4=; b=zkJBvDReNKmKV6f1ZZtrgaJGS6
	1cD/LacYfp4HNw3pg3tToLD40nw36Q6BCqBF2+uEfKzQc84H8h1P3dGrtJoXAZPM3X+wUTmwF2F7U
	qxElovKNG62IPn6O7uoKT+FnA3FXwKza+AHqNaTaCgd7zMKRAgUs1Y/DiDrO6Ylh78DB2xqCeYRvu
	WXN0Ymzjbr1ulGXMnSDIBG8xmm78TyQX/asROPQHbCtgVqkaOIBzJzr9a/gTORdceBw0VcW2hcSaQ
	mEcIbADZtHy0nbZBuRMwv0qteT0ZPFKbH3LwhbYjNECEuWgvImtLcvsIGobYc4cGq9kgtT5ybbtrS
	no9a5a4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rerb9-000000044hd-33H0;
	Tue, 27 Feb 2024 07:09:55 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rerb4-000000044eu-0X9e
	for linux-nvme@lists.infradead.org;
	Tue, 27 Feb 2024 07:09:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8B7B1F399;
	Tue, 27 Feb 2024 07:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709017782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di0G+eNBOUrl9euKBJZEFFRUrJ4VbLQs5XifOW3ylY4=;
	b=j16i/GcQobXjaIKBWo7Q/QUEPP3aLKCmY8dYWyf9vvluwYnJy22G3+HPzLqO1dBrmEjoc2
	5XgyfVj+LIin1q1XTlVkhiEf9Bb8RdzWISDgLxGiAEFmFbGuzLag7QHe06BuIfaQ6NO76H
	dBzyJhNFr2esk6TJW+/b+PUESYmX6N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709017782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di0G+eNBOUrl9euKBJZEFFRUrJ4VbLQs5XifOW3ylY4=;
	b=P6ESdJ68c2HLPBmUwAenm2Q9uyTjHgOYXXJkWraxbDhAz5Bm4rfI64QW8lyfvoadwW8+Hj
	mtO7pqZAphZR3kCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709017782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di0G+eNBOUrl9euKBJZEFFRUrJ4VbLQs5XifOW3ylY4=;
	b=j16i/GcQobXjaIKBWo7Q/QUEPP3aLKCmY8dYWyf9vvluwYnJy22G3+HPzLqO1dBrmEjoc2
	5XgyfVj+LIin1q1XTlVkhiEf9Bb8RdzWISDgLxGiAEFmFbGuzLag7QHe06BuIfaQ6NO76H
	dBzyJhNFr2esk6TJW+/b+PUESYmX6N8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709017782;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Di0G+eNBOUrl9euKBJZEFFRUrJ4VbLQs5XifOW3ylY4=;
	b=P6ESdJ68c2HLPBmUwAenm2Q9uyTjHgOYXXJkWraxbDhAz5Bm4rfI64QW8lyfvoadwW8+Hj
	mtO7pqZAphZR3kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F44A13A58;
	Tue, 27 Feb 2024 07:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UWBZFLaK3WWuUQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 27 Feb 2024 07:09:42 +0000
Message-ID: <ac55b96c-243c-416e-8d96-79b71088da8d@suse.de>
Date: Tue, 27 Feb 2024 08:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: add 'static' suffix for user-specified TLS keys
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240226122449.46976-1-hare@kernel.org>
 <hm7yy2s6z4thaoytpwz6hx3gp7hvpdur4bhglyrnf7khqxqjpq@3n36hpna2265>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <hm7yy2s6z4thaoytpwz6hx3gp7hvpdur4bhglyrnf7khqxqjpq@3n36hpna2265>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j16i/GcQ";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P6ESdJ68
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.56)[81.02%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: B8B7B1F399
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_230950_348760_5F4BEF87 
X-CRM114-Status: GOOD (  11.52  )
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

On 2/26/24 17:35, Daniel Wagner wrote:
> On Mon, Feb 26, 2024 at 01:24:49PM +0100, Hannes Reinecke wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> If the user specifies a specific TLS key via the '--tls_key'
>> option to nvme-cli we should be adding a ';static' suffix
>> to the 'tls_key' sysfs attribute to signal that this is a
>> user-specific key, and not one auto-selected during TLS
>> protocol negotiation.
> 
> Isn't this conflicting the one value per sysfs entry rule?
Yeah, you are right.

I'll be sending a new patch introducing a separate attribute.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


