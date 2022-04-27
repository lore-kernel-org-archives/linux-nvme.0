Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCD1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SYO6S4wSS5TgNnn69ULkvPYv5FP7agaVxb8vZruMBA=; b=tZSfVfRMJYZug/9W/JFu8ZVLM9
	Fonp5GaaJEZs0JhHBlgf/5Na5AnYflhjsTgJISfZHtjnepUgSWoaQNKzzuIlUEEL23lpHwZT3iKUu
	7d3dcK/RQ3xRtAiiv0AyKEArPYLax40T1FmKlLS4m3Y66gC7WLLp+NLWEygVzbisiPLIvGQEaQS5I
	hohaKUxNhv8x23FyvGdijdaf/3efC5tI8RnKPp4JaloPtc7GLfqoZfCN9M8ajPsDVb1qNUESSrMWz
	x/hJhDA89LCXoOXUBGAR5NerVyb7xcLWC04LEMWU/JSQ3RydznGthRff3NKbWhSITVNcGpTm0YyTL
	lyZSAMxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh7s-001Ng2-MI; Wed, 27 Apr 2022 12:50:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njewm-000wXy-5N
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 10:31:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF7831F38D;
 Wed, 27 Apr 2022 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651055458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SYO6S4wSS5TgNnn69ULkvPYv5FP7agaVxb8vZruMBA=;
 b=ZtMWsp/vgSv0x+hV9X6XBgzBRpYAhz2Ni1JKSL4BLbE+tikPu/yDLv/LYgJmCiEku80xrF
 1X5NMCVCrTj2gFM7w18PXmyMw4bPUaS1tJuAbxhTAsejm5cXz2+5gSgVWmlBgvv1zUAQUj
 N9wH0oEGf1mWY6CurDEf3E9c9npyslo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651055458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SYO6S4wSS5TgNnn69ULkvPYv5FP7agaVxb8vZruMBA=;
 b=6X6DqUjKXVYhZDBL9goi/XEUFK1JQuukpkPAwhQWeog8eUle97FBRv3cZZK8i/BbQk5H41
 5dC/EF6L72Lx8jCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73EA91323E;
 Wed, 27 Apr 2022 10:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wzGnGmEbaWJ0AgAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:30:57 +0000
Message-ID: <96acbc76-1de8-4be0-314c-4a6a9284c5a3@suse.de>
Date: Wed, 27 Apr 2022 12:30:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
 Frederick.Knight@netapp.com, osandov@fb.com,
 lsf-pc@lists.linux-foundation.org, djwong@kernel.org, josef@toxicpanda.com,
 clm@fb.com, dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>, Arnav Dawn <arnav.dawn@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220426101241.30100-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_033100_392374_B99045B6 
X-CRM114-Status: GOOD (  11.70  )
X-Mailman-Approved-At: Wed, 27 Apr 2022 05:48:55 -0700
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

On 4/26/22 12:12, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>          - copy_offload (RW)
>          - copy_max_bytes (RW)
>          - copy_max_hw_bytes (RO)
>          - copy_max_range_bytes (RW)
>          - copy_max_range_hw_bytes (RO)
>          - copy_max_nr_ranges (RW)
>          - copy_max_nr_ranges_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload, used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_range_bytes: maximum length in a single entry.
> copy_max_nr_ranges: maximum number of entries in a payload.
> copy_max_*_hw_*: Reflects the device supported maximum limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   Documentation/ABI/stable/sysfs-block |  83 ++++++++++++++++
>   block/blk-settings.c                 |  59 ++++++++++++
>   block/blk-sysfs.c                    | 138 +++++++++++++++++++++++++++
>   include/linux/blkdev.h               |  13 +++
>   4 files changed, 293 insertions(+)
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

