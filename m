Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE8CE77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vhaWdpfYyWqKrZIeB5sGAT5UpES883pFZ9Kk0WdmWcs=; b=1iz2dgEVq8JdoqjTFJI/QMRuod
	jHvqa5flqTe2iPcBvNNomSbP9NIlDFcHz1NkkaDC1yrvag4BOTbUpd+PW1i24sgB5st8k0CXAThja
	lwS9WdKOlo0/ldYB+uSFxjpQwMN6SOUWHnwTfXYgmvrga//qn1hx0FaENvnqx4d9oC+YrIHHrEa3I
	SC6hNmqgpn8t/jeNbJl7R3rRUv0rE9JRPFC0iF0Bsu4Yzt7A+1X4p3Zd7i5GZYo/1DehzFcDj3FtP
	lmYE02j1CKktLC2RR28ez5guZKUo+xCiVvPiMj0p8zewhQNvbcPX5K05Vy7MQFPEFYIf91dxAThsK
	tX9+OjBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ7Z-00000006uVv-1EtI;
	Mon, 09 Dec 2024 08:28:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ6W-00000006u9U-1XqH
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:26:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98EB021160;
	Mon,  9 Dec 2024 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhaWdpfYyWqKrZIeB5sGAT5UpES883pFZ9Kk0WdmWcs=;
	b=tlvkL7u5uUUmgIfcqT9q4PLqUDm29O8tDj1cfTY5pnrPEPei4Idm9ldjW+ppL+iv9/28/L
	bbhwsPZAWh4KQeAoG2xC8ir1WrxibAaRMkx8qrKpS/IfqppfKTBVmby9xCGSjikNibicO5
	FmEo1eI7cfwECqPzgbPYDdgAiVSID7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhaWdpfYyWqKrZIeB5sGAT5UpES883pFZ9Kk0WdmWcs=;
	b=BM5IquwJu5j7yC8EDIrnEHmVJza3J7cKBu3SsuimQFbpesRu6mLEDa3YCrO18l1yph+/W6
	owyhXSKHkxvSO6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhaWdpfYyWqKrZIeB5sGAT5UpES883pFZ9Kk0WdmWcs=;
	b=tlvkL7u5uUUmgIfcqT9q4PLqUDm29O8tDj1cfTY5pnrPEPei4Idm9ldjW+ppL+iv9/28/L
	bbhwsPZAWh4KQeAoG2xC8ir1WrxibAaRMkx8qrKpS/IfqppfKTBVmby9xCGSjikNibicO5
	FmEo1eI7cfwECqPzgbPYDdgAiVSID7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhaWdpfYyWqKrZIeB5sGAT5UpES883pFZ9Kk0WdmWcs=;
	b=BM5IquwJu5j7yC8EDIrnEHmVJza3J7cKBu3SsuimQFbpesRu6mLEDa3YCrO18l1yph+/W6
	owyhXSKHkxvSO6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26D04138D2;
	Mon,  9 Dec 2024 08:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4wLbBs6pVmf/DAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:26:54 +0000
Message-ID: <3cb409f1-cfc8-452b-b10b-a0755117bdab@suse.de>
Date: Mon, 9 Dec 2024 09:26:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 03/12] block: add a bi_write_stream field
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-4-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_002656_548131_C8931FFF 
X-CRM114-Status: UNSURE (   9.88  )
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

On 12/6/24 23:17, Keith Busch wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Add the ability to pass a write stream for placement control in the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/bio.c                 | 2 ++
>   block/blk-crypto-fallback.c | 1 +
>   block/blk-merge.c           | 4 ++++
>   block/bounce.c              | 1 +
>   include/linux/blk_types.h   | 1 +
>   5 files changed, 9 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

