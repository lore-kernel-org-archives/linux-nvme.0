Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A242CCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LizefO1tRfpsNEnSLTRHntkV4SJD6LIRirCpsUp3djQ=; b=TYPOiTS0CsIz7ZDUAT0H/1Q8HO
	zKVMQI4Vpqz0FPTeqbPKgSeGmQT0BdCim4ABp7cdfS97u52GZyNzap5ZhrIUtKMU784kUNEbmOWJy
	tOJOD+cbA0H3JiSbVZiMfe2Ifh2dfDPruvKUDCGWeAq/qFYwdBJjBZbm1b71Xj+t1PhDleIWynqMS
	iGox5fU17FBN20wrGOFZCY6KbRmq0W93XHxIqhbHThWP93I0a9dnVoniJCLp/zfpBcYBTeocZVTEe
	i4XMVrCW7mPCVP+WZzSGPp5WvIp9oeZXALRlhxxX3LKtBhQIxrPVl/L0SbPQ+I5YGOPIkRxQO3JqN
	v4gzTq2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Yww-00000005BOO-2MFu;
	Tue, 30 Sep 2025 11:55:18 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Ywq-00000005BNY-19QM
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 11:55:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CF1333698;
	Tue, 30 Sep 2025 11:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759233308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LizefO1tRfpsNEnSLTRHntkV4SJD6LIRirCpsUp3djQ=;
	b=gTNHYrHQGafbuTdpbmp5MbMnRYKu2lbFofMyVLmd1aUyO6MPrRbBshdcuZVCQ0VrIsgPup
	FMwgbW50baF3gyF8n6R/JNVbEwG7nOzkCs6reuC3+Vo1rbs/cLizU+BvDioOrG8LMhmdaH
	wEVYzLAfsinQ2AEawTcmxMNlpPB0K70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759233308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LizefO1tRfpsNEnSLTRHntkV4SJD6LIRirCpsUp3djQ=;
	b=saT8y1MPCiBFwznk5g8/IgGwW3vE2yJWhtGus5E9JYIfWAt/Y4NTJFpS0Jm90pHf6hfypV
	7cMSjAZ0gEj7QnCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759233308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LizefO1tRfpsNEnSLTRHntkV4SJD6LIRirCpsUp3djQ=;
	b=gTNHYrHQGafbuTdpbmp5MbMnRYKu2lbFofMyVLmd1aUyO6MPrRbBshdcuZVCQ0VrIsgPup
	FMwgbW50baF3gyF8n6R/JNVbEwG7nOzkCs6reuC3+Vo1rbs/cLizU+BvDioOrG8LMhmdaH
	wEVYzLAfsinQ2AEawTcmxMNlpPB0K70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759233308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LizefO1tRfpsNEnSLTRHntkV4SJD6LIRirCpsUp3djQ=;
	b=saT8y1MPCiBFwznk5g8/IgGwW3vE2yJWhtGus5E9JYIfWAt/Y4NTJFpS0Jm90pHf6hfypV
	7cMSjAZ0gEj7QnCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 333061342D;
	Tue, 30 Sep 2025 11:55:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BgF+CRzF22iUJQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 30 Sep 2025 11:55:08 +0000
Message-ID: <21c6fe46-0403-4cb5-98d0-72edd06e8a39@suse.de>
Date: Tue, 30 Sep 2025 13:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvmetcli] 'discovery_nqn' configfs attribute
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250822115449.105656-1-hare@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250822115449.105656-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_045512_473965_99256AAA 
X-CRM114-Status: UNSURE (   7.61  )
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

On 8/22/25 13:54, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Implement support for the 'discovery_nqn' configfs attribute to
> allow the user to read or modify the persistent discovery NQN.
> 
Christoph,

ping?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

