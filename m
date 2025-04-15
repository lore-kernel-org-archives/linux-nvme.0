Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D0AC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 21:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=clIx4Fb1N08KwzB64yY5DHc0HFyznzKwia3fVqlxUlo=; b=YzTYy/1DZSuC3hllJrw+FEH511
	ZE2DDi42kPt5dkTTd4a8RGlp9KKtZO/lJZXEDQrJGIkXU+RLce4xHYK4rkPMmniIRXIndNH3tV5LW
	8SWgk3Gn2JrWXZdxkBrBgUCEAwCVO60Zb9ofUbqEdRjTlI5xEjT0FoJPIzivJwUFMMk0UsfJMKiLh
	XQQY9Ol8lWN85qKL4BGe2ZFF+OcPPLAj76d5/u7QqQ8fPd+FBRZI3PUtB8wwXAm9Qx5KxMi28M3+X
	VpN7Y8+MeAzDO+nTNnbL4ZH+Slc5QkPPrGYZmvm/pTJgv0oVglCWlvnHDsPMehEVC1n/4CXO0FUVJ
	nsVutcpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nc1-000000079Wu-1m5K;
	Tue, 15 Apr 2025 21:14:33 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4nbz-000000079WS-1w2N
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 21:14:32 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3965c995151so2739284f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 15 Apr 2025 14:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744751670; x=1745356470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clIx4Fb1N08KwzB64yY5DHc0HFyznzKwia3fVqlxUlo=;
        b=nv5cQ26GOmeH/b8tPqPbPgTMOEenJDSJA9FTV5hBV7qDhJwtdLTT6uEjbQdrQNojCK
         B/ELujOCXHilpWc/k1TU0XWif0tVYCs9R6C6IlBCmehQ7Yceh4mfNL/X/QXWQ9pcPE/w
         f7NdEb+A9p7P1+vs01b+hNYlBhU8m3oUMrmNqAN3a8hCfOY/Q+f8bGD5IZlLev1EOxpG
         Ybbq8O+9KFXyWDJ/87nSCYraPie2K0AEUtvIghsGS+zRUrySDhxAwKUtMHh2mFHUIj+a
         RyEg9QSS4OOsjHnSQl957lukQnf+zwjwC7fx6TwEkYlLnBiNNQim4UFLZoqEZg83uZ1i
         9/Zw==
X-Gm-Message-State: AOJu0YzBJFBTW1/Ywdj98Fa6atTHgLRSyqS2QaCTRSBws2AHeSOAGac9
	zeBxWqtyy6YcH9EXnj7Tq3CHORtevlcMrGeGHggWx2GZ1xvZe/Ea
X-Gm-Gg: ASbGncvh3wHPyirMQc9BFitRhAsx4uw5vh1J20rBZOzA9P65iE9/pMEeS9pQJStvQsf
	QYQSfxnoErKvecgArGDUYG8ATgpbIkEtIEkygMuCgM27kHmHOQG39fVEMWPBjtSNABqbwKieIih
	dlGLnPLHxEikU1HJr3QMVIvufevmuTwmq2BDPPjr8XI+fUH9ZpUoIDxxQQZUKsBjGIF+YJwTJOk
	K43/2hoW+PHn27OI+7UKjwxkr6lqT5b6LEvsdoWojsJyknTB4ydSiR8Rh37eC3XrRiFOZFDRRQe
	X1f48kx1zVfoQS2WaihklTvAxUHeIh1CPDFvwQxBAhgf7xrPwITC8VlCNBbMInqEzMjJ/afy
X-Google-Smtp-Source: AGHT+IE7tULYtKpjR06CEZjExJqwQDFJAedtPwT5Q9tPed2vYqjts6HkbMmVs4bbsnILnJKnVpQThg==
X-Received: by 2002:a5d:47af:0:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39ee2755ad8mr738934f8f.28.1744751669554;
        Tue, 15 Apr 2025 14:14:29 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d127fsm1159865e9.12.2025.04.15.14.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 14:14:29 -0700 (PDT)
Message-ID: <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
Date: Wed, 16 Apr 2025 00:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli connect regression
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 bluca@debian.org, Caleb Sander Mateos <csander@purestorage.com>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_141431_502347_B7390D70 
X-CRM114-Status: GOOD (  11.96  )
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



On 15/04/2025 12:01, Daniel Wagner wrote:
> On Mon, Apr 14, 2025 at 01:29:42AM +0300, Sagi Grimberg wrote:
>> Was this resolved?
> I've added a retry loop in libnvme when the write to /dev/nvme-fabrics
> returns EINTR. It takes a few days until the newly version hits the test
> frameworks and we know for sure that is handled.
>
>> Couldn't follow where the issue was - kernel/userspace?
>    [ 10.397892] nvme_tcp: queue 0: failed to receive icresp, error -4
>
> Stable kernels started to return EINTR and one change which touches
> this area is:
>
>    578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
>
> Unfortunately, it's not easy for Luca to build a test kernel. If we
> provide one for his distro, he would be willing to tests.

Its not great that we now get sporadic EINTR errors. I am wandering what 
is triggering this?

Caleb, did you see this?

