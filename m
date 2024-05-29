Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC3FC25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIhxxfJdm7UCrG08Dq/neg6lxFvjAtrsOkzxlMPMwZk=; b=KNzrDBVHYZiTl408fUapl+LNIE
	Lqevf5fwro670zW5R/hh70dfL2JsKoB9r/yGYYLpSUgHvqoOd4em5De8MLkco09/oamdvnB4cX8w0
	oEUf9kebiEk3dONnt8DmE4G893NV2O6wVSEtism4qNwfq89N6Y+ALugto4wTXud49kUJv3559Oq4T
	as97RMi7y/sptlYSgeL1+jH9l1zUNhlIPziHoEmfVlmUWpf6b5efpIwr3S9QdPJsAqx7mPDrJjQtT
	6SstkdDZadxnnXkZG9KjMmm/y/sdA4dBhckS6t2si/3Qi53Ztj2wdH3uMXh+VKxa1ljsAnf4XaDid
	3OwFcqbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCIlx-000000049s7-0kFs;
	Wed, 29 May 2024 12:51:17 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCIlu-000000049qu-1rl6
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 12:51:15 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4211fb904a8so2810325e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 May 2024 05:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716987071; x=1717591871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIhxxfJdm7UCrG08Dq/neg6lxFvjAtrsOkzxlMPMwZk=;
        b=pKzMTLr63uAyNp2zBENqT/99cgNAzQnN+lXqubUj9A9XZ6tjZs89n+Qx+YCg6sfFpd
         OgBaqGvIe6ey4ArvFjE1bz7fV6bP59SXdDI6Ih9tUIzTdmWBgzwgvRTaDFGQZ93BnoGU
         blv6ix4y0NF3HbzwZBjTA34AK+w52/X8SPnHrm/GqXaj7MJEYsJlxNCDXvWhsAnypOJ9
         9V3BXK9QD3NZPQyheichG1ci//XPpYKKwYpaojgI6mnnZrxpx1dr+f2D1d06j1u8Wxlb
         6DVqOd5Qoct42OCbCCGPuo61mn9G48CFF85YoVJUIZDVL73T6wFDLOnmeC3ei3myZQuD
         M1GQ==
X-Gm-Message-State: AOJu0YxFQBEMvPLDr+3b6oQskqHYVDx7YBwNHK7HAQAXldQ5NAQzNR97
	xpSdOC1gpia0Ait1QjVwS4rlQT7vZ1LngT3SmaishdJm9Fclc1PA
X-Google-Smtp-Source: AGHT+IEYPJK8rw8IIgUziPVhWrvPlLVmlXk4InFU2ZllYZ6YtPzQh/luhr+3eJnh1ly3pPxbS+uY3g==
X-Received: by 2002:adf:e642:0:b0:354:de95:9762 with SMTP id ffacd0b85a97d-3552fe18542mr10384157f8f.5.1716987070690;
        Wed, 29 May 2024 05:51:10 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a0908c7sm14693669f8f.51.2024.05.29.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:51:10 -0700 (PDT)
Message-ID: <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me>
Date: Wed, 29 May 2024 15:51:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests nvme 041,042 leak memory
To: Maurizio Lombardi <mlombard@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_055114_511644_3A91DF63 
X-CRM114-Status: GOOD (  14.13  )
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



On 29/05/2024 12:08, Maurizio Lombardi wrote:
> út 28. 5. 2024 v 11:44 odesílatel Maurizio Lombardi
> <mlombard@redhat.com> napsal:
>> This patch fixes the problem for TCP, it should also work for loop but
>> I've not tested it.
>>
>> http://bsdbackstore.eu/misc/0001-nvme-fix-memory-leak-when-nvme_init_ctrl-fails.patch
> I updated it to fix all the fabrics, with the exception of apple's driver
> because I am not sure I fully understand its probe process.

It'd be better if we didn't propagate this issue to the transport drivers.

Seems that the asymmetric part is the device_private allocated in device_add
but only removed in device_release (last reference).

A hack like this would also make the issue go away:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f62fd49c1411..8a9d51e1ccd6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4702,6 +4702,14 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct 
device *dev,
         nvme_fault_inject_fini(&ctrl->fault_inject);
         dev_pm_qos_hide_latency_tolerance(ctrl->device);
         cdev_device_del(&ctrl->cdev, ctrl->device);
+       /*
+        * this is nasty hack, but device_add allocated a device private
+        * dev->p, which is freed assymmetricly in device_release, and
+        * in order to cleanup after ourselves, and not rely on the device
+        * .release handler (which also calls the nvme transport free 
handler)
+        * we explicitly free the device private.
+        */
+       kfree(ctrl->device->p);
  out_free_name:
         nvme_put_ctrl(ctrl);
         kfree_const(ctrl->device->kobj.name)
--

But this is ugly...

