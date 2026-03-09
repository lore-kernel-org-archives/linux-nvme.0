Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8F7EFCD9B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQCAFCa6WqNNAixvt4eitLAbW/d5CqRYReziR86kwaU=; b=18HTGrE3vOAwEB5c2P1SIRK6pJ
	kFBoI/b7K68EsveeQGtWVqxYtyrYwNg0Ygoj41Mgv4w5/krNdKJFPJdEFTnnD23L17BlC8OkrnRd3
	+jUd4nLuI2yqvGLqrei5vUAqB8BLLjeX2XTtEE0xZMwoIzvFHzbhuym7LT7AhFjGCtKYqhR8LvdRc
	x04ROyt/499QwQE9QjKbs1cpabzSmOOsvNY8mWVg/wIpITLntYxU+i2foj3Nmwhoi58PLchSeVFw3
	NoVUitr4YNnBlURN+x5WMCYpMtrKRUYiUylq8x4RNesng/9zrdMl9x0XUQzwwdQpWilvnKd0Ta9v+
	o74R0tlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzYqL-00000007CII-0DJ9;
	Mon, 09 Mar 2026 11:32:13 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzYqI-00000007CHs-3e43
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 11:32:12 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A52705BDA8;
	Mon,  9 Mar 2026 11:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773055927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQCAFCa6WqNNAixvt4eitLAbW/d5CqRYReziR86kwaU=;
	b=xLSOAGrQafK71WT8V6KOYBfAcme7pERcJidLV0DMnvbxt34+6KtheBaBaRei8Pb1QRtJLi
	sEa1s2kGoyfacZiMulOg5Lp02ZEbjeJ9ozUhW8+HCGKm4mYx6WBZmBGZYkBwaJrMov6+gD
	lm0SBTlN8PyAnq9EzfjTDKJCFBtv0a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773055927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQCAFCa6WqNNAixvt4eitLAbW/d5CqRYReziR86kwaU=;
	b=zIAP4Nie9vQCH28kTS/SdFdSyIZqYfb4sbaVz5+Y9U58j4tOEkqC15gK3uI7nMFRpPwZyp
	2ohJba5vsF9TWZDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773055927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQCAFCa6WqNNAixvt4eitLAbW/d5CqRYReziR86kwaU=;
	b=xLSOAGrQafK71WT8V6KOYBfAcme7pERcJidLV0DMnvbxt34+6KtheBaBaRei8Pb1QRtJLi
	sEa1s2kGoyfacZiMulOg5Lp02ZEbjeJ9ozUhW8+HCGKm4mYx6WBZmBGZYkBwaJrMov6+gD
	lm0SBTlN8PyAnq9EzfjTDKJCFBtv0a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773055927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQCAFCa6WqNNAixvt4eitLAbW/d5CqRYReziR86kwaU=;
	b=zIAP4Nie9vQCH28kTS/SdFdSyIZqYfb4sbaVz5+Y9U58j4tOEkqC15gK3uI7nMFRpPwZyp
	2ohJba5vsF9TWZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7759A3EE94;
	Mon,  9 Mar 2026 11:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3eXHLevrmkhfwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 09 Mar 2026 11:32:07 +0000
Message-ID: <5cd2ef61-375f-48ce-b2d6-4246b45e54bc@suse.de>
Date: Mon, 9 Mar 2026 12:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with
 SC_C
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
References: <20260309042733.1137108-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260309042733.1137108-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_043211_117212_238BD6F2 
X-CRM114-Status: GOOD (  12.83  )
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

On 3/9/26 05:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.2 of the NVMe 2.1 base spec states that
> 
> """
> The 00h identifier shall not be proposed in an AUTH_Negotiate message
> that requests secure channel concatenation (i.e., with the SC_C field
> set to a non-zero value).
> """
> 
> We need to ensure that we don't set the NVME_AUTH_DHGROUP_NULL idlist if
> SC_C is set.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Use a macro for Diffie-Hellman Group Identifier List Offset
>   - Use a pointer for data->auth_protocol[0].dhchap.idlist
> 
>   drivers/nvme/host/auth.c | 23 +++++++++++++----------
>   include/linux/nvme.h     |  2 ++
>   2 files changed, 15 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

