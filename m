Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586FAEE4996
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7McqsUG9/n9bF2XacmN1JD06VS50QhXM/DtLdX+veoY=; b=dOQIOYVCB/8dXm3Al+xSt8d82y
	EZ7p2HjyCZy/1Oox4U9M91+IOlGks1kMbntxZ+2V7npsHiNhcV9MkO0z51eHuldzsvZRTuxejPXxl
	jR8xqPA1L0T9IeKwD6uLUs0dHjQTRTQ20X+08rhfbxBTOIzgsjkl8g21FIXh6GOIOYj6HGJWwyEcN
	DVpA7uHmYyZ9wk43l43KI+hIrUdAxqMic6r77z3tN2eoL5Pv7B4g0Wz4N9aNAWKK1A5CSCYJ+S61D
	vRRs+FjHQG3T3ew0/S+P8TQFwXURHnA4dkGGdnIn9hJkG98iGZ/o6MWD+OZr85UiOFfnz3+tqTNPB
	ZL7LELTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXza5-00DNuD-1K;
	Mon, 21 Aug 2023 07:44:09 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXza3-00DNsu-10
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 07:44:08 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3177675d6dfso466447f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 21 Aug 2023 00:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603844; x=1693208644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7McqsUG9/n9bF2XacmN1JD06VS50QhXM/DtLdX+veoY=;
        b=AsspbnP0tk8qV3kBNL9qYR9KlEjh+wc1n6QtJSsnO5FYxqbhlbcS3DF3gB+L/eZ/Nd
         h2FgI+nnQSogrjFTlY1pyNbr9apn78co+7e3MZAgAP0gCmSHWIkKoOZFZxcBHIojNrmO
         pYxOdpj6PIlmn2ZpZ9blczE+yHjpqqQf+qIHRq8+lFxVaTrOzIgwIJgATqoBtV3bbcsI
         LiTQgXxN0fzKrB6F93M5CrNv6XSkrKmNCfVNCsvsVvSJyUYwxhX6gkAQXaNGqUPJb49Q
         Xm1XRE0GwWVybjIBoHu1eK5qTRRLurYVzSH/Delm/FOTgrXwtHNigkRvWc1xdBUS3nT3
         FV2w==
X-Gm-Message-State: AOJu0Yx0nQHqZJR0t9VjlskT0MHkNpaimoBAhbNImtXgQJXI3ZlCkOCS
	Op01g7EXkbWiCt8kRInZ8X0=
X-Google-Smtp-Source: AGHT+IHw69/rKHEeuvsKA8e+NrcvTW8sHjVAIBGESUm2zUaC2BzNnaHhlhJ++hzpA+natM1YbpQb5w==
X-Received: by 2002:a05:6000:188:b0:317:73e3:cf41 with SMTP id p8-20020a056000018800b0031773e3cf41mr4029033wrx.1.1692603844662;
        Mon, 21 Aug 2023 00:44:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b003179d5aee63sm11434972wrw.91.2023.08.21.00.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:44:04 -0700 (PDT)
Message-ID: <1e56aa0a-d957-f31e-eef9-a143a7ac4bd5@grimberg.me>
Date: Mon, 21 Aug 2023 10:44:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH rfc 6/6] nvme-fabrics: expose support for traddr as dns
 names to userspace
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20230724092023.708335-7-sagi@grimberg.me>
 <7d60e267-be0a-41ff-8015-d3440b6eca2c@suse.de>
 <433182d8-c57e-2e51-2692-02ac8b474bf2@grimberg.me>
 <8e72f698-af99-c8a4-a672-d51d28ee7a36@grimberg.me>
 <cc448d32-f3f1-0929-18d4-15186adeac01@suse.de>
 <b4fe7c1f-1581-bad2-9203-6f4c87d6a599@grimberg.me>
 <69b5e07b-f16a-0a9e-bee2-28877dbecab3@suse.de>
 <0569a67e-1264-1dcc-d44a-23bf8256a9e9@grimberg.me>
 <3wmt5cd5yd5ru3uzp5grcspkvi27ijztnxwxhov7chmf6wicg5@6dj2qed6ulja>
 <e797a124-ac6a-0205-65a5-9806c6955d4c@grimberg.me>
 <vzcluo7jktlrut4iavcdyrsdedcg4cpsm72ewuqwrq2sjqkce3@ik3imkps3llf>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <vzcluo7jktlrut4iavcdyrsdedcg4cpsm72ewuqwrq2sjqkce3@ik3imkps3llf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230821_004407_344448_B0FA28F0 
X-CRM114-Status: GOOD (  11.44  )
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


> The libnvme parser is ignore anything it doesn't know yet. Introducing
> 'feat' or 'cap' is not a problem at all. Also it should be fairly simple
> to add. The resulting code is likely to be very similar too; testing if
> feat/cap or dns_ip_addr token is available and then use the dns name.
> 
> Given this, I am in favor of the feat/cap approach.

I do still want to hear others. We have thumbs up from Daniel and
Hannes.

