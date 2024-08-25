Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7128C5321E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35ZyhSg4n1mN7fnn5YBrg/MYaHRNhu6kqHwZmJ8j25Y=; b=t2tAXr2LbQggCFn9Mbvw5cG0vu
	A3DVGNdncQ73SxU8+dy8e+tIHLis2c9bAKDmvy6+InBliqnSweqIgcdeAbSRGeCIuoo3efnHvcyU/
	kkEHjlapbYYyAcYv8wxftxuCPl/hzuurfSzWECQNLRKH69n+6kvYtvezVv7IujVbqpQXzlnhDck4X
	MhripepUy6zdsIrQ+V/wDrG13XZRoHS3XNjwt+NIO17z5c4CyGfODrv/8q1LZTpnH/bxhsVFZf/SJ
	ZqoertjIoX1N+R3exjfkUob0bvhEMm3M1y9CRAGrml/bB6GMqvIhOO+a4Jz9wxzFX+apH8Fh6XbE9
	cYZYMsrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si98f-000000041TC-0XaW;
	Sun, 25 Aug 2024 09:02:21 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si98c-000000041Sh-2CDh
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 09:02:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42812945633so28226425e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 02:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576537; x=1725181337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35ZyhSg4n1mN7fnn5YBrg/MYaHRNhu6kqHwZmJ8j25Y=;
        b=PIjUIfQXvXM6W2pWSr4PCZJBngXgRefc6JUkc/lP/IKjAZULqng74xJcfHQ+at82Wz
         DmFu4/cqOKnNis8kUyynxfeY51b2/I9KSV6iBi6d4A/T6GP9C9K4nFzG9Upe248wbVdX
         rmtVw1eNdnsa5UK8w7yRKNKyiRbp4KIkaK+bhNDW6oE3Punm7eMeZF8UmzQom9OTSOcV
         EEJ8KofigmnMdR5qohKs9Fx4RVBqJmFSF3x4rI7o2h8/M1mUfEwTSPAx1tsjg8QQgTTl
         tph512u/XW1LHaqYVFHRWYYX57QAnIpwKt+p+YJGnerm1XXCVmit08UqAdcONTG15SBZ
         Sg3A==
X-Gm-Message-State: AOJu0Yz4F9rp8etQRAYMy8DGSRMC/NWJERN4AGmK/hIBm4atvSZz4WZv
	0P+dr70Y76YzlrLMy8G4BBI6MRLYk2RjvhBQEvcqH1iRmBR9n3O/Aghw+Q==
X-Google-Smtp-Source: AGHT+IHkm2XflKiAtcjoPoTILJW+q8iBIHfhP2IygAhzsVgqBQIPccqxWUQB5d52/oDifZxLI8pMFw==
X-Received: by 2002:a05:600c:19cc:b0:426:5546:71a with SMTP id 5b1f17b1804b1-42acc8d492fmr45101645e9.2.1724576535957;
        Sun, 25 Aug 2024 02:02:15 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8c2dbsm152816065e9.21.2024.08.25.02.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 02:02:15 -0700 (PDT)
Message-ID: <71888cf5-d796-42b5-a748-e4864bc273f9@grimberg.me>
Date: Sun, 25 Aug 2024 12:02:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Jonas Konrad <me@yawk.at>, Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
 <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
 <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
 <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at>
 <CAFL455mk0aD2DNOp5PPDKM=OJEVd-Cxj4gbtpQeUJH9gpnSs3A@mail.gmail.com>
 <CAFL455kXKGwmketGSK_4R_5jM11LzA5JMpBV4sUeDq8L5meuAg@mail.gmail.com>
 <53001ba3-42af-4038-97a3-4e5a88861623@yawk.at>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <53001ba3-42af-4038-97a3-4e5a88861623@yawk.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_020218_581425_AF44F64E 
X-CRM114-Status: GOOD (  10.56  )
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




On 21/08/2024 20:13, Jonas Konrad wrote:
> It's the default, 20.
>
> The machine has 192G memory, of which only roughly half is 
> used/shared/buffers. However a lot of memory is used by ZFS cache, 
> which may impact things. Next time this bug happens I'll try to get 
> some form of memory dump.

We really should not be allocating this much contiguous memory.
I think that the below change is also appropriate:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..010b8da2d2e6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1516,7 +1516,7 @@ static int nvmet_tcp_alloc_cmds(struct 
nvmet_tcp_queue *queue)
         struct nvmet_tcp_cmd *cmds;
         int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;

-       cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
+       cmds = kvcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
         if (!cmds)
                 goto out;
--

