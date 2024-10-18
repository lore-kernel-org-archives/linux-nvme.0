Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22B9D30019
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jq8Ad7kSqhfGS4A9cN7JcUt35EIeLJtTutEGEd7kVT4=; b=CvB1ToZ+/LAS9iKWv7P3euwwjC
	hUaEhPcHTOauRDCrUOxEfvotdkaACC4AEVFzaMPQcKH5V00vc/wi9Rywoy7Q7MIEHaIy9ehyl1O9U
	hS6DHB6Kf5YhpAZRD+b3XVLFzW4533lKsYpM42ZM+16jqNmxT3fobcpOnQKWxbuObWoH9yozgoBa1
	B7ikXDGbXTuTXeTfqzJvHEgKZ21itDTmoNUb5FnS/4W1P/NxNHgtsmPhtFLET1C0ADHYRRskQX1m0
	fa7TWfvUH5lEodzPZVJNWxCHEVaVFhTlhNFV+Y1ToXYzlETPWPfhA0r4kco5aWIpRUnTGh4Wib/KG
	M8pnIPhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1pab-00000001JE1-3isa;
	Fri, 18 Oct 2024 16:12:33 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1paZ-00000001JDZ-3Gve
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 16:12:33 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XVV8v3Npwz6ClSpy;
	Fri, 18 Oct 2024 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1729267948; x=1731859949; bh=Jq8Ad7kSqhfGS4A9cN7JcUt3
	5EIeLJtTutEGEd7kVT4=; b=CYqZMDiT510FtZkz5+5s2r9tWuqsJpkL57dW6q0W
	KUR9t7uDPTGPvIsa0Cq3L4lkTPNdJVJeck1/337Msd7Xei4yJ5Cc+toXZD+bsyfC
	miom68w1FCZJpPyFDVUaTdQQlkSyN71dk94Y3cm54f90RI/q6Km0IGlMlG+oHaA0
	3vk6y/nZL64imq7VKQIPqlNcJoQ91u5kG7FPN39r/lVNvJTJvoe5IRg8krk3uPC1
	Ha1cEoEsBAdmCzV3Hu8YUTljzYU5VrSjULwenpdxuPJEqSQR3pb2iTKgwW311QEm
	iBzcpXPw365T9NAxjZ5vubAXLmBs/Tz9v3GDw3woP9G8Ag==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K5RnAnkziMAE; Fri, 18 Oct 2024 16:12:28 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XVV8k4Fpdz6ClY9l;
	Fri, 18 Oct 2024 16:12:21 +0000 (UTC)
Message-ID: <d09efed0-c1d2-4c7b-a893-0c7367d1a420@acm.org>
Date: Fri, 18 Oct 2024 09:12:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 2/6] block: use generic u16 for write hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-3-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241017160937.2283225-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_091231_878136_41610C11 
X-CRM114-Status: UNSURE (   7.17  )
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

On 10/17/24 9:09 AM, Keith Busch wrote:
> @@ -156,7 +155,7 @@ struct request {
>   	struct blk_crypto_keyslot *crypt_keyslot;
>   #endif
>   
> -	enum rw_hint write_hint;
> +	unsigned short write_hint;

Why 'u16' for ki_write_hint and 'unsigned short' for write_hint? Isn't
that inconsistent?

Thanks,

Bart.

