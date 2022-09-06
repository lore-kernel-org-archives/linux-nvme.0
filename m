Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A7ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXNXCTMQvl91gJQQD8zWsXD+k9ISAw8HX7ZLJ01i51Q=; b=WhZKETsrHgEqo5kTStPcoADKGd
	9jAkPphmb1Krf1YBPaEVFumS2wG7ZrgE43CgAy4nlqRXKtpga1u+QLCtnnO/y5bYdzqOD66wNrMbE
	kxdW7vHddfW3XM6l4fBSiqEqvimPxJT2aaQza3zwli9AFryJTwQkEmAuEmk0hec4z1jwVkWihEM6T
	CDwTMxZu3C6VB4T+r4S2L8PP6wN1GJWuEe11JhfTDfgwwX6wMKzyhqRidn7yEA5guUDX5Vg1UaWF2
	lXzN7iRQ5aaSCzme3IarCtTCfEdNCaiKUyZT22x4zQZF30lZ4mJ6DD34O6g8sbh3yjvtGe+/3nYuj
	ydwZTTCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYJQ-00Dc32-JB; Tue, 06 Sep 2022 13:08:20 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVYJN-00Dbz5-VP
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 13:08:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id c131-20020a1c3589000000b003a84b160addso8859992wma.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Sep 2022 06:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gXNXCTMQvl91gJQQD8zWsXD+k9ISAw8HX7ZLJ01i51Q=;
        b=G870UXPMEg2Al9DqzoApw6CK1jSjuhQDiD2GHRt7w+qtb2/ZG9tllfr2H1QPqWlWPD
         sowL3iFRRrCrGLzO4JF4SXWN0+3epOPZX3iB0S8u7sIYPwd37p3vhIE3ejBjNsaBDFgQ
         dNtrpCZ19C0SKclxy2mIeAzoRTcPpbu3kf2kZgmBETDmrYv0BF7lt6ZrSZKVi9UcU9gO
         lrrgFVkLyFLYPuG316C4Onwhk9ff0aciZas27yQ+h2SOMnGT1TSRz1kDHdxhol3j1D05
         pr4mmphLBmLzINMZircyMNPeEGfehfOozEmTiPVqrU4WUAGAFp/jTx7JYQov6Ty34maH
         1BLw==
X-Gm-Message-State: ACgBeo3XED6R5AKh2c172uXez/Ef4bjjxjuxRb6hKietZTJGMWolQaDs
	PSjVRvlKED2OLXMAPo5xSQA=
X-Google-Smtp-Source: AA6agR47dt2W1ah1GYRQwOq1nx12kTTDzPvcltf289lQGXBOrDx72iT7QX47B++83oH5RefOJG8FuQ==
X-Received: by 2002:a05:600c:4148:b0:3a5:4f94:577b with SMTP id h8-20020a05600c414800b003a54f94577bmr14021915wmm.167.1662469693169;
        Tue, 06 Sep 2022 06:08:13 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k27-20020a05600c1c9b00b003a845fa1edfsm33949292wms.3.2022.09.06.06.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 06:08:12 -0700 (PDT)
Message-ID: <c9399436-3d45-90b0-731a-6baa0605f918@grimberg.me>
Date: Tue, 6 Sep 2022 16:08:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] nvme-tcp: Print actual source IP address through sysfs
 "address" attr
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
References: <BL0PR13MB42919EA6B50B34A1A60455969C7A9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <e98a1c28-4994-470d-6fee-ed569de536ed@grimberg.me>
 <SJ0PR19MB45440F0F979FB14315AE6B4DF27E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB45440F0F979FB14315AE6B4DF27E9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_060818_063382_8233E7E8 
X-CRM114-Status: GOOD (  15.51  )
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


>>> TCP transport relies on the routing table to determine which source
>>> address and interface to use when making a connection. Currently,
>>> there is no way to tell from userspace where a connection was made.
>>> This patch exposes the actual source address using a new field named
>>> "src_addr=" in the "address" attribute.
>>>
>>> This is needed to diagnose and identify connectivity issues. With the
>>> source address we can infer the interface associated with each
>>> connection.
>>>
>>> This was tested with nvme-cli 2.0 to verify it does not have any
>>> adverse effect. The new "src_addr=" field will simply be displayed in
>>> the output of the "list-subsys" or "list -v" commands as shown here.
>>>
>>> $ nvme list-subsys
>>> nvme-subsys0 - NQN=nqn.2014-08.org.nvmexpress.discovery
>>> \
>>>    +- nvme0 tcp
>>> traddr=192.168.56.1,trsvcid=8009,src_addr=192.168.56.101 live
>>
>> I wonder how this works with udev events etc for auto-connect? and also for
>> uniqueness checks...
> 
> Udev events are triggered by device properties (which are not the same as attributes).
> The properties are found in the attribute "uevent". For example:
> 
> $ cat /sys/class/nvme/nvme1/uevent
> MAJOR=238
> MINOR=1
> DEVNAME=nvme1
> NVME_TRTYPE=tcp
> NVME_TRADDR=::ffff:192.168.56.1
> NVME_TRSVCID=8009
> NVME_HOST_TRADDR=none
> NVME_HOST_IFACE=enp0s8
> 
> The change I'm proposing does not affect device properties and therefore no impact on udev rules.
> 
> With regards to uniqueness checks, there is only one place in libnvme where we read and check the "address" attribute (file: tree.c, function: nvme_ctrl_alloc). The code will simply skip "src_address=" and extract all the other known keys from "address".

I'm concerned that adding this unconditionally may trigger someone to
fail due to this addition... It is also confusing when host_traddr is
provided...

If this would be logged as pr_dbg instead, would this achieve the goal?

