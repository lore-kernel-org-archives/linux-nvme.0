Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0128FC27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1TjxwdtwDBf9dpqHFM5EICaXQ28U0dNmB1rsvDAYAh4=; b=Uk8IspsmB6jImjTP/xaQcMWF3r
	jqe6fOZkvXqsq1KZwxbu8WlfYwsv0DcGxtJyf0eMDDUL225yHs1siHhkk+w7PLxWAUJe1wktFO8wI
	bb9uurvx9BJ5IysYpCVtlv2tlNqBICKO7hFxb3gLpEdCcP0abJujc8vTe6cRFC1YvadFk3kRa4iW2
	C6/kX5ibCeu9hW3QrGTsu4tbAt3MkuOeBjxFjYMSSVpg6Nxnu5v/y56MxTZf2hLm3QBvoaMK76zGc
	p5ZWqJZmo5+rSmGZCKisl33xxLmHNlsuCN8ubx5ryxAN0NbSfaqNW5D+zUMgrWVNIBFOmuWxIbErL
	MKR2UwbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkWc-00000006EYV-2PJo;
	Mon, 10 Jun 2024 19:17:50 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkWZ-00000006EXt-3SST
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 19:17:49 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42111da672eso2867115e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 12:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047064; x=1718651864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TjxwdtwDBf9dpqHFM5EICaXQ28U0dNmB1rsvDAYAh4=;
        b=HkflgQoaz0k3Wq5sPbMFF5eXbeEf11apuhRbtKGgJ3mNTqRbnv08JgJ0TDBDtGN8Yu
         h+dEQK/0r9xjIvBEY192w8RvGqluS7USHLN6K4jthqX6W6588je0OQtllSUsEEKqltkb
         g6hy4inaF4ovvdgHKfQvRDSt49vfhu2REl2EOA4wa5Dnal+GEB6xU9ByXcu/sNvLx1ff
         kZjbMlWyscTe8rdzkgfMWJQPehHSh2Z/s1EwDioCnfBXyCUYbxpk9Wbaw8mPMAMiLSnM
         ea/EtOjeJ+XoDiyzIK4ZEjxf6XX6/YgXSK3J09LMPhHx09ECVEMKACJZaFGTWNwgQYeq
         jpiw==
X-Forwarded-Encrypted: i=1; AJvYcCUyOdSZ4IdnN1oy0bRxLE1G9N2t7gmtwjFKT3vF4LiV3sSy0SrcXnExuOsc3XmOOecdrKx+SKa7N3vcQEQ5+K+OPsNkWfxnLQPUb+E1eRI=
X-Gm-Message-State: AOJu0Yyr6FwqLVXp4mkET5WV9rpCrEs3vIeZNTQgBhmPOkkZ+dOBTKvt
	GnJaghxRnUPIViLElJjmoO8nuOE4H8BxsAMBM+UjXz+inc50YCxJ
X-Google-Smtp-Source: AGHT+IG+Arhc0Ki2O2+3o5JkvJ//dutAV8umCJHhjPj9FFAHbXcosO2mEhVAJGDN3XGI/o1YqR+BZw==
X-Received: by 2002:a5d:588e:0:b0:34d:b5d6:fe4b with SMTP id ffacd0b85a97d-35efedd2e3emr7494771f8f.4.1718047064037;
        Mon, 10 Jun 2024 12:17:44 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e567sm152346085e9.1.2024.06.10.12.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:17:43 -0700 (PDT)
Message-ID: <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
Date: Mon, 10 Jun 2024 22:17:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Keith Busch <kbusch@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
 <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_121747_898855_91340377 
X-CRM114-Status: GOOD (  14.47  )
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



On 10/06/2024 22:15, Keith Busch wrote:
> On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
>>
>> On 10/06/2024 21:53, Keith Busch wrote:
>>> On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
>>>> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
>>> My mistake. The namespace remove list appears to be getting corrupted
>>> because I'm using the wrong APIs to replace a "list_move_tail". This is
>>> fixing the issue on my end:
>>>
>>> ---
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 7c9f91314d366..c667290de5133 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>>>    	mutex_lock(&ctrl->namespaces_lock);
>>>    	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
>>> -		if (ns->head->ns_id > nsid)
>>> -			list_splice_init_rcu(&ns->list, &rm_list,
>>> -					     synchronize_rcu);
>>> +		if (ns->head->ns_id > nsid) {
>>> +			list_del_rcu(&ns->list);
>>> +			list_add_tail_rcu(&ns->list, &rm_list);
>>> +		}
>>>    	}
>>>    	mutex_unlock(&ctrl->namespaces_lock);
>>>    	synchronize_srcu(&ctrl->srcu);
>>> --
>> Can we add a reproducer for this in blktests? I'm assuming that we can
>> easily trigger this
>> with adding/removing nvmet namespaces?
> I'm testing this with Namespace Manamgent commands, which nvmet doesn't
> support. You can recreate the issue by detaching the last namespace.
>

I think the same will happen in a test that creates two namespaces and 
then echo 0 > ns/enable.

