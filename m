Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55923C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18707610CE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18707610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qilmPVe0/mXe989C5w5773UqlhOV3oCrQZXqVsiOwRo=; b=KIeF9Ct99cioiT3yzAla/KiOFq
	bmz1GFLAzB2Nm/RF7wliJqGY6ckwf+Z1iJ9u99l22oih4gezLVNQ83AjLzNF0qlh18rG+7DCID0Ij
	/a/COF6eogA13yhF9ohwvNwV8X3qspUYBw6E0FosH3iuKomK3kDKfce9N5T50vqQYDWtj0pCQ5bzb
	i9vSRuL3kMaVvZChVbdYaJTZ4SrGza3xYHoAsBWBKDrfua2x5ARaAJl36Sppze47wRE+7xFFjyBCy
	Waaz+bMCvZUmyFfITfgH+8cEDve6SOBb55mY7G938+UMwWKP6M6TdV4PH04onYCceBRbHiH4daFjY
	2RKCrbZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2PN-004MGQ-J0; Tue, 14 Sep 2021 06:59:09 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2PK-004MEq-Vj
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:59:08 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 n7-20020a05600c3b8700b002f8ca941d89so1654628wms.2
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O+YD0uRfeqeVdOInm47CpQjRsIxOU9qM9xC7/+5X28k=;
 b=xAKJrP+6JcFukMF2IStZlIquK6oF7aKusxwspVRTvGFMQKRQPPdYfnjU91DIG90FoV
 0akp9a5Vc6XpQWVjxl5qv0ewtjupYaa+SwzF8azv+oBQwnH1k4W1vnUqJVPR3voBgG2P
 fO/T55dDMloDcwPysVz9MDm1j2ze1UDXYcx2IUe9pzTqdRf0G51Bep1gDI4yHyGESS46
 pqZ2qrdOt76teHp/cr5MzFHGErFu1C5A8Md2vJKgd8TKx/kzyuinrmTjwj75/rfxDOpy
 eN0BqWs3oKOTGBgzVSvOCISukq5cWCf05id7ntjEuqj/kLr35jufdtgTGQPsxpamYpsq
 KdZw==
X-Gm-Message-State: AOAM531bZHFXj1s26byDX+tYH7wA0Zu0s4OopOqt8ncg1mwPd6bHRERe
 Nk6ZcWjW4geY3GdTdReXMKtCTI2Q7oY=
X-Google-Smtp-Source: ABdhPJzLAbtiLxi6WUFArhR6VOsyrkFtwYoPNM0en5ZkbXVPs6bZ/DLmuUXFBKF+cGqfIUdBV+0Vtg==
X-Received: by 2002:a7b:c30b:: with SMTP id k11mr397205wmj.49.1631602742719;
 Mon, 13 Sep 2021 23:59:02 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l15sm194827wme.42.2021.09.13.23.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 23:59:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add 'gen-dhchap-key' command
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913102415.19044-1-hare@suse.de>
 <20210913102415.19044-2-hare@suse.de>
 <a64c9dde-7c81-85d8-a1d5-5b691a2f99be@grimberg.me>
 <20a61ffc-e910-0a62-9248-9a573029ac08@suse.de>
 <ff32b35b-1346-765b-def9-74656fda8cc3@grimberg.me>
Message-ID: <a8fa8d60-6959-17f2-4f3e-57d37d354b9d@grimberg.me>
Date: Tue, 14 Sep 2021 09:59:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ff32b35b-1346-765b-def9-74656fda8cc3@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_235907_080607_EFC5E16C 
X-CRM114-Status: GOOD (  18.01  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Yee... it won't be long until we'll hear complaints on this one.
> I think we need to have some simple format like:
> <default>:<def_hostkey>
> <subsystem1>:<hostkey1>
> <subsystem2>:<hostkey2>
> ...
> 
> And we will need /etc/nvme/subsyskey in the same format:
> <default>:<def_subsyskey>
> <subsystem1>:<subsyskey1>
> <subsystem2>:<subsyskey2>
> ...
> 
> And ideally we also have a way for nvme-cli to populate it in this
> format (or some helper script for it).
> 
>> So would just stick with the simple case, and leave this as an 
>> exercise to the reader.
> 
> Don't know if that is good enough...
> What do others think?

Also, if we expand the format later, we may introduce a pain when
updating nvme-cli...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
