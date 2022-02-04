Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70DBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 12:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=453m+8cTev61CBzwIcGWEOMqd9scLWa21LUQH9E5IjM=; b=3ExN9j9Rg9pew49zHICgt76S0w
	IJGm/z7vRGCPPMQMxWjMPfPoY34MukJ6Oo/vShiDYLaRqfgI8VOwJtc/EgGK8EJNl5wa5xn5dM7DA
	UAXsmIHr6EMg95H/SCWUUtM+smdrRJrsq0YPE6Wb5SKieftCxQZwINCuLm0bL2BpN+Xw48/o/8AJU
	9k8LrCk5vfAiN0sX8lOQRYTusIJtTks5aELqHO2bLMe4imdjTD3gkyPnqtJNVYPhizktYWHqHWb/H
	Vx5HAWQEsMxCqOtsD7aOiaSWS6Qzhft/njy4G922vr6r5Im923nC0Kl08vp0iih/y5oicTi3Dq+1p
	/X9UupPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFxaa-004FTZ-2T; Fri, 04 Feb 2022 12:21:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFxaT-004FQy-Ke
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 12:21:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F86F210FD;
 Fri,  4 Feb 2022 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643977272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=453m+8cTev61CBzwIcGWEOMqd9scLWa21LUQH9E5IjM=;
 b=TglMs8gMZDcHEWrryVlAZErggitjSoNd2UKtUnEjXElnuf31BNOEZ2+2UW+zYNjz0X6+DH
 2OcooXmcHJMBO3sZerq3lsz/A+fkgJNAMm8yVBd7Uxv9xh50VAb1QNijG1R/f0615EhcJu
 MbL9OVFjWir6ushgbb8DqB8FmJmTDPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643977272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=453m+8cTev61CBzwIcGWEOMqd9scLWa21LUQH9E5IjM=;
 b=XBKh3SCaSO1udWPEY7tueGoEQGDSwy1qNWrzkz+PS/Qn81s5a7J/ZnSWc6gLAfcsM7oZaU
 OUSKH7yFxG2zQ0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5154D13A96;
 Fri,  4 Feb 2022 12:21:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7XuWEzga/WH/UAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 12:21:12 +0000
Message-ID: <7888e232-01da-2f05-8f0f-7590a4a5c5bf@suse.de>
Date: Fri, 4 Feb 2022 13:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 3/3] nvme-rdma: fix possible use-after-free in
 transport error_recovery work
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
References: <20220201125421.177942-1-sagi@grimberg.me>
 <20220201125421.177942-4-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201125421.177942-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_042113_867509_B1BC7B5B 
X-CRM114-Status: GOOD (  16.90  )
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
> While nvme_rdma_submit_async_event_work is checking the ctrl and queue
> state before preparing the AER command and scheduling io_work, in order
> to fully prevent a race where this check is not reliable the error
> recovery work must flush async_event_work before continuing to destroy
> the admin queue after setting the ctrl state to RESETTING such that
> there is no race .submit_async_event and the error recovery handler
> itself changing the ctrl state.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 850f84d204d0..9c55e4be8a39 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1200,6 +1200,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   			struct nvme_rdma_ctrl, err_work);
>   
>   	nvme_stop_keep_alive(&ctrl->ctrl);
> +	flush_work(&ctrl->ctrl.async_event_work);
>   	nvme_rdma_teardown_io_queues(ctrl, false);
>   	nvme_start_queues(&ctrl->ctrl);
>   	nvme_rdma_teardown_admin_queue(ctrl, false);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

