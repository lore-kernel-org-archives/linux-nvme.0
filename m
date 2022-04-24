Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A8FC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Apr 2022 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=odBx7hT1wSZJiP7flW0GTnsZa5tZa4ZVfY4ulpIFZyY=; b=Gudqople05geiuDK36RR8Xb0Ur
	mxm0GMhYwrjzo66TjnKwqm+D0ti38d51cJ7ag+/2P3JnVu9HfmjDxUBHoAXzc0w9XktmQIvwU2oeh
	vfPA5TOObeyxkd2DK5mF89HDcQP8Wi1RK9DVJvnUbwtBIIMkPKZYzk5UjFZOYCQ5UqIcMTw+jjpn5
	eyLoupLQhyQnlYbHP/NBhXGwRAypEuMiuDZLQhE/LKx4wWAX/mTN1fODF05SiMcaCz14OC0p6xpTG
	ef4YwQfGTg48IvSXTMu/JzPqX2eUUpsaCSTSFXtnhx7ehrQaX7auD27XkpIshUNnvoPv0ON8dQRXP
	SxCQXCMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1niabX-006UWf-I3; Sun, 24 Apr 2022 11:40:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1niabU-006UW3-S9
 for linux-nvme@lists.infradead.org; Sun, 24 Apr 2022 11:40:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 089D21F37D;
 Sun, 24 Apr 2022 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650800435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odBx7hT1wSZJiP7flW0GTnsZa5tZa4ZVfY4ulpIFZyY=;
 b=zmhNzYLR+/VSk7HGQ2VBtA0gAH5ilOtUVFw3L/b9so0lnj0cXvUv3Xby+bg+l1wyyYCLL8
 JMHnQ34Ef8CbH5bdFHsrvDHq/iBDdpj7uPeWc7SklQfyc80Y34KmCvGGP6nFo2klfD3fxW
 jt+bs0OD7OKqq4dtU4MnvZlkJmUQFjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650800435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odBx7hT1wSZJiP7flW0GTnsZa5tZa4ZVfY4ulpIFZyY=;
 b=qmpkhtSW6MAD1HkSSj2r94gPtwbxNplV60Zrmh18fCOkCUZXZ6kKI0iabNqiFpsl/X21eK
 pLH6T471Ch3aSCAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1CF113780;
 Sun, 24 Apr 2022 11:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a5v0NTI3ZWKMQQAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 24 Apr 2022 11:40:34 +0000
Message-ID: <d9ed253a-c6bb-c4ca-a608-69e237068f73@suse.de>
Date: Sun, 24 Apr 2022 13:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Content-Language: en-US
To: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220424_044037_097706_AFA0DB37 
X-CRM114-Status: GOOD (  17.63  )
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

On 4/22/22 16:40, Smith, Kyle Miller (Nimble Kernel) wrote:
> In nvme_alloc_admin_tags, the admin_q can be set to an error (typically
> -ENOMEM) if the blk_mq_init_queue call fails to set up the queue, which
> is checked immediately after the call. However, when we return the error
> message up the stack, to nvme_reset_work the error takes us to
> nvme_remove_dead_ctrl()
>    nvme_dev_disable()
>     nvme_suspend_queue(&dev->queues[0]).
> 
> Here, we only check that the admin_q is non-NULL, rather than not
> an error or NULL, and begin quiescing a queue that never existed, leading
> to bad / NULL pointer dereference.
> 
> Signed-off-by: Kyle Smith <kyles@hpe.com>
> ---
> v1 -> v2:
>    - Update commit message
> 
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed680915..2f7510938b18 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1772,6 +1772,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>   		dev->ctrl.admin_q = blk_mq_init_queue(&dev->admin_tagset);
>   		if (IS_ERR(dev->ctrl.admin_q)) {
>   			blk_mq_free_tag_set(&dev->admin_tagset);
> +			dev->ctrl.admin_q = NULL;
>   			return -ENOMEM;
>   		}
>   		if (!blk_get_queue(dev->ctrl.admin_q)) {
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

