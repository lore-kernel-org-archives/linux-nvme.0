Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB1C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 21:22:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA346102A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 21:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AA346102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QecgFf9oxgLgs5MyBrBwDh4tDB3pmDhZ6sKhR7Y7/80=; b=odLPqwJ6o1ADKO2Me3B9x+wnyu
	a8Ufo8ys2ihqyELSYo4eYN0zqEyRbqMMC0kYnX54WwjCaHZ5CjoUC1HkO540+xmhGE4MmTQvaDaka
	7sRzh11zDKD8Hltd+sY2t1T8D3YyIOWJ4E/YRJnR94pDV3/YvTCSMSMv9G6RgRqUP3bMdY0ki/8+E
	q4UblZiNqwnFH7uLf3b8gfPop84FU18ZaMfnIJYMtL6PfcaGTCfvzzJWrrn8+1gnc+zNtYCG4k83A
	73mlGKbu8kTta73EZaY6fknXGfdx1S+p2puUsYcyuV0IEIbKt8SjGuYoUeH94cX+/dJJ233PWlg7x
	1AcBYfxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG6Wh-003WfM-VG; Tue, 17 Aug 2021 21:21:39 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG6We-003Wek-7E
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 21:21:37 +0000
Received: by mail-qt1-f178.google.com with SMTP id t16so18402264qta.9
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 14:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h4c9eridmxkphFFOBoPmYKgD9hRWmeja2kwztcEKjsg=;
 b=DvjnJst+LsmMpAJvPXHB/ARtTUzDD7aPmP2dK9SW1la6uAi4KncAyIuPmrFitvYIR/
 9f2rkwrL9bLZxRPYo8Fxri6sWUIrcMmU08xChWs35nG+3DOSoRvbwtSi3xLDVvqq/hsM
 WG+HpERjiOX3qFAiExuID/j2ASDMuK3KuJC4POtEdnh876mMdEgR9taLHZa9cbcpoO20
 opYLvXRKkCOZh6ECOCFoDwyVuMbGWnedkXaElH8tHay4jJfZntIJpEKHWlX9FOXRP7ng
 p5zjQtVLqJkm0deiemCWzBDdKn1ZqQaatJ9P0n6LpQ9zmChHEw2IfZMDh9S7U+ppXuCs
 9PBA==
X-Gm-Message-State: AOAM533OQ8WQrXMH36AJkSWDY5Yg8JFI1AWB0+n7KhG7r6OXVqVrGK9Y
 1O1xuSMEtFSpY9ue6cKF15c=
X-Google-Smtp-Source: ABdhPJwp7/RJGu4+3s+1aAyhr+on3BNtiGRUuYGVc+5vDmQrUcTornptNrZIQG+S9AQH/noHwR+J7g==
X-Received: by 2002:ac8:7e81:: with SMTP id w1mr5007450qtj.81.1629235293764;
 Tue, 17 Aug 2021 14:21:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6c86:2864:dd78:e408?
 ([2600:1700:65a0:78e0:6c86:2864:dd78:e408])
 by smtp.gmail.com with ESMTPSA id 75sm2204474qko.100.2021.08.17.14.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Aug 2021 14:21:33 -0700 (PDT)
Subject: Re: [PATCHv2 00/13] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210810124230.12161-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5a69187b-cfb1-d09a-87e2-8435e27612a7@grimberg.me>
Date: Tue, 17 Aug 2021 14:21:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810124230.12161-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_142136_338100_EABF512D 
X-CRM114-Status: GOOD (  22.50  )
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


> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Tricky bit here is that the specification orients itself on TLS 1.3,
> but supports only the FFDHE groups. Which of course the kernel doesn't
> support. I've been able to come up with a patch for this, but as this
> is my first attempt to fix anything in the crypto area I would invite
> people more familiar with these matters to have a look.
> 
> Also note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters) is not
> implemented; one would need to update the kernel TLS implementation
> for this, which at this time is beyond scope.
> 
> As usual, comments and reviews are welcome.

Hey Hannes,

First, can you also send the nvme-cli/nvmetcli bits as well?

Second, one thing that is not clear to me here is how this
works with the discovery log page.

If the user issues a discovery log page to establish connections
to the controllers entries, where it picks the appropriate
secret?

In other words, when the user runs connect-all, how does it handle
the secrets based on the content of the discovery log-page?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
