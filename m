Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C115EB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AWV0t6uN1AOE/hJpf9gaVn09F0ED8FlupPXBaNmwf28=; b=3ph3ie+ZRrrsI+GvBBL0CnZyL5
	Sffj10md8GD8qZiMzu/1UQdvLjOOnjThA0TA9Ed5oMorC/6lGlqvVWLTl5/HvUVX5RN3b6VKrQsQ8
	w4a3wDhnVcnQekvZrz0geQtzKeJ0kZbyQUtFNKJGq3wOEbGGLlKIRm9Q/ZpSegPVcrngVfECGLK+S
	Ii0zF2g1pMDOthh6QUhJG/AzN88AP/lBYiAuRtOP9pISM8eBedpUBkgU7BOJOxkgJ/7sf7DYPiAmF
	OwsUaDY8S+h+Ofj7j0aHne4WspO4dmpfmv4KFNOwUN0szivPGe6c9yepQRCIXtjsYTH2xZxeyHm1m
	3oLuQXEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqFm-008OSp-0V;
	Wed, 06 Sep 2023 10:59:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqFi-008OHW-1j
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 10:59:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CE7A20293;
	Wed,  6 Sep 2023 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693997944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWV0t6uN1AOE/hJpf9gaVn09F0ED8FlupPXBaNmwf28=;
	b=Bf/NURxpZkENwhVWbbLF/IvnYlqaioYMYTU5xzidWumF7/8M2mnVnT2DUr+G4+GaKyuE6m
	E2SoFETWoEfFR6IcxAtVxxw8heboS4iEqefk6K42M0aB/zzSlpZ47lTzblg4NRDMd2Yu33
	YekyVWL88KmJhQBDqaJlffmXXC4ca8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693997944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AWV0t6uN1AOE/hJpf9gaVn09F0ED8FlupPXBaNmwf28=;
	b=udZfH2iUNnEWNIyX+hQPs48VqGvIheWe7Z1HQiP2XsN6R7X9KUdCV2b2R9d5qPA5AAmCd9
	4P7SgfjY1AkeOhDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 444D41333E;
	Wed,  6 Sep 2023 10:59:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AcJFDXhb+GSOQgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Sep 2023 10:59:04 +0000
Message-ID: <47ea3835-2494-4601-9da9-02831a1b4a4b@suse.de>
Date: Wed, 6 Sep 2023 12:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: auth success1 msg always includes resp
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org
References: <20230828212033.3244512-1-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_035918_720375_B28A31A9 
X-CRM114-Status: GOOD (  10.76  )
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

On 8/28/23 23:20, Mark O'Donovan wrote:
> In cases where RVALID is false, the response is still transmitted,
> but is cleared to zero.
> 
> Relevant extract from the spec:
> Response R2, if valid (i.e., if the RVALID field is set to 01h),
> cleared to 0h otherwise
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
>   drivers/nvme/host/auth.c | 5 +----
>   include/linux/nvme.h     | 2 +-
>   2 files changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



