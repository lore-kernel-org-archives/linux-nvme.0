Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B6C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Dec 2021 10:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZbuQWGj4Exo/bQg6uaDn4SOsmn6tCdLllErpnT9Jz4=; b=IR1HbDK2uOdUiK97bwHBIwQgER
	f/qHW+DjIWDYblM3K77yFY7mO/yl3BI0DruTLflU3n+MzVGdQZP6U11TgmyOQY+CTM7xjQrhAb6bm
	xknXE/eX315xYgI81cJsHOSIvYvqDXnrkeYZdL6Umz2dJKxTdESpFwJUDMVVSwoyXpwJ9BGYDFyoN
	44BVRRh2PRWEZNFH2leYINF39UIfub0CB+9hCddBP9FFH9LlZwAdsoo6EUL4cOeSn9Fdl4CwEpJN+
	4OxvSxxk3uydmrRJEsTNQ/a7cO4dip3ilNSW0+cgLhUJipvLVKa4tM/UFTaAubn/EiyQrg1PJCpjn
	j0CVz+Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtSZP-000DsT-Gc; Sat, 04 Dec 2021 10:47:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtSZM-000DrY-En
 for linux-nvme@lists.infradead.org; Sat, 04 Dec 2021 10:47:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38F071FD37;
 Sat,  4 Dec 2021 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638614823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZbuQWGj4Exo/bQg6uaDn4SOsmn6tCdLllErpnT9Jz4=;
 b=Hk3+FSCVc2srXagY2Dql1bp2YHldkHPhiYKAW/EYREv1Tq3T2ZBcnbzZXOS2tV3P4ylzYb
 htWjjjF+JbLwr8E6s7EKIk7AsimkZuxKHwVAxrST9J7LmTYYFPnpeQokfY6Zn3DwvrinQT
 ZD5ePkqGksczQuKBNPmYelaPrGRhjYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638614823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZbuQWGj4Exo/bQg6uaDn4SOsmn6tCdLllErpnT9Jz4=;
 b=XGjtagYaImYIXunxL0oiE4DSS3DHzlDcepJYfJgp/fD5bnOg8yA3qkSZ94rL/p/yGqWbR1
 Qn4Aet9xhvireADQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2438313BF8;
 Sat,  4 Dec 2021 10:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Wb4JCCdHq2HIawAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:47:03 +0000
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <63cf5e47-bc05-03eb-bc67-581eeee0ba37@suse.de>
Date: Sat, 4 Dec 2021 11:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-5-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211204_024704_672344_E0EB5B63 
X-CRM114-Status: GOOD (  17.23  )
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

On 12/3/21 10:45 PM, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.
> 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

