Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B9AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Feb 2022 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6WQ222RrgFOQqHNjEJXb2H6/ub+vFxox4mp2WLtDS4=; b=UpIMb+FNvy7Uvp0UBLfeCllxKN
	FKF0leI9wjlDaJztIl5MrnHuijKz6430yT0Wro69XWQULTULzFhXXdFWLN2IkszbqMOwTSGfgyHNf
	duodidseubNDmds9rf14iBuVKsloI2hTWror/6GyqFabiMkqnHsOpeoOSZ+0+lJsY3dhNJvkUjwRk
	xFagAFf7nFZclfbHy98kHgKtPOsmXuUdeeS4NIBQ7w+7o/VlZPX1Zb9Y64Epy/T7FNpHss9y0kqqU
	qPsq0t8/eEct6kLknmuhSuK8P+Y1Xck+XoU8WUHEz9b1x+jTkHtVfv06SfJcVrFKwsRYcWtirON18
	BtmczsFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGdYJ-0082n9-CI; Sun, 06 Feb 2022 09:09:47 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGdYH-0082mh-5e
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 09:09:46 +0000
Received: by mail-ed1-f50.google.com with SMTP id w14so23409658edd.10
 for <linux-nvme@lists.infradead.org>; Sun, 06 Feb 2022 01:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=r6WQ222RrgFOQqHNjEJXb2H6/ub+vFxox4mp2WLtDS4=;
 b=71TiZc5eG2q7JybBD16DFURG5z1oy8xM+wH+Bo3rw06zQTcvb6Syy6JSjoL7oEHmTR
 TCLlcoBiwn7D7q/r9QSxqaTNVjwoEH+V8165Q/IyVryEuv8VEz3pvNJL4XQiPj9qU94G
 05app6+VDBXacPQm9oc9D+SYAv9JH3Qg1QZebx0jOOGMp/QQ7u/g/HzGWtv+FPQsz7B4
 NJGYz99Hgw38iESwir7UiDnZPTJ/mvQMOf5AFN5Lp6bhEYqzrkb9Dx7C/36Q4C6FutYD
 /Di03MLQHl7GmECQlACgQe+o+hUAt86+OoVMXhqknnesTUlFMpS4ucjXoYR1ewrqEop7
 H4PQ==
X-Gm-Message-State: AOAM5303mxoWIL2vGHCXIUkHPrVVaqBL5Tdd5Jp7NX5S632KqB7k7tIs
 5RJGpoxSgW71MrWKBEnDZ/I=
X-Google-Smtp-Source: ABdhPJx2Uj2MZ9fFUcLcfzMGwltK49tG2Muj9T/myxL0x0z9GdRcpHsiAK9ezz+0NunBrGRPYoKeQw==
X-Received: by 2002:aa7:d949:: with SMTP id l9mr8072592eds.348.1644138583558; 
 Sun, 06 Feb 2022 01:09:43 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id d23sm1379122edv.79.2022.02.06.01.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Feb 2022 01:09:43 -0800 (PST)
Message-ID: <b10f199e-83eb-7088-f9ea-44057b59b6cc@grimberg.me>
Date: Sun, 6 Feb 2022 11:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv2 3/3] nvme: Expose cntrltype and dctype through sysfs
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "Rose, Charles" <Charles.Rose@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>
References: <20220203211748.27542-1-nitram_67@hotmail.com>
 <BL0PR13MB429136A542739D745DE3AB679C289@BL0PR13MB4291.namprd13.prod.outlook.com>
 <YfzZmxPrtXwavoRZ@kroah.com>
 <SJ0PR19MB4544F6472AE13C8634E9AB9BF2299@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <Yf0yq3wXzvkPf5Wa@kroah.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Yf0yq3wXzvkPf5Wa@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_010945_274174_0FC15395 
X-CRM114-Status: GOOD (  23.67  )
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


>> Hannes suggested that we combine both attributes into a single one that would take the values: "io", "discovery-none", "discovery-ddc", "discovery-cdc", "discovery-reserved", and "admin". But Sagi did not like this proposal and instead proposed the changes that you see here. Basically, we want to be able to re-execute the is_visible() method after we have identified the controller so that we can determine whether the dctype should be exposed.

Just to note that the same fundamental issue exists in both approaches,
having the "combined" string change after the controller is identified
is equivalent to having the separated attribute appear after the device
is initialized.

> Nope, that's not how the driver model works and you break all userspace
> tools by doing this as it only scans the list of attributes when the
> device is created and announced to userspace.
> 
> By changing the files and types and such afterward no one ever notices
> and so userspace is "blind" to the change unless you want it to
> constantly walk all of sysfs all the time to find this out (hint, you
> don't want that...)

The idea was to add a separate udev announcement that would tell
userspace that these attributes are stable (it actually serves
a different purpose, but it does come after that point).

> 
> So there's a reason you are being forced to add a driver-core change
> like this, because it's not something you should do :)

I do agree that its a bit backwards to do this update. But the device
even today is not fully usable when it is created, so we know no
userspace program relies on the creation announcement.

>> So now I'm in a bit of a pickle. Sagi suggested this current patch set, but from what you're saying this is not a good approach. If you could suggest a solution that would satisfy all parties, I would greatly appreciate it.
> 
> Wait to create the device when you know the device type.

The initial proposal was to defer the device creation to after the
device is fully initialized. That though is a heavier lift because the
device initialization is something that happens on every reset or
reconnection after connectivity loss, so if we move the device creation
there we have to now check if this is the first time we are doing this
or not, and also error recovery becomes more opinionated...

