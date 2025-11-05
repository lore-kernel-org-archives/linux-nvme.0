Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E73CCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=; b=IAdcCLkkJDRGw93+p44sGm2amc
	YlkYoJ8Bd7s8uYIZ0espqbVLUwLksYdxJV0SIKgpLbm4s5GbEfqk/hYd7fuv3XHElDUinkpyqruxx
	Jr+6Rq9Jj1hrjagD0+OvSmpo75337fWlhjHaWt2Zw9aOLuTRkkGq11+LVKUmqYN6VQKidEPpJtgHH
	Eqn7Xv7diZShDhSDFoyJPmBJoVkK8GpotXaiQXLJf/xwhINsRfI/pre//KOODI2G36G0nDTrvLR2k
	SMBAgjK/aOEUVJAlMdF+VDkZvHEbeXvVe9XjF7VixlRgsIPb6uePmjnUYs16MzQUskUz5bmYlVOB5
	eVOXIagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY1F-0000000DCfk-1XlA;
	Wed, 05 Nov 2025 07:33:25 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGY1C-0000000DCfE-2w5X
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 07:33:24 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7523211A9;
	Wed,  5 Nov 2025 07:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=TNFay4r5Gj7ooZMP9Y2U3UYkGjuiTTWK48blYrZCqZ1z9n3sHS8fvHot20S4XidEV3RxKa
	uVl3JPG+Y7HEo/cB0nlUlnTeebD/5XETyv+dcuCydLXB/IdrUsrIQsMs32VOmLImn8vZqQ
	6ZTBglOPbH4WuPRAmjfg5VDZrRyqu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=NYp46wO4NnMflPPGcRUoSHWTDnP6TbiOfE9kvwRDqTpjz99RRd6KpXZD+tSttcuugiGkcN
	RKQrb6QlN8ifJ1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762328000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=TNFay4r5Gj7ooZMP9Y2U3UYkGjuiTTWK48blYrZCqZ1z9n3sHS8fvHot20S4XidEV3RxKa
	uVl3JPG+Y7HEo/cB0nlUlnTeebD/5XETyv+dcuCydLXB/IdrUsrIQsMs32VOmLImn8vZqQ
	6ZTBglOPbH4WuPRAmjfg5VDZrRyqu20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762328000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7WHpwWJsFQidSis9vBhinqzkd1Tci0EX77bk2nM6CQ=;
	b=NYp46wO4NnMflPPGcRUoSHWTDnP6TbiOfE9kvwRDqTpjz99RRd6KpXZD+tSttcuugiGkcN
	RKQrb6QlN8ifJ1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7ADF3132DD;
	Wed,  5 Nov 2025 07:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id umV0HMD9CmnuKQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 05 Nov 2025 07:33:20 +0000
Message-ID: <15c974ec-dd78-4344-bd90-f30f4bb7da49@suse.de>
Date: Wed, 5 Nov 2025 08:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
To: Daniel Wagner <wagi@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Daniel Wagner <dwagner@suse.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_233322_883911_53BA4270 
X-CRM114-Status: GOOD (  15.96  )
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

On 10/28/25 13:54, Daniel Wagner wrote:
> From: Daniel Wagner <dwagner@suse.de>
> 
> Dell Express Flash NVMe P4610 reuse the Intel device id 0x0a54. The
> Intel P4500/46000 device needs NVME_QUIRK_BOBUG_NID whereas the Dell
> does not. Thus clear the quirk when the id check passes.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi,
> 
> Obviously, using the correct IDs is really hard. There are at least two devices
> which share a the device id and one needs the bogus id workaround the other
> doesn't.
> 
> We discussed the idea to pass through configuration from the kernel command line
> at ALPSS. I am not sure, how far we got with this yet. What about something like
> this here?
> 
> Thanks,
> Daniel
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

