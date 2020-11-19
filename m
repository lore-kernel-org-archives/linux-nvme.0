Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F766C5519F
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 03:09:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B76246AA
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 03:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pBmZdVqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B76246AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k2tFBzHnjlySfYb6cbFanP1CdHSATqtmyYnzNo7H7b8=; b=pBmZdVqcm0BzjBRaA5zF/MoGb
	jKMn0CNcwQGF10Z6vqt0HuT3h8zUjkEAdcC1j/DOg6rFeOi3XYbXwAGXyt6vJGSCIyYQssH0tnwM9
	Ey08adUI5PIQvNAQsudck33nDTqVIzUZGAKczc7Co66j3TFjU7DqbEoPWJaRT1JuVJ7GRgD45/zhn
	GSrdMgllsYBNz853eqPpXH/DThHH/S+/Nsk09LGZjZ3F39Iq2Vw2Ch200nH/9sjGfyqikPHZDQoi4
	hSdrWjzB8h0vo6St0d7ke3yEFZYSPGNQSjdRyw5iTaS61i1nw/EAqieXqJqRkuwmRziELav/iH0Mk
	vYyw1/SYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfaJk-0006lX-NQ; Thu, 19 Nov 2020 03:09:04 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfaJb-0006kz-Ac
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 03:09:02 +0000
Received: by mail-pl1-f193.google.com with SMTP id 18so2142595pli.13
 for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2020 19:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=giH61pOIw5bHesJZ4V9wI9hbzC6hKKbgOczqppew67w=;
 b=ZBEfmfUsAcJiCIykMioTy7cMxOL/XbfDjn6THWsSw0Jy5BnStE9omG+hLSzGhNkbcv
 m9Wqn8An/IHZnGPWvYtEj6YKyj9OxrBeWxEUCx+6igwBOji1ytQbjnkOjOlfxylOl7Kf
 022qTlIpSsy9pLuqIcqzzlRASnmG8oL6dJZCDXLXkoY3/b1fvaOf2kykumTS/HhMK6Yf
 MjmhEjrhRnC7S5SxXUQT0Olt6jz3bKBn9/uEwfeyrfMf3Sq/a618TaYo0kkzqy6s5oND
 PqrSa9lygnX/PBKEBlQrgAliSTbODzpGW7RjidHE+39/5Q6FbXmQLN+dhpx8PBeYOUeo
 5w0g==
X-Gm-Message-State: AOAM533GpITYZ5zi47oN7dKtHPDV9jhGfAr7/6OxGRPE/SzGFPNJUPVs
 NkBF3vUNvaeG5Zzb5NtZlmXRq4nSX48=
X-Google-Smtp-Source: ABdhPJy+pW+FkiCb9UB1eV5J5o2W1daIeqV4sDZCbdS9q5rJjxPY0fCIMxy5Anu1eCgPgP3WJkdiiw==
X-Received: by 2002:a17:902:7482:b029:d6:682d:5c6c with SMTP id
 h2-20020a1709027482b02900d6682d5c6cmr7025827pll.84.1605755331977; 
 Wed, 18 Nov 2020 19:08:51 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id c193sm26619650pfb.78.2020.11.18.19.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2020 19:08:50 -0800 (PST)
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
To: Keith Busch <kbusch@kernel.org>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201111191920.GA2573679@dhcp-10-100-145-180.wdc.com>
 <a2e50a52-49bf-9a69-5897-d471db5054b0@acm.org>
 <20201112142024.GB2573679@dhcp-10-100-145-180.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <fa3eb5e6-7864-ecce-df92-fd7a2b913f3a@acm.org>
Date: Wed, 18 Nov 2020 19:08:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201112142024.GB2573679@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201118_220901_543434_F937D6FB 
X-CRM114-Status: GOOD (  13.57  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/12/20 6:20 AM, Keith Busch wrote:
> The easiest check is something like this (as long as you're not actively
> using your nvme namespaces):
> 
>   # echo 1 | tee /sys/class/nvme/nvme*/device/remove
>   # echo 1 > /sys/bus/pci/rescan
> 
> The subsequent probes don't go through the async_schedule. They have
> this stack instead:
> 
> [   44.528906] Call Trace:
> [   44.530512]  dump_stack+0x6d/0x88
> [   44.532373]  nvme_probe+0x2f/0x59b [nvme]
> [   44.534466]  local_pci_probe+0x3d/0x70
> [   44.536471]  pci_device_probe+0x107/0x1b0
> [   44.538562]  really_probe+0x1be/0x410
> [   44.540564]  driver_probe_device+0xe1/0x150
> [   44.542733]  ? driver_allows_async_probing+0x50/0x50
> [   44.545170]  bus_for_each_drv+0x7b/0xc0
> [   44.547172]  __device_attach+0xeb/0x170
> [   44.549163]  pci_bus_add_device+0x4a/0x70
> [   44.551182]  pci_bus_add_devices+0x2c/0x70
> [   44.553229]  pci_rescan_bus+0x25/0x30
> [   44.555126]  rescan_store+0x61/0x90
> [   44.556975]  kernfs_fop_write+0xcb/0x1b0
> [   44.558940]  vfs_write+0xbe/0x200
> [   44.560710]  ksys_write+0x5f/0xe0
> [   44.562483]  do_syscall_64+0x2d/0x40
> [   44.564354]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hi Keith,

Thanks for the feedback. I will look further into this but I wouldn't
mind if someone else would come up with a solution before I have a
solution ready.

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
