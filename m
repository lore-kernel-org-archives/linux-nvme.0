Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384ACCAC5A7
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 07:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fecDuW6t3UUfa2ZEsrxaTihkJ4MdDMLDeUWjrH0S2iA=; b=x+AgxjlmsmqoUWjgl2w71vOHvI
	7E8ofHuwa6sR8TSm4WH7TvE+BuK9f1ePURwHY/aAsbhnqXbC+lO2NYh0hxSO95BNp30nZ3QSox0vZ
	1XnkmutINPwoUjK+MSO4Oa9JEJZXhsb9PQBKH1hHJIL1T3Gfb62LbjM5qsbD6Cp2XMj4Yz6pCYqht
	4HylVQiih2EJnbS34yw+ENkBIAe/tYVnWOjAG773RRcojb6fn+mgUxOK+FXWSXeJ5baJKJKWSxjwK
	6zwRL/oAhDgrncWd4m0xVj1wfHdX98XRF1NMi6W45NEAfeoozFTOhQPkvlzY0j7Ft08PVD5gVgJfR
	8ruu/oNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b8O-00000009PeP-2OP4;
	Mon, 22 Sep 2025 07:38:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b8L-00000009Pbv-43if
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 07:38:51 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF14221B7;
	Mon, 22 Sep 2025 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fecDuW6t3UUfa2ZEsrxaTihkJ4MdDMLDeUWjrH0S2iA=;
	b=ZzLiO54ksz9nDIY/LS8jnu3O5Uu+Sb+hygUZkR3ffcpqtvdp/zDdNmCiJnfrWRuyWY4HzU
	8LGHLUy1rHzDLj+6NRf8uL8d1Wd28xbTR+RRg3OiTIveINn8zojK1g6kEe1SgAbzZgqp3b
	Nu5ZaHYMbMsp/hfN5jT/LXGs9CaQOEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fecDuW6t3UUfa2ZEsrxaTihkJ4MdDMLDeUWjrH0S2iA=;
	b=jTAxpUzPLU/KLcrlGi/r5g+Ehosd0MX0IwnpoABlEZTp28lRnj9ihRhNoBnUhlRnp3ES1Q
	waLmZrpJ/3nahVAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZzLiO54k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jTAxpUzP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fecDuW6t3UUfa2ZEsrxaTihkJ4MdDMLDeUWjrH0S2iA=;
	b=ZzLiO54ksz9nDIY/LS8jnu3O5Uu+Sb+hygUZkR3ffcpqtvdp/zDdNmCiJnfrWRuyWY4HzU
	8LGHLUy1rHzDLj+6NRf8uL8d1Wd28xbTR+RRg3OiTIveINn8zojK1g6kEe1SgAbzZgqp3b
	Nu5ZaHYMbMsp/hfN5jT/LXGs9CaQOEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fecDuW6t3UUfa2ZEsrxaTihkJ4MdDMLDeUWjrH0S2iA=;
	b=jTAxpUzPLU/KLcrlGi/r5g+Ehosd0MX0IwnpoABlEZTp28lRnj9ihRhNoBnUhlRnp3ES1Q
	waLmZrpJ/3nahVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B19C61388C;
	Mon, 22 Sep 2025 07:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LmfKQf90Gj1AQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Sep 2025 07:38:47 +0000
Message-ID: <bacb5186-b3f6-45fe-967c-0472df746b4f@suse.de>
Date: Mon, 22 Sep 2025 09:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] nvmf-tcp: add support for retrieving adapter link
 speed
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-5-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250921111234.863853-5-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0DF14221B7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_003850_304453_492D795F 
X-CRM114-Status: GOOD (  14.22  )
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

On 9/21/25 13:12, Nilay Shroff wrote:
> Add support for retrieving the negotiated NIC link speed (in Mbps).
> This value can be factored into path scoring for the adaptive I/O
> policy. For visibility and debugging, a new sysfs attribute "speed"
> is also added under the NVMe path block device.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/multipath.c | 11 ++++++
>   drivers/nvme/host/nvme.h      |  3 ++
>   drivers/nvme/host/sysfs.c     |  5 +++
>   drivers/nvme/host/tcp.c       | 66 +++++++++++++++++++++++++++++++++++
>   4 files changed, 85 insertions(+)
> 
Why not for FC? We can easily extract the link speed from there, too ...

But why do we need to do that? We already calculated the weighted
average, so we _know_ the latency of each path. And then it's
pretty much immaterial if a path runs with a given speed; if the
latency is lower, that path is being preferred.
Irrespective of the speed, which might be deceptive anyway as
you'll only ever be able to retrieve the speed of the local
link, not of the entire path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

