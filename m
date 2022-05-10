Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D37C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R2sf6sfODVs1BjVdCAC0de7tT9uSOa1+mpgolTGWuRs=; b=lIausqlM1C6lrX/apUE9Yi37+l
	f/mEVMl4D3VImv/6GzDPiQV5fhU9e/so86tR1QeaB8FbHs2cEjDBBOsIuhJ+2kx7Z0y9IYMXDyi5e
	sAu8v0DN3QQtVCwzDhCCGiXwYVXTvQt6cBHdtucQ4ayHGEzMMhPlJlII3zo6WViPZMn5cKruNc7yF
	W7lHiUvklYkePq1A2h9BKzxnqH7HMsHXBL+OGNXw5H48cawAuPDPCMuwqwphVkqx5/bTzGCGPqLs/
	ZCCWGmJOSgf2TA1T6wNCmInItZMia9u0ipL4XEO+i2uUEW+c6MExQ28LTwezPCOMdwE5cCJoZ3/xd
	AIjlEKIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noV4l-003k2y-Of; Tue, 10 May 2022 18:59:15 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noV4j-003k2Z-62
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 18:59:14 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 l20-20020a17090a409400b001dd2a9d555bso2974805pjg.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 11:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=R2sf6sfODVs1BjVdCAC0de7tT9uSOa1+mpgolTGWuRs=;
 b=AOwUA+D9dlmPgNOjimrHaJNg10YP1XPU4KQfIj7tclK1aipQguuiVNJTSz2YDIgOjD
 pI0nz78oS2ssUG1+5s58j5enbGCrIT5bh8mlI+kbHwNA2sW0J7UHrxUgkyLlwm1P+VK2
 91MsVF+9ZpwblJ2aMugmZic6D/8YocJnLfv3LltQ6IpWCveHMypp5oDQBkeqdKbrLcfh
 s/VsWXf7zBuPtLuBISj/jGgTZbPtZba6uIDjjZ8eBHg7okk0AaqlCjEsPv8GgKQOkXWU
 Q0jklrdK3yEFjXafTlt187ao4zy/K2kF2EPuj3lJuDgTjADHjwrFbJZQYgQ8qcvIeheo
 UveA==
X-Gm-Message-State: AOAM533jQPOvsYBWUSQGBFGBFofHRkjYGX+gMSHbhTDE6Sg4TYeRgikW
 K/4utNJeZ3YOjZE674HIwyM=
X-Google-Smtp-Source: ABdhPJx0/ibkg02TKaY+CnUzJOwqiNZ/Xh86XIhGuucH39j6PH4Ugp6Y4Zer9+tlSXXqZf6dr/3v+w==
X-Received: by 2002:a17:903:22c6:b0:15f:14e1:1518 with SMTP id
 y6-20020a17090322c600b0015f14e11518mr10034580plg.116.1652209151078; 
 Tue, 10 May 2022 11:59:11 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
 by smtp.gmail.com with ESMTPSA id
 m63-20020a633f42000000b003c63ae859d3sm48776pga.83.2022.05.10.11.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 11:59:10 -0700 (PDT)
Message-ID: <2fadeb83-6670-14d6-71e3-c8a23ed7d9e8@grimberg.me>
Date: Tue, 10 May 2022 11:59:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] nvmet: expose discovery subsystem
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220420092730.35101-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_115913_271722_DF133492 
X-CRM114-Status: GOOD (  17.12  )
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

> Add a module option 'expose_discovery_subsys' to expose the
> default discovery subsystem via configfs.
> When this option is enabled the internal discovery subsystem
> is disabled, and the admin has to create a discovery
> subsystem manually.
> The discovery subsystem then has to be linked into the ports
> which should present the discovery subsystem.
> 
> o- /
>    o- ports
>    | o- 2
>    |   o- subsystems
>    |     o- nqn.io-2
>    | o- 3
>    |   o- subsystems
>    |     o- nqn.2014-08.org.nvmexpress.discovery
>    |     o- nqn.io-1
>    o- subsystems
>      o- nqn.2014-08.org.nvmexpress.discovery
>      | o- namespaces
>      o- nqn.io-1
>      | o- namespaces
>      o- nqn.io-2
>        o- namespaces
> 
> So in this example the standard discovery service would be available on
> port 3, presenting information about subsystem nqn.io-1.
> Port 2 would not present a discovery service, but a controller can connect
> to subsystem nqn.io-2 on that port.

So what is the behavior of this param?

expose_discovery_subsys=1:
both default and unique discovery subsystems function and behave
in the same way, i.e. user created, linked to dedicated ports and
answers log page info with subsystems on all ports they are linked to.

expose_discovery_subsys=0:
default discovery subsystem behaves like today but unique discovery
subsystems behave differently (i.e. like first option?)

This will be confusing to users I think.

I would say that in case expose_discovery_subsys=0 unique discovery
subsystems should still behave like the default discovery subsys,
meaning return a log-page with only port local information.

This way default and unique discovery subsystems are consistent with
each other. Then the modparam could be something like:

static int multiport_discovery_log_page;
module_param(multiport_discovery_log_page, int, 0644);
MODULE_PARM_DESC(multiport_discovery_log_page,
		 "Include subsystems from all linked ports in the "
		"discovery log-page information. In this mode the "
		"default discovery subsystem must also be created in "
		"configfs like any other subsystem.");

Thoughts?

