Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66654C3A5A2
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 01:35:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB0922CF8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 01:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tacK4Vtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB0922CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zi0Z+GFMizq3a9gzRlrn7I2XAZw2ImNWIP9Jva15DGE=; b=tacK4VtkY4MOsbX5bOsKVCBrt
	aPD82fQNf2+u9MosvfXo/8R55wgyfpXhyFwnNHXiB+WAIE72LPE0fRC8P9FeMGyNG6cTNRChitG/J
	M20WP6Dc4e02lswbrrPIzlBtcUhxMuL5c8zwNflymAuDrbenSlHb/dGjfU5vfuEb14zV1b8K+nRJw
	3hCixHwzW4jPMUTgSgNXtGQmWjxzjmrcwXgk0IGMRfLvqPfEXB1jUlFEEROndEE1pWUU/AmiwQZDb
	3Z94TyGZjfaw1is7+Csr44TLv6mzNtSoZXrIB+tOcmqyHK0en68kHFqbPcD78TlEW7bd8L7VQKyau
	A3Aeohn9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5KCw-0004BQ-Ri; Wed, 04 Sep 2019 01:35:39 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5KCt-0004AV-OU
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 01:35:37 +0000
Received: by mail-wm1-f66.google.com with SMTP id n2so1557630wmk.4
 for <linux-nvme@lists.infradead.org>; Tue, 03 Sep 2019 18:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cVriKr46na9K66+qbHPCbYZK287/xFQJ6lf/grUOyVA=;
 b=RB6sdxUL8EsIkGvSvst3euPXVeq1NPCH330IMUDIrmpcT4asF/VZeTaCqMR3QZSCZz
 DWNfuSW6barKSEmQt89mbJ6SrwCwgftrTWRjxhnvpYLn6FQaJLEbH+cwLwMggmVlclBh
 03DXzKBOgzy82beK1RXZm48nEPQ5zeu4Chl1pHk7S703j/pt2gczBi6PyqVrFV04vJhz
 WMgUBStZaWdbWH7vcjE/bTfUbNE/k5tvkBrCnc7v2oYJnM1ZNZdycD14u0ZYLNlsGDM5
 gL9tbEw0oE8HsVYinwDjdFcw+XHxwZm6Iz6yVzd+Ly5CGVCwaU+soLEWf1eONTxdue/V
 J7/Q==
X-Gm-Message-State: APjAAAW6XJK+GeyeSe5x1tobmuCApv30IeXKLy8yhs9hpQlMGVJsiKLa
 /4TwlNqG3p1Gu66DYgiNJhg=
X-Google-Smtp-Source: APXvYqwTkQe0iNlryf7V5FTO30+pZa6wEDT/faxpYAu9NJ3kNQiIJ+qJky3Cllw5NpmC71aE/HPARw==
X-Received: by 2002:a1c:9ecb:: with SMTP id h194mr2065048wme.35.1567560934037; 
 Tue, 03 Sep 2019 18:35:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id a16sm935287wmg.5.2019.09.03.18.35.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Sep 2019 18:35:33 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830062036.GA15257@kroah.com>
 <73e3d2ca-33e0-3133-9dfb-62b07e5b09c4@grimberg.me>
 <20190902193341.GA28723@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f9204955-a1b3-796a-dc4f-fd7af7946635@grimberg.me>
Date: Tue, 3 Sep 2019 18:35:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902193341.GA28723@kroah.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_183535_806024_AF2269B2 
X-CRM114-Status: GOOD (  20.83  )
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
Cc: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Still don't understand how this is ok...
>>
>> I have /dev/nvme0 represents a network endpoint that I would discover
>> from, it is raising me an event to do a discovery operation (namely to
>> issue an ioctl to it) so my udev code calls a systemd script.
>>
>> By the time I actually get to do that, /dev/nvme0 represents now a new
>> network endpoint (where the event is no longer relevant to). I would
>> rather the discovery to explicitly fail than to give me something
>> different, so we pass some arguments that we verify in the operation.
>>
>> Its a stretch case, but it was raised by people as a potential issue.
> 
> Ok, and how do you handle this same thing for something like /dev/sda ?
> (hint, it isn't new, and is something we solved over a decade ago)
> 
> If you worry about stuff like this, use a persistant device naming
> scheme and have your device node be pointed to by a symlink.  Create
> that symlink by using the information in the initial 'ADD' uevent.
> 
> That way, when userspace opens the device node, it "knows" exactly which
> one it opens.  It sounds like you have a bunch of metadata to describe
> these uniquely, so pass that in the ADD event, not in some other crazy
> non-standard manner.

We could send these variables when adding the device and then validating
them using a rich-text-explanatory symlink. Seems slightly backwards to
me, but that would work too.

We create the char device using device_add (in nvme_init_subsystem),
I didn't find any way to append env variables to that ADD uevent.

Did you mean that we should add another flavor of device_add that
accepts char *envp_ext[]?

What exactly is the "standard manner" to pass these variables to
the chardev KOBJ_ADD uevent? All other examples I could find use
KOBJ_CHANGE to pass private stuff..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
