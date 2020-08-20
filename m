Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URG_BIZ,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57822C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27439208A9
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 17:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UXbtUwLv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e+je4UI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27439208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WMcuyF+SnvjXkuzzCLj1PyJrj9rIEA55vDr+3P2vGHc=; b=UXbtUwLv3eCs/TsWA/9vgDwuo
	XxrOql0tzTRB7F4QCxg/XGNLN9kQ4H3szZmCu08etQ3KiOWv45cYaLbjl3dOHXgT1nGT0CQP6m6J2
	pfonMVBA3G0yMrYGKjduodZaE8otSACubzDP0sZgzAwyiIq5pBB1eAnts/JLXhi7cvlC7lCEhrY1G
	jcEwppOSN33oSsHeM9HfqrtBNahr3I3eAlmvvG7S7Mc4Vpl75EpyTpy/5WgvxyH0b+CO5fNrmDwvx
	hJhy+ynbJfcFyH7zqsbk6Hk6yBaC72UsZ1JDI2L4/p61nJaAVopWFwi55LFEJ9GWe9Uj+v+IWJ9KA
	3j+QhcQWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8o5k-0007EF-5J; Thu, 20 Aug 2020 17:11:08 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8o5f-00076R-RQ
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 17:11:05 +0000
Received: by mail-pl1-x642.google.com with SMTP id z23so1180134plo.8
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g1Ec2aiSR8okAneKzTV7deaJgayy3R6pU4u3Zwp9mDs=;
 b=e+je4UI0ndDKcz0RqGNYIBM1E772hGkzCepSNoniXi1pWUiOoO5030WpiDTNtD4AT5
 bfrvuv3vOFaz+NNSJvf+ogjla86OHNaeGpdkXnl6i+chnNw5pcUHySN36TYloJz+hpwj
 3GBjF3CWG3QxqX3IPkW9DBAo6OxcKyOZFcpJ2MEVKXnmRwlYgf2Yur42t8vpT04uVt13
 Ue1HXAXY33cf5Omr2OG31Hegf46c9RB8RN9CMcJMdC8Cq8SkH8DgOOSLClXHjRth6nij
 Abf3lCW4PFvP7sPiNNsgcsVehPu1NReG2Vp6u+pO85EyMjp38XAknC6/I/Y6/osIzx+6
 3A3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g1Ec2aiSR8okAneKzTV7deaJgayy3R6pU4u3Zwp9mDs=;
 b=doGBI/Ne/8xVhRNnf7T022gP2+l0qbqoWuh6pTP08Dn5bcDJA86A/cRmSINoxk3RBi
 VlCDrZrgSA/XEx8SfJZLOOdtpRERUe106JpDx5J/ozzyiIVGB2KY4zpeKwQNiIMfLeQM
 W7BP/+2aX1k+bq6sk7fU5LvsiKG5lW8KZjP54sg5RkxilkeTg9L9wfg7CafFDV72gsWx
 3JFo1JhaGJQbZAQkTMQYpF0JR5pvc1LXa4ctwDFhFKPHGuByYnTwv01zWNDEndQ7Qpt7
 R+/OoWOlEJGtRxaZHWcFcACjGeq3Zaigai/Le/s5CUBIAT9l8tzphmXMOYK0gTLTjSpu
 ZFyg==
X-Gm-Message-State: AOAM532C3sGSOjP4+9WjBAf/CHilrp1vcEwEY8edkMjSp7aS1lYzcSsh
 HqZJqqJMVW6NNIGWnZr438I0ag==
X-Google-Smtp-Source: ABdhPJxkWxe6AXAe6q7sC+LDEE67yFQYFltAU31qIhU8qyLH8/0NRVaS1sJAZ+l++iZBiwrbalZdjg==
X-Received: by 2002:a17:90a:d3d4:: with SMTP id
 d20mr3103117pjw.111.1597943461135; 
 Thu, 20 Aug 2020 10:11:01 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c1::16b5? ([2620:10d:c090:400::5:609b])
 by smtp.gmail.com with ESMTPSA id g15sm3463099pfh.70.2020.08.20.10.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 10:11:00 -0700 (PDT)
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
To: "Ahmed S. Darwish" <a.darwish@linutronix.de>
References: <20200817135011.GA2072@lx-t490>
 <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
 <d077aec4-d79b-b52e-cdd9-bcc89fbbde5f@fb.com>
 <2356f514-9408-6a6f-871d-046984963533@kernel.dk>
 <20200820170729.GA4116@lx-t490>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <83a3d1b6-1eb5-859b-3c5c-287d8d18a99b@kernel.dk>
Date: Thu, 20 Aug 2020 11:10:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820170729.GA4116@lx-t490>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_131104_018911_E6AD6072 
X-CRM114-Status: GOOD (  21.72  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/20/20 11:07 AM, Ahmed S. Darwish wrote:
> On Thu, Aug 20, 2020 at 09:35:38AM -0600, Jens Axboe wrote:
>> On 8/17/20 9:58 AM, Jens Axboe wrote:
>>> On 8/17/20 8:56 AM, Keith Busch wrote:
>>>> On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
>>>>> Hello,
>>>>>
>>>>> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
>>>>> laptop. PCI nvme detection fails, and the kernel becomes not able
>>>>> anymore to find the rootfs / parse "root=".
>>>>>
>>>>> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
>>>>> fixes the problem and makes me able to boot v5.9-rc1.
>>>>
>>>> The fix is staged in the nvme tree here:
>>>>
>>>>   http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
>>>
>>> That would have been nice to have in -rc1...
>>
>> And now we're getting very close to shipping items for -rc2, and it's still
>> not in. Can we please get the nvme pull request out for -rc2?
>>
> 
> I keep wondering that myself. Completely breaking the boot like this is
> really not nice -- and for x86-64 laptops no less :-(

To be fair, I've only heard this one complaint about it, so hopefully it's
not too widespread. I'm on an x86-64 laptop myself with nvme, and it works
just fine :-)

> The fix is really small and isolated. "Urgent pull requests", containing
> only a fix or two, were created *exactly* for this reson...

Totally agree on that, it should have gone in for -rc1. This will be going
upstream tomorrow, so the end is near...

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
