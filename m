Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9E5C3601B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+SH6eeBTQzZ1CPgNpdP327MoBfPOV6H/Xkzknm4Hao=; b=UHdNmgj5zbjt1FQhvqmJpK+NK2
	jGILTHeH21Q/E6ljJvTqv+5ymULQj3B1F+B3eipw3hVPr9eCzcNcFUq/WzR7ecAckkq73OnEWi2mJ
	ppaNoXQTbhDfP1s9rxMxX+Jzh/MtF/SBX2DT1IBys1xeR3U64BCHd9PNS/p56xrsF3cQxYEgFMueS
	YZVNDRCEKPqtZDorSV3Y9OcPj5L5u8Ing2hOgcOxOrCUdz4ij8f3dAZhIn3DAyjoo5qhz1Ofa7+NP
	NtnIBAiIuSQ2xgER384qJIw6OrvzXw3z0q2SJVP02Yd/X4kMKwWh4uj1zpCUHSDjIKaO5ILQZk+1Z
	KcsViOLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYTr-00000002Yor-1BXi;
	Tue, 01 Apr 2025 10:04:27 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXzx-00000002URf-2I3d
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 09:33:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4985D1F38D;
	Tue,  1 Apr 2025 09:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743500010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+SH6eeBTQzZ1CPgNpdP327MoBfPOV6H/Xkzknm4Hao=;
	b=LuUoUuPwPyYrwVPb168YD3sfPm3Q/bKFRvlv6/j1qIBCUgdnX8F6T0F1v+0KtzncCyQDh1
	3W5zx2+e7bVOzSiu7E7STLXiH6hSo+KQ9ldaq7UTSOJKg2QYbA5dUZov/oZaGpfVz8+dDu
	yczg7w0vdE1Rj/9i/oPL20QE2Oxvhoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743500010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+SH6eeBTQzZ1CPgNpdP327MoBfPOV6H/Xkzknm4Hao=;
	b=sjIv6WoFSDKivm28GP9RtZ2tKLgJI+IDTADUdWRo4yHYTOtiDTGcgtQiFruaUFgg5Nr9qP
	u/BxC7b+EeTMv9Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LuUoUuPw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sjIv6WoF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743500010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+SH6eeBTQzZ1CPgNpdP327MoBfPOV6H/Xkzknm4Hao=;
	b=LuUoUuPwPyYrwVPb168YD3sfPm3Q/bKFRvlv6/j1qIBCUgdnX8F6T0F1v+0KtzncCyQDh1
	3W5zx2+e7bVOzSiu7E7STLXiH6hSo+KQ9ldaq7UTSOJKg2QYbA5dUZov/oZaGpfVz8+dDu
	yczg7w0vdE1Rj/9i/oPL20QE2Oxvhoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743500010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+SH6eeBTQzZ1CPgNpdP327MoBfPOV6H/Xkzknm4Hao=;
	b=sjIv6WoFSDKivm28GP9RtZ2tKLgJI+IDTADUdWRo4yHYTOtiDTGcgtQiFruaUFgg5Nr9qP
	u/BxC7b+EeTMv9Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F04B138A5;
	Tue,  1 Apr 2025 09:33:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDnUCuqy62eGAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 01 Apr 2025 09:33:30 +0000
Message-ID: <a301c37c-fcc1-4c1f-9317-eb70cae59cdc@suse.de>
Date: Tue, 1 Apr 2025 11:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] nvmet: add command quiesce time
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4985D1F38D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_023333_737389_527C9930 
X-CRM114-Status: GOOD (  13.29  )
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

On 3/24/25 13:07, Daniel Wagner wrote:
> TP4129 introduces Command Quiesce Time (CQT) for coordinating the
> shutdown sequence when for example KATO expires.
> 
> Add support to nvmet but only report CQT is available but the controller
> doesn't need any additional time when shutting down. In this case the
> spec says nvmet should report a value of 1.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 6 ++++++
>   drivers/nvme/target/nvmet.h     | 1 +
>   include/linux/nvme.h            | 4 +++-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

