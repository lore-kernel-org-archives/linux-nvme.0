Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4912BCA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=; b=0oWH0rxQmfklxZI0b9GtIgntYw
	wqqWqnbgmv53dXGItiXclRpUqzhszYxdmac0p8gg+NbZg/3pQsEOpVxlp9Bs54S8KSpj+oYJ5OmjE
	K9PvVY0Fld0/bdh0w0aFzYPON2MVD4TITFv0iQasP0DVLmKiwD1xsR7NLyxlLWH3ppKht/DdKy0yN
	HYAeFLpZlCF05jOITC0Nl8Xk6xv3/sMVw4FxfFOV0CggxTOzRxLdN/xR5pWDYTgwSNyNqRaH1Iokb
	zTbi5qEOQQjzHecJao0ZB9sL60xg1ZWlIm4qAtL96KMODhoVeGFQVkIPZfrSbOBr2NeP143dDXjvu
	PhbLlucQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utNH4-0000000GLv6-0Axo;
	Tue, 02 Sep 2025 09:25:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utMov-0000000GD1y-3KWe
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 08:56:55 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3928E211D4;
	Tue,  2 Sep 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=fSn0lV+vhTvXYKT+kD4ZyziJBVp7q+SehdYBkgq+7jrf2t39zlGRkFJTurVMypbNMraYKu
	dseZ6hlTMY43fMJzH1y3xTYO4xobbuHyh6MKavrY284XYs4JWik9zcyNlv9B/lAjyMb605
	Iw6qG8DxRmLkgLrYrUkDrDJ0Bzk4c1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=to4iaZItr7iDPbXlXgl2ChP1eeHKmKKsNAvNU96SNQRJ5W4lEemypFfemIFg2sQVCDPrbi
	FJ6ki7KeH0ST7TBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fSn0lV+v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=to4iaZIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=fSn0lV+vhTvXYKT+kD4ZyziJBVp7q+SehdYBkgq+7jrf2t39zlGRkFJTurVMypbNMraYKu
	dseZ6hlTMY43fMJzH1y3xTYO4xobbuHyh6MKavrY284XYs4JWik9zcyNlv9B/lAjyMb605
	Iw6qG8DxRmLkgLrYrUkDrDJ0Bzk4c1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=to4iaZItr7iDPbXlXgl2ChP1eeHKmKKsNAvNU96SNQRJ5W4lEemypFfemIFg2sQVCDPrbi
	FJ6ki7KeH0ST7TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 222CC13888;
	Tue,  2 Sep 2025 08:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s66vBFSxtmjMAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:56:52 +0000
Message-ID: <8bf6c91a-18c5-4236-8176-d03aab8286f4@suse.de>
Date: Tue, 2 Sep 2025 10:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Queue-Id: 3928E211D4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_015653_990731_ADA16CBE 
X-CRM114-Status: GOOD (  12.12  )
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

On 9/2/25 05:52, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The NVMe Base Specification 2.1 states that:
> 
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
> 
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a non
> zero value to avoid continuous timeouts on the target.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

