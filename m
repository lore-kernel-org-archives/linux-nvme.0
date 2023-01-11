Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A032C46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lu8KSDioBcU2LxefL8NLGMOV+Q8P3RiK7lNjGpc2bqQ=; b=R/UaZhZipQ6BpGcxEKQHlHvjtz
	NciUugDIyLyHo7g04x6atxwiJSYJBBNVoHGVzqizV2JhYRnhqlT1aEylH8x8qrM94Z9C8ElGUUNc2
	34WSGCGXiIa8mkDEPOIEoX4tHF1EfPti//uxqJ0NQzc9Cofz8/0bBIizwMSZbsUAtVCsLCo2C02Rj
	XFENwg09F/oiV9+cg7hegn34a6YHGYnl+HsjhCjU1r800zaKrQl+MO/drk0VumAq9LiMJ5W7PEa4c
	TesYY6ffdWsJrTA+sV3OfPMHsGPXZwiEvuyM5Cpr5kMr+BoFsRvA1D6B/NxqoGsQ/NrbSd83ScSOf
	MFp3opkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSRK-009W9l-7C; Wed, 11 Jan 2023 04:10:14 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFSRG-009W8o-L2
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 04:10:12 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 3AC21420CF;
	Wed, 11 Jan 2023 04:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1673410198; bh=xIRvx/jmkEZ56tBeyElfYVKAMV1zU1cIDIsWSSQqaRI=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To;
	b=gFIGI+8nlVfHYbQ1P2yxoAk00mnoPSVkm6PvyefN4lEsb6IdthHTNtity//J1cbPG
	 Z4fG90dw6yMiqRpavMcMmsMLCRq/FGYkBjAK+Fc5Wjx3Nt1G+gwY/5+VFOgh8kiXRG
	 Y65sRpVNoCuahQ0EY+M0x0r9VV0RLNVr4ayrlH8V/zfdm9Xdb5f22XB5GLubbA1Vk7
	 ed9ntCVEql33sfmxaZiyh/Ln7AywvG0UQTaRbVCz96+6CLDq6BcedaU7EPVxs3QhYU
	 oC8MN4NpjGRScpHbjrQk8WXIfSM36yMCvEBgX1kNcgiK+kIxP+mOeBnUAK9UscTt8e
	 C6D7Ms1QVMVAw==
Message-ID: <91323446-cec0-0333-64bf-288bdca8b429@marcan.st>
Date: Wed, 11 Jan 2023 13:09:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Janne Grunau <j@jannau.net>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Sven Peter <sven@svenpeter.dev>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-2-hch@lst.de>
 <c20485ec-28aa-2a45-3eba-8fa384ce0349@marcan.st>
 <20230110174745.GA3576@jannau.net>
From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in
 apple_nvme_disable
In-Reply-To: <20230110174745.GA3576@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_201011_457340_F3D1774E 
X-CRM114-Status: GOOD (  19.46  )
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

On 11/01/2023 02.47, Janne Grunau wrote:
> On 2022-11-30 00:41:45 +0900, Hector Martin wrote:
>> On 29/11/2022 22.22, Christoph Hellwig wrote:
>>> nvme_shutdown_ctrl already shuts the controller down, there is no
>>> need to also call nvme_disable_ctrl for the shutdown case.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  drivers/nvme/host/apple.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 94ef797e8b4a5f..56d9e9be945b76 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>>>  
>>>  		if (shutdown)
>>>  			nvme_shutdown_ctrl(&anv->ctrl);
>>> -		nvme_disable_ctrl(&anv->ctrl);
>>> +		else
>>> +			nvme_disable_ctrl(&anv->ctrl);
>>>  	}
>>>  
>>>  	WRITE_ONCE(anv->ioq.enabled, false);
>>
>> Reviewed-by: Hector Martin <marcan@marcan.st>
>>
>> I looked at some of our other implementations and we always seem to do
>> both, but this makes sense. If it breaks something we'll notice and
>> shout loudly when it makes it into an -rc at the latest :)
> 
> This breaks resume for the apple nvme controller. The immediate problem 
> is that apple_nvme_reset_work() uses NVME_CC_ENABLE to decide whether to 
> call apple_nvme_disable(). Only nvme_disable_ctrl(ctrl, false) clears 
> NVME_CC_ENABLE.
> 
> Even after extending the check to consider NVME_CC_SHN_NORMAL resume is 
> still broken. The host specific reset to re-enable the controller works 
> but IO is blocked. The controller logs following messages into its 
> syslog:
> 
> | RTKit: syslog message: cmd.c:728: Oldest tag 12 is 19 seconds VERY OLD with cmdQe:2
> | RTKit: syslog message: cmd.c:732: Oldest tag is about to crash!!
> | RTKit: syslog message: cmd.c:720: Oldest high water mark moved up to 21,tag 12, cmdQ CQ_PRI0W
> 
> This looks looks like the controller reset after/during shutdown is required
> on this controller.

It's actually required by the NVMe spec. See the SHST description in
Figure 47 (NVMe Base Spec 2.0c). I'll send a patch.

- Hector

