Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CAAC4CEC6
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 15:58:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EEE20693
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k5E0+G5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EEE20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kHMkL9LMwLYZ694aWBohKjBJckURnR6NDT0M6Wo737g=; b=k5E0+G5JTZtKLOlARP6pts+7U
	n85QCzUbVKPuUqB1FbqUYf4EiSSqLmEYi7aNOPpXC993N01Z2y+sQrI/YjuJLhyzqB6+tdjqqU4fw
	4ryncH/eamNeD2AoXlnL6jiIIEsFfkMxQIb6tLjTzdvmrJ2OHfHSGSSxoIN5IVYHzpAndC/C8CbXy
	uL2LIolc7IAYl/6q+/TtoIn3VzAKbWzUb2V1/p3E313UlgOW32/Ek2x7wsbseLv7u5zCdaBjOQSfT
	UbyfLq0AwrBv4IjPsmYhLHv5phHANEZ8evTWZDPp5uie8ipVIyflNagURlzjodwJUkCEPCfFXPCBw
	ovZNKG4vQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8RU1-0001wZ-Kd; Thu, 12 Sep 2019 15:58:09 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8RTz-0001w8-NV
 for linux-nvme@lists.infradead.org; Thu, 12 Sep 2019 15:58:09 +0000
Received: by mail-pg1-f195.google.com with SMTP id z12so2154050pgp.9
 for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2019 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HzUOhX6raNAUS8YPdyvuVDI8gzg0MsOHBWxWGNC6q8I=;
 b=AQ/oUcoUNHKlgTlcdkWPhMpE+mpjm65l//Wt/wqQvp78Tzgje+uNBDuvry/aY+KCx2
 JaedAySWDkKuP11mJWGW3ypHw13VEkEPR93y2Xi2CUK1pbfnJA6DNcrZk5V8Q5KvDAOB
 8MCoCyPD1H79AZD9LWRCwko2VZwvrTtnT/KSPX2qNuN/zRPZJ754UAoJCKyKFgbY0H8/
 YLOrPrRIUB4/8N7oV94xVVr+dww1g4gijIyzmdMCvld6GxEMJSxOFpVUO9tn+SWXvgSP
 xmH2ZFUzKNZkocWd446MxoPBfKjcQtRgB697obsHnD0gxPkGX3ihVTlC+nET9awOQalY
 sjbA==
X-Gm-Message-State: APjAAAVL5c3CR6KFXoZauz0U9TdgxPexAJfGPLMmuuDHrSyEGbn39rm9
 mKdeADJyzJzB26aJ56sFPNw=
X-Google-Smtp-Source: APXvYqyLde3piiCC1efywXzKg44BdQAAaU8NPnU3OSE0GTeLHscqQ1b7bch+lZCKwGKzyaw/OV3rUg==
X-Received: by 2002:a63:971a:: with SMTP id n26mr13336585pge.67.1568303882427; 
 Thu, 12 Sep 2019 08:58:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:c36:579b:9814:69b7?
 ([2601:647:4800:973f:c36:579b:9814:69b7])
 by smtp.gmail.com with ESMTPSA id d14sm317390pjx.8.2019.09.12.08.58.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 08:58:01 -0700 (PDT)
Subject: Re: panic in pci driver
To: Keith Busch <kbusch@kernel.org>
References: <a1242213-47f1-ffa1-d71a-1b0abb1e1049@grimberg.me>
 <20190912033106.GA5820@keith-busch>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9553c7c9-fa09-7289-60c6-98d3d673222f@grimberg.me>
Date: Thu, 12 Sep 2019 08:58:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190912033106.GA5820@keith-busch>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190912_085807_768501_3988D5BE 
X-CRM114-Status: GOOD (  12.17  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Just hit the following bug on a simple test case with Qemu nvme emulation:
>>
>> for i in `seq 100`; do echo 1 >
>> /sys/devices/pci0000\:00/0000\:00\:0a.0/remove; echo 1 >
>> /sys/bus/pci/rescan; done
>>
>> Keith, is that addressed by your series with the reset_prepare stuff?
> 
> No, but this one fixes it, in rc5 (you're running rc3)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=bd46a90634302bfe791e93ad5496f98f165f7ae0

Yes, thanks for that, caught me by surprise...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
