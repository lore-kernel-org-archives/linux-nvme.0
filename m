Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42A0C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 07:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lz60kBv5CfiMZ6t9+IFKEcqhF3cjz1v/kvaUyCbpNd8=; b=QUSuDy8Ff/NmldeS9WI69NIkQk
	P5Js6o1mIolWcVcaBbJpv950YK08jyuZrim5o39YmHdMqcNor6vhd/0+grJofNPcL+HaKPC2ddUSw
	Ztn+2Au1gmAt6yU15GR29gkNSpZ6XYcVxAUPBYFV02yiTHqyVcYUh2mIs1SOj3goBuZHdZ2FuB9Yo
	IzFnl8TDmGiQYAs3lxPdW8dOZDvieXBPUx/IGGoDADoBLVO3n5dpbRl4fZodZ1k4Qv6Oo8pV0p4KV
	kFpvi4qaRmwJIgZgytV3Jdw7huxy0xEOUK1s0LtVRjQmcfVk29akAbhbd4wdLnCUcS3b2b1PZp5uw
	rQGtIGYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q64r7-00EaXa-0t;
	Mon, 05 Jun 2023 07:42:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q64r5-00EaWl-0R
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 07:42:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2078721B1F;
	Mon,  5 Jun 2023 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1685950935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz60kBv5CfiMZ6t9+IFKEcqhF3cjz1v/kvaUyCbpNd8=;
	b=Yyz68yGaFoDlzjsVxRlQgMeqj/P3R/JlSjbfbWCqXUj0QwwN9irVgd5nglwIGNfOFhn/c9
	BGJtHMw2V/PHcH1GVhx7ZeVevJsdmPRfwDL9drk/OHIT+KUkNcDlmTW8HrCde4d0qNunHa
	GuPNdDv8EnxQJTOgf6Ts2h78iAEBLNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1685950935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz60kBv5CfiMZ6t9+IFKEcqhF3cjz1v/kvaUyCbpNd8=;
	b=ie7sjMdXMJYQPQ+sB8VvIMcvmlneG1TaXHDHt4by5D5/HdUVvWV/CkrSmS6iJ7WEW2teDg
	KSBhpyyh5WShCQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2137139C7;
	Mon,  5 Jun 2023 07:42:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0ecHOtaRfWRRcgAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 05 Jun 2023 07:42:14 +0000
Message-ID: <f3d496e8-69e4-bb42-f0f2-29eee26f403e@suse.de>
Date: Mon, 5 Jun 2023 09:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] nvmet-auth: use common helper to check secp/spsp
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 kbusch@kernel.org
References: <20230605064434.45233-1-kch@nvidia.com>
 <20230605064434.45233-2-kch@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230605064434.45233-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_004219_343307_B003B742 
X-CRM114-Status: GOOD (  10.88  )
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

On 6/5/23 08:44, Chaitanya Kulkarni wrote:
> Add a common helper to factor out secp/spsp values check in
> nvmet_execute_auth_send() and nvmet_execute_auth_receive().
> 
> No functional change in this patch.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 60 +++++++++++---------------
>   1 file changed, 24 insertions(+), 36 deletions(-)
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


