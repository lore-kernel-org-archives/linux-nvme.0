Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2CFEE57D1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 06:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfiRMiLiljQPPOhhpNNBkApUXT20U3F3E5R68i/OMvk=; b=reI3duPQuomg90/ydkdJprgOTp
	IK+eyLVylPpEko+5CwJo4eeo6o4v09Se1gKASd2R4E22UoO4QDPCyZ9ly+lEImRSCkvb1089DviR1
	tzSjsZwHK/xMIw32lu4eNIdrT7nWMLYIH/w9KJ7jftcSBdu3qB32fudJ7gA0aDfIqtrmi4JoITSj0
	wxasCPAd4Jlj9nQeNcH9i4VOGXN8GXH0ksBiRZdKc3vik5Y0UYvvR84CCZAOrOgn3/BMDZKTHA6eT
	GbDWq06e82SsYPQLMKn6y8WjTQuKOkJst2b+CBaPcAzEGnsaDqoCZYECmVU6OVp/T3X2g8PifPEOQ
	e9vqxF+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUnN-00D9XP-2S;
	Fri, 08 Sep 2023 06:16:45 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeUnK-00D9W3-0c
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 06:16:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7AD4218E7;
	Fri,  8 Sep 2023 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694153800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfiRMiLiljQPPOhhpNNBkApUXT20U3F3E5R68i/OMvk=;
	b=kRet6pO+tsSrG82Rwvv1LyygTDeAuDqcQvVQHNuT+wHctPZU1qp1ipdxRGQNUTuuY1iqEJ
	25dcUERNuPvHqVGHDx0iGpZhZSguIeMPo8QeBUR3zRtYG6W3uNSzvp0d0AyXg2NbSjBdNO
	vRWDoikWhtc4OLXe1vKoakW8hOAqxUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694153800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cfiRMiLiljQPPOhhpNNBkApUXT20U3F3E5R68i/OMvk=;
	b=m+QzdY88ivA30UWFiCkWR71EfkwDvFkXyiaqpuqwEUnvy5x1HQwHdfItrKeBiB/MbEWhxw
	FhqKG5e9iwUHiNCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 616D0131FD;
	Fri,  8 Sep 2023 06:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id baswFki8+mQibgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 06:16:40 +0000
Message-ID: <7bdf32f4-6fac-4ed4-a11f-b6dfe1c45177@suse.de>
Date: Fri, 8 Sep 2023 08:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/12] null_blk: add support for copy offload
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164434epcas5p16135fb4935a62519360ede42e137bbbb@epcas5p1.samsung.com>
 <20230906163844.18754-13-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-13-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_231642_366625_AB0B4867 
X-CRM114-Status: GOOD (  11.49  )
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
> Implementation is based on existing read and write infrastructure.
> copy_max_bytes: A new configfs and module parameter is introduced, which
> can be used to set hardware/driver supported maximum copy limit.
> Only request based queue mode will support for copy offload.
> Added tracefs support to copy IO tracing.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>   Documentation/block/null_blk.rst  |  5 ++
>   drivers/block/null_blk/main.c     | 97 ++++++++++++++++++++++++++++++-
>   drivers/block/null_blk/null_blk.h |  1 +
>   drivers/block/null_blk/trace.h    | 23 ++++++++
>   4 files changed, 123 insertions(+), 3 deletions(-)
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


