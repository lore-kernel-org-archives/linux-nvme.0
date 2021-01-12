Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E04C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:49:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA55F22AAF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 06:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA55F22AAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q0Dl3D3p1GI9BH+U/IEF2qUcLAHFxxtvMtn2SlcR+uk=; b=1lKblE19HZ6O6/d8xK/aWgXCT
	Zctde2cAAfaJdHLu2wWGxMae5zOXP3tYJ7YCl6PzGDjGo9N3mE1+iiLHqmy+HQTtz2SI7kDkFXs9Y
	AWQyohamSKGlBOELlP+YCv5T+qNPTyn+dyEUzBK5aU3s1aVF1d2w0n6ZHN0AZ9duQ+3EXJZx/MTdK
	MsiMtfVi8mpX7cXQecRfuO6gEcNvZrxGonttArRtJV6gPDysRodUA8c+CiqJ8oCQFfg9T/kXca8gS
	xP4FUn4Aa/sHLMNhcVJWEMHdZ1YzfxMUoRXicxIMeVUFOagpQtrVdj7zKnSuJK3130FINLxD+IxP1
	LLIBKklrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzDUR-0006RC-7x; Tue, 12 Jan 2021 06:49:15 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzDUO-0006Pb-Ke
 for Linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 06:49:13 +0000
Received: by mail-pj1-f42.google.com with SMTP id j13so1048531pjz.3
 for <Linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 22:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kP8j+TNCFQmcTbrAXCZ+l6RUmnHbQEmjKo1qRTeY8wQ=;
 b=PQS2Nm+MpQr/OvGKTXiV7K5/xLfkh8BRC5nhUMvjn8hsk2/PXB31rYdDjNRh3otFSD
 0smRuSKDJGIU8RUAhz+lHGzk0qhUdmMz9hQx/AquCWeTCSF86Jq7HTp69otyB8ND0gR3
 HbrcS2qsb2FnGJi+/jWIEWnDHXqQb2FdzA4sA4OmYlYAB5DEtfAYnyuxFDAKAbdRaU6G
 ulHMEm0ZbOCyZuPjTAqEY5p/vnqGe3BUFBJYcqMQgEebX8UoLpvb0FEoWYcyqrHjVBs7
 R1M1AlOLTB93X+nUVGOZzSzU3aX/1ApT7hltaZf+Yr+4sAqwSrk3BaLIawWvjqK27cr8
 2ayA==
X-Gm-Message-State: AOAM533JKYXnr9fRcYe7ncib1dxkkKd+yrz/lkLrYh0f2qMlGCpBmwGh
 0URl2g84tr0noau8JeZBld+kmFgAKGc=
X-Google-Smtp-Source: ABdhPJybc6Md/lq7/JrKv8EqquuT7uwlK6rMq6+DpUFzRLGtLVERFdL2tfURBY27LAnqkJXWaUBBBQ==
X-Received: by 2002:a17:90a:a415:: with SMTP id
 y21mr1480589pjp.88.1610434150021; 
 Mon, 11 Jan 2021 22:49:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:8187:1b02:7bea:17a7?
 ([2601:647:4802:9070:8187:1b02:7bea:17a7])
 by smtp.gmail.com with ESMTPSA id o14sm2273718pgr.44.2021.01.11.22.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 22:49:09 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Ming Lei <tom.leiming@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
 <ae5b1654-e580-88be-0498-0cd111b53fa2@grimberg.me>
 <CAJS6Edjkfvs4pfH9XvwAT0h4STuoDh1PahSxkkTWOsKwgL5pZQ@mail.gmail.com>
 <16fe1e9c-3a43-ef28-7b69-755e6a86464f@grimberg.me>
 <CAJS6Edi9Es1zR9QC+=kwVjAFAGYrEru4vibW42ffyWoMDutFhQ@mail.gmail.com>
 <4684c86a-8cc7-c5ae-0d6b-9f0e7c59eda5@grimberg.me>
 <fcb56817-1f34-e307-e888-45ebb661c31d@grimberg.me>
 <CACVXFVNwhFTq2Aq7bx7cwmhab4itkAntF-TKunv59XoZySy51w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd3d4c8f-459e-1fa0-2a98-3bdb3e83de4a@grimberg.me>
Date: Mon, 11 Jan 2021 22:49:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVNwhFTq2Aq7bx7cwmhab4itkAntF-TKunv59XoZySy51w@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_014912_769088_D185FDF3 
X-CRM114-Status: GOOD (  15.25  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Hao Wang <pkuwangh@gmail.com>,
 linux-nvme <Linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Hey Hao,
>>>
>>>> Here is the entire log (and it's a new one, i.e. above snippet not
>>>> included):
>>>> https://drive.google.com/file/d/16ArIs5-Jw4P2f17A_ftKLm1A4LQUFpmg/view?usp=sharing
>>>>
>>>>
>>>> What I found is the data corruption does not always happen, especially
>>>> when I copy a small directory. So I guess a lot of log entries should
>>>> just look fine.
>>>
>>> So this seems to be a breakage that existed for some time now with
>>> multipage bvecs that you have been the first one to report. This
>>> seems to be related to bio merges, which is seems strange to me
>>> why this just now comes up, perhaps it is the combination with
>>> raid0 that triggers this, I'm not sure.
>>
>> OK, I think I understand what is going on. With multipage bvecs
>> bios can split in the middle of a bvec entry, and then merge
>> back with another bio.
> 
> IMO, bio split can be done in the middle of a bvec even though the bvec
> is single page. The split may just be triggered in case of raid over nvme-tcp,
> and I guess it might be triggered by device mapper too.

Yes, but I couldn't find a case where it cannot happen, but it only
triggered with mdraid. I'll wait for Hao to verify and send a formal
patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
