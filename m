Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D12C02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 18:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqa/u0L8F+czPGTw873BxVndvTGfrqQvDGTLQBpawzo=; b=ARrjz5s9K3tmHrWVbeG8lWNNYk
	KJlexcKdnbIWu8mw+OxE63yLfp7EYsc8n06HUr/yvbh6y70M3Inw+08OXcjcsoez11g5pJ9BjVpbi
	pMPAqbJ7BIletqB8bPZtRIy0dyEzTDWAhyf5ppDRjKqkd3UBsaKAhsQmSXD3dntInkw2DiqpTKdC4
	4wdKAcVbtYvBqrodzxHs+XZ+/grxh3ii5KcPb0t2Q67wAgE16X395ZeWU8nqecDFgLiqGQj3fVj8o
	azMAVHGOemxrLHxl3OTIqp5CqylWcFW1SiaumPGW90IR+zJ29Jqx/yQ5ZXP+Da/qaSUG4qnFSXBBT
	DRsd9jQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tY7it-0000000Chfa-11oD;
	Wed, 15 Jan 2025 18:02:35 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tY7iq-0000000ChcE-2WyG
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 18:02:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YYDNY2NfMz6CmQwP;
	Wed, 15 Jan 2025 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1736964137; x=1739556138; bh=lqa/u0L8F+czPGTw873BxVnd
	vTGfrqQvDGTLQBpawzo=; b=bU3uTs7HU0PZgGV4G5vUE+dm6tmWAM/oY0SYxA/F
	ZEYZcv6KbQPGlr+z+8qn2p6q2eXQoYMyavNFMYhGExIm1HRMc6x/pxwTvOD58fgi
	UKfhgflRR8efPG/T2FZca4G+G+ic4v13kSvfnp9aywCQlm0NC7ZxuP1ZW8z4hJvy
	/baE/pbcEBs2zZBkFCANmrTkxtZ7hPP1jn9T9sp48W8jSpGcd8k+ll4HihaHFX4n
	zHAXJFjgqq0xFLuX1yTWriVCPCmhf+z/nkFUsfTPMo6CcyeTjTyp2LpsLJc+Bjor
	93TFkSWlOxZzo9pc9fPjbSHDFniapw10PLtpaMl8HvkmiQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z_tj61q2WKsb; Wed, 15 Jan 2025 18:02:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YYDNR4W9Nz6CmQyc;
	Wed, 15 Jan 2025 18:02:14 +0000 (UTC)
Message-ID: <8890627f-57bd-4601-921e-037cf7481599@acm.org>
Date: Wed, 15 Jan 2025 10:02:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix compliation errors
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250115034722.145742-1-kch@nvidia.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250115034722.145742-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_100232_669888_19F93BA1 
X-CRM114-Status: UNSURE (   5.86  )
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

On 1/14/25 7:47 PM, Chaitanya Kulkarni wrote:
> nvmet_alloc_ctr() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl
> doesn't have nvmet_req argumrnt. In nvmet_alloc_ctrl nvmet_req is

argumrnt -> argument

Thanks,

Bart.

