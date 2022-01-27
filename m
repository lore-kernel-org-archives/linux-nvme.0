Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EEDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6iCziEIYuBtiwUqfieb2TZ3kgXEhQg00bad2Itrlj0=; b=J0Dgyu4e5+xXRDvpwNFPrzgML3
	xdGA9JLJoZU/07IcsL0jS12eZUnuPJv1JO2g1jz8Z5Rken1pp2y+n2+5VtnaieCZ/g8fBr4EfhPNY
	zhIH/Ou2Sf9C+TIhOOYok5K6ZDH/kAxYmXBz7TphSIaW+0SG9eoywUNVz+N1gpqQsQ5RZfzMXKU9a
	ys4PKesu50AtGoaaEczdkJ3eYM9P1hW5qp51IvR//w3eLdenGShLJjOWrA1FnhwcAp909elLSZzrU
	pbsOpSVFpWvhJGW4qU+MbM5U8RFU4qgsyvot7VvbuBBbfa3Ur9J0zatAGXNRm9sFC9jgJMJ3Feyzg
	6omJoNZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD1Q4-00Eych-3K; Thu, 27 Jan 2022 09:50:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD18K-00EuUz-7o
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 09:32:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 872FD218D9;
 Thu, 27 Jan 2022 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643275918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6iCziEIYuBtiwUqfieb2TZ3kgXEhQg00bad2Itrlj0=;
 b=fHApcWpa7x+NeOH9LtjjvnUtY8+EYSDdxEaAFTizjf+gwJznSjeL8j7HympbUmZymhdZyK
 XppvbTISotxjL5WC7lMPKiVeg7knG74VnKJK0J1NbjsKj34rlcnxH0GwcU4WqSBznLwlzX
 HUYVRcH7KIejcrn8ihfYyhaWpQBU8rM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643275918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6iCziEIYuBtiwUqfieb2TZ3kgXEhQg00bad2Itrlj0=;
 b=NNRBnFBkYdqnOHfBxD8HrWgcMtz3H79YKSBLQkynEzTVJ9BKHrg2rWGMcrXxS+FXaDn5fS
 ukc7O2pwNhM6kcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74CAE13CFB;
 Thu, 27 Jan 2022 09:31:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 594jHI5m8mEOJAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 27 Jan 2022 09:31:58 +0000
Message-ID: <ca31d387-f113-bbdd-9e3e-ce42a1cee934@suse.de>
Date: Thu, 27 Jan 2022 10:31:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/4] nvme-fabrics: add explicit deregistration on
 disconnect.
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B32271567EB19DC312B79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <BL0PR13MB4291B32271567EB19DC312B79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_013200_473454_6EA43741 
X-CRM114-Status: GOOD (  18.62  )
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

On 1/25/22 15:59, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> Per TP8010, a host explicitly registered with a Discovery
> Controller (DC) must deregister on disconnect. This patch
> sends a DIM PDU to DCs to deregister the host on disconnect.
> 
> Signed-off-by: Martin Belanger <martin.belanger@dell.com>
> ---
>   drivers/nvme/host/tcp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 970b7df574a4..804d927b4b81 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2176,6 +2176,16 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   
>   static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
>   {
> +	if (ctrl->opts->explicit_registration &&
> ++	    ((ctrl->dctype == NVME_DCTYPE_DDC) ||
> +	     (ctrl->dctype == NVME_DCTYPE_CDC))) {
> +		/* Deregister from discovery controller */
> +		union nvmf_tsas tsas = {.tcp.sectype = NVMF_TCP_SECTYPE_NONE};
> +
> +		nvmf_disc_info_mgmt(ctrl, NVME_TAS_DEREGISTER, NVMF_TRTYPE_TCP,
> +				    nvme_get_adrfam(ctrl), "", &tsas);
> +	}
> +
>   	nvme_tcp_teardown_ctrl(ctrl, true);
>   }
>   
Similar argument to the previous patch: Does this need to be in the 
kernel? Can't we delegate this to userspace?

And, more importantly: What happens if the host does _not_ deregister on 
disconnect?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

