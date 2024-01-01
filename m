Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6450C4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UScGiKEB0A+vrkBGAnXWdpZgwQ8YwhpOzIunmkzYTwk=; b=tAiE6I+RAA8sx2/sq6E11iWUJB
	hgj0gIjIZZjxaS2ji6eNd79+5D/hkYE2DTRVaUrfQvnCLw0NyT/c6gzKBZdZX/82a34IL8vCg7stJ
	FHWWtgHh/TrT5iKwstAZ2wyFNl+vN5T8yE91Jb0h4gQ8nc0LaILH+CigeIbtjBykrmYZM1SxAc7Nj
	p7XQ6/NbLGXY5+broZ/ms/7QnZVwgrKDiEb6HU68WSzA0CRb+ROBpPm+wtrwrqf7+QGBBStvEwhgX
	261XSmtOgTYDhsksNi2fUeB2GT4CmzOqWo1RsqMpPHUR4Cy66zfXOKl7KxAB0rYcDxv6B0/URyqf5
	qApB2YIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGM1-005w2C-2v;
	Mon, 01 Jan 2024 11:21:09 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGLy-005w1a-1q
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 11:21:07 +0000
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccc1a757e5so17442621fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 03:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704108065; x=1704712865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UScGiKEB0A+vrkBGAnXWdpZgwQ8YwhpOzIunmkzYTwk=;
        b=jGHZmqxs1C9V3HUdjiBlpD5idMKTEBAwBFYgRdmqla8qVqIqltPxL31Kyw+9Xq6QVA
         nZtw503AXf2gsRUDjgeBXwAusMPfHEyTpbV8ZEnfqfSEBVFLPUtsR2KhC/OFUL520788
         HBprfV1Lmcd4pxtwimhxEfB09wa+mLVqw7k0OFCQQmchEAF/s48FuBZxvqkn7BoQ14vm
         OcxCYNEqpF2IhuFN5ojoHt36DuvemlycclswdI0tmtLzC9aYI9FJc13Myu3YQw6bjIn0
         PXRgSiCzOmfrebwEo1ZodJgi+UrGVrC9D75EFeH49qvHlSeUfyHq7/EyspFxjpVFkjac
         yAcQ==
X-Gm-Message-State: AOJu0Yz5eWIQ+KTMpn0/ECpszwidbaUi/GyUiYqpQgvI9ovYjWgDbZ8u
	dJ0ANT7TSi/C8k8DRoQccsE=
X-Google-Smtp-Source: AGHT+IEI9umBPTyrK82K5BOkEdo2a4Lu5DPNhF0+QDlFWVEu/Uzropn0qiFcVYDStQb6uqgUcnE3Sw==
X-Received: by 2002:a19:6d1d:0:b0:50e:337b:f316 with SMTP id i29-20020a196d1d000000b0050e337bf316mr11251662lfc.1.1704108064894;
        Mon, 01 Jan 2024 03:21:04 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm20303033wmq.24.2024.01.01.03.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 03:21:04 -0800 (PST)
Message-ID: <ae25991c-b4be-4652-beb0-843e1c3f7a59@grimberg.me>
Date: Mon, 1 Jan 2024 13:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-rdma: introduce
 NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-8-mgurtovoy@nvidia.com>
 <d55384fd-42aa-4aeb-8a7c-f36c6a9dc6a4@grimberg.me>
 <b1363b4b-ce14-4797-9080-40e9d37a6b97@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b1363b4b-ce14-4797-9080-40e9d37a6b97@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_032106_616140_33646700 
X-CRM114-Status: GOOD (  10.49  )
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

>> Another completely arbitrary limit...
>> Can this come somehow from the rdma core?
>>
>> If not, its not making things any worse. So its fine by me.
>> Please comment that this limit is based on testing the devices
>> that support PI.
>>
> 
> We are not changing the logic for PI controllers at all in this commit.
> 
> I can say something like:
> 
> "... We'll keep the maximal queue size for metadata controllers to be 
> 128 since there are more resources that are needed for metadata 
> operations and 128 is the optimal size found for metadata controllers 
> based on testing.

That would be better, yes.

