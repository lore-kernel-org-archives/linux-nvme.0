Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B57C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 11:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5528360EE1
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 11:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5528360EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86Y098jpC3aLmM3YA7YgkkNFl5PyHQpJZT7r3xbeJaQ=; b=fdPWdgFbaRDHo4qF0MoNihdPWP
	RYkdedmRND+16hWFByd2o3JK/f9iv6NlqLVEPIbpegZ/gBb8L1vzBv++ZKGcxvNDACS+UYac7gxNg
	8SJaLt0ytOp2UALNrvmh818zL4u8Hoxbh5HOT22Euu2entMGrsfcTWHelSFvkKxrv1b8TXEXyVgM4
	OIeI7DACvlOl/D5zqZvX0bBn3Vk/5MRsOnlwYLp0k+rxjS25A/jyxeytzCL7elyBe+fLeTiIznRb2
	NlId7gIRzpegSTA5eLLQxYQEMEKUvhEsQGl1fd8r8/W8lbxX3XJQRl2JbsoA5It8ADNH0cpE0Q105
	vmKktKDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNCY6-000c6f-BU; Mon, 06 Sep 2021 11:12:26 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNCY2-000c6I-HF
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 11:12:24 +0000
Received: by mail-ej1-f44.google.com with SMTP id h9so12815852ejs.4
 for <linux-nvme@lists.infradead.org>; Mon, 06 Sep 2021 04:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uZnm5MAYGAX01bAOanAA8RFN41axKtb3ILJ2ww4uSIQ=;
 b=RdvgYqMQI3Vm6qpvszrtWHtAc7jfJ4sUHaLsLwrUTjltwaaHAf+e7vW8gkh/FuB5gR
 pInnJ4xGsyk/vqJ2z/ypU5boGQFy2oyyM59XSCXTAn0pVG2pF/V4kWSF9CJr8pUo1/no
 iwlmhbsx4RLN6X4aThnyQXHKs6F5+/pyewyMJj1HKWMNK3k77dkyXZHnJAQBPslc0y5O
 l4WUU6yLXPGSGiQ8476xEscUavFoUTjn5kilb/B7DjUbdxhhbkpwjc857ctpzmfc+z23
 8tZIsASiiIo67l/DN8RoYByQqQeSw1SV/CP0EKdtwvBOrEOqsuCbS/vRuDZkPOMiDXt8
 uENw==
X-Gm-Message-State: AOAM530bv9CpbvG9tEyVrenGpDtSiPEvXbaPc9zRtL5TvpiCKNkzl2Oh
 ZCOmrZqYQT2+yrTtD5jYgDhAmOmC48w=
X-Google-Smtp-Source: ABdhPJwANoqGuYDiAAR8nkwzfpif00EpE4Ax8zPfHARakofDBubWrXuGhvOUwtgkIvE5X639YEwiYw==
X-Received: by 2002:a17:906:4fd6:: with SMTP id
 i22mr13149516ejw.92.1630926739807; 
 Mon, 06 Sep 2021 04:12:19 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id h30sm4473272edz.40.2021.09.06.04.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Sep 2021 04:12:19 -0700 (PDT)
Subject: Re: nvme-tcp crashes the system when overloading the backend device.
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
 <11cd3514-570a-8bf1-55f7-cda6cacc7124@grimberg.me>
 <2E0B97E4-8182-4EF5-8D90-DA4998C58295@primelogic.nl>
 <06beadce-b135-f1ac-094a-8262ea37fe86@grimberg.me>
 <27377057-5001-4D53-B8D7-889972376F29@primelogic.nl>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <21d75c78-c73c-163f-004c-01a3b29632cb@grimberg.me>
Date: Mon, 6 Sep 2021 14:12:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <27377057-5001-4D53-B8D7-889972376F29@primelogic.nl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_041222_628041_63C86AAD 
X-CRM114-Status: GOOD (  15.07  )
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


