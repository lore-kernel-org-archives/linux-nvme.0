Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75093C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 14:13:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B3264E3C
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B3264E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QI840JS11Ng7YwgI4z8VJQNC1FHCmQNGHG7ws5h1kbA=; b=bFjYvagIW67JKbrxlETbzSVvi
	eryOwq1ZpYab0MC0j6ofBA+Bzeop4ZIDS45Ykd6xjxFMa4BI2IpeugB6wrDNeMValSuEZI6qBOHHd
	soyKpde7COn+Il5cGlRXKba7ossRXY0ZXJh2WxdH3wggAoMbxqwXeNSkpqTddWLyMfWyoCDtUDu7q
	p0IOJwTIGXQN/xYLDRTlTee6ccNm8RJe7bS3Pi1BBSw6QNd/h1aPCRE0m9fKBQ2I4PnSB4cxxm/yU
	JHQ1lGIoMCcOFM8jg2eSyF0zyHmr52kU5bQoKs7DIiAavUjgRp1IzaTCB8gM5ylaj5F3EUmLYeqRJ
	6cmhs/tTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8koM-0000e9-GI; Sun, 07 Feb 2021 14:13:14 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8koK-0000dT-1m
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 14:13:12 +0000
Received: by mail-ej1-x62d.google.com with SMTP id w2so20458576ejk.13
 for <linux-nvme@lists.infradead.org>; Sun, 07 Feb 2021 06:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w6oegXIzIc0UwP/fg1twf7f1LMWXjODHbU1V0MHboc4=;
 b=Fgkk42D/h/KvLXiQkCCzsGy2s512RnstC9cnCW0vzDxwTyhkXkar870gdw0PJMDCsZ
 O2z2Qo7nOyxeEvfAb9me/3o/QL5WyeDZBYVbdDZel6H2QbvSxgGMHOIMEw3Etcti4IPD
 P52VdzjT7AmbdO1OKF3b5ExCBUW+goDx5XTfdZwY7NCaCBqxTB5nbFq/aHe0t7oid2oL
 PElKW1YzkGtqgsK59SIGRh14xEgZ6CUlUEgqU9GYAGLcML6ts6dPfs5Mn52A8FqP2ZLz
 RKE4JBOjj8OUucuPueCgOxGfh4vgC5NHrm8MO+rJxcrZg078vaYkyo80zAgk/Ck1OumA
 PVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w6oegXIzIc0UwP/fg1twf7f1LMWXjODHbU1V0MHboc4=;
 b=ADxHpz43VeTbsS7wbGDqtG6fuHqapIxzu957uAu1r0wX4XX9BuzjbWeC7IoixtY1uO
 41Plr2tPeoU6zzn292oZvJXC5XxYTMK7pmhjIBJYQ5pg2ACpycXSrU6vADX3Cz2S8hcJ
 Rq9kkBE/9bhUgo2+b91MOfxdpM37daPECr9Ggrboedkl8xjezOGV8mtP7QTRj64LzFcQ
 umUq3R0aIauGzB6KneCPqfeLbAPwzuysGKoUAFcSMWLUyKlUBiULWYpL6gOo57/92DCj
 CKV6c3tHie+84vXevJZ30SgCbzRobar38DF7HQMq0TOoxWpOK8HUIm4ytNzK1poD7xbT
 KBww==
X-Gm-Message-State: AOAM530rYLwZtFGaiX1cnsRaXoyw5rzV4/PowNbVxHZOCozkeg31RM4O
 us3yKvJtKOCIUus0ABlxXfY=
X-Google-Smtp-Source: ABdhPJwEHlfxYvZkRGE5qe9GbdKWUbzpreU6bUsiLHWYa+0DGCAdXcaaqYik4Hxv/gfbibM45Juzxg==
X-Received: by 2002:a17:906:1b11:: with SMTP id
 o17mr2265901ejg.295.1612707188971; 
 Sun, 07 Feb 2021 06:13:08 -0800 (PST)
Received: from [132.68.43.187] ([132.68.43.187])
 by smtp.gmail.com with ESMTPSA id f22sm6872841eje.34.2021.02.07.06.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Feb 2021 06:13:08 -0800 (PST)
Subject: Re: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures for
 copy to iter/pages
To: Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com> <20210201173548.GA12960@lst.de>
 <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
 <20210203165621.GB6691@lst.de>
 <20210203193434.GD3200985@iweiny-DESK2.sc.intel.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <e1eb7f7d-9a2a-f879-6fc9-4b929f2a4239@gmail.com>
Date: Sun, 7 Feb 2021 16:13:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203193434.GD3200985@iweiny-DESK2.sc.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_091312_119625_2B738AC7 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.net>,
 axboe@fb.com, Eric Dumazet <edumazet@google.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 Or Gerlitz <gerlitz.or@gmail.com>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/02/2021 21:34, Ira Weiny wrote:
> On Wed, Feb 03, 2021 at 05:56:21PM +0100, Christoph Hellwig wrote:
>> On Tue, Feb 02, 2021 at 08:00:51PM +0200, Or Gerlitz wrote:
>>> will look into this, any idea for a more suitable location?
>>
>> Maybe just a new file under lib/ for now?
>>
>>>> Overly long line.  But we're also looking into generic helpers for
>>>> this kind of things, not sure if they made it to linux-next in the
>>>> meantime, but please check.
>>>
>>> This is what I found in linux-next - note sure if you were referring to it
>>>
>>> commit 11432a3cc061c39475295be533c3674c4f8a6d0b
>>> Author: David Howells <dhowells@redhat.com>
>>>
>>>     iov_iter: Add ITER_XARRAY
>>
>> No, that's not it.  Ira, what is the status of the memcpy_{to,from}_page
>> helpers?
> 
> Converting the entire kernel tree in one series has become unwieldy so I've
> given up.
> 
> But I have a series to convert btrfs which I could release by the end of the
> week.  That should be good enough to push the memcpy_*_page() support in.
> 
> I'm get it formatted and submitted,
> Ira
> 

To conclude this discussion, there's nothing that we need to change here
as the relevant series is still WIP, right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
