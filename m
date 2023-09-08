Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46332EE57CA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uO334wLPNGZ0g1WNh7fmBTcS2K14Hk+oRRgDz6PlSsU=; b=O0i3x63ckany4PO2giHD3EoIXE
	hF17F1FaQZ5qy2xfiHVi+D4wThjiwH3os/6yAnAOPgeJFs5YgPj1nGNxnknpUMuxyeD6YV4P+k+VC
	2ulZZFww8ATEapDOGuLMF06lpS/8gIOPbyGHlFDgbHwNpbiPwkqD4XW8po7yOxwsEcMMBjZgF82yi
	FiRQrHKi3VJ3VRI6+F2hyo99fyZjVQct5p53MH1jcpefYYjbJxf71GDQofvj8EGeEpOE2xDA99KdA
	tP/QFWNCI7Mep13LGkPCXgW/TRnoIx2tGK2U3CbD56o+tj/t1BEmyg5x8mUnbTUQubZMp+tqWFI3u
	V8Y6D32g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUlY-00D9B5-0d;
	Fri, 08 Sep 2023 06:14:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUlV-00D99c-2U
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:14:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D27B1F45A;
	Fri,  8 Sep 2023 06:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO334wLPNGZ0g1WNh7fmBTcS2K14Hk+oRRgDz6PlSsU=;
	b=1B0lyFDnUSw5BFUJy9Y68/rp3TjBP8BSHQo/CqfMXOTQ1RshG7QunosG14CnBc0X12xxEl
	b/9gKN9nLYFdHUSEYIXGZOpge81Fv5Ii1zSQzF9TUIqdgUy3CAeVEcq4LtxqOpSDn96zxI
	2x5YgAKz4u1SF7cNjbziqvUL5wDZl4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uO334wLPNGZ0g1WNh7fmBTcS2K14Hk+oRRgDz6PlSsU=;
	b=+X3bQmJ9VSbDChz5GQktO+Uq3w9FEi3xugmkHcZiJMitTcR0G4x42b1MzIUbdzxt69hM7d
	DOcnzTACDY8H/WBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D10131FD;
	Fri,  8 Sep 2023 06:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WLKONNe7+mSabAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:14:47 +0000
Message-ID: <bf2e8a17-fd95-4e48-92cd-382f7c8ee944@suse.de>
Date: Fri, 8 Sep 2023 08:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/12] null: Enable trace capability for null block
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
 <CGME20230906164425epcas5p4275f672db2cfe129f666d8c929cbd095@epcas5p4.samsung.com>
 <20230906163844.18754-12-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-12-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_231449_955521_832EEDAE 
X-CRM114-Status: GOOD (  12.68  )
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
> This is a prep patch to enable copy trace capability.
> At present only zoned null_block is using trace, so we decoupled trace
> and zoned dependency to make it usable in null_blk driver also.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>   drivers/block/null_blk/Makefile | 2 --
>   drivers/block/null_blk/main.c   | 3 +++
>   drivers/block/null_blk/trace.h  | 2 ++
>   drivers/block/null_blk/zoned.c  | 1 -
>   4 files changed, 5 insertions(+), 3 deletions(-)
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