> Hi Sagi,
> 
> I installed a recent kernel on the system and restarted the test.
> The kernel is: 5.10.57
> 
> Before the kernel would crash, I stopped the test by disconnecting the initiators.
> "nvmetcli clear" did not hang and in this case, it still managed to remove the configuration.
> 
> # ls -l /sys/kernel/config/nvmet/ports/
> total 0
> # ls -l /sys/kernel/config/nvmet/subsystems/
> total 0
> 
> However, after this I still see nvmet_tcp_wq workers that are actively running:
> # ps aux | grep nvmet
> USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       163  0.4  0.0      0     0 ?        I<   02:28   0:21 [kworker/24:0H-nvmet_tcp_wq]
> root       199  0.0  0.0      0     0 ?        I<   02:28   0:02 [kworker/30:0H-nvmet_tcp_wq]
> root       355  0.0  0.0      0     0 ?        I<   02:28   0:04 [kworker/56:0H-nvmet_tcp_wq]
> root       361  0.0  0.0      0     0 ?        I<   02:28   0:03 [kworker/57:0H-nvmet_tcp_wq]
> root       683  1.2  0.0      0     0 ?        D<   02:30   0:56 [kworker/53:1H+nvmet_tcp_wq]
> root       785  1.0  0.0      0     0 ?        D<   02:30   0:44 [kworker/59:1H+nvmet_tcp_wq]
> root      1200  0.1  0.0      0     0 ?        D<   02:30   0:08 [kworker/27:1H+nvmet_tcp_wq]
> root     29212  2.0  0.0      0     0 ?        I<   03:28   0:18 [kworker/31:2H-nvmet_tcp_wq]
> root     32691  0.0  0.0      0     0 ?        I<   02:31   0:00 [nvmet-buffered-]
> root     39437  5.3  0.0      0     0 ?        D<   03:32   0:35 [kworker/51:3H+nvmet_tcp_wq]
> root     39440  1.8  0.0      0     0 ?        I<   03:32   0:12 [kworker/59:3H-nvmet_tcp_wq]
> root     39458 13.3  0.0      0     0 ?        I<   03:32   1:28 [kworker/18:3H-nvmet_tcp_wq]
> root     39508  7.1  0.0      0     0 ?        D<   03:32   0:47 [kworker/53:4H+nvmet_tcp_wq]
> root     39511  2.7  0.0      0     0 ?        D<   03:32   0:17 [kworker/28:5H+nvmet_tcp_wq]
> root     39520  7.7  0.0      0     0 ?        D<   03:32   0:51 [kworker/52:3H+nvmet_tcp_wq]
> root     39855  4.3  0.0      0     0 ?        I<   03:32   0:28 [kworker/48:4H-nvmet_tcp_wq]
> root     39857  3.0  0.0      0     0 ?        D<   03:32   0:20 [kworker/28:7H+nvmet_tcp_wq]
> root     39902  6.3  0.0      0     0 ?        D<   03:32   0:41 [kworker/27:6H+nvmet_tcp_wq]
> root     39928  5.3  0.0      0     0 ?        D<   03:32   0:35 [kworker/25:9H+nvmet_tcp_wq]
> root     39963  8.8  0.0      0     0 ?        D<   03:32   0:57 [kworker/24:6H+nvmet_tcp_wq]
> root     40024  3.3  0.0      0     0 ?        I<   03:32   0:21 [kworker/28:9H-nvmet_tcp_wq]
> root     40087  6.3  0.0      0     0 ?        I<   03:32   0:41 [kworker/53:6H-nvmet_tcp_wq]
> root     40169  6.1  0.0      0     0 ?        D<   03:32   0:40 [kworker/59:5H+nvmet_tcp_wq]
> root     40201  3.5  0.0      0     0 ?        D<   03:32   0:23 [kworker/54:8H+nvmet_tcp_wq]
> root     40333  0.6  0.0      0     0 ?        D<   03:32   0:04 [kworker/59:7H+nvmet_tcp_wq]
> root     40371  0.4  0.0      0     0 ?        I<   03:32   0:03 [kworker/49:5H-nvmet_tcp_wq]
> root     40375  2.5  0.0      0     0 ?        I<   03:32   0:16 [kworker/20:8H-nvmet_tcp_wq]
> root     40517  0.4  0.0      0     0 ?        I<   03:32   0:02 [kworker/58:6H-nvmet_tcp_wq]
> root     40811  2.8  0.0      0     0 ?        D<   03:33   0:17 [kworker/51:9H+nvmet_tcp_wq]
> root     40864  1.5  0.0      0     0 ?        I<   03:33   0:09 [kworker/29:5H-nvmet_tcp_wq]
> root     40891  1.7  0.0      0     0 ?        I<   03:33   0:10 [kworker/17:9H-nvmet_tcp_wq]
> root     40902  4.3  0.0      0     0 ?        D<   03:33   0:25 [kworker/59:8H+nvmet_tcp_wq]
> root     41061  3.3  0.0      0     0 ?        I<   03:34   0:18 [kworker/51:10H-nvmet_tcp_wq]
> root     41145  2.6  0.0      0     0 ?        D<   03:34   0:14 [kworker/56:7H+nvmet_tcp_wq]
> root     41278  1.3  0.0      0     0 ?        I<   03:34   0:07 [kworker/22:9H-nvmet_tcp_wq]
> 
> I've attached dmesg.txt as requested.

The dmesg output seems incomplete, I'm missing the nvmet-tcp threads 
that are blocked. Do you have this output in the journal that you can share?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
