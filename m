Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqiMoLPpsUcNuY+nAeHT4sXeejRFDPIxfyzcNGGvY8w=; b=kL9yVIStMs+/UabTv6YYdm06BW
	zxnfbKQTRVUNuZnYJ22vQHGQIM5sVZGsdS4nS4pnwC3on+lbDTbivsC0chqgOHdHRg0YeEX3juTaB
	vsZ0TY/11jlQ411zbZ39/OylRfLVT+qt+7MPBT+kpIlVTBfiecF4UKgurPl2iasoIAtqJQKEZnC6e
	JkGmYLP1XbUB3Q+AoteqxxrPLxIFcQoCUdOhl+Y9EFClYHbmaZqmlZuZjxc7M94Lb3I6A5O2WPKZ1
	Y+gzWCZwrfeIRIvQVT9GUULihLLIxe0C5pa0TRQjYtJxVu33hun9M4sRaIWMKm+fnc9+5PpIQb/qj
	OgqVSxXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oasyu-009D66-K1; Wed, 21 Sep 2022 06:13:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oasyr-009D48-E3
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 06:13:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 445101F388;
	Wed, 21 Sep 2022 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663740785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqiMoLPpsUcNuY+nAeHT4sXeejRFDPIxfyzcNGGvY8w=;
	b=dby73I9WHbBkn/2ssDCNSH2BGnUu4jw/ANty65OEmcgoIoplI4nm6oqE4UtKyFP8wJLcYR
	Clz0TurPtCBQjDCnF8x5NX/Zn+bM/nLGYYHat6L2ZsNKl3iAPEIMew4Nr4ymoi0YYFkjoF
	HN9pnDL2qRiLLBwGDDGi+7dMcvZwogY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663740785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqiMoLPpsUcNuY+nAeHT4sXeejRFDPIxfyzcNGGvY8w=;
	b=o7c3brzRbwEf+V+HcyyQheMCHwcGt8klWTA64qhMb1CZpPOCdgHYO9mIVzlIKq/fWybnkz
	2ycuIuzrl0RsHHCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36F3F13A89;
	Wed, 21 Sep 2022 06:13:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xsK1DHGrKmP5agAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Sep 2022 06:13:05 +0000
Message-ID: <ee3bbeaa-0ccf-e735-cc96-18e5ad8e96b0@suse.de>
Date: Wed, 21 Sep 2022 08:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] nvme: improve the NVME_CONNECT_AUTHREQ* definitions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171931.1289669-1-hch@lst.de>
 <20220920171931.1289669-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220920171931.1289669-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_231309_657872_9B9B472B 
X-CRM114-Status: GOOD (  11.00  )
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

On 9/20/22 19:19, Christoph Hellwig wrote:
> Mark them as unsigned so that we don't need extra casts, and define
> them relative to cdword0 instead of requiring extra shifts.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/fabrics-cmd.c | 6 ++----
>   include/linux/nvme.h              | 4 ++--
>   2 files changed, 4 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

