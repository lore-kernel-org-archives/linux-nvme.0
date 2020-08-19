Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC48C433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 19:26:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7ED12078D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 19:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fgX6mPEV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nR7G5SwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ED12078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+a/LzuIJOiXLkw9U2de7XE0e2RkYJZsdly0WtiNTfto=; b=fgX6mPEV55R+/OIro752CtHNP
	zmYVy6AdlxB72l2VYSrkONrXwByVz77uom8FrlPQBbT1w6R9+jCMw19EgmsSgDpHx6/jEXugVWO8B
	Ky3SKuTovMrNHl92hiWGfbisQl/MC1kaH8OI+3bXU62I2JGGUlwFX33j9JblK3gT/mE7Rp8mvaU42
	lEKc5hWKrEBok24XbnpG7MGiTwQoo3cSVbMK697IvBcF38SGNVEWopqFwyE3EsR6J/wc+CA5jvhIC
	PBDjUVfNRpHnFQdjkOIvu96VacjvlrKd6XxrEqxrqYeeslCWSSMi6P3pXe+0+339a1g4CeHxNapJB
	zXCKlzbcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Tig-0005rF-42; Wed, 19 Aug 2020 19:25:58 +0000
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Tid-0005q9-Rf
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 19:25:56 +0000
Received: by mail-pj1-x1044.google.com with SMTP id e4so1564125pjd.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uIHy/4+dOTIzbxPNc7n6E/xZy0w8cFL8jWiQ0sl5YxQ=;
 b=nR7G5SwFp2JNr6fuvAhbEb1o7xKTXFbeB+0VOd0exvnNhw75pIp+ZO987UkhaH7KCl
 kt1OPnfzX8XXOQntKZrAGq3pqfKbPDeKB4RyDO/DBvTuEIq3gwsuXc9J1yqb82gXjhr4
 jPaPFV/gvbpptAaLLv3YEznM/o1wZjgGklS6dY52+sTfbOS9zYUi2owz1OQqd7f9Vn/v
 B2DwrK73+KEfTU3mWrj68bpX71UhgsCbVXK1aFFeFTHJ0kOMzZVHeG1bYX25Pgfy9LPe
 5D5UmMGCQp9rJ2Txbw97Nz+dmPiqGWjC7//2sslnuoM5Jwz8xmO9fDin91pG11CTB6Ge
 KXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uIHy/4+dOTIzbxPNc7n6E/xZy0w8cFL8jWiQ0sl5YxQ=;
 b=ilYmvs+O4mvpMsVWnp3d5igBHai3BUfPTwX0qqUL6r0RUhvTvBPpc9YM0sAmJUPSru
 4/uMShL2mhIROf3q4HOsq8BPoeugs5CIFiUdS+h4N3ARkpJ/IHnZ4SsNI29EDfNA33fG
 nGWeLKyJxb+icww0ckxWgPko5zBi6SB5VkDnnZzZ48+N4QJfCsOV5gXNQS0dLlp+nuM4
 geDtDYas+0HIOU3RMxoRUmOJiXTXTo82Rc8+4E8vo7cBo1ZETWEu/Wrc1LuDznLvvq/y
 wAz2cMnnNCL4os7vvtulgOWi6wf8b8k9PJ9AfaxKuV1DGY4PhA2L5tpnnDlbVf8yAlPH
 FTfw==
X-Gm-Message-State: AOAM532qjHOEp2hnUzsHIBcbw6cZ2s+V7v+SdU72a8tBtaYBEb8keXB0
 jNj77LcVKaN0QqoCM9oY28trPA==
X-Google-Smtp-Source: ABdhPJz1lVEXLMArBIyCI0+M+EFSrZu0FfBjeeBhrzI2UstOIY8JV80nnGdwZefu7jVKH0RReO6PnA==
X-Received: by 2002:a17:902:7245:: with SMTP id
 c5mr1136646pll.317.1597865153509; 
 Wed, 19 Aug 2020 12:25:53 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id s185sm26735618pgc.18.2020.08.19.12.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 12:25:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To: david.fugate@linux.intel.com, Christoph Hellwig <hch@lst.de>,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
Date: Wed, 19 Aug 2020 13:25:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_152555_920525_2AA55BED 
X-CRM114-Status: GOOD (  20.72  )
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
Cc: "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/19/20 12:11 PM, David Fugate wrote:
> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
>> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
>>> If drive does not support zone-append natively, enable emulation
>>> using
>>> regular write.
>>> Make emulated zone-append cmd write-lock the zone, preventing
>>> concurrent append/write on the same zone.
>>
>> I really don't think we should add this.  ZNS and the Linux support
>> were all designed with Zone Append in mind, and then your company did
>> the nastiest possible move violating the normal NVMe procedures to
>> make
>> it optional.  But that doesn't change the fact the Linux should keep
>> requiring it, especially with the amount of code added here and how
>> it
>> hooks in the fast path.
> 
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver.

It's not required, the driver will function quite fine without it. If you
want to use ZNS it's required. The Linux driver thankfully doesn't need
any vendor to sign off on what it can or cannot do, or what features
are acceptable.

> It's forgivable WDC's accepted contribution didn't work with other
> vendors' devices choosing not to implement the optional Zone Append,
> but it's not OK to reject contributions remedying this.  Provided
> there's no glaring technical issues, Samsung's contribution should be
> accepted to maintain both spec compliance as well as vendor neutrality.

It's *always* ok to reject contributions, if those contributions cause
maintainability issues, unacceptable slowdowns, or whatever other issue
that the maintainers of said driver don't want to deal with. Any
contribution should be judged on merit, not based on political decisions
or opinions. Obviously this thread reeks of it.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
