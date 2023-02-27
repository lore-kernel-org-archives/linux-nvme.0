Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BA6C64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uHr+Co8eEabIuNx5JmGIl5utnyG6aUsC6+tq4HIs5mY=; b=25lmCRvvRS3hic+pSH0RBKAIsV
	v7ARdgs+3zizBq8cfO4+GPIyNyN8zoHhks0bo27S+NyW7e2l5BZzQbWFavZviZPXqIyWFuq+Ts7h+
	VDUa9uPgdf86jtXe4bBrQEkcBSKJ+qcIF8MOq38TP3SVEsYlvJLi9Py2AeJNAOSeLonUB/3j6SFot
	L9RcexKma0jwhNnalePohM1DEooISurv98Y/Q8g28luQL3msmg6ArJBEFgDcVpdOSnaYrtD2IMAk2
	t+FEVlYrOKH/2XvlLp36qpEt6at1Ded5dGtZnxug/JYFBHAAGs9VtEo/AD/AAu+CsmqYZqufL2kom
	gcls/SjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgRz-00ANOG-By; Mon, 27 Feb 2023 16:34:07 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWgRt-00ANNJ-7F
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 16:34:05 +0000
Received: by mail-wm1-f53.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so4309416wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 27 Feb 2023 08:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677515639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHr+Co8eEabIuNx5JmGIl5utnyG6aUsC6+tq4HIs5mY=;
        b=FeAiujU7rY2bJhD9OxQAXUcc4Gf+/kAea29Ata5iP7SmUQvpaISD2rODYbdb4v+nD5
         6SIWrHBPgpOdMeFo56f8MIdIEWANo/8hcK/5LqmbVRG72WTQjwlhb5d0CSX2REWrPye1
         u/ydjhZO/21EwgaGwGFs6MhvVEWZ0DA6IIjvNy3n4oqZmeRzXgCzsXBCWZ0jxxyPVghq
         /+IEjRaGVCStqU/5Ptcb6w7c8cF7To9nFybrh7EZRdS7paRMRe/nY6dfbnAI7SVwRYQo
         cIxfQH0TSBbFfsd1a/0/yWygYLM3F7AbdTsNg2YlDRlKOhy2Ga9AnG44NPl20pMcYsN/
         tilA==
X-Gm-Message-State: AO0yUKVXsV6n3Otk8v2vKHQ//tqqpdJDWll09QwvQc2Ztjj4I2n3iv80
	0fmy6+B4LVXfSOnCxoSRWP8=
X-Google-Smtp-Source: AK7set9XuktCuCbfaEM6UQv1TXQCJUOCI6+5jRpfNuq7BuGAtwnkJnGreI3Ovudm509y4Apw8vnHDw==
X-Received: by 2002:a05:600c:3b94:b0:3e7:534a:694e with SMTP id n20-20020a05600c3b9400b003e7534a694emr17518116wms.3.1677515639042;
        Mon, 27 Feb 2023 08:33:59 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003eb20d4d4a8sm9305724wmk.44.2023.02.27.08.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 08:33:58 -0800 (PST)
Message-ID: <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
Date: Mon, 27 Feb 2023 18:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "dgilbert@interlog.com" <dgilbert@interlog.com>,
 Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_083404_553300_6E81E36B 
X-CRM114-Status: GOOD (  20.24  )
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


>> On Fri, Feb 24, 2023 at 11:54:39PM +0000, Chaitanya Kulkarni wrote:
>>> I do think that we should work on CDL for NVMe as it will solve some of
>>> the timeout related problems effectively than using aborts or any other
>>> mechanism.
>>
>> That proposal exists in NVMe TWG, but doesn't appear to have recent activity.
>> The last I heard, one point of contention was where the duration limit property
>> exists: within the command, or the queue. From my perspective, if it's not at
>> the queue level, the limit becomes meaningless, but hey, it's not up to me.
> 
> Limit attached to the command makes things more flexible and easier for the
> host, so personally, I prefer that. But this has an impact on the controller:
> the device needs to pull in *all* commands to be able to know the limits and do
> scheduling/aborts appropriately. That is not something that the device designers
> like, for obvious reasons (device internal resources...).
> 
> On the other hand, limits attached to queues could lead to either a serious
> increase in the number of queues (PCI space & number of IRQ vectors limits), or,
> loss of performance as a particular queue with the desired limit would be
> accessed from multiple CPUs on the host (lock contention). Tricky problem I
> think with lots of compromises.

I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
the queue level would cause the host to open more queues?

Another question, does CDL have any relationship with NVMe "Time Limited
Error Recovery"? where the host can set a feature for timeout and
indicate if the controller should respect it per command?

While this is not a full-blown every queue/command has its own timeout,
it could address the original use-case given by Hannes. And it's already
there.

