Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAE9C47072
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrdeMIrGE3u9o6XM57Lyz4hMqa78rVLWqLPMcDlZVQ8=; b=hylaGGo5T2erwk3kbKXVjZu+Yf
	GPVmcJgibBdlfx32Ss6nIoRiFePJu9JYXqINvtpYhgaAOOCgg5i2rkm1RwNsGfLVoDWvnl7AgVGuW
	rjpRH3RS1A7EDm0hsXA38AhPTfik/FsyFKTeT3YDEZDb0tJqU5CLWRyulvh88p+koPf86ev1F2DOf
	msYXl3lSNqZJpx4JX/QooE1UfxRSAfclw5GVDxreGZdtNiN1shFxRsyWK0VJ7d8NBBZE/C2kY+VbC
	T8QPYiX1L9M+evR/oODj76ykGkWVXMpzjOReEmT0mqABSfWZfv7PVuphLy/LdBnDaiAsefW4LWENk
	xI2XQtUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh1U-00ARvF-2x;
	Mon, 25 Dec 2023 09:13:20 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHh1S-00ARut-12
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 09:13:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4ef21007so4924455e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 01:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703495595; x=1704100395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrdeMIrGE3u9o6XM57Lyz4hMqa78rVLWqLPMcDlZVQ8=;
        b=TOi/FUkF+QylxUAClH4ixQPA5WrLlQ7/eT/h24RqBP0mmEm3W+tAfjawEvIhA3FNrE
         vIYP3BB7j+WQODA2q8fwm6ZD+IH8dO69C4/wH8CxwrZeS+QdK+ngaj2wISIZMW2WJLmG
         6oYwRrQI0YJLSZwnWB+yB2L7G0sxREjlEHC42vrj2lvkzkw2W9acruRENx+FBYrJAwaO
         CZRp0Llq9xNiipov3AZQ2AmY/AU5vIut0Zk7NLxpRoIt0hnF+CAHPZCaRFi3F3XEPTMT
         ZOOWxDHaQsS9x9sl/sWqE+An/E6xtMsdfo6DDLamul9JrNTRZ1lee/Jp6mfrwjYf6RMi
         SyGA==
X-Gm-Message-State: AOJu0YxtIq/GvV156Xh7DKlW7fx9UII3z8ELdMM3SOqtn+7m99EG/S/8
	FyQAGLi/i301CqSDYdV26e8=
X-Google-Smtp-Source: AGHT+IHg0ozdIbIMnzljlnhHRZn8FtFlKgS6gDIwUNNPT7SQ32rqbzDCTaH5vPnraMmnDS2252LLWA==
X-Received: by 2002:a5d:548c:0:b0:336:6414:4018 with SMTP id h12-20020a5d548c000000b0033664144018mr6518961wrv.4.1703495594996;
        Mon, 25 Dec 2023 01:13:14 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b0033629538fa2sm9869739wrx.18.2023.12.25.01.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:13:14 -0800 (PST)
Message-ID: <7100b7dc-25fd-4b4b-a30e-81237208961a@grimberg.me>
Date: Mon, 25 Dec 2023 11:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: marcan@marcan.st, sven@svenpeter.dev, kbusch@kernel.org, axboe@kernel.dk,
 james.smart@broadcom.com, alyssa@rosenzweig.io, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <20231221121746.GA17956@lst.de>
 <b4cee1fc-f115-40d6-9a16-3cb00691b98c@grimberg.me>
 <20231221124034.GA21682@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231221124034.GA21682@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_011318_361630_8F3CF083 
X-CRM114-Status: UNSURE (   8.56  )
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


>> Exactly because its odd. Unless there is any benefit of using sgls in
>> admin commands lets not flag it per transport.
> 
> The other transports always and unconditionally use SGLs anyway.  With
> the virt boundary we're just adding extra checks to fail certain
> passthrough admin commands (the kernel will never generate those cases).

I just don't see the point of adding a per-transport flag. Either we
always enforce admin queue virt_boundary in the core because its not
important enough, or we always allow sgls and have pci set this flag
locally (given that only it has this quirk).

