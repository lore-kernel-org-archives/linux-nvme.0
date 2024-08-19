Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACEDC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZ6HCtVeQ8OqZS9f0xsJC/cqwGvnQtKqVMzHvKKAfjM=; b=2A4ZBHg/qW+gJsOaPFSNN6y3uq
	mrb/FCeiOmfmIqixGucnQCbhgi2Zfn4PAhOQDtyxv3GSCsL+JgiTd+VRK6gBK2ZKkh/ZLfOi/K+UN
	XHIaoJUmr78K8TcYbQoaOHK+NlQPKJ/lqwIzM7NMecM27I5gldFfhABMyUz/aWx/VwQNa79wQMFMG
	LPspEPGU7xxSdTCUC4aPitm8BlLB5f5QbrXUTSFKUZazzzVLnITbqpx5KHjafEElnJaf/YV2885BL
	DFkW2Acvq86LC6RmZOtF1Mb6gfKw0diolGN1lOucR5yFhRCA62UCDgsUSUbMJEtumQB94ZYCqKCmQ
	uw+5280Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3H7-00000001jSW-2A7v;
	Mon, 19 Aug 2024 14:22:25 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg3H4-00000001jS7-2pcz
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 14:22:24 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso4801415e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Aug 2024 07:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724077341; x=1724682141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ6HCtVeQ8OqZS9f0xsJC/cqwGvnQtKqVMzHvKKAfjM=;
        b=WsgCF7Dle+s7OuxBjELG+aGK0ZbC1i6FQQKeGjc7ZmlKGysWk1gCDFYbbw0FQbOnFN
         1yfoKs+Z1jTnAB4iFEmM5CS6ML4cwXIEZ9/8vKsIuMs261FFsOC86vEooPD6BSO8dF/u
         cR98FHmW2FOz3KOKYCQYUgcLE5SwwxH1RSdTmMsQEf4TKydfsr5jFlQTo8fBHjB69mE/
         oPgkiZwamHnPaRIxjO/1xC+JUonHdtXzTdZCG1L9v0YP0oOY94EojHmG+VHI1rraJdht
         IoDEbdd3i4zOSDb7QtB3ftBVyDbZEt3rSA8EvDJaZvCGp4Gm67lYVtt969Da3T1NRatd
         ljXw==
X-Forwarded-Encrypted: i=1; AJvYcCXtN+tPm/a564sug2M7amRjkGw1dGLwPRCE+CTrUCUye3JxE5Aeylb7JZBkfOQt39Pfa4pK6GpcMERvOBE/J+sOpjV3a7DN+Mwc3y9nJLg=
X-Gm-Message-State: AOJu0YxXnUN8MfbIH7El6VqnzOuwRxILfRtwRCUeehIWgvB9kyTXkniB
	EbIrNQki5f/ZWO902xrLxjcpm3U/mATLESI8HNvlq0JsjZ8dVtMsnODtdA==
X-Google-Smtp-Source: AGHT+IGujBXAwz5GIZuWOfriQ/PLO9TundyGNAlAGI60hlbxfnRMMK/iASXPimOoHN22hIXrPnKRzg==
X-Received: by 2002:a05:600c:1ca9:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-429ed62f54cmr46583295e9.0.1724077340387;
        Mon, 19 Aug 2024 07:22:20 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650e41sm110770035e9.19.2024.08.19.07.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:22:20 -0700 (PDT)
Message-ID: <94e2d189-28dd-457b-af17-8a21efbdf744@grimberg.me>
Date: Mon, 19 Aug 2024 17:22:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: return 'namespace not ready' for disabled
 namespaces
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240819122917.65313-1-hare@kernel.org>
 <dc3d279d-58a9-412b-9cb3-cc51297f65ba@grimberg.me>
 <9e1839fc-5b8f-435f-abde-e8fb1bd9b60d@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9e1839fc-5b8f-435f-abde-e8fb1bd9b60d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_072222_738142_77F9BDCF 
X-CRM114-Status: GOOD (  15.48  )
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




On 19/08/2024 16:54, Hannes Reinecke wrote:
> On 8/19/24 15:17, Sagi Grimberg wrote:
>>
>>
>>
>> On 19/08/2024 15:29, Hannes Reinecke wrote:
>>> When a namespace is disabled from configfs returning 'path error'
>>> is quite an odd choice; the actual description for that error is:
>>> 'The command was not completed as a result of a controller internal
>>> error that is specific to the controller processing the command.'
>>> Which is not the case here; once disabled the namespace is disabled
>>> for the entire subsystem, not just the controller.
>>> So return 'namespace not ready' here to clarify the problem.
>>
>> Hannes, can you explain what this patch is solving?
>>
>> The reason why this error was selected is because this is a path
>> error, which will trigger a host IO failover.
>
> ???
>
> This is not a path error.

Depends on how you interpret  it.

>
> # echo 0 > 
> /sys/kernel/config/nvmet/subsystems/<NQN>/namespaces/<NSID>/enable
>
> will disable the namespace for all controllers. Not just the individual
> path (as there is not individual path). Failover won't change anything.

subsystems in nvmet based implementations are not limited to a single 
server.
The originated reporter ran a subsystem over multiple hosts with drbd as the
backend.

In this case, disabled NS does need to signal a path error, and hence 
why a path
error was chosen.

If you want to change that, please make sure that io failover works as 
expected
in this case as well.

