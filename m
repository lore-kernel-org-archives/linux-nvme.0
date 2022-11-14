Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1121CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/eeklWf1nCq4WM/A3kh6kkmdu+OcavNom6epsV8kcD0=; b=xybWWBe3I3MCXpCsK8NELfnqGZ
	G5RuQd/F7U6q1v7kuh/5Q1AYTcQF0C+saRm5A6tYi+5l1YYSCZOIvYK2A0qQHFcZD1BD7nGA4uY2x
	UCyrwPplD+67JodyiZI4m5q6dHtTINriFGn2j6bGdzfWWRZFZDLYOGhnCwXzo6sXWzuvwVWi+XpCu
	T4UImYtgiDIM9e+4HYPzYPHl0SRGhn04e/SE8ie6Pr+4IOnINxO5GxArZwSDBQy203kQvyx1w77BV
	GzcEK9pTfVw24YOXgyCGAHHq4/qdonCLzcKlDf8M32tUsNSm8TtNWXelBAOgJXRIGDbOZbDsHdpVg
	5t/FI3jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouTPf-00GRam-4n; Mon, 14 Nov 2022 06:57:47 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouTPd-00GRaC-6h
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:57:46 +0000
Received: by mail-wr1-f53.google.com with SMTP id bs21so16352870wrb.4
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eeklWf1nCq4WM/A3kh6kkmdu+OcavNom6epsV8kcD0=;
        b=xSHwzhMeOvaBt9PGlEtVsnKEHGxxenaA3cPNg2K5OhHU0rLBVwQwWcMc+63CZ7H3yj
         BVHCAf4YLryZLJr+YxpJ2lKujdaQm0bYiTD9oVAt1/80l9TOYsITkk/O/o8qUuHUr85Z
         81OpdqkqI22Lw8JHbEL/POHw4NjUno9o1HPn+LxPGWCqxiZlNOoNESbSo6JZf88jw31y
         TOBnU0uf0xFrwegrXn1maKnSYeFUOb+H5Ou4CDyNw6j7YnE76b3PXEvqXdIPpMNX+Hrc
         aPkKq71qjrHQwNRo+4pFF+yT7d16i/KvIo4GfFCRs8UESQeOFjLhYOHeAXD81aeXjy5C
         QKQg==
X-Gm-Message-State: ANoB5pnlARTMyvE8ok81kxGUm/eRIAlK2+YK21sZGjxY3A0ik40TqECF
	cltDPlDyS2bpywGUSkgkAVNu6fIPDqA=
X-Google-Smtp-Source: AA0mqf5IhjvKQ1aBLgIklrtRu0vlQk0FCBJ2Hvpc82Ew+1IuMe2bsNfetWfd0NN5Am+98fctBEOnhg==
X-Received: by 2002:adf:dcc3:0:b0:235:14dc:5e14 with SMTP id x3-20020adfdcc3000000b0023514dc5e14mr6854352wrm.252.1668409063071;
        Sun, 13 Nov 2022 22:57:43 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm21776967wmo.0.2022.11.13.22.57.42
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:57:42 -0800 (PST)
Message-ID: <a4fd461b-7c87-5223-dcf1-1ef251076f74@grimberg.me>
Date: Mon, 14 Nov 2022 08:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: dev_pm_qos memory leak again...
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_225745_268409_EB4C63FC 
X-CRM114-Status: UNSURE (   6.21  )
X-CRM114-Notice: Please train this message.
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

Anyone else noticed that this leak came back?
--
unreferenced object 0xffff8c7f753a5180 (size 96):
   comm "nvme", pid 11065, jiffies 4367781021 (age 261.143s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000ea22ef2c>] 
dev_pm_qos_update_user_latency_tolerance+0x6f/0x100
     [<0000000027e49fb6>] 0xffffffffc0de066c
     [<00000000a28f8b9e>] 0xffffffffc0e0e2ae
     [<0000000006fcc7f8>] 0xffffffffc0c8924e
     [<000000009fcecf5f>] 0xffffffffc0c893d1
     [<0000000074212a7b>] vfs_write+0xc2/0x3c0
     [<000000009005a2a5>] ksys_write+0x5f/0xe0
     [<00000000cd495c89>] do_syscall_64+0x38/0x90
     [<00000000f2a84ac5>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

This is probably the third time that this leak is coming back (most
likely from the gendisk-less admin queue...

