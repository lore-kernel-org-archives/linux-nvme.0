Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF2AC49ED7
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 03:18:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0851214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 03:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JyNK8MXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0851214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0TftIajCOfgsBBc+EHCI0Z5xaSlFXGnaj4KB2fANvwc=; b=JyNK8MXbd3Ko5rjnPqFzqVr5i
	f+jJNELazhs1V9deMKIXRTlfgaez+QXXf+4Z5in2q3FAAh2GHJnJj8LbLnydNy5DAYhptlcx8u9UT
	kJntRa2GC3fsX1lyMkw+WUXA6imwahUTRpzcVQBIV11WtcEX8C8hFrj60p4FI40dunKuvIrIOhX01
	3adocJmJLng090FtGxXFwypMn4XVzKMiebmiVEY96q6YMUeNdWPejE34SuSMnBGm70eHhxErffckg
	Gh35cUti6qJzBZWV4itqhf1fCk8PX0q4JJGuKxuF5fHOQosIjU3MPsmtz57r8x2s0lAFAshDaGuQZ
	T3xZIH+9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iA408-0007zR-HS; Tue, 17 Sep 2019 03:18:00 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iA405-0007z7-DI
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 03:17:58 +0000
Received: by mail-pf1-f195.google.com with SMTP id a2so1241809pfo.10
 for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2019 20:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqH9oykYuwzo82qJZvA5tzaqJ2zxE8qUM2Z8nJtAKsA=;
 b=Kbnf/hT9sccHmpw4x+ER5mhjtS1/LwaJr2PUc56vP8FxRRGCtvdO+Gnq8hmpnF3SpH
 Xihg2Vhf+aRCti5GDdN+5nwldbM5Ea2jrlJoSQEwfl4iHdeiRcWgcryT2JJbXKuzMnNs
 AYvHoUJneGSSW4nk+W8wyzoKSyOLdukqkduA5fltn7gG7fxE4Y38Mrjf1sT55p0ebz3w
 oUckImO7PjYdP4WHrDHSIMGNjIW1AOqxFN7ZVaBVZrNUQVgaPXS1D/X+5kjqIxVfGxjj
 oEAhwR8dwhOp9mRx4gL67GduHANsYxGiJ+Pwi4ktgmeNoLONv9c0rbbFT6z/G9FF3ZiU
 JbjA==
X-Gm-Message-State: APjAAAW4ekg+PsA8+M8da8Z4HJEl4n43js6rDm/UnrPAzCCU5sbAvCog
 xIoZa3yzi2GgGXyqA7ODCXs=
X-Google-Smtp-Source: APXvYqyzqld75J6ev+sunBtsOqqLY8yOxr8YVxW5SXYYM148HXFgMcDc9uZDHBZu8q8BdiAv5hOOQA==
X-Received: by 2002:a62:f80a:: with SMTP id d10mr1816159pfh.98.1568690276191; 
 Mon, 16 Sep 2019 20:17:56 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1bdb:75d0:9089:df96:87d3])
 by smtp.gmail.com with ESMTPSA id c64sm626965pfc.19.2019.09.16.20.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 20:17:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvme/host/core: Allow overriding of wait_ready
 timeout
To: "Singh, Balbir" <sblbir@amazon.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
References: <20190913233631.15352-1-sblbir@amzn.com>
 <20190913233631.15352-2-sblbir@amzn.com> <20190916074153.GA25606@lst.de>
 <c51a4ac0b974e6efbd4f9d67adc8a70ae94ac325.camel@amazon.com>
 <20190916160117.GB1455@lst.de>
 <b9eb8038c04e3ae87d4f55ea228f8d12ef1ed42a.camel@amazon.com>
 <20190917011441.GA31163@C02WT3WMHTD6>
 <9612b87ed79704b89da559f42e3051ecb171a2ce.camel@amazon.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <ee9a3b5b-2572-5022-0322-e1e2ae38904b@acm.org>
Date: Mon, 16 Sep 2019 20:17:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9612b87ed79704b89da559f42e3051ecb171a2ce.camel@amazon.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_201757_460851_86033B0F 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "sblbir@amzn.com" <sblbir@amzn.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/16/19 7:56 PM, Singh, Balbir wrote:
> On Mon, 2019-09-16 at 19:14 -0600, Keith Busch wrote:
> [ ... ]
> In my case I was doing a simple mirror (using madadm across two nvme
> devices) and when I get timeouts on one, I need to wait up to 128 seconds
> before switching over. Ideally I want this to be really fast and drop
> the slow broken controller.
> 
>> If you really need the driver to do spec non-compliant behavior, we have
>> quirks for that.
> 
> I like the quirks approach, but it assumes the timeout value is not
> variable, but rather fixed by the quirk. I was attempting to really have
> mirrored IO timeout quickly on a bad device.

Other Linux kernel storage transports (FC, SRP) decouple the failover 
timeout from the I/O timeout. See also the output of git grep -nH 
fast_io_fail for the kernel source tree. See also the documentation of 
fast_io_fail_tmo in https://linux.die.net/man/5/multipath.conf. Maybe we 
need something similar for NVMe?

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
