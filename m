Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9D5EE14D4
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vEzdXwzrXnDTeO0P+aNFlsgJ60oxO7RTr/+XEDVnWGU=; b=W5GRq2oJ3qHSYkslwiDTIVnmIu
	lMOLo1jdo1wFXeOztpRf9q7rxCVh1z9iqZVynQC3PS2HNnSe54LpyGCeZ6pc0IND2u0CRWvSWHUHN
	oLs/0uiLu5oecn05HPvoYrRTkyCvGtIYKHslZF2xhnmavtGn67WELwQ+AVzjBEup0H8fa9LlT/aLf
	iZ58x4uotkGOffLU1GUb2RJR/VTrw+ayqQjDjF9aPPkZMS6prGBz1/z/+/j2Wix+l6G9CrEbmPXUG
	KwvjZP6dBeSMyKKfbTwgx0ho1wVcnfsmULWLRh+Dwxkkk8k9LZbf6upomD+i9RyGfmDZbMk02Ih0u
	xpvJXInw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qe7je-00BMt2-0h;
	Thu, 07 Sep 2023 05:39:22 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qe7jb-00BMsL-0v
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 05:39:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C08A1F459;
	Thu,  7 Sep 2023 05:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694065156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzdXwzrXnDTeO0P+aNFlsgJ60oxO7RTr/+XEDVnWGU=;
	b=zr7k3C3k5bcifoR7lksFXR5wYxINEnL5SHX7Hgtw8PH/VB7pxIJltEsBEDIsWKJhtOBllg
	kjBlPikKsXRR3aBkuHtcwqVYAsGuRiCE+5YdeJ9Gj/nMdolzpBxh0W+LWzTQsmgCtsl0GU
	nx8up8cqOng/NvIWPUVsz5QE5LyTNmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694065156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEzdXwzrXnDTeO0P+aNFlsgJ60oxO7RTr/+XEDVnWGU=;
	b=cwHd6RbV9kQqZVcKJLf2ZxshTikYkz2/zqjz1vx77H0a2bb63I00umYAVZa6h4IjnOM5ZK
	fpOti423Zoa7T8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AB0513458;
	Thu,  7 Sep 2023 05:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id r6UMGwNi+WQ6XAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 07 Sep 2023 05:39:15 +0000
Message-ID: <d2c3a257-0505-4d3e-ae71-28015952cef6@suse.de>
Date: Thu, 7 Sep 2023 07:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/12] Add infrastructure for copy offload in block
 and request layer.
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164303epcas5p1c2d3ec21feac347f0f1d68adc97c61f5@epcas5p1.samsung.com>
 <20230906163844.18754-3-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_223919_474576_4FE433F2 
X-CRM114-Status: GOOD (  15.37  )
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
> We add two new opcode REQ_OP_COPY_SRC, REQ_OP_COPY_DST.
> Since copy is a composite operation involving src and dst sectors/lba,
> each needs to be represented by a separate bio to make it compatible
> with device mapper.
> We expect caller to take a plug and send bio with source information,
> followed by bio with destination information.
> Once the src bio arrives we form a request and wait for destination
> bio. Upon arrival of destination we merge these two bio's and send
> corresponding request down to device driver.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   block/blk-core.c          |  7 +++++++
>   block/blk-merge.c         | 41 +++++++++++++++++++++++++++++++++++++++
>   block/blk.h               | 16 +++++++++++++++
>   block/elevator.h          |  1 +
>   include/linux/bio.h       |  6 +-----
>   include/linux/blk_types.h | 10 ++++++++++
>   6 files changed, 76 insertions(+), 5 deletions(-)
> 
Having two separate bios is okay, and what one would expect.
What is slightly strange is the merging functionality;
That could do with some more explanation why this approach was taken.
And also some checks in the merging code to avoid merging non-copy 
offload  bios.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


