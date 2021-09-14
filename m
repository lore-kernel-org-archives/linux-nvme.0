Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B3C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:28:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0825860F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0825860F4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bNnk50qWDFdnIrZRekiZF1iZbhQfTKgMdXR3YtE7+kQ=; b=yCg7RY/NJ2zTLp/LVcTWzMx1pu
	oywHpEbT/e7tg2xkEofP7muqHx+VANVelloY9yBv+6LHcZWeHr68UIEgS+FJlG0YPrUfsSfa3witY
	+xrHPzFFvjzO6R4BkDZ7IidTrnEhbIDOz4Mb/f+zkRt7YOdItM6FWl41QvUEAmRCqIQcgj5mqba1v
	Ufda6Mrzqrk0Of61wJZutU7UufJ878WQlXlUEjj4efUD0QwZhshmHE5dO1KykqvmvJlG5LzlUlE4p
	nryZCAq2+VTeIpUrEq6M+ok/DowYtZYtHyp2W0MqPDnMeHh0Kb9n5YWzFNxNK/o5GDp3PsbcFjCol
	hkRK65WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ1vY-004H4x-5s; Tue, 14 Sep 2021 06:28:20 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ1vV-004H3r-4O
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:28:18 +0000
Received: by mail-wr1-f42.google.com with SMTP id i23so18351469wrb.2
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 23:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Le/a7KU710BF4NpFUmP4zYcVt90DYu9Go+lNqmeg1Sk=;
 b=TCjiPgW4hWrH73XXTt2ZKeS8ImY0+pzDAAYCILMclmLv/hK2upeJOU2KX4udV2LRAe
 G1BOdpOEfNK3eQgb4TpxIETdOq7erGNakPMutpmC6t8HxQ56/mEmSAontuvnWG9C5FFL
 aiElstMfiqkkDwzviAAhri2qdgi2WjX+P3/+45sVdGmvDCOei82JvoQcRd9XC0ovTFUP
 0ftMU5NymzzKYGMdyDpAwEkGBcBAa9HTafjb2mvgMO407djDcj2NFan5TIJPIfwhSdAV
 uYZIH79BwXmsXfBpxzTua/VdDLyCg6DrPG2dv29IjLPULDdcAINGP34pQAL2GNvMtkps
 zcGg==
X-Gm-Message-State: AOAM530eRutnkV9FIHBhvMoFsgO1+M270R0XsAn1FK+f9TFv8oOtSru9
 rGB8N/xtgfDnWri3qd+OsUTwWSo7/hM=
X-Google-Smtp-Source: ABdhPJyF/AO9mIYlYPC7frPFJC4vuI1OfsbPpWSvdql+8B1BRFUfUmVR7odOBautRgtAyT1XuC2BAA==
X-Received: by 2002:a5d:5003:: with SMTP id e3mr17053250wrt.118.1631600895523; 
 Mon, 13 Sep 2021 23:28:15 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s10sm9544741wrg.42.2021.09.13.23.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 23:28:15 -0700 (PDT)
Subject: Re: [PATCH nvme-cli] nvme-connect: Add 'dhchap-secret' and
 'dhchap-bidi' arguments
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913094201.18729-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <692f5019-fb1e-7a59-8bbb-9d181745147c@grimberg.me>
Date: Tue, 14 Sep 2021 09:28:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913094201.18729-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_232817_228493_7616CBEC 
X-CRM114-Status: GOOD (  10.34  )
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


> +-B::
> +--dhchap-bidi::
> +	Enable bidirectional authentication (TCP).

Not TCP only

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
