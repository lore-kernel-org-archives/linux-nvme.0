Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94916E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TFKE+E+UxKw2oElTi0jyOzJrNq1G2O/kUZF/FASzs/4=; b=uYd2PYhqKKBA5cbK1MwvZb4hia
	1uqzsf/tOXTy7JIR/oDLT35MTjVMRS6fge91DP7v6HToXQY/I1GZVdVquLvd9A6MUBYoQSyKX39uc
	L2cSHF149aILVynH6Q8ms2NfPeSAb9E5bXxYaJWioZbTzw9DSutA3z1y5/9OQ2657k16PloS94D47
	DFmYOJ65XK7cZq5VcpfF61Q9dCQqRrqWBiVCe5RCGFUWm61BePEFkgds77R1w0KeYawslYnqxnSE6
	AZbZABH7WBF/S2f7OcegPqrZCA1IomaAFgiPCNU2oyzF26PR35RBnV4MdiTpgvhHVzD8XBcKvQ/f1
	a66z1Rng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ5C-00000006tnt-3BKe;
	Mon, 09 Dec 2024 08:25:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKZ59-00000006tnI-49rk
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 08:25:33 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 91C261F456;
	Mon,  9 Dec 2024 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFKE+E+UxKw2oElTi0jyOzJrNq1G2O/kUZF/FASzs/4=;
	b=PPt/YYW6hQ+KPRM5Vqjx1HZMUOdlSkHiwT9np59y/Z6sWLo1T9KQE+P4JUmMIIWyfwqikJ
	QZZhr9JmvjjqeopUiefTzDYhuYX4I9ylx0vnJrIVq/wnChPX5CoabKa3GSmSkZ8E5J9RCh
	FbSjyufw5LtnI7R7uU4Ad8k9oTKwLTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFKE+E+UxKw2oElTi0jyOzJrNq1G2O/kUZF/FASzs/4=;
	b=ZQaSd4DYkezjVVNDCv/PRdfaeARmoC5+sz7xjnkzTM+5RhITlGMVnKtY2Fu9/yA1PGeiTt
	UQClv5NfMcVEeGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PPt/YYW6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZQaSd4DY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733732728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFKE+E+UxKw2oElTi0jyOzJrNq1G2O/kUZF/FASzs/4=;
	b=PPt/YYW6hQ+KPRM5Vqjx1HZMUOdlSkHiwT9np59y/Z6sWLo1T9KQE+P4JUmMIIWyfwqikJ
	QZZhr9JmvjjqeopUiefTzDYhuYX4I9ylx0vnJrIVq/wnChPX5CoabKa3GSmSkZ8E5J9RCh
	FbSjyufw5LtnI7R7uU4Ad8k9oTKwLTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733732728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFKE+E+UxKw2oElTi0jyOzJrNq1G2O/kUZF/FASzs/4=;
	b=ZQaSd4DYkezjVVNDCv/PRdfaeARmoC5+sz7xjnkzTM+5RhITlGMVnKtY2Fu9/yA1PGeiTt
	UQClv5NfMcVEeGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2345A138D2;
	Mon,  9 Dec 2024 08:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fN3BBnipVmdrDAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Dec 2024 08:25:28 +0000
Message-ID: <cbfe5293-6315-4724-996d-507457b92b20@suse.de>
Date: Mon, 9 Dec 2024 09:25:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv12 01/12] fs: add write stream information to statx
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241206221801.790690-1-kbusch@meta.com>
 <20241206221801.790690-2-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241206221801.790690-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91C261F456
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[grimberg.me,gmail.com,samsung.com,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_002532_172865_24DEC058 
X-CRM114-Status: UNSURE (   9.79  )
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
> Add new statx field to report the maximum number of write streams
> supported and the granularity for them.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [hch: rename hint to stream, add granularity]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/stat.c                 | 2 ++
>   include/linux/stat.h      | 2 ++
>   include/uapi/linux/stat.h | 7 +++++--
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

