Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0591BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2JpBcc/NKpDAPZChPw+W7kZSZTO1SHhUlKPE+wqy+c=; b=KhDkB3eCk8XTQ+rQcxSuRYNjcl
	U1NkBUQK+AIZkhd5hc6ViVF+wvdHfcBD8R9soXPW+8rVeyZHALkQ0TLcjiuACkW9X8VdVhMzudtIN
	br10brJwCKXblLzgpX8nzqw02yLQx8JtsRPl1eLfaA3gaqHumzn+Gdn4l4N8AUzOKklEzr0bLWKi7
	t0Et+eoCF1fTlzlHsyMa10v2hmg/wmYW83KC4WXZ0/kvWOtfWlXYMN/ldDeKUpFdVZzaw8aolaMr9
	Cz5cBHpaqhJR7JiSIC4diVPlesN60HZZq6tc4ZAHPzidG498kgpx3khFXPVN0av+4V5SaS2jxH9Yz
	4YIyUpeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUU58-00D6JP-Gz; Wed, 16 Mar 2022 13:52:54 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUU54-00D6Id-Au
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 13:52:52 +0000
Received: by mail-wr1-f42.google.com with SMTP id u16so2076542wru.4
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 06:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=g2JpBcc/NKpDAPZChPw+W7kZSZTO1SHhUlKPE+wqy+c=;
 b=LZvuhwMwapB72jrAevbTaa6sdFkIAp4jsX01zmHCQvEEiPE/rZjGu6B+sB96sgLDuR
 ntoQLg5gX8xA0NiW0ey1Sxbvsk3fXHLdbwISSVBt7gljT6mKXsz6qcTOa8rWBQ26XuJ7
 iN6WvuNZiYOFgRm2V4Mazp9W+q5H6WEj3r63KteFUGWQ8RG3+sjLTXt0P51HqIRJtIT2
 G8XYVkzQm5DL7SWhXjQ34oOvVInpmK/jm37/2siNjxbIZYISvs6bJ+b4QWE6xaiqCieR
 9xZeU2o/eQ/JRM7x1FXTwmNC8W2SnFapwqFUMcpc6/OeVlgMdNLhZgDVsK/xRr1O1+Wu
 Falw==
X-Gm-Message-State: AOAM532dFYmgHknb7vv+VHdw5KT07qjuIaJ1aQg/N25QXifvBx6PTQms
 pmooSk9kf5yyhFj2BFi1N4s=
X-Google-Smtp-Source: ABdhPJwLwWzFdFkbUnONXVDVXs/3GZdMiKVABbSaSYh1u911dOx3621EujfQC+sGuf1CeLp19Qm79A==
X-Received: by 2002:a5d:55c5:0:b0:1f0:7672:637d with SMTP id
 i5-20020a5d55c5000000b001f07672637dmr101416wrw.170.1647438768337; 
 Wed, 16 Mar 2022 06:52:48 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 e10-20020a056000178a00b0020393321552sm1921536wrg.85.2022.03.16.06.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 06:52:47 -0700 (PDT)
Message-ID: <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
Date: Wed, 16 Mar 2022 15:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_065250_428526_9728F452 
X-CRM114-Status: GOOD (  12.21  )
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


>>>>>> No one cares that this has no multipathing capabilities what-so-ever?
>>>>>> despite being issued on the mpath device node?
>>>>>>
>>>>>> I know we are not doing multipathing for userspace today, but this
>>>>>> feels like an alternative I/O interface for nvme, seems a bit cripled
>>>>>> with zero multipathing capabilities...

[...]

> Got it, thanks. Passthrough (sync or async) just returns the failure
> to user-space if that fails.
> No attempt to retry/requeue as the block path does.

I know, and that was my original question, no one cares that this
interface completely lacks this capability? Maybe it is fine, but
it is not a trivial assumption given that this is designed to be more
than an interface to send admin/vs commands to the controller...

