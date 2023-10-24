Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFE3C07545
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 07:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=crcJZphGqKpgNzGM6PW7RcwV7MNwfIsOtsxoD091HgM=; b=xFX20ZZCzXy6G/B0bW3JdeBEGE
	d85PGkdvybtLb0BDAiWomz0aVBN2rWlZQVLguK9p751JalTYFxB1h4sL7b/u0yZrHt3eXEBLMGOhw
	u738E3UQCp1p1LtXN0JkG7/z+qmJeE9WhtMHbLQyPf5TheW/YwAjzaRRzXXtaUPoMuL+Uzueu4O+8
	MD+EUKkYZtpQUg+8HIsiUgBpNiaDyTTOwt3mevE4Wrqyt9tcF/oW9+RA2XUOoxe4zOK/CkWW512L1
	6aBupOQsvawfl3rHz3QWp54wIKNa/7sUOQyu6qNmc2CkXAVx5d5VdmV2QGl8TcXoVLSOMUEaMcIjM
	b1jg6gxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvC7D-00972v-2L;
	Tue, 24 Oct 2023 07:46:15 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvC7B-009721-15
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 07:46:14 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b3f6dd612cso2319776b6e.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Oct 2023 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698133568; x=1698738368; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crcJZphGqKpgNzGM6PW7RcwV7MNwfIsOtsxoD091HgM=;
        b=R8FRhPjFRO59C+u3xJBtziiswUviBE5UiDdelNrVA8ndWINcY3wKKQwRWrZLTduv3V
         lvkNDgJOIyRXKHdoSUPIlv/rfxvbXIN4NbJHRhOUnyb+4LqAoGpe4g1yHSmfRTjG/6Bn
         aIhAyr7kEH+9BPNqVvIgaxPuO3uFa/LlWXUMWEbiL0Plsa4ZGPVcoCCHklbStjdxkPo7
         8bVosh4gAud0C3b21hWdpGIAj+CXhIDT6iOkEsx2S9u6EIbplXgLtwN910kJUOe1lF0f
         Fm53fbX82/A8oHWNjLNl9W23busMm20mPSt4uyzUJuP61w4GUoT2czOLK0DTYPQiWK+d
         bQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133568; x=1698738368;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=crcJZphGqKpgNzGM6PW7RcwV7MNwfIsOtsxoD091HgM=;
        b=PupDx8MDzQ2zKA72kLrq0n7GM7FDXdnXBpimnMpbHjlQIgXeFnMJfAQQI6FW9cHy51
         qjiUjPyiYbXFTPYlmhOg/anMSiTUAIFEObnAuUgq3Ox2m4YN0aRIYjU9AGASj/2IJVZa
         4Ge/rfSGy0LiTBGxBmEOcWSmCat1L72rVBD8aTId8udV5jD7/lNOydN0fGHfOwcuCwcL
         Incp2OALLhU46qOOQMy0ATKzAN/hrrDFi3+w8TAz3w1elLQVNR5N/BT/YCEwh6hV8xT+
         j153tBSK0qdXfr9mvp3E5BvqLvI4CZNRwAJXaFcW6n6MB4bDEm2msxu/TLwNCO7Jz3At
         3OMg==
X-Gm-Message-State: AOJu0YxxKQU3FIBTlwVZNYqqKR0CZ6IvDFpVTRbwgcHIwi3w5ZBQ5SdQ
	/DYgOxXiNEkZ5JU70rfwx1wXHNSjj1M=
X-Google-Smtp-Source: AGHT+IHs1W1HIW7R0G5ajbRXMxhWCNb3B71kf0w4STqGqwHr8J1UnDLhCIs4OXoOxenNuC5X5YiAAg==
X-Received: by 2002:a05:6870:1148:b0:1ea:eed:fd02 with SMTP id 8-20020a056870114800b001ea0eedfd02mr11468882oag.45.1698133568543;
        Tue, 24 Oct 2023 00:46:08 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id k67-20020a632446000000b005657495b03bsm6366509pgk.38.2023.10.24.00.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 00:46:07 -0700 (PDT)
Message-ID: <462c5ed5-d8ce-4862-b1e9-04787847b4a6@gmail.com>
Date: Tue, 24 Oct 2023 14:45:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Block Devices <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai3@huawei.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, michallinuxstuff@gmail.com
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: queue/scheduler missing under nvmf block device
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_004613_376016_66C098BE 
X-CRM114-Status: GOOD (  16.75  )
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

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Noticed that under 6.5.6 (Fedora build, 6.5.6-100.fc37.x86_64) the queue/scheduler attr is not visible under namespace block device connected over nvme-fabrics. 
> 
> # readlink -f /sys/block/nvme0n1
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme0n1
> # grep . /sys/devices/virtual/nvme-subsystem/nvme-subsys0/*/transport
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme0/transport:rdma
> /sys/devices/virtual/nvme-subsystem/nvme-subsys0/nvme1/transport:rdma
> # [[ -e /sys/block/nvme0n1/queue/scheduler ]] || echo oops
> oops
> 
> What's a bit confusing is that each of the ctrls attached to this subsystem also expose nvme*c*n1 device. These are marked as hidden under sysfs, hence not available as an actual block device (i.e. not present under /dev/). That said, these devices actually do have queue/scheduler attr available under sysfs.
> 
> # readlink -f /sys/block/nvme0*c*
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1
> /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1
> # readlink -f  /sys/block/nvme0*c*/queue/scheduler
> /sys/devices/virtual/nvme-fabrics/ctl/nvme0/nvme0c0n1/queue/scheduler
> /sys/devices/virtual/nvme-fabrics/ctl/nvme1/nvme0c1n1/queue/scheduler
> # grep . /sys/block/nvme0*c*/queue/scheduler
> /sys/block/nvme0c0n1/queue/scheduler:[none] mq-deadline kyber bfq
> /sys/block/nvme0c1n1/queue/scheduler:[none] mq-deadline kyber bfq
> 
> 
> I have a little test infra which normally, after the nvmef got connected, would take the namespace device, set some sysfs attributes to specific values (that would include queue/scheduler) and then execute fio, targeting this namespace device.
> 
> The only clue I got is this https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d85ebf95c44e, but then again I am not sure what to make of it. Initially, my thought was "ok, queue/scheduler is gone, so just don't try to touch it". But if the c*n* devices still do have this attribute available, are they meant to be used instead of the actual namespace device, to tweak these specific sysfs attributes?
> 
> The problem here is that I have two c*n* devices but only single block device (multipath setup). Would that mean that changing either of those devices' attributes would affect the actual namespace device? Or is each path independent here?
> 
> Any hints would be appreciated. :)

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218042

-- 
An old man doll... just what I always wanted! - Clara

