Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A9C388F9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 04:39:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FCF20867
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 04:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="crnlI4qV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYgu7sPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FCF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6WCRvZBUxq7bQNEwsKQNpwakP8E33YStf2APvqljgUs=; b=crnlI4qVADg3WWlhVOFvo3qOi
	x1xh0EfS04HqzTK34o4WTZrKEQnef9vPp1noYg7aD72Rpd3/gthTu4HtxmJ8rp8qgmFmVmLQEMJ0p
	y90cDmxygXXbc1u0vCTB1FD74GlU+IVsc4osWZZ2vIL+4QFpICTrw8DBwd24NzfKkkuvuF24U1xw3
	C7slrWUis1cxxXNjc4SjoBDXs8b/qerrVEFSJsYuxVdNVxf81A+dVmHIQNOWtskZurNFLQfyYW96o
	a0wL1AZ7wZ1yqC39YwMVS7HMeixM4FDn4R9Cwsy4xvaGGqjAqQTWacoGoxdNDLxNmGEo0McEXLr13
	xH3t0Qd6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaX3p-0004py-HF; Thu, 05 Nov 2020 04:39:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaW6h-00016k-MN
 for linux-nvme@merlin.infradead.org; Thu, 05 Nov 2020 03:38:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=PiIsKxKi+wDvDpEx1xlpEosQ/dTF9BdCIczJuu+Taz0=; b=HYgu7sPEPlTmIXTW4L1M+QwhgC
 TFzfHPDOqatNFjjfdwS4ro2PqzSAZgEouS38Napvp14X04C4xYRGFX7Nw/uNcocdPmS4dPFzKjPhw
 8lg9eAq9sYy34o5LU/ExSkYM3dkX1tJ7Qr3D1yKzQTdePL2c0+nS3qwLR+tglSk8hKqsh+qnO+92i
 nGKzEy1Ean3l54Tjf9sswuA8gGiMIu6L6mA3Ay6qt2L1NZNZ6R0xK7vu0HAQ4ZGd5oKYDSNcS+V9S
 k/8kzavM6EMgqwistussN2bxoVl5nSIy/em6gZM7hLAz741yt3M7HzYYYqNMGo+zgatH1myC+N6oM
 N3rV3vOw==;
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaR1r-00066M-4e
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 22:13:21 +0000
Received: by mail-wm1-f65.google.com with SMTP id h62so3776187wme.3
 for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2020 14:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PiIsKxKi+wDvDpEx1xlpEosQ/dTF9BdCIczJuu+Taz0=;
 b=i0sfB91HNV5f0kwKpe9RJu85jOW+LKKk1s3Q9aQXMU96UTZb12NxIvzQKMJbA05hPE
 orZI5nZJWzGu9Qc060OAjMStR1xjJxtcK5rTKShNhZc+NyslCtY92tCpdMn3hW/5Zelv
 aJBtOXqW2mt9ZfsLjdDFM3dAEqtuKzA3FQcr1TbunhHyWPTxBFC6sXC7FJpHFjfl2Fgl
 xSFfuhBkr/rDgDjfxJlC4QZBsDEOWTuAU6r4/8Xlr3j655CldSMqdRzS80K8d22nvn7U
 k7l+I1VE8F6GEj6e4D230YrJlGz0QWBIePPtxv+43wJ/vOrIaQrak5YymUpo/qs8XH/k
 w9Yg==
X-Gm-Message-State: AOAM530sx+zXR6oVdZaYq/HI+AuehgAGkvi5B+Xi9nKFoqLtJdSom+zI
 sku6qDLTrIf8zqMFydFQcCU=
X-Google-Smtp-Source: ABdhPJxJSqsVvuVZXhAzcrl34VJgdmDPjg60aNhW4TggPzTGWWiuYQXJQio1qqNVBbgjAI7HaYK1+Q==
X-Received: by 2002:a1c:a445:: with SMTP id n66mr7106666wme.51.1604527995443; 
 Wed, 04 Nov 2020 14:13:15 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f032:e586:d54c:b9cb?
 ([2601:647:4802:9070:f032:e586:d54c:b9cb])
 by smtp.gmail.com with ESMTPSA id 4sm4703763wrp.58.2020.11.04.14.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 14:13:15 -0800 (PST)
Subject: Re: [PATCH V6 2/5] nvmet: add passthru admin timeout value attr
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201104203736.62745-1-chaitanya.kulkarni@wdc.com>
 <20201104203736.62745-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6c080198-dd74-4758-e916-9414e24a445a@grimberg.me>
Date: Wed, 4 Nov 2020 14:13:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104203736.62745-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_221319_568922_E88344E6 
X-CRM114-Status: GOOD (  17.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/4/20 12:37 PM, Chaitanya Kulkarni wrote:
> NVMeOF controller in the passsthru mode is capable of handling wide set
> of admin commands including Vender unique passhtru admin comands (VUAC).
> 
> The VUACs are used to read the large driver logs and can take longer
> than default NVMe commands, that is for passthru requests the timeout
> value may differ from the passthru controller's default timeout values
> (nvme-core:admin_timeout).
> 
> Add a configfs attribute so that user can set the admin timeout values.
> In case if this configfs value is not set nvme_alloc_request() will set
> use the ADMIN_TIMEOUT value.
> 
> This attribute setting is only allowed when ctrl is disable to avoid
> rcu calls in the fast path, in future when needed we can always make it
> fast path friendly using RCU.

What's not safe here? a command will get a single timeout, either the
old one or the new one, not sure what can go wrong here...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
