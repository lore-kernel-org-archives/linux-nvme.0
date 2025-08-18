Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1131BCA0EF1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5bBvEjkDuFecWIQAly2QsB7UAomNK47HU/ZIMwWLo1E=; b=XMlsUS2EaY6u4s+k0VPWBkJqdV
	75srZoGBpdRJoqxCYYLxEBYljS0Tb8wMm0WXuXNPto2ctuyDnB09hgMXEXmr0VhoD5vO8c3wGj02s
	HrD093EjJyhbSRbpcGKvL6M04mIG5+y4FcoLnD/mgf3kq1q2wd+11PK2Eil+wJ9CYUKPohWJoPECJ
	OsEtnLjGS1SWbMGj6bHN8z3XWLtuZRRFrR9we9ZodcSjjDvd9kmwNXA4h0+9FjutYhtvrdJDiNFTa
	35mCdlzdCUE1DzEU9yadx8y/Mpn1SKASyiSSOEcbWPmKlpXJSSQ4BDCr3Bi6RJvN3I4wtTjwxNY5y
	ly2JVgEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo08G-00000007cRC-3x6H;
	Mon, 18 Aug 2025 13:42:40 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unyeP-00000007IXh-1nAI
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 12:07:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA11A1F74C;
	Mon, 18 Aug 2025 12:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bBvEjkDuFecWIQAly2QsB7UAomNK47HU/ZIMwWLo1E=;
	b=Qq78L8GFXUJXuiv9K3X99Fvb4snhnGfUWjsLQJ/O43U5E9BAPtd5OUPDl+Tju1irz2ZsWp
	soO94VN0lqpVT4MJ/F+ru/V2/C1Z1RFimZAocy5Ymk2xK5qIMzdN5qP0N7r5ssGgG0V46s
	LZY/hn4lACTrKRnxgsOU/LdczfjEEH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bBvEjkDuFecWIQAly2QsB7UAomNK47HU/ZIMwWLo1E=;
	b=5PtA/5DNNx54lQNE2SKAg2W5+pjyHo/KyHn+YOc8NF86oBIYimfWeUYbbrdcU1Xi/OW2ky
	0iF4dxIMMCBsw3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755518863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bBvEjkDuFecWIQAly2QsB7UAomNK47HU/ZIMwWLo1E=;
	b=nRX1SK214ROcOnHCoUGD2vkyf4eX6OqconbFQccPjpXUbAzzg4XZtwepNkAzeD/+0JdwyX
	r8P+hHGsEl+rVhCVNn6vga10oqd+EKmZqyIn5XzEhQTv/iN9I75EZsRhZtuYrfvZdVmskJ
	pb/zBMy6VjafbGiqcghXotkbp2FifaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755518863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bBvEjkDuFecWIQAly2QsB7UAomNK47HU/ZIMwWLo1E=;
	b=zLJ8Vru9EH7FM7usSiVVbp7n9nR4II0owT9fHQ8+jK78F2sCGGC/7MyhpWHD97L5a1yh6p
	yGc0ecenVAl4tKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A1DD13A55;
	Mon, 18 Aug 2025 12:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yqdkJI8Xo2jJbQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 12:07:43 +0000
Message-ID: <8bc163a8-a2a5-4adb-91c7-6d3c627b4edd@suse.de>
Date: Mon, 18 Aug 2025 14:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/9] nvme: add NVME_CTRL_MARGINAL flag
To: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, njavali@marvell.com,
 linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jmeneghi@redhat.com,
 emilne@redhat.com
References: <20250813200744.17975-1-bgurney@redhat.com>
 <20250813200744.17975-3-bgurney@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250813200744.17975-3-bgurney@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-CRM114-CacheID: sfid-20250818_050745_613178_86EEF42F 
X-CRM114-Status: GOOD (  10.32  )
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

On 8/13/25 22:07, Bryan Gurney wrote:
> Add a new controller flag, NVME_CTRL_MARGINAL, to help multipath I/O
> policies to react to a path that is set to a "marginal" state.
> 
> The flag is cleared on controller reset, which is often the case when
> faulty cabling or transceiver hardware is replaced.
> 
> Signed-off-by: Bryan Gurney <bgurney@redhat.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   drivers/nvme/host/nvme.h | 6 ++++++
>   2 files changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

