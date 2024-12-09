Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542EBE77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lmw4QapUG6CeNyZ2P7aDTzQNFPNIr8DPd/TJXXNF19Q=; b=r4Hx7hBWK6uS3M5Jngcgx/crZA
	P/gRz+iSQ+kD0VCBfucfQlwVMjWIbAb0I+noxZRn+AX8GSA97qWrnog+b4grJ8DZHUCilGvnWt2Iy
	x9VOGjzS9Io5e2yRV39Qw/yD1qeZAkKd2y3Wpm4Q6K631zgh3WhudtxEdOonoNPwiCvDtIfIsh6t4
	I1TtlzpUCj4vFFPKEObFPz4g9so1y6BlP60H94DPYUS7xBHQ+2XQ13ycZrV7Mh7BXFdtFjdP6cBl0
	neyf9T6IE4sViGXd452o/+bz5sysSKfAs65JNNDxcL7aA4LgozK0DxJBrIUUWGZ5RqP/dLvfx1Ri5
	INQGw0Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZCR-00000006w0X-2D3d;
	Mon, 09 Dec 2024 08:33:03 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZCP-00000006vys-174c
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:33:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A42651F74A;
	Mon,  9 Dec 2024 08:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmw4QapUG6CeNyZ2P7aDTzQNFPNIr8DPd/TJXXNF19Q=;
	b=WyUjnvONMa0HZJE/5xzZT5KVIW79E7tZF+zfaMu8kzTBaqXuixxRFcAQqoUKqWcsbmx5bL
	T9KRmPAqGaUf8S+a5bsPyZ3aMYoUZy2vjLDH+y+ynmK8LrWumDJtE+Au0Xi0Wr4krnSxEw
	rc1TQMN9IzV1JqDMgZDNt7nx/vxOL2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmw4QapUG6CeNyZ2P7aDTzQNFPNIr8DPd/TJXXNF19Q=;
	b=+qfgpRmBw8Mh4hooaxjXbPY/tF+oJ+EYRdE2X33oTAYB6T+JnqUL5wgj8WEMaZTeXjsLrY
	EPX7vgZqEnVs0MAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmw4QapUG6CeNyZ2P7aDTzQNFPNIr8DPd/TJXXNF19Q=;
	b=WyUjnvONMa0HZJE/5xzZT5KVIW79E7tZF+zfaMu8kzTBaqXuixxRFcAQqoUKqWcsbmx5bL
	T9KRmPAqGaUf8S+a5bsPyZ3aMYoUZy2vjLDH+y+ynmK8LrWumDJtE+Au0Xi0Wr4krnSxEw
	rc1TQMN9IzV1JqDMgZDNt7nx/vxOL2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lmw4QapUG6CeNyZ2P7aDTzQNFPNIr8DPd/TJXXNF19Q=;
	b=+qfgpRmBw8Mh4hooaxjXbPY/tF+oJ+EYRdE2X33oTAYB6T+JnqUL5wgj8WEMaZTeXjsLrY
	EPX7vgZqEnVs0MAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3075713B2E;
	Mon,  9 Dec 2024 08:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uqDrCTurVmcQDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:32:59 +0000
Message-ID: <2a4ff5b5-43ba-4ef0-b53e-6d8a44bf2252@suse.de>
Date: Mon, 9 Dec 2024 09:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 09/12] nvme: pass a void pointer to
 nvme_get/set_features for the result
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-10-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-10-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[grimberg.me,gmail.com,samsung.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,lst.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_003301_454678_6B9427CB 
X-CRM114-Status: GOOD (  10.22  )
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

On 12/6/24 23:17, Keith Busch wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> That allows passing in structures instead of the u32 result, and thus
> reduce the amount of bit shifting and masking required to parse the
> result.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   drivers/nvme/host/nvme.h | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

