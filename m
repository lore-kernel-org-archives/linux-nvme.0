Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C160FCD37BE
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cem1mIyrGEmZz11IcjVLP3k4zmB99foKwLMnDyYMUAE=; b=aveaCPnl4hJlUT6pXNL8sZKCZC
	p6Q/nJIUJXtn4LzHCqysz596hdNpFysLXQaV8/WebQefdZj70oAVZKMdT786+s7BcjLi25c/rINHX
	H2CsYUnx5blaISnpKmN+FSXAHxvp6aKD45tu5T95Hh/VNwG0T1Rf9yA05nHS75X1t8p4mGTHNH/XA
	kMqiU07vO/d51s+O4cKQoZzi3S6P68bQdYVBm4B/vXpTjPBZa6nsqCi4SJm74sTXPDG4A5Hpb2UmQ
	K1WPrs2d5uUG0Mm+feX2BLQpri0ssHF+dcZO2M4+y2hHj0u3oD5E3BLmaq9n2CAVrMiykxkWON8nj
	PMTaOurQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQ9u-0000000Ddid-2agk;
	Mon, 11 May 2026 12:54:54 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQ9s-0000000DdhI-3YEf
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 12:54:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d75312379so3372903f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 11 May 2026 05:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504091; x=1779108891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cem1mIyrGEmZz11IcjVLP3k4zmB99foKwLMnDyYMUAE=;
        b=cSoQLCmKhpUZFhqVCPWL2Im7uWqiA64pa5/i8LAzvsym/Q/rtMRN8fYGd2ps+RNoEB
         ZKC8HhnjvY3pCPGSKrlKwrnoCgZdRJJVHhsH6vQkyEXu8JBDAUfh1TZurxaDUtGsUz30
         YitXAYub1Mdpa/KIQOlXy96NTeqDmyPnMmL8uNlqQJ+R5lctCTnnssVnlvaqHvMtmqcP
         +7smgx/myt6qVcgiSzYJ9z1KO13+AofAgiGIlAw/oLt4cWoP4QJIw8bF8JcBI1OqkfVz
         THhiFDsCU3DnrkUmOCnnNze69IGmkw0JFIdIdIILEgRcSWIui8u6fxkw5Pip+Kb8oCkQ
         k8fg==
X-Forwarded-Encrypted: i=1; AFNElJ9FoM3sfh2YUMvGO3J90A40BnmzEAbiZN/UuH9Owj5FY+aI15ilFfW1cHachkmHabGZ4nvFgWSh0Ygm@lists.infradead.org
X-Gm-Message-State: AOJu0YwaQbCU3P5f4VeZj7zwQ6tehHAfxilA4fJm9LUJQoNu+2IpRkNh
	/3sTzCUdcxIAZ+JB8W7onmDFus+Kyq3KC5QLxD49n/HR5u3zmcIjnPBM
X-Gm-Gg: Acq92OGlr9axQtj0vBoml38EvNH8bJCtNjP8yNgTiYtaU4queqhtmJX+iIpNVjCcTbg
	pVPp1LZ9rZl1KYuAXHdPox9GivhrYwq1azMRFfM3SanIdmojUViMZ/0olI5l/nAjAnvueE7DLLn
	6g7PYLG2dljyiiDpmESZUQlnP0EBbjErNy7zgBUJnFLRafGVpu6+MZmYgoECCgVFV2UONlXaApL
	Nx4G6t/6VJ06uKAJ0Kpul4V6bT8sJR7WEZq5KUeH+61mg/hix0NoUWoGWa9OUl5IB/zZsH4xs/T
	xUYLJdcv2zm0PrD/rvgjb7K1vgFO/3aKQ3mXeLV7Nm7G9KzJFrADj0HmKoigo0Ft08R1c2Ko2d6
	YS9+nkLgR55Ah1AvAsmz+QR51Mi5ULMVFE9wQM2gb0a9uOQT+rMNUIi5yMaUjzML4v2dIQbmqFN
	w72TDLG3UpaJOUD2WjSBP5vw4ZVPjs/9oNk81P4rF5APIVylQtKSmsUr7nBv/hTDao2xKT73crP
	KQ=
X-Received: by 2002:a5d:568b:0:b0:44f:69f4:39b5 with SMTP id ffacd0b85a97d-452ea742f47mr21165797f8f.29.1778504090630;
        Mon, 11 May 2026 05:54:50 -0700 (PDT)
Received: from [10.50.4.100] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm25489363f8f.22.2026.05.11.05.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 05:54:50 -0700 (PDT)
Message-ID: <36ef5a04-8b34-479c-bc09-09af6cd104f5@grimberg.me>
Date: Mon, 11 May 2026 15:54:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.com, kbusch@kernel.org, hch@lst.de,
 gjoyce@linux.ibm.com, wenxiong@linux.ibm.com
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
 <94f23fce-c968-478c-ae88-c3286d644eb7@grimberg.me>
 <9799c2c0-f6a0-41e6-9fa0-2993b60f1801@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <9799c2c0-f6a0-41e6-9fa0-2993b60f1801@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_055452_930585_5EFFB855 
X-CRM114-Status: GOOD (  14.49  )
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



On 11/05/2026 14:59, Nilay Shroff wrote:
> On 5/11/26 4:04 AM, Sagi Grimberg wrote:
>>
>>
>> On 30/04/2026 13:52, Nilay Shroff wrote:
>>> Hi,
>>>
>>> Monitoring NVMe devices and paths in production is currently limited to
>>> static snapshots via nvme-cli. While this is sufficient for basic
>>> inspection, it is not ideal for NVMe-oF (fabrics) deployments where 
>>> path
>>> conditions can change dynamically due to varying network latency,
>>> congestion, or link failures.
>>>
>>> In multipath environments, administrators often need continuous
>>> visibility into path state, ANA status, queue depth, link speed, and
>>> error counters. Today, this typically requires repeatedly invoking
>>> commands or relying on ad-hoc tooling, making it harder to quickly
>>> identify issues.
>>>
>>> This patch series introduces "nvme top", a tool for real-time 
>>> monitoring
>>> of NVMe devices and fabrics paths, similar in spirit to tools such as
>>> top or iotop. The goal is to provide a continuously updating view of
>>> device and path health, enabling faster detection of link degradation,
>>> multipath imbalances, and transient failures.
>>>
>>> The series first adds the necessary building blocks for supporting a
>>> top-like dashboard. The initial patches extend the table APIs 
>>> (including
>>> support for additional data types such as unsigned, long, float, and
>>> double) and introduce a generic dashboard framework. The final patch
>>> adds the nvme top command built on top of this framework.
>>>
>>> Future work:
>>> - Export NVMe statistics to external monitoring systems (e.g. Grafana).
>>> - Improve topology change detection in multipath configurations. The
>>>    current implementation relies on kobject uevents for topology 
>>> change,
>>>    but namespace path add/delete events are not exported by the kernel
>>>    since they are associated with hidden gendisk kobjects. This may
>>>    require explicit uevent generation from the NVMe driver for 
>>> namespace
>>>    path changes.
>>> - Wire nvme top into an MCP pipeline and feed it to an LLM
>>
>> Nice, However I think that the traddr information is missing. Often 
>> the network
>> has some routing issues for specific IP. This tool show this.
>
> This tool prints the traddr but NOT host_traddr. Did you mean we 
> should print host_traddr?
> If yes, then I think that should be a fair ask.

I didn't see the traddr...

Also, ctrl+c is not existing which is annoying ;)

