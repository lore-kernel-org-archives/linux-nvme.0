Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B23C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:11:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834DC60FE4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834DC60FE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7mQUXhzeo49bncUuvi9G+gPn7ipYgx+/dsoK69lMNbc=; b=lP13zK3+0n12vexkmps/ra25M
	PjYWFuwOH6YogLr09gU7f9nTZLXbkNpIeWMR9TWrXRE5UyjXoiHJJ8924au/TnGh0YEsaQ+dZl4Kr
	IxBgt07a8f/0/7WWeA17afCvuvKZLriuLAWZX45Uv6Oaxjc6ZRRvj0854te6EZftWeEcrY1p197+1
	KiDtpyeibXOyUt6Y0cM1wYyi/kehAjDeNq7gtIRvm4Juxlacrl8ydjX9XwYqynTJeC1eZHdeJ5l4Y
	aWWY80ZSP5hfpG0Lf5RCnggrESLD9kSyAUjztHTfu1sUB/SxYKRKVm3hjg72gzbYLA08dBlcaKLbd
	0rylLT4wA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRgF8-007KtV-QR; Wed, 31 Mar 2021 19:11:07 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRgF3-007Kso-1w
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 19:11:03 +0000
Received: by mail-ot1-f51.google.com with SMTP id
 v24-20020a9d69d80000b02901b9aec33371so19974392oto.2
 for <linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 12:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=80SkR2Uqe9LOLCMpmsAfammoilA0jgZLZVMKvZ6Xe+E=;
 b=r9dv360wQ9HTgh82R5TLMyRVqF3I74j9zwzWyPlLprHjr/d6m5tXaXQZRARMFgeDGL
 xGr/seuV2aD1/HqWwzYEy73xBVWvVf8zb/mle13DWauATWwUU/+0nctGmecgsU1fDK09
 uBdx0wxHQT4DmT4SEUmApimnA+KxT+bgHpEa6/6dtuJw2l1s1lGgmsNIqx7d86xMGTYG
 3a9+sAhdFOTlAN4yS7CSZzCnuim3DnWYGd7hjpXayJy7jsDb3ATeWASrj9eNyr9h0cyu
 XMQU9ukq/by9uERzqRR8qo1m2EH44NRh85GXGvA+D5gVWWScKhms+bnFaYBl9km3kI6m
 Jk2A==
X-Gm-Message-State: AOAM532P3y5wdAaS6QToBKUgoD/DvadES+lRgD0EKr+O34bLZ7X+KlKf
 XqTrITfSLXs/j34/9oiJgOI=
X-Google-Smtp-Source: ABdhPJx9X1n/4fL1bvTnd5UJmMElSuiK3cQpyNPxv4YT8iTMHWUY+98Dsm8FJHMU1bvUQBk216/nAw==
X-Received: by 2002:a05:6830:1bf5:: with SMTP id
 k21mr3896001otb.129.1617217859218; 
 Wed, 31 Mar 2021 12:10:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc?
 ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
 by smtp.gmail.com with ESMTPSA id 62sm651987oto.60.2021.03.31.12.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Mar 2021 12:10:58 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
Date: Wed, 31 Mar 2021 12:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_201101_284371_CD5DDA33 
X-CRM114-Status: GOOD (  14.65  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi,

Hey Keith,

> While running a read-write mixed workload, we are observing errors like:
> 
>    nvme nvme4: queue 2 no space in request 0x1

This means that we get a data payload from a read request and
we don't have a bio/bvec space to store it, which means we
are probably not tracking the request iterator correctly if
tcpdump shows that we are getting the right data length.

> Based on tcpdump, all data for this queue is expected to satisfy the
> command request. I'm not familiar enough with the tcp interfaces, so
> could anyone provide pointers on how to debug this further?

What was the size of the I/O that you were using? Is this easily
reproducible?

Do you have the below applied:
ca1ff67d0fb1 ("nvme-tcp: fix possible data corruption with bio merges")
0dc9edaf80ea ("nvme-tcp: pass multipage bvec to request iov_iter")

I'm assuming yes if you are using the latest nvme tree...

Does the issue still happens when you revert 0dc9edaf80ea?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
