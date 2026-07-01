Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020BDC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Yo48ALSMv+SDMF+5eUPALzxwluiPRufT6oTCmzn1Qc=; b=uX/bQIj5zpTdfmj/O3maCxXuwd
	dtFUCAaMy2m9+hqfljTSUToUwRLhNasi3YmwEkdKFvZUx2e9YNBeAaJVIY+gfVC2zdUxCa9SGwUGD
	hK/oNr3iXu/ZV0bRKkkYVw6jMKF2tzdEIhZgMm2Cp5F09DQ50ztqCGeLx5mxBfpI1VTvYJgvqGpfH
	jHrbTbe7nk/KU29uuw0M5LlhRxbbMPOpisUh22a6IMm7d2xenM4xcGzQE63M2+h0qUlL0l8Nj1rEe
	tkgGOFMxl9tMMrkOcm+ln2r1heThUdTe7P7rG0d+RNkN2EzXTtDkkKtlwmm564XIg/LLdgNFOUqSd
	ylXtjDNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1westW-00000001RGE-4C76;
	Wed, 01 Jul 2026 11:14:19 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1westU-00000001RFU-0XIX
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 11:14:17 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0DD67598B;
	Wed,  1 Jul 2026 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782904454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yo48ALSMv+SDMF+5eUPALzxwluiPRufT6oTCmzn1Qc=;
	b=iOmXZPsU4Srs/JWyYBJ4Re9SKdr9uoBn1b7f/5WNRdHhmkY6xYJIo8isAQ/FsJxXaDvyUr
	KdQ4mBd60u4hNPQZ130ep4T3WaQTDvFvg3rJwM9j3c++0PsOuRCrwyy2uq/v6gr/8GGYl9
	klt4qCrprDRrT/wzkM0W2Wg92T2ngiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782904454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yo48ALSMv+SDMF+5eUPALzxwluiPRufT6oTCmzn1Qc=;
	b=bWVfbAr0JtOgnQPYEOt4erWqf21BRfR+9dhj/dN0oHHkDDv6Nm6g0Vm5ESBIdgeauyzTqm
	Tv84kYH5kMZ+cSCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="J/mRPrZ5";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LTOtvQR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782904453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yo48ALSMv+SDMF+5eUPALzxwluiPRufT6oTCmzn1Qc=;
	b=J/mRPrZ5ahTdbEwoOA6VeixXDTEBOh7AknxSfYBL1g6iY0o8FeH6XonVJmOs91BuxBZWvt
	RkQeBjtxoIi3QheTdS21ettAO2BTjD94I5CxXmWq/xgpMRnQQL/bRVc9qXr+KhszbJH96K
	iU+P7lRyRtkI8Q6CIATgdvUaj+p/xYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782904453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Yo48ALSMv+SDMF+5eUPALzxwluiPRufT6oTCmzn1Qc=;
	b=LTOtvQR8mdX8Vi1+Qw0Q2m+3y6dZdDhtQ4Mqr5l12E0wq40zWDojJIBzUZQTV+n3RORDuy
	E0btJELhRW8uKHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C225F779AA;
	Wed,  1 Jul 2026 11:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nYElLoX2RGonfgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 01 Jul 2026 11:14:13 +0000
Message-ID: <8103a626-d07b-4b20-b10e-d258485176ee@suse.de>
Date: Wed, 1 Jul 2026 13:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: Introduce service-time iopolicy
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, onathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
References: <20260617114602.2224074-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260617114602.2224074-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F0DD67598B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_041416_617293_91FE4A4B 
X-CRM114-Status: GOOD (  12.37  )
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

On 6/17/26 1:45 PM, Guixin Liu wrote:
> Hi all,
>    I developed the service-time iopolicy in nvme native
> multipath, please review, all comments are wellcome.
> 
> Guixin Liu (2):
>    nvme-multipath: add service-time I/O policy
>    docs: nvme-multipath: document service-time I/O policy
> 
>   Documentation/admin-guide/nvme-multipath.rst |  31 +++-
>   drivers/nvme/host/multipath.c                | 165 ++++++++++++++++++-
>   drivers/nvme/host/nvme.h                     |   6 +
>   drivers/nvme/host/sysfs.c                    |   5 +-
>   4 files changed, 202 insertions(+), 5 deletions(-)
> 
We're still waiting for the adaptive I/O policy to be included, so I
guess this patch should build on top of that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

