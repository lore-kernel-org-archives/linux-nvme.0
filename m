Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF895C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DqNMz9pwBKKEhO6Lt04H2UeGM5En/75KAmyF2mqrnbQ=; b=bW38YEKe+2036VmCfyGH6td6O3
	YL1A4k7sfiicdAvEi/77PVK99UwLXfYD4aqxrKPHvbHTxz60B5vZv6R/U3JReIJ3WvPKQ+BY2TCLM
	8Gc2pHisvSZJtZvGiYIjNbf6SjrcrEY2K67cSJwa2QL3g2yYHl+XR0ejvBzjfcwhuZF8uT53V2+fv
	MhxA3mfq7K10sCRI9HZbAhKh/RmQ04nsO0T61l1CCkI+ADzMelxw2sNJfliIupRLoz7F0pVPOnO0T
	MCplvwGWGl39JvbfMzfH2NEoA7doGllsSS6G7rWRWO1SwxUBfB+56Q5PiQlHPoNhBx9DdLGdOfOtD
	QRL81ZPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBI1-009kPU-2r;
	Thu, 11 May 2023 18:45:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxBHy-009kOZ-2D
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 18:45:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5CA121FA0;
	Thu, 11 May 2023 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683830714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNMz9pwBKKEhO6Lt04H2UeGM5En/75KAmyF2mqrnbQ=;
	b=hcjf0ZSv2VashG9kBKGlaDRydR9IC3eS/F5TpaqJUVuBJ1HBkOBNcC18XUJOWxqiJmkCjx
	1bwcSB+Xr8S20liI32NbLAIVM78e3j16kx9zdRFYnz7uVe/lPIzIiQWHMNulpUxRef8Lq+
	YHcAu6wYQHxMFJrO43aDjOunD2rxrWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683830714;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqNMz9pwBKKEhO6Lt04H2UeGM5En/75KAmyF2mqrnbQ=;
	b=eLCntk3m+vjTxRMkIqdBMzYNUdVp4Zed6KCRnnApGD/cKVtOPRCj9tOQum14sak697qHRt
	4+mFIeYNoE+55XAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C07C5134B2;
	Thu, 11 May 2023 18:44:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5tEOMKI3XWTATAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 11 May 2023 18:44:50 +0000
Message-ID: <c202f4da-1bbf-f724-9331-4a610abaf544@suse.de>
Date: Thu, 11 May 2023 20:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/3] nvme-fabrics: unify common code in admin and io
 queue connect
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
References: <20230511165441.30005-1-mgurtovoy@nvidia.com>
 <20230511165441.30005-2-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230511165441.30005-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_114518_894115_B362949F 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
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

On 5/11/23 18:54, Max Gurtovoy wrote:
> To simplify code maintenance, it is recommended to avoid duplicating
> code.
> 
> Tested-by: Noam Gottlieb <ngottlieb@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
> - address comments from Christoph
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


