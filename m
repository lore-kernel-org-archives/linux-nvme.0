Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07ABCCA47E
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HDaErepd7MXQL8sjcNVh04oN+eeqScy5EJEm65OASXE=; b=CXAnICFkMV9TY5hZ2/DAwnoUFk
	9CFExHF0wejz7qjTsLU8JUjAP1QqT6c5Q81R/n82aj4B6jre38aJuGKDlPQB62FrfAmbQZR40KI9p
	l9IEK7YPPJz8900MUizOyCMViIlqtEr73KPmuAZjAjLLWabnhQpwitdh/TKFfcRo5T7wcxuV6Uocz
	fHY34iaDlN7fgj1Ky31+USW+0hZmdZ1uVrGDfH8YRKmu1U7OwBeV6TGwGp+1p6wgNoDausf2uuwLo
	xydskbq8vDUMSZrX70Ahps+4xHMB5aHe8qDqRL9RUzZwrHSGvVqpHpfoJcNqA7vUJrmgmjJCvP4mJ
	iaTNlsIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3lKn-007JLW-18; Tue, 21 Jun 2022 21:22:53 +0000
Received: from mail-ed1-f49.google.com ([209.85.208.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3lKk-007JKj-5G
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 21:22:51 +0000
Received: by mail-ed1-f49.google.com with SMTP id z11so14967697edp.9
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jun 2022 14:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HDaErepd7MXQL8sjcNVh04oN+eeqScy5EJEm65OASXE=;
        b=oohOrJbbEylYmJi0aXa19s3OFm30+9o11wH51jf18NOlOh3HSVe5VvuwMk19r1Dual
         b1w4YwUfeeTbgoqxE6FKgkz9Ooc88mzVWCF5qGWZK+5wXK6UvN05Ch0qKcACy+BYe2SW
         ztRghxmuOgFja6BSnVJRS6fTzhsDKTfsjwygijfJl5mmVL7U5UDY8FI6yn6BIcaKKR0y
         rjOwnGR8hWkxyNGGjkpXA8N47rwEviS3JDyRRM6I2SQo2Da+zI/XtHXwpcAub2ss7Cel
         6cFsJdStYUxgyY0/87fnsElv59arq9aljzG9C+flvgqmVS1bEElrUW+eiMxV7tsdD7QV
         VgAw==
X-Gm-Message-State: AJIora8PI9ZO6RfZd6TBAkdxKAJjg7Y/8m/AN+eO33zJg+LIVqog969c
	oDWcRguMlkZJxR4hrvn2/NZ2bCkqUIo=
X-Google-Smtp-Source: AGRyM1tmH9+I+aRKtQE8yFR8dsEH+HhBGpfU65xR67KzQIvoLcnd1VUI+vQxXzHSMz5YW4ATMEsd/w==
X-Received: by 2002:a05:6402:40cc:b0:435:912b:257a with SMTP id z12-20020a05640240cc00b00435912b257amr107939edb.380.1655846567494;
        Tue, 21 Jun 2022 14:22:47 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id fd18-20020a056402389200b0043570d96d25sm8549550edb.95.2022.06.21.14.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:22:47 -0700 (PDT)
Message-ID: <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
Date: Wed, 22 Jun 2022 00:22:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv16 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220621172414.82847-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_142250_252644_2A24F062 
X-CRM114-Status: GOOD (  19.88  )
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


> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Thanks to Nicolai Stange the crypto DH framework has been upgraded
> to provide us with a FFDHE implementation; I've updated the patchset
> to use the ephemeral key generation provided there.
> 
> Note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters)
> requires a TLS handshake, which the in-kernel TLS implementation
> does not provide. This is being worked on with a different patchset
> which is still WIP.
> 
> The nvme-cli support has already been merged; please use the latest
> nvme-cli git repository to build the most recent version.
> 
> A copy of this patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
> branch auth.v15
> 
> The patchset is being cut against nvme-5.20.
> 
> As usual, comments and reviews are welcome.

Hannes, did you see my panic report on a malformed dhchap_ctrl_key?

Also, why does the dhchap_ctrl_key not passed when connecting
via discovery?

I have in the target:
--
# grep -r '' /sys/kernel/config/nvmet/hosts/
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_dhgroup:null
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_hash:hmac(sha256)
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_ctrl_key:DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C:
/sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_key:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:
--

Then on the host I have:
--
# cat /etc/nvme/config.json
[
   {
     "hostnqn": 
"nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f",
     "hostid": "14f15c4e-f6cb-434b-90cd-7c1f84f0c194",
     "dhchap_key": 
"DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:",
     "subsystems": [
       {
         "nqn": "testnqn1",
         "ports": [
           {
             "transport": "tcp",
             "traddr": "192.168.123.1",
             "trsvcid": "8009",
             "dhchap_key": 
"DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C:"
           }
         ]
       }
     ]
   }
]
--

And when I do connect-all (i.e. connect via the discovery log page:
--
# grep -r '' /sys/class/nvme/nvme1/dhchap*
/sys/class/nvme/nvme1/dhchap_ctrl_secret:none
/sys/class/nvme/nvme1/dhchap_secret:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:
--

This means that I can corrupt the dhchap_ctrl_key entry in the config
and no one will care (because it is not authenticating the ctrl if
dhchap_ctrl_key is not passed)

I think this is something wrong with nvme-cli/libnvme though...

