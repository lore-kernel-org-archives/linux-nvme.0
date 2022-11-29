Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SqT501/2aE8dTP1KD3nproVv7/9FtkQ4wJ/ZT2zJ/bo=; b=wGjI17YTAukOHVOxbpYGQqT59z
	RCygXrZatxUpZvHahfM38vVsLSUnN4tRnwu0BIlWEGl5xicAhTUXLoh7nqKu64dr3jYL6Y9WsRLGu
	fIdD+xsS58M769h0OZcZ5r4JqrBCSXM65zRFU2RkdppiY+7VRuBirDIsl36jYlnwkjMqQB3qcVQhm
	infPyDPhOgo4oOw7Qzpf5JNzNT3KAvDyOJodI/qE7fF2SzWd/IpATFg2nda7nmTnd9kzZfS7eKqmK
	A7FPCEsByUqOPlkX9Uwcl6jqrUaLdJq54LdSgal68KmZF0VNgORI5EE5ohyJznSnvAOSX5nRlILHC
	hwflWLOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02kD-009o2A-Rm; Tue, 29 Nov 2022 15:42:01 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p02kA-009o1A-Ux
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 15:42:00 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 4EFF83FB17;
	Tue, 29 Nov 2022 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1669736515; bh=wnSLS1lcmJYtAh3XGrwopHs6WB99DslvB63Vgb/tUec=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To;
	b=W6CDj26AxK5Js9+BA+6rOX/ZcaldAzN5E1jtEDy1uUaAlvOMqPfvba6oxk508OUVj
	 +WuNTgaKCf1KLio1TISeUlpPLCBCsbNg49l3UMcz6NguA9/4QZlriCRsrkrAmfQPMJ
	 fs+7TqyAdbreHly9WKvWw1ZFT2YAI1QJaMqNBBdokMphLuWf48DMJ8Gr+/CzzEBD1Q
	 It89SK+hqWS4hUA418+QTuD3DNNppPPTIyoDgUHG+0hB9uhDs+CIWvfqdyXAXROX81
	 kKYsXiyWJTlzQHOWmqIFcySoFdjjVYLUKUFZjhVzyTzRjDINqfRRwV9+hKYn/th62W
	 wRZfgImzkmrdQ==
Message-ID: <c20485ec-28aa-2a45-3eba-8fa384ce0349@marcan.st>
Date: Wed, 30 Nov 2022 00:41:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Sven Peter <sven@svenpeter.dev>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-2-hch@lst.de>
From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in
 apple_nvme_disable
In-Reply-To: <20221129132208.4337-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_074159_188494_F6508DBE 
X-CRM114-Status: GOOD (  18.90  )
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

On 29/11/2022 22.22, Christoph Hellwig wrote:
> nvme_shutdown_ctrl already shuts the controller down, there is no
> need to also call nvme_disable_ctrl for the shutdown case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 94ef797e8b4a5f..56d9e9be945b76 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>  
>  		if (shutdown)
>  			nvme_shutdown_ctrl(&anv->ctrl);
> -		nvme_disable_ctrl(&anv->ctrl);
> +		else
> +			nvme_disable_ctrl(&anv->ctrl);
>  	}
>  
>  	WRITE_ONCE(anv->ioq.enabled, false);

Reviewed-by: Hector Martin <marcan@marcan.st>

I looked at some of our other implementations and we always seem to do
both, but this makes sense. If it breaks something we'll notice and
shout loudly when it makes it into an -rc at the latest :)

- Hector

