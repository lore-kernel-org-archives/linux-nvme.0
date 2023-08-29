Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B24C6FA8F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58tJu8HS3Uk+gerFXyZAfcbbsx2SaXKrB/OzNfMroZM=; b=g8mI8CDy/ZYUsBRoLUIqxwCkTv
	KGD71wYyy8RtDldjgZ6J2LGDGKabI+eFoTalENgXQUtRvSoKkieKFOkUr/s+lWXbHuiqzcGyc2WSg
	PyStQuuIiZ7/dbK5rH7O7HZo8wxhIKZv2MlpLYi1O9CnZUr7XHeEIRc4Za7KUGsRqiKrs1uVpUabv
	GM1uM24QcVlzC78VYnmlvrBoPbaZskBYa6KvgCZshB3rohBQZjyAxdr5sOrP451V7FDR3ZIorJs3c
	bXuEAm8V/fD7ybmAKpGhKzwjSc+0nZcfK2Kc3FIjslQNW51c634bpazLxetkUDjgL+3xNsdVKO6ni
	q371OM6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaysw-00BcVb-0L;
	Tue, 29 Aug 2023 13:35:58 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qayst-00BcV3-1t
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 13:35:56 +0000
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68a440a8a20so3788593b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Aug 2023 06:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693316154; x=1693920954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58tJu8HS3Uk+gerFXyZAfcbbsx2SaXKrB/OzNfMroZM=;
        b=K5kafjupIqhWGvxKvYs1AIx5CE7WCR7Xp8iK9NEvMbcKfs76XyrHGNgDRVdNFg5Lhc
         VGJrwGjket4pXggjjCB4jCw5WagldDlHdclvju7FKN82nQetw+OyFe/ZRlzM8TvrfPwA
         K5vFHI45TC5Y3IHQ6Dzua+tX9YU1Q2r7FrqohzJ/q8vhbeH1h8LUgq2idioMwZncfrs6
         GwwPWwwIx1v/6GTSZQ2vmWKMtQb1MSNnwSLj8gBWcS3F/22qAAY/5Qdk3tuguBbDDydb
         tYH51TrWnjMQa/49saz7koqDKVvMqvzgTg0Y6lDW1SRAi7JLLIbR/9B8m7M5co4jJ7TU
         e4Xw==
X-Gm-Message-State: AOJu0Yxh/XUZN/b2BpMBUua5XnrxVndds90NVwgIZ/f1HwUD/RZ/k1cT
	fn4YajgM84PHb1cTYZRFRoE=
X-Google-Smtp-Source: AGHT+IG9aL/VbyawH5cxLpKPv48bF/ifjtaCOBxvr16QlUWtHvl9BmANrS6abaZiiejyKlhA6FbCiw==
X-Received: by 2002:a05:6a20:6a05:b0:13f:9cee:ff42 with SMTP id p5-20020a056a206a0500b0013f9ceeff42mr35105172pzk.41.1693316153610;
        Tue, 29 Aug 2023 06:35:53 -0700 (PDT)
Received: from [172.20.4.71] ([208.98.210.70])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79156000000b00666b012baedsm8485174pfi.158.2023.08.29.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 06:35:52 -0700 (PDT)
Message-ID: <3b5b246f-386d-4afe-a20d-4b08770bd4cb@acm.org>
Date: Tue, 29 Aug 2023 06:35:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>
References: <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
 <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
 <xz7rnke52xu3anmnjliybqv4yk3w367noo6ipguarkec6u4i5g@7bqtovmc3gjb>
 <d6ec4e54-1ec9-648a-ce8c-1e08a439c3c6@acm.org>
 <ckuewnzuiejug6jbuxfw4viqwf4v43pq54mj4k4qbq7uz3zwpn@3iijcby24ujd>
 <8ffb6c2f-0836-4302-82b9-902e092e537c@acm.org>
 <txsyjpcxb3baog5fgqdnm5hh765nt5qcbcmllsto7uulyzr5kn@zirmqldhosbi>
 <ed518b56-a579-49bb-b2bb-220214ef6e2e@acm.org>
 <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ptqdqjo7xt5qsijmuftmboutck5bpwm2wjrwks5lr4l44ssvjy@iurtgbaxnoji>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_063555_620474_85AFE000 
X-CRM114-Status: GOOD (  14.03  )
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

On 8/28/23 19:11, Shinichiro Kawasaki wrote:
> This is the unclear point for me. Does bash really pass the arguments list of
> the caller to the callee when functions are called without arguments?
> 
> Looking back the commit 852996fea4f1, you explained that bash does, and I
> agreed. But now in my environment bash doesn't. I tried the script below in my
> environment, and see nothing printed.
> 
>    funcA() { echo "$1" ; }
>    funcB() { funcA; }
>    funcB foo
> 
> Then the arguments of funcB is not passed to funcA. How does it run in your
> environment?

I see the same result that you see. It seems that I misinterpret the 
text produced by shellcheck if it reports warning SC2119. After having 
reread https://github.com/koalaman/shellcheck/wiki/SC2119, I'm OK with
suppressing warning SC2119 because that warning doesn't seem useful to
me.

Thanks,

Bart.

