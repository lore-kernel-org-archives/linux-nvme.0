Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A17FC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UcEd/N8S1l2AEKiHKDZAr2MPdIh2dEQzMofhohNhsCM=; b=SONr1ow1fiMqH1gDOsTNDZYsbR
	i+nrXh0P2HNFM+wXLDlKzRsljX4K1UYjj08Gq3LTeB4HwYJeOzZenNCHWqSIsHCtoifknrK88q50Y
	7dpc1hWEnje4L5sta0lPePMudvhP3jh2RfmJr4s4kD2NndlqhM8P4z5zxXdhk3HQMj0kxNSR6o/kD
	OfDVKYCEchNG4+vp2xfGmNZRI6erRm2YwBp7YOxFTAkrlG8x8d01gQ6rkhKMnOYmpJz6wiYfDMNdd
	RKfL0uKy2TrRgpZvHEXJaBv9+LUNOwIu+1e5cu4uJUR4ry+SsS6XA7Ruu+rzT1fnBS6dvMGQhSo24
	9kFbx3Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFxZR-004F1h-0t; Fri, 04 Feb 2022 12:20:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFxZM-004Ezk-KL
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 12:20:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24CB421122;
 Fri,  4 Feb 2022 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643977203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcEd/N8S1l2AEKiHKDZAr2MPdIh2dEQzMofhohNhsCM=;
 b=UO4RRIR1tMZNrD1rvIPJj/UGuT38pDrRsrIV+6bw02c9kNvCubfJx5wYZInMwQFOfziObJ
 gGkOB/K4DRt0fHJIp96evbuOPEdcR1nRkuSTxVJEhhPra3fGGUj794kWhxMOJeyEpq1cI2
 kr2zNzxP+ETvN+SuYoBWsrwX7jStr8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643977203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcEd/N8S1l2AEKiHKDZAr2MPdIh2dEQzMofhohNhsCM=;
 b=sJJKMgeKWLJuRq36Epd2vNrLhcNPL/exC+/FqZeKL7M8jRmu9O2VKW9PVZq2l0bzAMk9G3
 KGsfsrK7Zw+9smDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1307D13A96;
 Fri,  4 Feb 2022 12:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kwuAA/MZ/WGDUAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 12:20:03 +0000
Message-ID: <ebb86cfb-1728-db8e-4043-fe1d7f99e97a@suse.de>
Date: Fri, 4 Feb 2022 13:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] nvme: fix a possible use-after-free in controller
 reset during load
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
References: <20220201125421.177942-1-sagi@grimberg.me>
 <20220201125421.177942-2-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201125421.177942-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_042004_857518_8FB526A7 
X-CRM114-Status: GOOD (  22.24  )
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

On 2/1/22 13:54, Sagi Grimberg wrote:
> Unlike .queue_rq, in .submit_async_event drivers may not check the ctrl
> readiness for AER submission. This may lead to a use-after-free
> condition that was observed with nvme-tcp.
> 
> The race condition may happen in the following scenario:
> 1. driver executes its reset_ctrl_work
> 2. -> nvme_stop_ctrl - flushes ctrl async_event_work
> 3. ctrl sends AEN which is received by the host, which in turn
>     schedules AEN handling
> 4. teardown admin queue (which releases the queue socket)
> 5. AEN processed, submits another AER, calling the driver to submit
> 6. driver attempts to send the cmd
> ==> use-after-free
> 
> In order to fix that, add ctrl state check to validate the ctrl
> is actually able to accept the AER submission.
> 
> This addresses the above race in controller resets because the driver
> during teardown should:
> 1. change ctrl state to RESETTING
> 2. flush async_event_work (as well as other async work elements)
> 
> So after 1,2, any other AER command will find the
> ctrl state to be RESETTING and bail out without submitting the AER.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd18861f77c0..c11cd3a814fd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4251,6 +4251,8 @@ static void nvme_async_event_work(struct work_struct *work)
>   		container_of(work, struct nvme_ctrl, async_event_work);
>   
>   	nvme_aen_uevent(ctrl);
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		return;
>   	ctrl->ops->submit_async_event(ctrl);
>   }
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

