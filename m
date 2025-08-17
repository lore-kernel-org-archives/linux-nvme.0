Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17FBCA0EDC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BMnCO2zM9NxeIYDXCHfCP7qlydNItbG2D6dOsV08UvU=; b=uvlyw8asv4DqOIabdg1Y1GZbE8
	cs4MW0wnddbowOoORt+8fMxqDue5uOFEKXJZb89W9GUg5qkwLUF4OZmzzd7C6hP3eK8nBAhRdOKeq
	P4RirgZDK6x28A76HholcI8HE/QZ0GrzgrH6gLMO4a9aKECK7c9YIc5Uvl8McBWrPMMf12fpCkQ+2
	FEVQKdyJDldNIWX0KPZj67fNjVNCawNJV7nEjmo+YLoi5sCZNp7gHU1ygxY1XsIRvwSfIsO9MH12g
	hqC4mR6ZIzO9isSMjNCfYmx2YLdOSuJZ0ETpE2b2gT/mosp0PzHQcaWwvQ8FcjmfGRE63EQL+J63G
	HET9pBOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unaxg-00000005ZI2-0Xal;
	Sun, 17 Aug 2025 10:50:04 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unav6-00000005Z9K-2kDg;
	Sun, 17 Aug 2025 10:47:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A855D60008;
	Sun, 17 Aug 2025 10:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62A2C4CEEB;
	Sun, 17 Aug 2025 10:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755427643;
	bh=I2ib/OXqX53rEewSl2SArXNdOrcnURD5+ssUMeP5k4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QjGM9q7nSJXUG+plAyBKPeCiYay+NFV+chGfJaCtilblGRo03kdUHr9qFNgkc8iJ6
	 anqblR9hInENq7Uuu4qRNQA83z0iPv7ADUCW881ts/mqQ3AWZnPkmRhvD4u210QSfj
	 MJJixD0mqvqXagcHSxfcKfpAUScJjRMNHEcqLG+Huji6tOSzinqkYWjVeqifGk5z7/
	 CDMjgWqJrmdXJwz3hYNJC1UbPjva4T9KuVEsAu8obnILYYAAcnSQCfS8ft4Na0NCVr
	 cUlp3650rCXaI0M/XM33xOxy4VTF6Fv2hjgfha5YP26SMZSQQN0LYy+hTKGNy02fk7
	 cfpRCk+CRnwtA==
Message-ID: <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Date: Sun, 17 Aug 2025 12:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme: apple: Add Apple A11 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Jens Axboe <axboe@kernel.dk>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11.08.25 15:50, Nick Chan wrote:
> Add support for ANS2 NVMe on Apple A11 SoC.
> 
> This version of ANS2 is less quirky than the one in M1, and does not have
> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
> SQE.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>   drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------

[...]

>   }
>   
>   static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
> @@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
>   				  struct nvme_command *cmd)
>   {

Please just create a separate submit function here.
There's just not much code that's shared between the two variants.

[...]

>   }
>   
> @@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>   {
>   	struct apple_nvme *anv = queue_to_apple_nvme(q);
>   	struct nvme_completion *cqe = &q->cqes[idx];
> -	__u16 command_id = READ_ONCE(cqe->command_id);
>   	struct request *req;
>   
> -	apple_nvmmu_inval(q, command_id);
> +	if (!anv->hw->has_lsq_nvmmu)
> +		cqe->command_id--;
> +
> +	__u16 command_id = READ_ONCE(cqe->command_id);
> +
> +	if (anv->hw->has_lsq_nvmmu)
> +		apple_nvmmu_inval(q, command_id);
> +	else
> +		command_id++;

This entire block here looks weird. First you decrease the command_id
directly inside the shared memory structure, then you read it with
READ_ONCE to a local variable only to increase it again. Why?



Sven

