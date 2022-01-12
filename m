Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C35C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DoxA/HZ6Hqtl2AG7gqghNwbzIr4xoTtN3O39GeX/hkU=; b=dY8tVh8tfUsxTKi/2O+ephTrJn
	9lrEmNCvOE4i3dsmdNZGlO3zEtroEN36/gByb4cDNj+XZnIkU6Rk7FyLqFBKNyDtvuTHevrWCpavD
	u/oPois0EiVLk74Vljo9L5SkpjNHQZk2hGJhHKALU8Wf/yjiaifMAvDamFj1Bi9TjYEU2zIe17GLT
	fMckmxMUDrX/b3iI9lTiQwaHJ5e9Oola3Qhl1y0JJw+VPOPxyqH4sbZtYgaIY1i9kMxHlFa/3DcNk
	rbz2tEcUI+GI7rl0aLHmn1qsM84ge3CwxBl3NaFs5qI1L4ZxIFc9BdjC31G7qjuxq3XT0/Kc20Hg/
	MCJyCdhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7llB-003uFs-4H; Wed, 12 Jan 2022 22:06:25 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7ll4-003uFD-QW
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 22:06:20 +0000
Received: by mail-ed1-f47.google.com with SMTP id q25so15581787edb.2
 for <linux-nvme@lists.infradead.org>; Wed, 12 Jan 2022 14:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DoxA/HZ6Hqtl2AG7gqghNwbzIr4xoTtN3O39GeX/hkU=;
 b=4FCLa4cNoTFQj+bA4daA3cDBCChJY+EjgR0BZS0sNLYEwNfR1l7NPWuudZHDIAE83+
 o1l095GTNfHQQbqh/eHO4k5BUJU5WUFD2ulZ5A6Zz1A9U3bXH4hd9kjHB3DGiORBbcr1
 c/R26BiVo8M3B2omwq3bEnPVWKBtZS4XS/G1Ihdb7XIx1g4ltNFnO5RcI480Zxaf2mkt
 1bUL/bXW05ZJlQOK6ON9xJ1AVjZ90gTiUL/PEsQ+oTodahiTHGJPgUZOz06u3ICJ8GtI
 JJF7GvtUtSxH0HBJqI6Io1F4/EfBVGzup43sWgTt6EKLnenzEuCav6RZtE1YHgwoxZOa
 DiKg==
X-Gm-Message-State: AOAM533Af6GCVbQ9/7IrumonkLCrb7Gjp2qVxWnvVXHsxV83Lym7cmwZ
 MXFcl+vdeSXduamKM5VdiAI=
X-Google-Smtp-Source: ABdhPJzNvVHaMEZO4bfIHWaYzPSAgNqefBClGfMoKJKHzAsOwmddGfQBNigAG4UszpMf80ZPWJ6EUQ==
X-Received: by 2002:a17:906:1145:: with SMTP id
 i5mr1296525eja.317.1642025176807; 
 Wed, 12 Jan 2022 14:06:16 -0800 (PST)
Received: from [10.100.102.14] (85.65.254.89.dynamic.barak-online.net.
 [85.65.254.89])
 by smtp.gmail.com with ESMTPSA id w3sm384642edd.63.2022.01.12.14.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 14:06:16 -0800 (PST)
Subject: Re: [PATCH blktests 0/3] tetss/nvme: fix nvme disc changes
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "osandov@fb.com" <osandov@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
 <dabc21d2-6431-67e0-8ce5-62c74c76bc99@grimberg.me>
 <0dfab539-c85b-68da-0a2e-3765d7d3903e@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29ec2611-ad72-051d-7725-5d07fda70c04@grimberg.me>
Date: Thu, 13 Jan 2022 00:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0dfab539-c85b-68da-0a2e-3765d7d3903e@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_140618_898131_35D0E0D1 
X-CRM114-Status: GOOD (  16.82  )
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


> Sagi,
> 
> On 1/12/22 12:38 AM, Sagi Grimberg wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> What is preventing this to break again?
>>
>> Can we modify the tests to not rely on a consistent
>> output here. Perhaps just search/match the expected nvm subsystems
>> in the log page?
> 
> Do we expect to change the output of the log page again ?

Yes, I don't expect that we will lock down the discovery output
in both the target and nvme-cli.

> It is important to match the disc subsysnqn i.e.
> "nqn.2014-08.org.nvmexpress.discovery" and gencounter,
> only matching the nvm subsystems not going to get us good
> coverage.

I'm just saying that it is not sustainable. Nothing prevents
anyone from changing the log page again.

