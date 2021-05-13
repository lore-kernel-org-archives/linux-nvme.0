Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA364C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:55:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276A7613D3
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276A7613D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CXjYvUPdtsBbGy2fNfYaomqvMczYJ8nCafNs9kE6HZg=; b=hhDf+ykzyGE3zRxFHsz4rRtRk
	rx4zFCyfcVaqsIsS+weqgLHZysON1sXb9HI8AW7yR3iIBTr7fMp3zHRFbKrs6EhO0rmazd5hoXdMG
	dwwXnHwlHippESIqoyhZYpWSjaZfSq8nHqVCbMzH4iK90WivTM+nnXMpqywFvwMz95vqFoMolkXU0
	qHQO6h6xmTPDDtY2kMc63LaMbRwzmNLFSiAw4wW5HCHSMD5r5qIXUGlLKe9wxBu6N+2t5KSHBYR5c
	IbPATozit/uHPiy4VW4oxnV0RGNtmd16JVI8yJ9uFYXqUFrbuN41Vp6qYygF2lJSWMfAIhXDPipV6
	WA/3K5xig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhHQg-006KWd-U9; Thu, 13 May 2021 19:55:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhHPE-006KP7-Bm
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 19:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=bpebVckHJL2EJoxs4TK/xFJjh6Me8mHvPdCh+lDPDRM=; b=dytVJXv7b/omKpMiplwthmKbV3
 2gh1Hwk6WpIsGbtoNDQFWQ8mm6HPge9uMBEkGw2jV89ZESVWwDEkjn6G2PsIVFDnScbIbYAOA1aEi
 Sebk7fF2giFdNt/dgKYcy/vIOdFaGgWOh+GxSrPkH3qOwp7V43KqBgTomSnjYFeiiFGJVFQ9fhtQj
 6VhOl/4C4jQAtYbg7ehAoviL35TFpUBynxs0fCL9BhIQ4G4pRTbW6hfAeanhH/9Wn2K36xkeC7Ulf
 xaOBPD3hO5Z/YADfLtQ+BmbBSP70Jv7fxtutph1cPoRUih1QeN0FVid+338KEl7nnYvPgCob5+P5I
 5J13otyw==;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhHPB-00BUNb-KS
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 19:53:59 +0000
Received: by mail-pg1-f170.google.com with SMTP id m190so22463562pga.2
 for <linux-nvme@lists.infradead.org>; Thu, 13 May 2021 12:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bpebVckHJL2EJoxs4TK/xFJjh6Me8mHvPdCh+lDPDRM=;
 b=fBweKpe9YgCCw5hOsUGV6Mc3RHSZTw2DTCNu44tKp0UgSy3Hy19NiRB/KWwe/w5Mwc
 20tkQkTIs+ha5fqSk30msb5wd24TiqxOPVT1vcG6pVqS5uOtcSDYFvGpdwqeBnjtWVhR
 sDbyxBPiwIsEAXn4Xsl2610HX0KMkIcIl7V3i6Xb7vG4Q3uoetqhHBou5SA71Shd1a06
 CRLIE+llYiIrpL4ocmhMIruahG1FBKTkvYno2dcE6qV3To0smWsxKOBQv2c/MdsYiwOh
 GmFBHQkQyocjo/u7g3duOxWewmKWixMiYINGwe7Brx6O0CMHLHbt3tVYOyPaK+TjKwe+
 jmZA==
X-Gm-Message-State: AOAM532ZMffgMhGEVqg58fWf4enUBl3IJ9+ztP6r3csMa/c1Qtp41avk
 01FrbqyGRsvfz0n1Zq666hEvjQJxKu4=
X-Google-Smtp-Source: ABdhPJxVtvR4vbV6kmWRkNsDqUnglgSzJ6W/Dsi2QM7TmB4y/gAphVFzzr9wuzD7yl9hHEhM6tiYng==
X-Received: by 2002:aa7:90d4:0:b029:28e:b912:acf with SMTP id
 k20-20020aa790d40000b029028eb9120acfmr43425164pfk.43.1620935636598; 
 Thu, 13 May 2021 12:53:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:fbea:aad3:995d:b40e?
 ([2601:647:4802:9070:fbea:aad3:995d:b40e])
 by smtp.gmail.com with ESMTPSA id t22sm4985048pjr.43.2021.05.13.12.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 12:53:55 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
 <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
 <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
 <88879279-fff5-b26c-2c1c-52a700a1c40a@grimberg.me>
 <20210513154819.GB2272284@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68ca75e3-2e0a-c0d6-c6cd-ab4d7467c0ad@grimberg.me>
Date: Thu, 13 May 2021 12:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513154819.GB2272284@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_125357_705574_BCBADD66 
X-CRM114-Status: GOOD (  24.53  )
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



On 5/13/21 8:48 AM, Keith Busch wrote:
> On Tue, May 11, 2021 at 10:17:09AM -0700, Sagi Grimberg wrote:
>>
>>>> I may have a theory to this issue. I think that the problem is in
>>>> cases where we send commands with data to the controller and then in
>>>> nvme_tcp_send_data between the last successful kernel_sendpage
>>>> and before nvme_tcp_advance_req, the controller sends back a successful
>>>> completion.
>>>>
>>>> If that is the case, then the completion path could be triggered,
>>>> the tag would be reused, triggering a new .queue_rq, setting again
>>>> the req.iter with the new bio params (all is not taken by the
>>>> send_mutex) and then the send context would call nvme_tcp_advance_req
>>>> progressing the req.iter with the former sent bytes... And given that
>>>> the req.iter is used for reads/writes, it is possible that it can
>>>> explain both issues.
>>>>
>>>> While this is not easy to trigger, there is nothing I think that
>>>> can prevent that. The driver used to have a single context that
>>>> would do both send and recv so this could not have happened, but
>>>> now that we added the .queue_rq send context, I guess this can
>>>> indeed confuse the driver.
>>>
>>> Awesome, this is exactly the type of sequence I've been trying to
>>> capture, but couldn't quite get there. Now that you've described it,
>>> that flow can certainly explain the observations, including the
>>> corrupted debug trace event I was trying to add.
>>>
>>> The sequence looks unlikely to happen, which agrees with the difficulty
>>> in reproducing it. I am betting right now that you got it, but a little
>>> surprised no one else is reporting a similar problem yet.
>>
>> We had at least one report from Potnuri that I think may have been
>> triggered by this, this ended up fixed (or rather worked-around
>> with 5c11f7d9f843).
>>
>>> Your option "1" looks like the best one, IMO. I've requested dropping
>>> all debug and test patches and using just this one on the current nvme
>>> baseline for the next test cycle.
>>
>> Cool, waiting to hear back...
> 
> This patch has been tested successfully on the initial workloads. There
> are several more that need to be validated, but each one runs for many
> hours, so it may be a couple more days before completed. Just wanted to
> leat you know: so far, so good.

Encouraging... I'll send a patch for that as soon as you give me the
final verdict. I'm assuming Narayan would be the reporter and the
tester?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
