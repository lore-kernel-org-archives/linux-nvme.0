Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE39C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 12:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q18rv5UylGOVZaTd2naG7DcMD3WkST5vwcKPjoM7nIg=; b=Gxo9w++EGxfx1l873OrgiP0Dim
	8CBu4SiK2AQULKE3QYyoInk+GcRHFxDFSBUiyfFesGEaiWRAqTtyW8PS7Ani4a2l0WF/wH13eiKzD
	y+ELY7Gtktk0SdhJ5hbwjln3G1rhyqB2qhwri15lbkxyUmYzMus8RvWWPR3m7tiSiMWzYRFlA/GXO
	WG8yMof+JH8cyu94Ez814HVS6js4X73QsmobCr+/vyGMjHHcQrnLifrTbL/QCJx0jSlCAigYaU0Wv
	wtGT1LCKn8xiaPUX8Du4m8q1qt/hXs0Gh0Cw6XdSefg4SC4XIxmeL5tEsJrnTn4PYyrj/ouloxM4E
	zvr0MNNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFxaA-004FK2-QU; Fri, 04 Feb 2022 12:20:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFxa6-004FI0-2L
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 12:20:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9A541F382;
 Fri,  4 Feb 2022 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643977248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q18rv5UylGOVZaTd2naG7DcMD3WkST5vwcKPjoM7nIg=;
 b=w9kc3shiT0/CPLoivHAwPLarLOZRhwSNbkBADghj6AzzmX1pe51HBsA4aFGZNzI+FaRHT7
 ARm7eWKLTxpoeX3laIOQcQIcqNI3eFmPf4jcv/757BpLnK+YrmrCECUEq9U/YoWEFa3uyU
 37JKW00UJ4GaGa5E9kX71R6+5r80r1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643977248;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q18rv5UylGOVZaTd2naG7DcMD3WkST5vwcKPjoM7nIg=;
 b=IECto/EjsEf4Ud1pZ7UV7/ybkppwCbOUK11R6K6s8TF3ZMjYZJYLIRaKzP4b4NFkVBKylS
 /mwYeEo68ma+c7BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99B0613A96;
 Fri,  4 Feb 2022 12:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bjQdIiAa/WHVUAAAMHmgww
 (envelope-from <hare@suse.de>); Fri, 04 Feb 2022 12:20:48 +0000
Message-ID: <5cdc4808-fd0c-ebb1-ba22-5ea4abcd660d@suse.de>
Date: Fri, 4 Feb 2022 13:20:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/3] nvme-tcp: fix possible use-after-free in transport
 error_recovery work
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chris Leech <cleech@redhat.com>
References: <20220201125421.177942-1-sagi@grimberg.me>
 <20220201125421.177942-3-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220201125421.177942-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220204_042050_308736_8E5419B9 
X-CRM114-Status: GOOD (  17.34  )
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
> While nvme_tcp_submit_async_event_work is checking the ctrl and queue
> state before preparing the AER command and scheduling io_work, in order
> to fully prevent a race where this check is not reliable the error
> recovery work must flush async_event_work before continuing to destroy
> the admin queue after setting the ctrl state to RESETTING such that
> there is no race .submit_async_event and the error recovery handler
> itself changing the ctrl state.
> 
> Tested-by: Chris Leech <cleech@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4ceb28675fdf..01e24b5703db 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2096,6 +2096,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>   
>   	nvme_stop_keep_alive(ctrl);
> +	flush_work(&ctrl->async_event_work);
>   	nvme_tcp_teardown_io_queues(ctrl, false);
>   	/* unquiesce to fail fast pending requests */
>   	nvme_start_queues(ctrl);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

