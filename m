Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD90EE57CB
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u70NF1V9pWl9eEz7YZwVeuG+ejy85zfIYBi8ygYJwcs=; b=YTpiPXXH1x3S/uEkCMa13Z0eHn
	VjOXyjq/6ZWiKv6iEvT8rGCwwQYO4BwWTYcxWx2DjNUOo9J2FxrhD8bqkxi3cxb6XdbfUCmu6AJeT
	r0tllmfNUvFvnBi49rArTacGnhGQ3cCKJBu/Eo8HhcZbzm5KRGQwNDYVcocq3TBQj21sTqTH6hEvJ
	zRb5CPZO1I44HSx1x7Yyz/2qfQPyxNwwGPsGAR+qA0h6CVpH9Rr1bvTrdAdmd66+ML8Lh7xkfl9gL
	GvP1nD0givH9IT7gAaMGY0B5hHqmFHN4SODU5YXby1284cKkSagseGyhaTCShyjfo4WF6ANsNE7il
	XhH0kKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUkt-00D91p-1Q;
	Fri, 08 Sep 2023 06:14:11 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUkp-00D91L-3D
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:14:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13221F45A;
	Fri,  8 Sep 2023 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u70NF1V9pWl9eEz7YZwVeuG+ejy85zfIYBi8ygYJwcs=;
	b=DfeVirnZxhbQk1vAmjPAszH9kgnjQ3mOjdsW6PQxPQoqn25ABy9S9M94hBjvfqWlB1Rcot
	OhTa3zhpxuizP08v7mUneOy36Jcv03CCEqTfdAUUWJn/+w4m3DUWlfxNC+Gd83kvXJfyDK
	evrDTPIBagGq4EXSJ3pJmeU15gkkenU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u70NF1V9pWl9eEz7YZwVeuG+ejy85zfIYBi8ygYJwcs=;
	b=8pVjwALs0VCba9DB+/tcyO7UMWlunbPcm56DD/pKbGKFHTDC57S/iVM0F+Qvf6MyKkqZp2
	msgmNvwoPd7uHgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37819131FD;
	Fri,  8 Sep 2023 06:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CKh6DK67+mSabAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:14:06 +0000
Message-ID: <ee307498-7d15-48e0-9f9f-518c928e8ebc@suse.de>
Date: Fri, 8 Sep 2023 08:14:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 10/12] dm: Enable copy offload for dm-linear target
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164416epcas5p307df0f4ab0a6a6a670fb50f6a8420a2a@epcas5p3.samsung.com>
 <20230906163844.18754-11-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_231408_184120_8F9CCA4C 
X-CRM114-Status: GOOD (  13.04  )
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

On 9/6/23 18:38, Nitesh Shetty wrote:
> Setting copy_offload_supported flag to enable offload.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   drivers/md/dm-linear.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index f4448d520ee9..1d1ee30bbefb 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>   	ti->num_discard_bios = 1;
>   	ti->num_secure_erase_bios = 1;
>   	ti->num_write_zeroes_bios = 1;
> +	ti->copy_offload_supported = 1;
>   	ti->private = lc;
>   	return 0;
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


