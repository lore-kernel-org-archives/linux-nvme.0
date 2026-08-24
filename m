Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8B2C5DF94
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Mn6VGn2uNZx5JaP9PTWXwzUWUQhBQpFRsCPY1rD01E=; b=pmXa0cKVQsme6rZN2qEazOBPrd
	qdBEcabT19E2lXEkni/hsLHROwBTs8DKtLlj5y7IhSKsOuF+N1vi5wV3kFHbrb8zoHsjcq4DxY1cg
	jYEXt7/cJ4tTxmuCAGQMIr2xlJDjWN8HnI+G144Iz9K8XZgeAmqLj24B0ubDfBjSAFf076KCn+Unv
	mw4ZR5I+CWsVk90nWQY0nGPskC4h/JZIYbf9t7Jgl8r5hqHDrwH78dxFhfg8Ey32bVgWRC/jds0s3
	ZF10z7h26eZo0EnJ5YSPcli6MZGZ3KzDucEy6ccDZHgPTh/q7Py5O+NRKF6weNzK2NI+GehRdytZa
	mYMceo4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wySuV-0000000GWJ3-1krX;
	Mon, 24 Aug 2026 11:32:15 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wySuS-0000000GWHW-3Xcz
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 11:32:14 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C234786811;
	Mon, 24 Aug 2026 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787571126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Mn6VGn2uNZx5JaP9PTWXwzUWUQhBQpFRsCPY1rD01E=;
	b=EwKX2n5CwoQL2Nhh4UHBQuZAMevIr+0lVhJ1jgMHM+Rm21yrj9/8h9dUpnQHmjYIzbYhOI
	zQ14tGx40oY4aHjKCzsfx0mStj4Y8Kd7VvZ2cI1vaZw05MQrt6IQbLdwIE0zEeNWW0byk9
	xh/FFXnECW3B3wNPARjgWRrSoDpZ1L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787571126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Mn6VGn2uNZx5JaP9PTWXwzUWUQhBQpFRsCPY1rD01E=;
	b=TsP8JdBMk/FjgLGaADs+MG4dOCQag9fBYCYxpxMVQGMde2iJvKBVd6u1ALz3y634+SFAgB
	/zKUUETXrfpdQoAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787571122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Mn6VGn2uNZx5JaP9PTWXwzUWUQhBQpFRsCPY1rD01E=;
	b=OCJqi+8Rat0WhPL1Na3riT1tMDOqBzNgfmjCUXadYNTuHHBSKFfwsGOavOndBVzatfyCF0
	PCVfIK0ggK3Nn5/VzICj+xGEgYmXQtoj0vdc34U2YU4Y9fxD6jDDIQVewITlL2Xzqkneeo
	ddi9raxKip0RnoS0wJKvyV4DC9/p5+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787571122;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Mn6VGn2uNZx5JaP9PTWXwzUWUQhBQpFRsCPY1rD01E=;
	b=LPpFUJyAepzvSYlPv0vWKHwGCM0ICT7NNBsqZhuGQDRyEozSYCpnNeF634cJkL9QP3AmHL
	nx5iOREMhWPLqkCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7F6C13331;
	Mon, 24 Aug 2026 11:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sYkUKLIrjGp4ZAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 24 Aug 2026 11:32:02 +0000
Message-ID: <1a9046f5-232f-4a95-9fb0-9bfa50453d00@suse.de>
Date: Mon, 24 Aug 2026 13:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme: add nvme_crd_msecs helper
To: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-3-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260823084903.193188-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,grimberg.me:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_043213_033848_BDE48698 
X-CRM114-Status: GOOD (  10.20  )
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

On 8/23/26 10:48 AM, Sagi Grimberg wrote:
> Hide the details of extracting the crd value. We'll need it from other
> call-sites.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c |  8 +-------
>   drivers/nvme/host/nvme.h | 10 ++++++++++
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

