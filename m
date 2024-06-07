Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAB3C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvqliOnmKfjiMZl0V1XZynI3cF2Xpc2ZtFB1HlXqiHo=; b=JyVhjvSwjwEMVxlulx5pxdAlvF
	aEnjMtvmjr0U3P98j0puBlK2JnJ1Afz3bKgWD9Yw+OcDvhhH27go5AmKWvG1VpMWc0QO15Ir501kX
	mvpPs/0H1n50Rzi3mc+uoo1v0iZByvIf5Zb8C0kPu2gSAtKBriAgL+Q2O5JOqpUTFwia+yshXjCq0
	nC+JYZzEbCfA1B5GbfUvkfDpkDcSpoCJrbx+ZOEJ00ss5XOy46TNpj92n2gAtRytp7Hkv6vkdrUv3
	ys5zxMT3BuAUjXitkkp5lddf086mwedNYIpqzJ/3pndbYvl7SsoykiY01+dWo8ZkgY3tCovzZpjH6
	j2BPW/Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSp1-0000000CcxJ-3fh0;
	Fri, 07 Jun 2024 06:11:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSou-0000000CcvX-0cZv
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 06:11:27 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9409D21AF8;
	Fri,  7 Jun 2024 06:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717740682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvqliOnmKfjiMZl0V1XZynI3cF2Xpc2ZtFB1HlXqiHo=;
	b=mL29cYRW1f23r4FVBRbYR68plEQFrexctQayRPO2D9AstwLPEI6uBM3x7OBH4ohZ1ucVeq
	Lh2RN7Euhe/g2Tu3oAnHQj14uB76Bn/IWEme7jksPh1U/lqNyvha9QdUVlQK3GhvP4DmT6
	OTX1tmQSjXRAz+8lk/RRBuyb9PSfJ+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717740682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvqliOnmKfjiMZl0V1XZynI3cF2Xpc2ZtFB1HlXqiHo=;
	b=NZNv9Bn67bWQM3WcXHyVwNWhhFB7+tcv3blRovrJXywEe6NBIujRzGEmozgyEBpidXPD9v
	ZTf0LF4cOq4/foCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mL29cYRW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NZNv9Bn6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717740682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvqliOnmKfjiMZl0V1XZynI3cF2Xpc2ZtFB1HlXqiHo=;
	b=mL29cYRW1f23r4FVBRbYR68plEQFrexctQayRPO2D9AstwLPEI6uBM3x7OBH4ohZ1ucVeq
	Lh2RN7Euhe/g2Tu3oAnHQj14uB76Bn/IWEme7jksPh1U/lqNyvha9QdUVlQK3GhvP4DmT6
	OTX1tmQSjXRAz+8lk/RRBuyb9PSfJ+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717740682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvqliOnmKfjiMZl0V1XZynI3cF2Xpc2ZtFB1HlXqiHo=;
	b=NZNv9Bn67bWQM3WcXHyVwNWhhFB7+tcv3blRovrJXywEe6NBIujRzGEmozgyEBpidXPD9v
	ZTf0LF4cOq4/foCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B11A133F3;
	Fri,  7 Jun 2024 06:11:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sAVvHImkYmbBXgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Jun 2024 06:11:21 +0000
Message-ID: <be9b4b44-3edc-4267-9927-12ba2e55e61c@suse.de>
Date: Fri, 7 Jun 2024 08:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] block: remove the BIP_IP_CHECKSUM flag
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 Bart Van Assche <bvanassche@acm.org>, Kanchan Joshi <joshi.k@samsung.com>
References: <20240607055912.3586772-1-hch@lst.de>
 <20240607055912.3586772-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240607055912.3586772-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9409D21AF8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_231124_363781_4ECD80D9 
X-CRM114-Status: GOOD (  10.59  )
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

On 6/7/24 07:58, Christoph Hellwig wrote:
> Remove the BIP_IP_CHECKSUM as sd can just look at the per-disk
> checksum type instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   block/bio-integrity.c | 3 ---
>   drivers/scsi/sd.c     | 6 +++---
>   include/linux/bio.h   | 5 ++---
>   3 files changed, 5 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


