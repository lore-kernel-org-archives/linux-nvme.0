Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99215E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkvBXTbWBOBuuxlBbQl1KGZ5Lag0wHfRsbu2Yeuio74=; b=CZRwzcIyDEiGV2Uq9zWxy6gisM
	tdPHxc5fNsVnQg+PvpgyYSxkT63VfGqie5g39WJ4cAg4tdovJyM/DIZnBvmAeIIZE4HP9ESkuSt/4
	Qb8v3AYrwTqoQ1aKJ2/PJeWoAoXbFQuu1H4MTjwjoHU7/hXN4OtkfwhkxBP8cF0NlhB2dtHo9DATi
	luLOP2FP9DmRgjDeDLiprObVRdSZWJq0O6rTKg3kTO3ATpxHUC1LiOqFMtad5u2ycrrtmDttVA57H
	TpsvaMzkAOL+SMPmlrJswHLT7aHg6I9nk9khgr4Pow6MXfpjh9qmFuLleteI8dexvQiXQRtiqRUp3
	/mbX64Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWOEt-0000000HE7r-0Eir;
	Fri, 10 Jan 2025 23:16:27 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWOEq-0000000HE7S-0gug
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 23:16:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so29572025e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 15:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736550982; x=1737155782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkvBXTbWBOBuuxlBbQl1KGZ5Lag0wHfRsbu2Yeuio74=;
        b=TRbDarIE7etSVHWbossSRV9dQe16IT//MJfFgBl6f93shj4YkTEnKfubFMkHm/l82f
         yBmtNSmf1ni4BcBMeuCthfLU3QDkj2+GVyLVzO8+Gt21S2fHSfbYxbfBkp/Ce+agoonP
         laHUeKxZ68xinjH892R+HhvBIhJBKtiYZ3oKjpcUYyYakBooPh7cPIJCBqyLBNvdHvZd
         Cy5fMZnHTu4mEd2QpVCYpD4dRO2XRtSu2rYWpEIFjImybFFTF35Hhxl6N89G7Ljzq5Wl
         B95qMVvB5GosdLwYR9qcfdyGquXfDnZf28NYBFeCTAhjk2qcdPCuPL1SQlY0aHloGeIn
         d0tg==
X-Forwarded-Encrypted: i=1; AJvYcCXBVRDY+h213vUM7mDP6VVsHto4gvWqTbP4DhD4EjVrJpyQU27vXyP6RmO6fbyF9AnzCqRhGYK6AmUw@lists.infradead.org
X-Gm-Message-State: AOJu0YxoUsqmn0cXqnx1sdMa+9m0y4IL4ZeqwlNG1bjmHXY8nVXTozn3
	eQkS7RcVGc0ag+mDcCwhF/0Y+oTrSNvlVVIAxlIM0up8Rc2fx1oh
X-Gm-Gg: ASbGncshh9dMkEGNNFXlm4XjSV+8JDay07coLG+sMtDOmoLdoD8+/uruKwYjbct7GMV
	s0NO30CIuHk2nb9W1tq4I/9GvpqWNJEZjGowpKMFlc4s475fnIc0viY7Dn1TUuIIC1ssm2Ozcyn
	WWj0elQtQTXvojXGyRHwrPBLQgvaaKl0NTg9Yy7NysG8GYsZpGAov1MSpfJJ5bko50cwR9sa5Cj
	GVY4hZ9T9arE41SexIIjZFqYwHdVvZj3hSGdSI24GklEkhd8sDT0A2/b+EftGv3TicBviKJ/Lc6
	T2GPefLqr1Jfq6qw
X-Google-Smtp-Source: AGHT+IF94gtk3kwNsgjEoLrS7S1VWvxaJDStvWdmThusPSIS5sIVDbikq1rks9qjuZV34LuDubB/xw==
X-Received: by 2002:a05:600c:4e44:b0:434:e9ee:c3d with SMTP id 5b1f17b1804b1-436e27070b1mr111560905e9.20.1736550977406;
        Fri, 10 Jan 2025 15:16:17 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9dc895esm64854115e9.13.2025.01.10.15.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 15:16:16 -0800 (PST)
Message-ID: <77130bd8-5bc9-41f3-b4fc-ab41835850f7@grimberg.me>
Date: Sat, 11 Jan 2025 01:16:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
 <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
 <9cdb72d6-291f-46a1-8c80-45ceb75e2b8b@grimberg.me>
 <e3c2d261-c360-4ec4-9423-e5c9ffbd9758@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e3c2d261-c360-4ec4-9423-e5c9ffbd9758@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_151624_216151_C7885229 
X-CRM114-Status: GOOD (  15.17  )
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




On 08/01/2025 17:45, Hannes Reinecke wrote:
> On 1/8/25 11:49, Sagi Grimberg wrote:
>>
>>
>>
>> On 07/01/2025 10:11, Hannes Reinecke wrote:
>>> On 12/25/24 10:58, Sagi Grimberg wrote:
>>>>
>>>>
>>>>
>>>> On 29/11/2024 16:06, Hannes Reinecke wrote:
>>>>> When a namespace gets unmapped on the target during scanning
>>>>> nvme_identify_ns_descs() returns with a non-retryable error.
>>>>> With the currrent code we will ignore that error on the grounds
>>>>> that we failed to get information, and hence cannot make any
>>>>> decisions whether to keep or remove that namespace.
>>>>> But a non-retryable error implies that the namespace is _not_
>>>>> present as we cannot retry that command and will never get
>>>>> information about that namespace.
>>>>> And we need to remove the namespace during scanning, as otherwise
>>>>> the AEN informing us about a namespace change will find the NSID
>>>>> present, but nvme_validate_ns() will fail, and the namespace
>>>>> will never be updated with the correct information.
>>>>
>>>> Isn't that a bit harsh?
>>>> I would expect to see a specific status line NVME_SC_INVALID_NS or 
>>>> equivalent for a full removal of the namespace?
>>>
>>> Does it matter? If we get a DNR status back from 
>>> nvme_identify_ns_descs() we _cannot_ resend that command.
>>> Meaning we cannot get the namespace descriptors. As we
>>> rely on these descriptors to properly map the namespace
>>> we cannot correctly work with it, and we're better off
>>> to pretend the namespace is gone and wait for an AEN
>>> indicating that the namespace (or controller) state has changed.
>>
>> I think it does matter. I don't think we should be removing the NS 
>> without
>> the controller telling us that it is actually removed.
>
> But what would be the recovery action here?
> If the 'identify ns descs' command cannot be retried, how are
> we going to map the namespace to an ns_head?

Let's take a step back here. Can you describe the scenario you hit? what 
was the error
status that you observed?

