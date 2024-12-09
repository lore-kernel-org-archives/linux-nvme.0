Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B821E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3eNA3hRD/YIW3yLrVH3YYj2NEgLCvcTYt7qLx7blmU=; b=AidKfbkFSQkvnmYcSdRvrV8ILo
	Y4T60hLbhL8jo6N9ox5KRO2qEDteLzmKlPxFN6Hy+kr9iIWtefAi7w6ziU/Yo/jWUKRiqzc4vDUR1
	Ds5GjISBLwb4PJLxdszSsLHfxQZCjA+uGXdsI6QR1/7Ap8H68aYs6bz0Qa53QXEuZfgtwwcJ0ydZy
	L/NtIjxXtf3LmLczCgot4izYFKjvHwaUCzwKsVMVVPBPCkVZkJPaEq7kh/d4AxUMiveEu7Qyf69I+
	ctFo9/F6O/fPRxQHAuwux4zIv5iThu0HxHh7qUDUjJ3GmvDTaJZErA4oM5Q7maHvplm1PUlMKbEE4
	5m7NFINQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZDp-00000006wWQ-3R2n;
	Mon, 09 Dec 2024 08:34:29 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZCv-00000006wBL-0GU8
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:33:34 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A69EB1F74A;
	Mon,  9 Dec 2024 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eNA3hRD/YIW3yLrVH3YYj2NEgLCvcTYt7qLx7blmU=;
	b=MH83HXq02b+P3Y0PxvFwNdY/clxQfrqYU4WRgJf1NuSqH+BBmRGmfux+ZxLutYOtJ6a/bf
	ECkE5B1ckto9RYoihFucEFfS+ZvUFoFogHiwGm9LkCrBRZs28XwVjPx+zyBV0jJcywnJIR
	CMLvaaWb4CdZ2VyPnL37Zqj8o71oC3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eNA3hRD/YIW3yLrVH3YYj2NEgLCvcTYt7qLx7blmU=;
	b=JdLVv0Qd+YY6QHLv8zYMj4b8IC5LZqspu8K9atO+2IoL65C+HagfG6Vf8Vc7gN0HASMGBl
	8tB8z4EWMT7jPUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733733211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eNA3hRD/YIW3yLrVH3YYj2NEgLCvcTYt7qLx7blmU=;
	b=MH83HXq02b+P3Y0PxvFwNdY/clxQfrqYU4WRgJf1NuSqH+BBmRGmfux+ZxLutYOtJ6a/bf
	ECkE5B1ckto9RYoihFucEFfS+ZvUFoFogHiwGm9LkCrBRZs28XwVjPx+zyBV0jJcywnJIR
	CMLvaaWb4CdZ2VyPnL37Zqj8o71oC3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733733211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3eNA3hRD/YIW3yLrVH3YYj2NEgLCvcTYt7qLx7blmU=;
	b=JdLVv0Qd+YY6QHLv8zYMj4b8IC5LZqspu8K9atO+2IoL65C+HagfG6Vf8Vc7gN0HASMGBl
	8tB8z4EWMT7jPUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 369FB13B35;
	Mon,  9 Dec 2024 08:33:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnGtC1urVmcuDwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:33:31 +0000
Message-ID: <35e86972-4fd8-45b0-9ec6-5dab9eda8ec1@suse.de>
Date: Mon, 9 Dec 2024 09:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 10/12] nvme.h: add FDP definitions
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-11-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-11-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[grimberg.me,gmail.com,samsung.com,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,lst.de:email,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_003333_253768_4926894A 
X-CRM114-Status: GOOD (  10.35  )
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
> Add the config feature result, config log page, and management receive
> commands needed for FDP.
> 
> Partially based on a patch from Kanchan Joshi <joshi.k@samsung.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [kbusch: renamed some fields to match spec]
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   include/linux/nvme.h | 77 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

