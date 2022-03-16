Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85064C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 14:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaff+ZDUoXqtqYBeMMWRXCXNeSj/5wDimU+/EYD5/Gk=; b=UXr2UQgWebE1sMzRh7Cs6SkGD+
	KCFg9F1CBxI+Gi8sJ0cF1EfEcHneCC4t3kR9W1ftsH+D7rVVQqP4YKiV4KiMxFGjPYoeYznTr0LPQ
	AoWy3pym5yKxvwEFg8I3bI/CHq5SGcMqYGG0MgAIU1HQXKIi01XtONMFUogk/fHkYj+GxeZC3+pdC
	GRB8kB/pyTAu4Nz0/zskUf7kPyF/PZmvPFFWhXhgWGCch4+JzQBGzf0zv13eef6pTWBRzECwshOYz
	PGmZ7Pk60WXJgLodhCte2omMA6jhHEKX/EiAw+6UBRWaYot6M2mveY8XxNbzLushq3iOUtZ0f/fhv
	xMNWkeuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUUkp-00DHo7-BK; Wed, 16 Mar 2022 14:35:59 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUUkm-00DHnK-MC
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 14:35:58 +0000
Received: by mail-io1-xd2b.google.com with SMTP id d62so2503354iog.13
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=eaff+ZDUoXqtqYBeMMWRXCXNeSj/5wDimU+/EYD5/Gk=;
 b=JThsvMwLIHIkGD1jdC/++Zj9xOlDlcjpnnA48h6EYeK4lmy7fjOLg99PtzOSpvprMC
 Xp0MVCYEn/cvEASmV8+QmHsLbXswKKiO8uwpl4Rm70ne1kWNpaNY5CYDZfZNvEQnrKQ3
 SViYIUUPuU2xyma9JdiZDqDjiuA/1ehgaVybZujWJna/wawr9Iu6+WhVqCq3c2SrijLi
 YQQ5etvqaKVc4jy/NVsz6B3bm2VZI+BXruhkLbHLpv4s2BsyoOgcdV8AIV/mjdWtS6Uo
 39MSbH3/oZndxpT9q42TjzuMcR5HGSnScrbCtmWj0GvAakZJyjzINPU5AGdjWWCJTSho
 yKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eaff+ZDUoXqtqYBeMMWRXCXNeSj/5wDimU+/EYD5/Gk=;
 b=hDIFiJUH3Rud7t5wGnuag6VJGKhVdnNuMUzh+M3r3c5CZn7ciNM7PuwsBS9jrDoIOX
 MT91TwlpixPsZCkQMenXaEvBE+IyVEK/zwzplL70z4y4T+PgszFKYERTDaVnjoQsq8/0
 OnsgmAUCEe4FARMUflK/6RhRwNqJqmLAkJ8AoyXW/sIlDwfexSzrroFlYHIEOsfQL4A2
 kah8HpFFEYY7Z1nSTtnnvfSEa8RoxMy98vZoa0OhpW361VEufbzVqNaotwVA6H3yDoTA
 ofZ1My0VruKXIOGUXm1YDlu8BArUudvOVYJClRy9IFZ9mYND/iEWAIJPbowskPOWfOTR
 63Bw==
X-Gm-Message-State: AOAM532yTdFRYWOsRYxk0bF/58Ss6DWgEDXJCKEMgD5ZJaMfa/tyRr6f
 JJL6t5aBUOE6fF4XO4SdxDJ9AQ==
X-Google-Smtp-Source: ABdhPJwQOXSKwhIW3xtIEqlzxJ3pNORPswTtyklm1l1o03V1DSh/93Z6RrmC6PwtXl3YEjBm/8ThUA==
X-Received: by 2002:a02:6a60:0:b0:315:4758:1be1 with SMTP id
 m32-20020a026a60000000b0031547581be1mr26549262jaf.316.1647441355684; 
 Wed, 16 Mar 2022 07:35:55 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 i18-20020a056e02055200b002c7b2ac7ba2sm1220084ils.26.2022.03.16.07.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 07:35:55 -0700 (PDT)
Message-ID: <666deb0e-fa10-8a39-c1aa-cf3908b3795c@kernel.dk>
Date: Wed, 16 Mar 2022 08:35:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
 <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
 <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
 <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_073556_805874_49E2F956 
X-CRM114-Status: GOOD (  16.05  )
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

On 3/16/22 7:52 AM, Sagi Grimberg wrote:
> 
>>>>>>> No one cares that this has no multipathing capabilities what-so-ever?
>>>>>>> despite being issued on the mpath device node?
>>>>>>>
>>>>>>> I know we are not doing multipathing for userspace today, but this
>>>>>>> feels like an alternative I/O interface for nvme, seems a bit cripled
>>>>>>> with zero multipathing capabilities...
> 
> [...]
> 
>> Got it, thanks. Passthrough (sync or async) just returns the failure
>> to user-space if that fails.
>> No attempt to retry/requeue as the block path does.
> 
> I know, and that was my original question, no one cares that this
> interface completely lacks this capability? Maybe it is fine, but
> it is not a trivial assumption given that this is designed to be more
> than an interface to send admin/vs commands to the controller...

Most people don't really care about or use multipath, so it's not a
primary goal. For passthrough, most of request types should hit the
exact target, I would suggest that if someone cares about multipath for
specific commands, that they be flagged as such.

-- 
Jens Axboe


