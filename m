Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A102BC46CA2
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lZH4nfXVvGkHRuS5/NZWLoTylQEMDL8jlGV3fevKyIA=; b=vtUZ8E8FzEgvXf2Db2XPHgv7Gz
	d1rQ+lq1i7oAOcFxeO+aTXPywunWHVmFVFD8jTvjaBCOnaO/PfYZh3jrteBjfRKbq+AEmLnHzwpBI
	RbNz4QylMCbFlqXdiul29KvH34OvhamG8Hmw3aOHovevcq4eB4HNwIMw28DtEZASinCSwLICxwQKH
	J+4d0KxnK0nhj6QUJ8IOstYA051Lmy6uIq3mcV0OZjcHUhLLklPjOnfaQd4wrs8xPUnHKpa2eV3Eo
	TFER/i8Hq8NkKrRorrHTGdjlRG+g3BqNUFAxMra5Nvlrm8z0gmTagQl6s7IA0Qi1xoTx3OiukaYw3
	o9cjXD+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgES-00FMWH-1c;
	Tue, 19 Dec 2023 19:58:24 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFgEP-00FMVu-26
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 19:58:22 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d2df9cc39so1841725e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 11:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015898; x=1703620698;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZH4nfXVvGkHRuS5/NZWLoTylQEMDL8jlGV3fevKyIA=;
        b=bgc8fvMYeodHdN0q17qoKcfydQRWy5HN6LiC3tAwTp7qGfaS+kSEsT5XlgSVJ+KMmJ
         PSdGq9XWWmn4ux7E88mIePytS1l0nx1pF+lYh+swQ06GsEDeUwwcA3iyOhrhdouL0kw1
         XKPG2oYYcfsL4zLSh8MU+tTqPPv+CnSVlznzKkXh8AC/lqIguaHr/x6mI/mN4nxx6SYT
         I+1H2Mgj+eaHtIK3tN7RPSlU/B54tyZ0f5EWTfaY22Fej3ldeuS/8rPrhpnBg+PVcXTx
         EslUDem7uLNwq1hgGoMFWvHWtd0q9Kfm5FD7X1HLQ9TljgZZiMmP+rz7uNrDey887t1J
         VvKQ==
X-Gm-Message-State: AOJu0YzvmZVz8Ybv7hElFdbL/S14+k8fTRkZ8LxPpFFO50rSskgui3HJ
	DZW4VaZWX1KHOoT/1GH1+Oo=
X-Google-Smtp-Source: AGHT+IHy9SUd45jqoosUtq6rfObgkzdyG0bOHucbV0SiZ83R+fZq8ivP7NMj9Veo5JM2rJQZw3mgMQ==
X-Received: by 2002:a05:600c:b49:b0:40d:2591:302a with SMTP id k9-20020a05600c0b4900b0040d2591302amr1906937wmr.2.1703015898109;
        Tue, 19 Dec 2023 11:58:18 -0800 (PST)
Received: from [10.100.102.67] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id jb2-20020a05600c54e200b0040c4afa027csm4054284wmb.13.2023.12.19.11.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 11:58:16 -0800 (PST)
Message-ID: <c594ed33-69cd-4046-90a3-f0880aab7c77@grimberg.me>
Date: Tue, 19 Dec 2023 21:58:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
To: Caleb Sander <csander@purestorage.com>, Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
 <hqha2fmtutg2p3daqjz7g4ozlkl25orvkirgyq4tibq6c6e7k6@losspn6rhbgm>
 <CADUfDZoFgbJ3J0XM=neq5vuyRDmc4agUy64_aVtDos1Ws0bmpA@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZoFgbJ3J0XM=neq5vuyRDmc4agUy64_aVtDos1Ws0bmpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_115821_712941_4F1FF662 
X-CRM114-Status: GOOD (  12.91  )
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



On 12/19/23 20:54, Caleb Sander wrote:
> I'm not sure IOCCSZ and IORCSZ even make sense for discovery
> controllers. These fields are "I/O Queue Command (Response) Capsule
> Supported Size", but discovery controllers don't have I/O queues.
> Presumably the host should ignore the values in these fields for
> admin-only controllers. But the base spec doesn't seem to exempt admin
> controllers from the requirement that "The minimum value that shall be
> indicated is 4 (1) corresponding to 64 (16) bytes." Perhaps this is a
> better question for the NVMe technical workgroups?

Perhaps. I'm not sure that the intention is for I/O commands only
as it is defined also for admin commands.

I think we should have the discovery controller simply place some
sensible numbers there and later debate if the host should ignore
them or not.

