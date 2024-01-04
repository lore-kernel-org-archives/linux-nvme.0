Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D701CC47073
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tpCAFHHNDkCIIkD3KFKBQSnEnysFzFpw4pIa0GAuCY=; b=CZ/ZLR25ZUkb+e2/O1SIUSe2QR
	drO/C0m5E0aJDoFrJ67N2NpXdCv7HvB1/C/E7tBjF+TqNeUrP++qQyat06djjub7IvmJlJw92wHVk
	sRwyMGcnhm1isb2jUYropImlNADjQ8veF4VGzZyrCE6Ch6juxMst8hN5r3IemfoOh3ysqYNrEtPnR
	mXl1+FHMJpmiHnMQSfv3AiZI9GD7dvpowDm4+QUISFQErhRRyJrDB1805htWdKks9eGOViZVmEeDa
	yRhWdMqmdHHwrst8ifq49PfqEz35MjKy47FMZVok9W/jHQB4EjHKYYmgQc6SpeiqSAipxtsy0PFfQ
	kLLL7wMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJ0T-00DC5k-03;
	Thu, 04 Jan 2024 08:23:13 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJ0Q-00DC4s-2J
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 08:23:11 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33694c0ebd1so59719f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 04 Jan 2024 00:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704356585; x=1704961385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tpCAFHHNDkCIIkD3KFKBQSnEnysFzFpw4pIa0GAuCY=;
        b=C4KnBxXF83TOxf8NjK4d+Mc4ax7rkhu8a6PZof5aRpkJGqkSy5XUgaWjtlVpUq+7PY
         iXQH65/8qb3FEglSryeHvZFn+/38FTavNo8kEe+SyMfXo2PhhxilK73yQYrE+fvAPmpT
         +MvXTHBGLEm0PQpDs7PPUOC5/qJpGpj+Jkko98Jn5ba3VMSO2cA/28dFZKW4dJa8IYLA
         a1u2V07LfBwEhm/kNTiBWgRh0ZhiZJEFND/wfCDz2W4PfIqCDkfVoEC92HEZq+cjuAUf
         BfPgC7SuguQlDybuouHujpwS0c9bKGdmpW5PJ42TXjz1rUuFJzGIel3gz6Xv5KLRd49Q
         Cs2Q==
X-Gm-Message-State: AOJu0YyghxaUz0xZrXw7R/hv7/xR++u7CO27uI+3EIfpDufdwWlVugZY
	FLzmeKZSdXcbEQPlGBrAMs4=
X-Google-Smtp-Source: AGHT+IGs6kn8InfSJ0WW7QLr5LxeN3jQqrVWoLVix6bEEJtlZbS/Ut15MUJ/ZN4CYAOyDpldsw7zKA==
X-Received: by 2002:adf:e702:0:b0:337:39c7:189 with SMTP id c2-20020adfe702000000b0033739c70189mr327429wrm.0.1704356585299;
        Thu, 04 Jan 2024 00:23:05 -0800 (PST)
Received: from [10.100.102.67] (46-116-232-10.bb.netvision.net.il. [46.116.232.10])
        by smtp.gmail.com with ESMTPSA id p7-20020adfe607000000b00336843ae919sm32093926wrm.49.2024.01.04.00.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:23:04 -0800 (PST)
Message-ID: <832e98c3-2404-400f-9b8a-0180cbadaffd@grimberg.me>
Date: Thu, 4 Jan 2024 10:23:06 +0200
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
 <ae25991c-b4be-4652-beb0-843e1c3f7a59@grimberg.me>
 <ceb1136f-30a1-41c4-b735-257d801b4efc@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ceb1136f-30a1-41c4-b735-257d801b4efc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_002310_757682_BE47C10A 
X-CRM114-Status: UNSURE (   9.83  )
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



On 1/4/24 00:37, Max Gurtovoy wrote:
>
>
> On 01/01/2024 13:21, Sagi Grimberg wrote:
>>>> Another completely arbitrary limit...
>>>> Can this come somehow from the rdma core?
>>>>
>>>> If not, its not making things any worse. So its fine by me.
>>>> Please comment that this limit is based on testing the devices
>>>> that support PI.
>>>>
>>>
>>> We are not changing the logic for PI controllers at all in this commit.
>>>
>>> I can say something like:
>>>
>>> "... We'll keep the maximal queue size for metadata controllers to 
>>> be 128 since there are more resources that are needed for metadata 
>>> operations and 128 is the optimal size found for metadata 
>>> controllers based on testing.
>>
>> That would be better, yes.
>
> np.
> I would like to send a new version.
> any other comments for this commit beside the language for the commit 
> message ?

No

