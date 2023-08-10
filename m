Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0416C001DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+soCux7Uc9IpDHW4V62SYp9vbvdk3PlSp61egS8RdF4=; b=DizkOpBluFWBzlRAlTH9mLFu4P
	kknG00uzPR4ZRyaN4Xo4l4Qyhv0CTuxzGDpkrIfo7Ul7E9lTjgw+xxDECJoIF0QMRS3bW5mBRxWuK
	3tXXcxo6CeD8Zef7RgmRgBOwNCUB3+HVRaShn17Puz8/cQmnYKA0JitwZnys1TBNAZMcDS5ASJX72
	WDKo9m3sLU+9GxJOofL7U5o8iaJTRcXqAZhmdTOU8Jlpv4pJnhkgQ9bgWlIPOzmyVW0gOe32ZCayo
	xbHuKw4YQEoDkYaLuu7BspkT9iI3kNyc1Akov4WJIz1A+O/O0KPWKUNrAfFtUur6QwJv7te39a1KQ
	x8HzU7JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5lB-007jwg-04;
	Thu, 10 Aug 2023 13:31:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU5l8-007jvc-0u
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 13:31:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8F111F74B;
	Thu, 10 Aug 2023 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691674284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+soCux7Uc9IpDHW4V62SYp9vbvdk3PlSp61egS8RdF4=;
	b=YJUz6YPUHQ11ELsrhzh0abFU2pAZQUlOrmoJ0LiTHpP8TjOK8Oz4ilej9V+V/g96ffsUWA
	9czE3mDIC2mlR91ogNHwziubWdlkp74Vf+hcA/jA/PunJtMh+JJ/FdiWU2nA5j2QnZ87U3
	tP0kf1avY9A/X/q5VNMUUB6HJJIzUFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691674284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+soCux7Uc9IpDHW4V62SYp9vbvdk3PlSp61egS8RdF4=;
	b=Au0j+tm7WWltN9NJZbDJBf1QQYq0lIIPQiOWs9Ur3fSAb6aUrYkrj65UYd+8JGhONC64Aq
	61Q0wL7v2G7VdxDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D5D138E2;
	Thu, 10 Aug 2023 13:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uB51J6zm1GQvbAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 13:31:24 +0000
Message-ID: <de389c3d-629b-4bf6-bc79-2dd1f588cc3e@suse.de>
Date: Thu, 10 Aug 2023 15:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 4/6] nvme-rdma: use nvmf_resolve_address helper
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
References: <20230724092023.708335-1-sagi@grimberg.me>
 <20230724092023.708335-5-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230724092023.708335-5-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_063126_463791_5814FCE4 
X-CRM114-Status: GOOD (  13.21  )
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

On 7/24/23 11:20, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d433b2ec07a6..797bd192a413 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -2230,8 +2230,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		opts->mask |= NVMF_OPT_TRSVCID;
>   	}
>   
> -	ret = inet_pton_with_scope(&init_net, AF_UNSPEC,
> -			opts->traddr, opts->trsvcid, &ctrl->addr);
> +	ret = nvmf_resolve_ip_address(opts, &ctrl->addr);
>   	if (ret) {
>   		pr_err("malformed address passed: %s:%s\n",
>   			opts->traddr, opts->trsvcid);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


