Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF92C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 11:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RCe2TPU9LUFhoFV6W5YhCg+pI/RXtQ+1Mlh93H/op3s=; b=jfRZYLBZXO3P7da7rMafFnwNVz
	hM5RUELy8lUa6MfCywy4y5IlEvyXeaHhPNXg9G3xJQrXq5wjYKr/m0ZNtl34+lNkfXs5ejpe/4qTi
	5x7yQ9u64ke8I3ESenwN8HaUncR/nXnRMi/9Jean73rkOUQegL1QYT14Tr5yGWnWc6hrlpVavQhkW
	2N84/4tDDwXI3A7W/rqhJYl52pGgDbYK20mR0OgWXhIoBCoUDS+3kNMspOkCrshGZeFHuH5jV4kYm
	KcHHwCj/7fxsZ7+7TO/vPw7Sa8d0D9PrRAyaQXoYPC/ee/oV9XnasrIFcIF+4hn0t04DGWY8HDbFJ
	E72BFGRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE83F-004kui-S6; Wed, 20 Jul 2022 11:39:37 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE83D-004krM-Cg
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 11:39:36 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61E2B33F64;
	Wed, 20 Jul 2022 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658317170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCe2TPU9LUFhoFV6W5YhCg+pI/RXtQ+1Mlh93H/op3s=;
	b=brz1gVTaifMcXXbNkLEyUhtoworyKdlkxCk2J9bDnyHgsrlnQRAX6qMehh4oS21IA9BPt1
	7AnuyP5IqAY7CZi1tNvBKY0l+aJ/pPXU5DTyfj92P3d8Toj6Ge7ADpYVrL/R/8DJfQfk1N
	p4pi1sdI4Swt7rZb50MYSOr4u4arGEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658317170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RCe2TPU9LUFhoFV6W5YhCg+pI/RXtQ+1Mlh93H/op3s=;
	b=BAGq1G93Yesa+YgZdJgR9n8g2e1baneV3S2NlLLA/5rfKCuI+8eD4PVYJ7QByimRJCoF5Z
	5YsgawL3J9A9IyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4318C13AA1;
	Wed, 20 Jul 2022 11:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id s0W1D3Lp12K4SwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 20 Jul 2022 11:39:30 +0000
Message-ID: <1f8867c6-1bdf-0614-aeed-d39e328fda82@suse.de>
Date: Wed, 20 Jul 2022 13:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220720113717.31854-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_043935_633355_C8269249 
X-CRM114-Status: GOOD (  15.99  )
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

On 7/20/22 13:37, Lukas Bulwahn wrote:
> Commit 71ebe3842ebe ("nvmet-auth: Diffie-Hellman key exchange support")
> intends to select 'Support for RFC 7919 FFDHE group parameters' for using
> FFDHE groups for NVMe In-Band Authentication.
> 
> It however selects CRYPTO_DH_GROUPS_RFC7919, instead of the intended
> CRYPTO_DH_RFC7919_GROUPS; notice the swapping of words here.
> 
> Correct the select to the intended config option.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   drivers/nvme/target/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index f0c91f7686a3..79fc64035ee3 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -93,7 +93,7 @@ config NVME_TARGET_AUTH
>   	select CRYPTO_SHA256
>   	select CRYPTO_SHA512
>   	select CRYPTO_DH
> -	select CRYPTO_DH_GROUPS_RFC7919
> +	select CRYPTO_DH_RFC7919_GROUPS
>   	help
>   	  This enables support for NVMe over Fabrics In-band Authentication
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

