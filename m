Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAABC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:37:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C09208E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ahr+2VHc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwdL2HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C09208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2hv7JF6cQX4m8k/34/0Bt7QmHUEUpz+vKPYYz/lUWiU=; b=ahr+2VHcO8qAVE6sj8PJybjbr
	XJ9APKTTsiPn4htTraYJDAjAgwos3onkYf3FdpKYxhQMmea5WkS5aB7l70MznjmiGhH9aRM5VbAVh
	QuTKrKYG9EZKtOU4OiwISimPK7CAjb7NB2BZfkI1dlOxmKWarmR1tgnMoRcoSJtOjm3ekpVDRVXFe
	XoRaMElgZap8rFyfFazjPwHoD4tc2wNEkiLkgXd1MK+I7f/PQn3pr1DmDmWPOO5BMLWmH9gIk7bFO
	p9YVh1W1LJughmYWZU4QBlDET330A4NpzOF2sjIMdqnGZY9qmNxFdICpXnEUypxk5DKLoQJXbC/fJ
	RqVqchHBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJIxM-0003Fq-Vu; Tue, 31 Mar 2020 15:37:36 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJIxJ-0003EE-P3
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:37:35 +0000
Received: by mail-pl1-x644.google.com with SMTP id a23so8261433plm.1
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=AIJaewX8GfCCNVseZs66fzOQB91yKeoYu4/Ep9E7PaI=;
 b=fqwdL2HD2ynty7HmKt6Q3mkGsMmztvgSpfY+9rj4EbEx5K0xOstNlgD4sRPPsBmYMI
 jQKKxax+vROKD5bu9sAeDbd9SnI7PNjoRkgpU/kSRQuKYZd8CQBxMtAaiZNtx7e/g7sO
 iHIIBtHxmfl30ClUbVBx1Y11p+y3Z/x4wE8aieLplXMtvHRD9c20+cjdpKQCWiWRi31Q
 KTeLk20vCrEMcjKJDzFmHUdJ+R6nAIX7QapbnZBjHaJKOR046qwZhnawaCHRCOdZ1cqU
 97oNBCqUPnWr/nEaSvkYVfZJNoQPAJZj+eZtxhSqHnOTQO2xa+1prgPegntk7xFihScP
 VC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=AIJaewX8GfCCNVseZs66fzOQB91yKeoYu4/Ep9E7PaI=;
 b=FxWAYUY8Dzzu8ZUbTU7ETY2u1L+M+DYFcPjsCVKD23RgIy3Iz8px08kXvQOtcU5VTA
 ZRLV6PF+ilNIcS+xYtTV4HM7YpyWCWN1/cbA6n2zr7cvWgqlFjqWdN5eZOco70p6dAGV
 C6sB5LKDmcXw5UeYg/fo5EK4yrckgL3Eb2jUvHwJVxU/jVP0LoqPEfpYHew4A14PiByQ
 Sl8/sXwvz3TU+hdk9aZRsfcy89lwr9tFbsUQxsS4nCapiFmiO++/VTDaoUuQY0UpYeN3
 HQZV4dVFD2ZDyQLgQy8rqFwF6AA7WMKcgcxvuyGHJa969butIs/u9nX5yMz+NJoJSYm2
 0WFQ==
X-Gm-Message-State: AGi0PubV9m9DzUMSUGiUDuuL+Ev6FA+GMV71Nbjza3DojYlf4KlfGWWp
 WJVjQdarviYRAjXlURAj0rU=
X-Google-Smtp-Source: APiQypKjy8p0X5p701s5Kmd7nfiCE0gP6442ZhQ46+pvCrU9CIXn/YOOhpfWscoL/0CTifCg23RbAQ==
X-Received: by 2002:a17:90a:218e:: with SMTP id
 q14mr4578731pjc.37.1585669052603; 
 Tue, 31 Mar 2020 08:37:32 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a?
 ([240b:10:2720:5510:a182:288:3ffa:432a])
 by smtp.gmail.com with ESMTPSA id x4sm12683810pfi.202.2020.03.31.08.37.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:37:32 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Joshi <joshiiitr@gmail.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
 <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <b93e02fe-ce91-a2ee-2373-cc6bf8366da0@gmail.com>
Date: Wed, 1 Apr 2020 00:37:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_083733_824239_2A7F6596 
X-CRM114-Status: GOOD (  10.81  )
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
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <tom.leiming@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

On 2020/03/31 23:13, Joshi wrote:
> Hi Ikegami,
>
> Are you actually able to bump up the max segments with the original patch?
No as you mentioned currently it is limited by NVME_MAX_SEGS.
On the older kernel version it was not limited by the value but limited 
by USHRT_MAX.
So it was able to change the limit by the patch.

As Keith-san also mentioned currently it is limited by the 4MB and 127 
segments as you mentioned by the NVMe PCIe driver.
So I will do abandon the patch to increase max segments.

Regards,
Ikegami


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
