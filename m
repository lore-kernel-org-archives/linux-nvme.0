Return-Path: <SRS0=oqNq=DJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654A7C4363D
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 20:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BD5206FA
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2020 20:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jiuBMntJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BD5206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l6TBBHQD0REPzXHyiK4VGavehqxGbW6Qo0jEi7vyRhc=; b=jiuBMntJNrmjmb22zDsSK55Sk
	Q9Sh1kG6o9hBQMIkhu8PqxR8W30IYGgOjH4Y5rSePLsOHIGlaPxYqBPhjKnJ2ROno5FMDQYaiv5SR
	hJbikgHYt+plUuEEgcarY7TRJZdnEWGirWdwu++p/P/n9E9mrAtVKIx9dZLtG/lPmthR80pC53pl8
	P8vkWcnRk8JbM6sb2qwImJK51qFecWD7ZGmZ/9HeDEE5Dim9nZ0Eo4bDzYwXooBeck4pE9I3zCygV
	tLEeh+Q/M7AUoh8icml/BlL1dHEXZ83WNnEQT2wX+Lwv+sS/dLz95LhBYFSfUiQpKYY5sRND7JTnj
	KlbHIRviQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kORXp-0006Jy-A2; Fri, 02 Oct 2020 20:20:45 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kORXk-0006J5-Ee
 for linux-nvme@lists.infradead.org; Fri, 02 Oct 2020 20:20:41 +0000
Received: by mail-pf1-f194.google.com with SMTP id d9so2076945pfd.3
 for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2020 13:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PNXMj9wXy59v9qpnujnEiqx2cewwdkt3Afn29BVwn5c=;
 b=W9e0TSAb/4R6M4UqtXL9sF9KXrJrA+vLXwoCgQRkDO8mxftpzxHwix3ESJXJphyeAA
 iYD4WT3JkPX1mGPqfChtqNgl4G7OwghtxYGSmY3Q4eslC5SeNRF6qLC/FYXFuytlAvrt
 B1zwm4NqoyMOzRLOPV2rWqgcrrSnpWllL+ofTDU55YLeYC/hGU9HaeAecjjHZfANMEE8
 tIVfFsIgnjGMCuZjHmnaVehpRLtVXPLclYATiVkhuZSD1fSuEo+dhkOijrD+ZGFEB0pX
 MuALlzi6AY3RhURGlj2pBmwHhM69+wHQYV5R7cI5mS+ziSIpXS+Sda/axUD1G4b7y9aw
 iILg==
X-Gm-Message-State: AOAM532MZ5fc1uI1IAbaoDxOYOlon7Cjb50IhfQF2T3go7J/xdGu3ff9
 uDb/h6mGXUT6QkuVSQi3IhU=
X-Google-Smtp-Source: ABdhPJw1scUdnUZRdy3/EYDI1WJHpzUsv5E7oA4yVYCtrzDCdpypISTAeaMWrVX/eBkOYx4+UIzMMw==
X-Received: by 2002:a63:f104:: with SMTP id f4mr3916557pgi.365.1601670038260; 
 Fri, 02 Oct 2020 13:20:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1be2:3dfb:f0b7:cc27?
 ([2601:647:4802:9070:1be2:3dfb:f0b7:cc27])
 by smtp.gmail.com with ESMTPSA id a1sm2388427pjh.2.2020.10.02.13.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2020 13:20:37 -0700 (PDT)
Subject: Re: [PATCH blk-next 1/2] blk-mq-rdma: Delete not-used multi-queue
 RDMA map queue code
To: Christoph Hellwig <hch@lst.de>
References: <20200929091358.421086-1-leon@kernel.org>
 <20200929091358.421086-2-leon@kernel.org> <20200929102046.GA14445@lst.de>
 <20200929103549.GE3094@unreal>
 <879916e4-b572-16b9-7b92-94dba7e918a3@grimberg.me>
 <20201002064505.GA9593@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <14fab6a7-f7b5-2f9d-e01f-923b1c36816d@grimberg.me>
Date: Fri, 2 Oct 2020 13:20:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002064505.GA9593@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201002_162040_492073_7E6FBDEF 
X-CRM114-Status: GOOD (  18.78  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Yes, basically usage of managed affinity caused people to report
>> regressions not being able to change irq affinity from procfs.
> 
> Well, why would they change it?  The whole point of the infrastructure
> is that there is a single sane affinity setting for a given setup. Now
> that setting needed some refinement from the original series (e.g. the
> current series about only using housekeeping cpus if cpu isolation is
> in use).  But allowing random users to modify affinity is just a receipe
> for a trainwreck.

Well allowing people to mangle irq affinity settings seem to be a hard
requirement from the discussions in the past.

> So I think we need to bring this back ASAP, as doing affinity right
> out of the box is an absolute requirement for sane performance without
> all the benchmarketing deep magic.

Well, it's hard to say that setting custom irq affinity settings is
deemed non-useful to anyone and hence should be prevented. I'd expect
that irq settings have a sane default that works and if someone wants to
change it, it can but there should be no guarantees on optimal
performance. But IIRC this had some dependencies on drivers and some
more infrastructure to handle dynamic changes...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
