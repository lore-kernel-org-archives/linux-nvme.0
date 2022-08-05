Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BC4C00140
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIUZUvMby+ZyQyN2vJN1//RsIIyzMxAERYvdZ48hCdk=; b=iB32eryzNfaXr0gT4oNd6vQGfP
	/8xjUxACUiqDsCMUoJFHmVL8aPXnaRTFVWCy8J5NsbdelfnC/85u2st6dZc8T4vPkaTIivDLxIFcJ
	FHwQLazP+zZ0bqfar8HDAf/mGAwHqJjbKNZULrLwZ0MPwEHd+z1Nbh0XEdKWTiCKAcOpxO07rcQeb
	Gj4D7TwyzNhjYXGdlAV45oZ8hvAs3gHixwuN381Zvu6w2nx9lSB99fvmwAtLD+3qNLlnOoCK2hMAy
	uWkAsqcsWxHRICDouU1ksuTbIbM2wlMj72a8BV7SdCjHVX4APTRpMEgrSQudUcrOv6X9Rjl2XRP1V
	yvdG15sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0kO-00GvC1-Kv; Fri, 05 Aug 2022 17:04:28 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0kM-00GvAl-0z
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:04:27 +0000
Received: by mail-il1-x12d.google.com with SMTP id g14so1635213ile.11
        for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZIUZUvMby+ZyQyN2vJN1//RsIIyzMxAERYvdZ48hCdk=;
        b=YIEynqiapoixqpHcZWa8r1skf5vp4fTwhH+J/Cy704O4HU99vSjRMr3UerTJI9Kl2w
         y2zExzgk80ARkfq9Oa1mm8b/ygM3HLHBCGV/9g5/DEglijwACbQ0/waV7pDdb7TKlOL5
         9Fo25m5eqTbc+wobpJaCoypLr+O+Vd0QHsx3QiPWKOjfEySCNqeJHD/D95JcGu359bmt
         UiT2JTzoPNaSQ+T78knE1ZupHEXeEtzrGD8y8YE3kip6+grY8nscqmVqQP5sJSDTah9e
         YUHvtJfJP14Nck80d9nZjHSRAWpYUgqZXJUVDf4rqKvsNHc2IHC05EaK3KxDiCrliuPi
         sRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZIUZUvMby+ZyQyN2vJN1//RsIIyzMxAERYvdZ48hCdk=;
        b=CHU+PcnuRA1XXT7NbNDV8y7pwQyHGdpqZCTNNleE/vN0Yt4b0/jqAzB6Mei8AOLqr1
         TTWBBjCUZAKW4RAJDuXMkWkJX5GkPf7iXbGiwwvt/xE+sVZg+NbSfuvhvQ7s9oaqBVVU
         O/bf4TEAgp3L8YT+CUHQMMi2qopK6n6rxpTthzbG+T5N0lczNI1H2u+/jszfHl4unkkC
         ob6oumo1DbvZ39F6YEc6564MxiVxjdHW/NGQeCbwJ5HxyO77m5RgtKvxVuASaA4SfDS/
         sNXVvX6GO38+ZGLotmX2MHNS3qtG74eUW7ecohZtyXMOAkmwpSTyMbISaQmS67ELqoZR
         Ya1A==
X-Gm-Message-State: ACgBeo195QAfSigzaD2mc9TbOwUH2RZSE1m9fwutWL32weGfUcgADxXL
	jZyq5qKxhs+LEMABSxwBuzmdMQ==
X-Google-Smtp-Source: AA6agR5xKX/nXXAojsu4XbbnE0kxe6LIuRhdXZFmET/3IRGkXG2CeEEtkygBzNhemE04dhCtVhJraA==
X-Received: by 2002:a92:ce50:0:b0:2dd:dc8e:1f36 with SMTP id a16-20020a92ce50000000b002dddc8e1f36mr3729145ilr.34.1659719064178;
        Fri, 05 Aug 2022 10:04:24 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i21-20020a056638381500b003428115672fsm1888782jav.30.2022.08.05.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:04:23 -0700 (PDT)
Message-ID: <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
Date: Fri, 5 Aug 2022 11:04:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
 gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220805154226.155008-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_100426_094053_2F09D75D 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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

On 8/5/22 9:42 AM, Kanchan Joshi wrote:
> Hi,
> 
> Series enables async polling on io_uring command, and nvme passthrough
> (for io-commands) is wired up to leverage that.
> 
> 512b randread performance (KIOP) below:
> 
> QD_batch    block    passthru    passthru-poll   block-poll
> 1_1          80        81          158            157
> 8_2         406       470          680            700
> 16_4        620       656          931            920
> 128_32      879       1056        1120            1132

Curious on why passthru is slower than block-poll? Are we missing
something here?

-- 
Jens Axboe


