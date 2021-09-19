Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846ECC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:02:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BF5611F0
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22BF5611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XLJ9P1UrrnS3ZQSLVkuLpEt0OHZuD+ybRQVsIES5b14=; b=rGlxFA5yAM2tKTY7AUNusZhupB
	398R4tz/YM9wzNoNNGJVCEGAgiIOGB2B4j2mQ7jHlSL1DvbI91qxb8WyaWdmiVKW8kT9ZyaT7zKSu
	eUqddG4qoozZMWL7x/EbAbOaB0K4sT1eCFgoS7C79LCeBw+fJ/WM8qldR2wJIe4WexBBr20816Ahq
	475TbjX54G0jgo8r55r842M1EF9FqbBRsCIEwoa7pTkypi5cvDVfqXLn+O7vO474RAosIxPQrAxLx
	VsiD1Xy9Ny+fVFOlX86UB6e4ie4zeb0f9HUfCD9rhkikIrLA1ZFGod2ZVvJiq5CknHCYixYOHYjY9
	ihssGFKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRtee-00H4gG-Kk; Sun, 19 Sep 2021 10:02:36 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRteb-00H4ft-OL
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 10:02:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id z2so1730867wmc.3
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 03:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uzlhXYrj/MO0yY+a5q5EmM2pUQnuR7pMdP+Jpjxe7h8=;
 b=S908/hA2vujb8H+XXIKenJhvCXyMUXad4sqEAQ5kag/WvKWkG0XnwAwWg8U41tX+v+
 B6UgMJHuO82g4nvbjjV508IFEqGp/Hoi1mYZkgNlyVfpgAUCtPd8o1IJPhd4fb/lJP53
 VvaoMpjE8GiKBD76LLlBgu6Rjxe9w67q5+QfJ2jmx5nvu5YD/onWw40AhOXswWg6y9WW
 +Yb5bYtlUl/QH2DzbdGpf1VDT3VQOpJnG36z3IrH3H4/St22SgHKZqDftLDhyibf+Ycz
 23V0hRw4SdikBQK0jBttTgzZdJ9pOFfH1VPpyMkKvcUhrNpU9wHGBtp/3wrVs1HDwp1I
 je0g==
X-Gm-Message-State: AOAM531bHajvASHHuKgTy+HEafDw3iMT9iJY5hZm/vstQJoX2nGa/AB+
 PdlN69yloi0dqh3E7dgVrDA=
X-Google-Smtp-Source: ABdhPJzg5dpDyByhCgQt9QN0xJKleBX2+1Aar0pTJuCgzRSyYjTATMV64zYzgxb/ey6BxBlLO3EMcQ==
X-Received: by 2002:a1c:4c14:: with SMTP id z20mr24228637wmf.82.1632045752064; 
 Sun, 19 Sep 2021 03:02:32 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c17sm15005850wrn.54.2021.09.19.03.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 03:02:31 -0700 (PDT)
Subject: Re: [PATCHv3 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <47a839c3-1c8d-9ccf-3b3d-387862227c4f@grimberg.me>
 <0ab8d79a-6403-9177-319d-ad41dfa4c41b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e9b8ff1a-59dd-d959-3ef6-176bb8fbd279@grimberg.me>
Date: Sun, 19 Sep 2021 13:02:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0ab8d79a-6403-9177-319d-ad41dfa4c41b@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_030233_851491_577492A0 
X-CRM114-Status: GOOD (  17.21  )
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

>>> Hi all,
>>>
>>> recent updates to the NVMe spec have added definitions for in-band
>>> authentication, and seeing that it provides some real benefit
>>> especially for NVMe-TCP here's an attempt to implement it.
>>>
>>> Tricky bit here is that the specification orients itself on TLS 1.3,
>>> but supports only the FFDHE groups. Which of course the kernel doesn't
>>> support. I've been able to come up with a patch for this, but as this
>>> is my first attempt to fix anything in the crypto area I would invite
>>> people more familiar with these matters to have a look.
>>>
>>> Also note that this is just for in-band authentication. Secure
>>> concatenation (ie starting TLS with the negotiated parameters) is not
>>> implemented; one would need to update the kernel TLS implementation
>>> for this, which at this time is beyond scope.
>>>
>>> As usual, comments and reviews are welcome.
>>
>> Still no nvme-cli nor nvmetcli :(
> 
> Just send it (for libnvme and nvme-cli). Patch for nvmetcli to follow.

Hey Hannes,

I think that this series is getting into close-to-inclustion shape.
Please in your next respin:
1. Make sure to send nvme-cli and nvmetcli with the series
2. Collect Review tags

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
