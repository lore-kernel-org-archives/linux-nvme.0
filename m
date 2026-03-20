Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5641098781
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 13:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6iGgkendOsOjHP7s1gaLeqySjQLMF47FYsOobqrhsXA=; b=dVfbCDiFQLWLzUUQmIt1CHpxak
	e7Mj/sAeVwcEjhJUaal0Q7SUhNmjZTgT2WB5C0KxrXZOfZVwj1S2s5Ua9LTJOGnRBgRC1b56YHY0v
	HFWxZJV+3Tb6IY01JXFS6sakeUUoAfCFPHLdTyIAErR9IslpVLchi8MDRuXmGkd5R9jJSg8JuW4lK
	NEQfeELo/M5RN9yxIxRY+aJzJam0M9uXE0DObwST062iR8m/2NUr4SaZ48miaymDwB1Qne1fO6qCh
	SRS89QGd/voY35ftbDGxiYjrpkemFH8EYxS1IO41AIJHPT1AeWIQ/AM41CI28bfKW9Oa+SzaMHUJy
	wWAs30Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3aEe-0000000CtD3-225k;
	Fri, 20 Mar 2026 13:49:56 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3aEb-0000000CtC7-40OT
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 13:49:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CFFF5BDF5;
	Fri, 20 Mar 2026 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774014590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGgkendOsOjHP7s1gaLeqySjQLMF47FYsOobqrhsXA=;
	b=xl+6rONbqZ1C1whP/kHaxH9D5PdlJ6c33k9vol++9fdrHuf0JHFMBTBSFpQgKfLtJG/wUk
	W2TiQlNChbqXE/GXZ6HWPxObyZdsgKe85yv6hGqr9XcbWO4E9kSNn+tQBGbeWwcWy2dX4F
	3Mgs751neUMtXhZacomvpM4L6QTFCL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774014590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGgkendOsOjHP7s1gaLeqySjQLMF47FYsOobqrhsXA=;
	b=qkVC3JOmxuAJEEQ+tYsJ5bjVCHT3Oi5Wq3u8fNwwIQOLHiLoJjs5aHGdiUUP5CBUGacKZH
	ebFqoYMmL1lgdtAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774014590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGgkendOsOjHP7s1gaLeqySjQLMF47FYsOobqrhsXA=;
	b=xl+6rONbqZ1C1whP/kHaxH9D5PdlJ6c33k9vol++9fdrHuf0JHFMBTBSFpQgKfLtJG/wUk
	W2TiQlNChbqXE/GXZ6HWPxObyZdsgKe85yv6hGqr9XcbWO4E9kSNn+tQBGbeWwcWy2dX4F
	3Mgs751neUMtXhZacomvpM4L6QTFCL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774014590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iGgkendOsOjHP7s1gaLeqySjQLMF47FYsOobqrhsXA=;
	b=qkVC3JOmxuAJEEQ+tYsJ5bjVCHT3Oi5Wq3u8fNwwIQOLHiLoJjs5aHGdiUUP5CBUGacKZH
	ebFqoYMmL1lgdtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 243034281F;
	Fri, 20 Mar 2026 13:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9zFaCH5QvWkUEgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Mar 2026 13:49:50 +0000
Message-ID: <232d8e58-0309-4785-a9ab-f8c4acf9842a@suse.de>
Date: Fri, 20 Mar 2026 14:49:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yjshin0438@gmail.com
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org,vger.kernel.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_064954_150707_7CE13AB3 
X-CRM114-Status: UNSURE (   7.80  )
X-CRM114-Notice: Please train this message.
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

On 3/20/26 01:20, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In preperation for using DHCHAP length in upcoming host and target
> patches let's add the hash and diffie-hellman ID length macros.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
>   - New patch
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

