Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B43C4332E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 02:33:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C65A820768
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 02:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DjkqWRrC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WZxieGRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C65A820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0PIYY05PAX1/8qP5sr5kfKdtOj9seLlWlcAIJMHpjBY=; b=DjkqWRrCEugIa3K6ZSGUYYFPrK
	1xuYZgYlYTI7Qa4CbBbBTkro71M/ZOJyTwZyqciJgleHn9MCZ/hnouYyF1mgOWfOAxoXFU656VEbM
	oxbMIqnH0s+z+cV/HcDllS46ujkuxMAQsmf536BisIIEFKpfWxPw8Xe16umazS8JpxbMpfldC+fPb
	llsVCqbZXq7xgE0UmeinaL3b5ef1Ofp4yP1z16C8edx6S94kDdhps7/KsGH9RDz7fmWlJmwLglDy6
	O5bbhWoUwoTfQAenRiLruT7g8t48DG75SKOR9vKoc5WWuG6/NtbT3DUTgV5mTmG/ummPq7HKxO5QT
	WIcLoOLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEkzq-0006HT-Rv; Thu, 19 Mar 2020 02:33:22 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEkzm-0006GP-GM
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 02:33:20 +0000
Received: by mail-pg1-x541.google.com with SMTP id 7so372828pgr.2
 for <linux-nvme@lists.infradead.org>; Wed, 18 Mar 2020 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=EjNVr9kFH7X30sMQJNTPUOYsjcy43wz9zEQJSbFTct4=;
 b=WZxieGRujikBim2qam4pIwU7e/9eF4+fkH5NeJ5q+Vtvt5sYaYvF1NWMNTQHn/RCrk
 i6u8zQ3l3La6ZdTyk7K47ZcRROSYo75Te5+ttVrYVGNICaQ28XB3FUf7T182RKhEjJFW
 hWFrRk5t8xzTq3iUxIsmEHdfY1MkjI1XgbQwWL8tVdnVDFCO4Wy5kY81JWX2MNDXNdtV
 2r9PhIE52EyTMYHHV0jDRd8ZdX0q5X1rdA2ZFl8P8nqAYgUarmWIbPu1WLPUE8pJYAJw
 zLNPdZ1pFSu3CwsdMS8knbtXiolSrYaJf1d6IpT6k8ISR+OQzdacnckt0584DiBOo1kk
 RXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EjNVr9kFH7X30sMQJNTPUOYsjcy43wz9zEQJSbFTct4=;
 b=tVlo/Elaum6qCtg8zufttMO29iWBa3MpMXaLDwxE52X6BAFMCj9onYoq6hmfTnfosp
 SSq8n3oJnJCYl0G/J7bem0EOei+qYgo7H3huOrv85xCMJhfUV6/0sUtdrtgEtVamIwDN
 2rt/U+ALPwdD4oDripRpPYYcusIOQr3qj0gRieb2v8SFmKl2Pw96zjSvM758Ggv1wZVr
 fQ7fZv04kwOy4cfaTtjQBIfcnX/FrRSIdR6S42OOlbO3JrNohxUzc2QRMSoXCw6VmYX5
 0Mp2kamr44LmZAzN6RUF/JLBu8Cn/1j79lMz3aQK51rYccNIKrwh6VXZtULfq3VUTHS/
 /rpg==
X-Gm-Message-State: ANhLgQ1Rcu+hoKO8fYWOEzt/1/rpQ02xYKnCl/F+kNSJ5iJ/OA6XXAKs
 P2aWmHsbPSdWpve5f15w8L9NLPzOJlPKlA==
X-Google-Smtp-Source: ADFU+vtz7WrmweFNNYyorhHQKr/MzlOa8y488KkXa+sklGKGHmGLv5sdYhmbKn98CgXina7J0BHUjA==
X-Received: by 2002:a63:1547:: with SMTP id 7mr840741pgv.353.1584585196556;
 Wed, 18 Mar 2020 19:33:16 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
 by smtp.gmail.com with ESMTPSA id f23sm257799pjp.35.2020.03.18.19.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 19:33:15 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a09f5d36-63f8-ceaf-da3e-743ca88dd537@kernel.dk>
Date: Wed, 18 Mar 2020 20:33:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_193318_599599_D2509BE4 
X-CRM114-Status: GOOD (  12.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/18/20 7:12 PM, Sagi Grimberg wrote:
>> If I turn on FIO verification options ( --do_verify=1 --verify=crc32c ) I see the following fault for same 512k write I/O pattern:
>>
>> [ 4850.021884] BUG: stack guard page was hit at 00000000291034b3 (stack is 0000000040c9cc3e..00000000e65d9875)
>> [ 4850.022471] kernel stack overflow (page fault): 0000 [#1] SMP PTI
>> [ 4850.022829] CPU: 3 PID: 3744 Comm: fio Tainted: G           O      5.5.0-rc2stable+ #56
>> [ 4850.023298] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
>> [ 4850.023742] RIP: 0010:memcpy_erms+0x6/0x10
>> [ 4850.023982] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>> [ 4850.025087] RSP: 0018:ffffb8ec09557b68 EFLAGS: 00010206
>> [ 4850.025392] RAX: ffff943ef5c2d840 RBX: ffff943ee9216500 RCX: 00000000000003e0
>> [ 4850.025808] RDX: 0000000000000800 RSI: ffffb8ec09558000 RDI: ffff943ef5c2dc60
>> [ 4850.026225] RBP: 0000000000080000 R08: ffffb8ec09557bd8 R09: 0000000000000080
>> [ 4850.026640] R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
>> [ 4850.027056] R13: ffffb8ec09557be0 R14: ffffb8ec09557bb8 R15: 0000000000080000
>> [ 4850.027472] FS:  00007f5db8053700(0000) GS:ffff943eff040000(0000) knlGS:0000000000000000
>> [ 4850.027944] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 4850.028279] CR2: ffffb8ec09558000 CR3: 000000203a052006 CR4: 00000000007606e0
>> [ 4850.028695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 4850.029111] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 4850.029527] PKRU: 55555554
>> [ 4850.029684] Call Trace:
>> [ 4850.029834]  io_setup_async_io+0x51/0xc0
>> [ 4850.030065]  io_write+0xe4/0x220
>> [ 4850.030256]  ? get_page_from_freelist+0x43f/0x1220
>> [ 4850.030538]  io_issue_sqe+0x419/0xac0
>> [ 4850.030752]  io_queue_sqe+0x13b/0x620
>> [ 4850.030967]  ? kmem_cache_alloc_bulk+0x32/0x230
> 
> This one looks related to io_uring and not nvme.
> 
> Jens?

Looks like you're running 5.5-rc2, which is a somewhat odd choice. I'd
love to see if this reproduces in 5.5 as released, or current 5.6-rc6. I
think this looks like an issue that was fixed previously.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
