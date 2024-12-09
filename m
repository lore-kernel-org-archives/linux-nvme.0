Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AC6E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mERKmteGMVMhlEcxx4GuYhnsdA7nWRdbAD9zSTOjz/o=; b=HJdx/7Muodkvs7CIc7k0WyDYGg
	lI7utgaw1IYwCPcpNctatubZ7HSsYBjNkC977Qfeb08tn8hFG/BFU+bBAZOHerNEf5j/KF8LYrPE7
	Cio1V9i3ckvTTy/Ymz6dM8pEgEx26g+1E8Qs9w2fBRVggy8zkD6e+vvR1z8/i6mv0TtNFdkyk7/Yb
	Oskzi5tAFIkUCCf5vEnfwddfIwSw7EDuHWA/JDelmfiz7QlNJvsu0+GedRAQTg3JmrHPuYnPOwtGp
	28nyOndBh+VCWoaEJr9o9ZOiZlNMto6BeRDNsJOstf+G14SggCRLcLw39P4EFkAfZ295Gnj7bfep6
	KpiBWR9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ8a-00000006umQ-2PlY;
	Mon, 09 Dec 2024 08:29:04 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ7J-00000006uPi-1ezK
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:27:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0015A21160;
	Mon,  9 Dec 2024 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mERKmteGMVMhlEcxx4GuYhnsdA7nWRdbAD9zSTOjz/o=;
	b=UiK7P4nSoX6587tH70cGOP7kiSyI/jLorzPyzeqpJwzTFA6J5ncB4kt5FO/poE6CVCe3kB
	OwU1STMkzWREdX7l0L4U8HEBq42EEqzUmy+LeDD5QzQEkV6pBTyr30816jikRr7fEG5+N7
	aKjjugdgO1oCgfFcBe6mhTsOKYv6p3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mERKmteGMVMhlEcxx4GuYhnsdA7nWRdbAD9zSTOjz/o=;
	b=UsRaztyf3SnX1F2OOl3OB/1G7MEs2mDZzZEavVQeyR1zd8Kuv6ZYW9wOj/qeRIf0v3RYKq
	C9NQgAdFdRDehpAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mERKmteGMVMhlEcxx4GuYhnsdA7nWRdbAD9zSTOjz/o=;
	b=UiK7P4nSoX6587tH70cGOP7kiSyI/jLorzPyzeqpJwzTFA6J5ncB4kt5FO/poE6CVCe3kB
	OwU1STMkzWREdX7l0L4U8HEBq42EEqzUmy+LeDD5QzQEkV6pBTyr30816jikRr7fEG5+N7
	aKjjugdgO1oCgfFcBe6mhTsOKYv6p3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mERKmteGMVMhlEcxx4GuYhnsdA7nWRdbAD9zSTOjz/o=;
	b=UsRaztyf3SnX1F2OOl3OB/1G7MEs2mDZzZEavVQeyR1zd8Kuv6ZYW9wOj/qeRIf0v3RYKq
	C9NQgAdFdRDehpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9414C138D2;
	Mon,  9 Dec 2024 08:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 46FIIv+pVmc9DQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:27:43 +0000
Message-ID: <76facd58-e1a6-41bd-b4df-45c19683c05b@suse.de>
Date: Mon, 9 Dec 2024 09:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 04/12] block: introduce max_write_streams queue limit
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-5-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-5-kbusch@meta.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,lst.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_002745_576111_B583BE6C 
X-CRM114-Status: UNSURE (   9.26  )
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
> From: Keith Busch <kbusch@kernel.org>
> 
> Drivers with hardware that support write streams need a way to export how
> many are available so applications can generically query this.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [hch: renamed hints to streams, removed stacking]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/ABI/stable/sysfs-block | 7 +++++++
>   block/blk-sysfs.c                    | 3 +++
>   include/linux/blkdev.h               | 9 +++++++++
>   3 files changed, 19 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

