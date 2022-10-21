Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6BCC43217
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 06:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x49+o/RKgjGEAc9coJnQ2grOeE1itzyCUszh+Gsjga4=; b=IMvtbIGDQxvAEdBbiX4a3b/uTZ
	f5K8VBiT3zJH/pdQ1Tj8dkM+r78lRJSDg86GLWW2NvmhKnYGlg82rZxbzJeM3Nbn/6YE/FMkxcJL8
	OuGqyYr3tUuoJzy5W8uYgOlqaEUEbfNaMZe7wbOQvtru9Z7pm2O+QxtqMn3hrVS//8vSTe24PoF9l
	Jl5Ypf2mkR+xlwGDO3yjbinaitvZyRJtm9XQg7V1r4j4qreE3KTj5STvWwJKQTCJEGIXwReYM8H4K
	dnxMY/hMKCMVZUwVcOXmTbV+9b02LLP2twNgdnmiOsoHeYeAD2op7sPhPoukjpHOSjFaGifX0mILR
	96IbUaKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollru-005myy-Kq; Fri, 21 Oct 2022 06:50:58 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ollrr-005mvY-Rw
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 06:50:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69DA821954;
	Fri, 21 Oct 2022 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666335054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x49+o/RKgjGEAc9coJnQ2grOeE1itzyCUszh+Gsjga4=;
	b=kjHjVfO/WhC+OIgXHuhQZS6RZAWn6OyaDypAEVBeuCwV8CFr1qLdri/6PVUuHsnsgUAfPr
	aAVoL4bmqZXAtyXgiOP4JwrtRCXOSbk9j8njJA6YtaTIRRFLxZSLWJxEOMJIbDkasgC2n4
	dBkIQyzlL/+I/Thdup/HLdI/GCkPzIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666335054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x49+o/RKgjGEAc9coJnQ2grOeE1itzyCUszh+Gsjga4=;
	b=yd6xQdJ8DarolGpSFTQqIof4eSWmUiMYNrri1xpfrCm9p5YOcCV6843EpBaLRg6v6JgGJ2
	di6Tz0657Ub7+6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47B0F1331A;
	Fri, 21 Oct 2022 06:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id UGuUEE5BUmPuHgAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Oct 2022 06:50:54 +0000
Message-ID: <5ebbf746-e53d-e303-b8ea-565bc097e928@suse.de>
Date: Fri, 21 Oct 2022 08:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221020105608.1581940-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_235056_068877_367B9E09 
X-CRM114-Status: GOOD (  12.81  )
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

On 10/20/22 12:56, Christoph Hellwig wrote:
> Noting in blk_mq_wait_quiesce_done needs the request_queue now, so just
> pass the tagset, and move the non-mq check into the only caller that
> needs it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq.c           | 10 +++++-----
>   drivers/nvme/host/core.c |  4 ++--
>   drivers/scsi/scsi_lib.c  |  2 +-
>   include/linux/blk-mq.h   |  2 +-
>   4 files changed, 9 insertions(+), 9 deletions(-)
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


