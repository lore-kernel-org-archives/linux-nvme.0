Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794CDC02192
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jk489ouJQSp3F2Igfa2Cyw8XH5E5SiHBOVYrQaS1yIo=; b=UjHZSOYfrDoWg48kuKI1fDbKZO
	w2GdGuxDpYsSFFPBmHEd8UFet4eGgaZfdQ0bMzS22iLQRIn86IMw8cER19Nqvsubjw90OHMsmkehT
	wd9SGnW7eSI2S1d/cGmNdj/AaVfjBV/ivOTlQMmaKvPrTBouQB6QEoNoMd1GxqCfBRzMdk0lRPUOv
	2GEn7BDQc+P5sCuquYzoyxZu+eo9mE1cbvXThUnV0t4HXIwhdgTBzOqJMRpQr0VJXZX+tHIxQqBGm
	8Co4ulDsXmKgU8Dpzlxgdu1+1qTxBOzIr7zGiymWQfMMPqn4N8X3WbqBsDAmsuVJx8ju3YxJHU1E8
	KP2AUfiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tewvy-0000000FaFl-432u;
	Mon, 03 Feb 2025 13:56:18 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tewvk-0000000FaDY-0OSj
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 13:56:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 245B01F455;
	Mon,  3 Feb 2025 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738590958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk489ouJQSp3F2Igfa2Cyw8XH5E5SiHBOVYrQaS1yIo=;
	b=H7ht7pmQakT98m1cCWUf8o3jWEN6u7XgVhOy1l0Vqp4EXOUuBMG/8m7IXgJMWfp4hvECgi
	unvtvOvmTb0opEYoD6sKiwQRqP9bLsQffsccWD3rKYdjl9mFOoBrzn33mpr3A+jVfnkJzC
	1H2jSADIdqsY9cypwpWAwiPgCR1KDVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738590958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk489ouJQSp3F2Igfa2Cyw8XH5E5SiHBOVYrQaS1yIo=;
	b=DYXrwIuB19Ouz8g51FzGlcmeSdsNF9/Z+PpoiX3iWbskhOX3W/kFcSFRyuChA6axpj/Og5
	AeCIJuXkROeTfnCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738590954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk489ouJQSp3F2Igfa2Cyw8XH5E5SiHBOVYrQaS1yIo=;
	b=uEKH0zT12tFGX/cUjOsHAePfcyRWWRhY58lUTppb4YziYJQywI7VSIgoYu3/pMV2J/akm/
	UKSTSqjpr6a0lwtpjuJ9w2nndX7tqq95pY7/ALx38jqki2JZMP3hG7E37ENs1x8ZKu8put
	JkEaS3cXWGVbOwN1DX3fs4WaKFaHK/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738590954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk489ouJQSp3F2Igfa2Cyw8XH5E5SiHBOVYrQaS1yIo=;
	b=tTVwsb1DRpMVVHgoGJncHdQ0dB9p6m+bsASjDS5RwLMqDkUsln7B3IUiDBziZSSlwrOrJR
	LeHQZknm1plTesDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DBD413795;
	Mon,  3 Feb 2025 13:55:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JnDwAurKoGdjOQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Feb 2025 13:55:54 +0000
Message-ID: <d0dae1aa-3af5-439a-8945-975c915eb1bf@suse.de>
Date: Mon, 3 Feb 2025 14:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] nvme: always include <linux/key.h>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250122165829.11603-1-hare@kernel.org>
 <20250122165829.11603-7-hare@kernel.org> <20250128090156.GE25760@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250128090156.GE25760@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_055604_279408_6FFF2D11 
X-CRM114-Status: GOOD (  11.53  )
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

On 1/28/25 10:01, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 05:58:25PM +0100, Hannes Reinecke wrote:
>> To avoid build errors when NVME_KEYRING is not set.
> 
> So do the previous patches created these errors?  Or following ones?
> This commit message doesn't seem particularly useful.  I'd expected it
> to be folded into the patch that would create the build failure.
> 
> 
Okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

