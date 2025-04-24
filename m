Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489DBC369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=; b=2J9VK3fHW0u33oIsP55kodQJjz
	ZfM1PjVW/CknZiqL5qjM2idTN6Ev1ZCBpk9PlHjLi4N9tQZe261VvqZwETLWqEPfKcI6br8glnLET
	QT3jblAenFn1B9dGO9HkcHs0sL9adiuRzBvvcVvW8RoybKnyLc0nXZh5TwZKSLjUmmxJ0yVu/Dq8h
	SONaC89I2VeUJXmkSO7rwM8/1yK7sHb7brIyeIQGqF5A3/jdO8jQIVq5IEX6+6C6xt7qWFFIrGhjq
	tscwGd8j3OE/cRMmdePeyE+vk+PFNmQExtCBkVfwK9BlPkiKXNI3qCsD0tQHYanaN/wHpHnvbrLuv
	a9WsRydQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7x01-0000000EGkA-2AQo;
	Thu, 24 Apr 2025 13:52:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7tiS-0000000Delc-2mJN
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 10:22:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=; b=jC+YiHGP2JGBKL7Lywo04Hl8vO
	/YpRIeKrO7+wIVFyW6HmG3zwoFF1hfDYcaj62UOgo3QshfBPLHfck8GbXNqNawYujImhIYDD7hKnO
	3uY37hg0vbXZ1gP0MvkZA63LqWV7kVdSdrwJXuQoJQNJXEWsHlr3mdp8im+O1HljavWFouZ9ImiA1
	HJkzFJlbNpgDLN/vnAYZWPD13in9Cz6FurLN2vIPU8tu7ox1SVcJVrVCwyyKcuOlKcBFHkEJK3mR1
	ZXdkcJq4ZCD2gLd6a/i7XLd7L8GeVgrmKFhiE/KlClsgWjNbQ/tjGSWrkZPy20/+SBRwteMA227tm
	2net37Vw==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7tiP-0000000BjIM-2tMC
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 10:21:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D462A1F399;
	Thu, 24 Apr 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=I20tKXm2vPnHFEh+CF7xorhhFOp6h6i/43X/EeKNYhMmqwalpmHe3Mz+rdPQcQdcPcfs/G
	hs1RgJZrqi2K/AIdQBp+cHDVFnopPaVnnuiD+7g+i6KNpTF5ICQG4RF0hB3WWm2ERXSz3T
	/aDzLAVd84atp/AMCOto1PmsIWkFgNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=a+YYAgpixgeRV+bm/N29cvn2BpJP8llXfjt2lk2YeP+60EKYbmEK8+ez+Qxg/BPJS2LZ6a
	THcBtMWl3RjuthCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bh3MHHFI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dQop6UZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745490114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=bh3MHHFIC62dDpLaM5nOwpPj+aPB7F1dyEoA+H8aJRUdWSBN+5K6A3DQpZWKq9Vo6pBjJP
	tZXNvGA/PMrXUW8q/wkeB9qBV0S5k/BjSUBNvZ1f4xnrzu7xuYjq01RbazW6Aqk3Ao6Ts3
	yQUmfV7JqT7hrK5BZklTWSZpx/PYuKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745490114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DsRlA8ACgBDe0U5ovDT/B/9nVnvrNMp04n0gN/E+imE=;
	b=dQop6UZWOo9+HwTQYn86FOZkMvDevC4lhLCgK9eR3dEVsQVqMGQ4gPiy45b4wSp5faszcn
	hL/Pu7Vly1q0bcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC415139D0;
	Thu, 24 Apr 2025 10:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f39QLcIQCmgVKQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:21:54 +0000
Message-ID: <c966329a-3979-4eca-adcc-4832ffb2b35e@suse.de>
Date: Thu, 24 Apr 2025 12:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] nvmet-fcloop: drop response if targetport is
 gone
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-11-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-11-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D462A1F399
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_112157_893977_191FA3B7 
X-CRM114-Status: GOOD (  12.06  )
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

On 4/23/25 15:21, Daniel Wagner wrote:
> When the target port is gone, the lsrsp pointer is invalid. Thus don't
> call the done function anymore instead just drop the response.
> 
> This happens when the target sends a disconnect association. After this
> the target starts tearing down all resources and doesn't expect any
> response.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

