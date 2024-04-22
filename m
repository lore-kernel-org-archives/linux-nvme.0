Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA746C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 10:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ss5beKZTHht2vaLBTc6HYCogExwfAkEZk+V+c9HgkFw=; b=CnX3CGs4/ioC/FA81xiWSZBlxv
	tiHPzqrVPRCtuZU050vOs5K2IOLX2ori6qJXuSx93OnmncxsdIz+Si/UEjpkPQOVaVK7DgOW5HcmK
	jU7Wsk7GqSfROtIchZNN21VrPRlv1sr9abpi2j9YPqBIVBM2bRKWeooJe+ywq8/N649pAHfKFpVTt
	lD8YED2sAC6KRNUIV9banNs1NqltrP2plebePPSPpMiaBw2gaujBTXjSOEIp0tXql+RLvf0r20kA+
	5D5rrGS6e4AQLH8YHRYbWSVR73XNMhl1GYdEfmMuQEuNKN7yOW9QT0aEp+zeQe5EJn50m1ozykOXC
	TKuBvWkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryrBb-0000000DDmQ-3QUV;
	Mon, 22 Apr 2024 10:46:11 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryrBW-0000000DDlB-2sgj
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 10:46:08 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349a33a9667so621708f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 22 Apr 2024 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782764; x=1714387564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss5beKZTHht2vaLBTc6HYCogExwfAkEZk+V+c9HgkFw=;
        b=UFNDrchqomYySDQAw5I8bgmP4iel2MhCTXNVcpapMZ68Q+Sqp8+d4oNzhfnwbJDnBt
         Nmp+ltYCvH07nJtF7z2H74+nHrAOvJR+pOUucZO/Id0/mW7xO46wWtYFXo8V+H9GZR40
         WNtNR6it9+34fXD76l451WN2jspVersHPLXYaest2MBukMcOjCzdKBIIFI3OoU4PlPGh
         EwTPbfZs3V7knGFG6EBwHigVKWCNMeeMkGg6L0BQT15d7SSf4WeWTYpD2PqsIdBcYXMv
         0Hk/faPw2exNBXKVQ7elFR/4ZI3mRow+MFU5R7Gx0mLq672MRBHMU+arfYajNs4Na4vV
         QsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8laxH3EGfQGOpoe+aaMc10AP5gvKUrNzotNWhLTHQNdfRHTsN1B4UR4QY8DQl7htqVb2KTddZeGlInZqOie2JxeSb2nMndqdVzXcFWs=
X-Gm-Message-State: AOJu0YyTfvlt71SHAJNaGL+ikNfU5ixDHoOc0tfmzBlopTqYz1l8fpkE
	3nBI+aa1n5JyaAgjpglsBqnEdRrUZ5iKY91LaWJLyTgXpBgi3RSa
X-Google-Smtp-Source: AGHT+IHxzDoUkIFLa0ivqbj6YgwpYzzSYZkL37RYWvKY4Zi82lkd/iEbQi2NHw+Hq/vE/UNJMynxSw==
X-Received: by 2002:a05:600c:1d10:b0:418:3d9b:b38e with SMTP id l16-20020a05600c1d1000b004183d9bb38emr6638369wms.4.1713782763863;
        Mon, 22 Apr 2024 03:46:03 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm20224057wmo.5.2024.04.22.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:46:03 -0700 (PDT)
Message-ID: <54666822-4e7f-4ec2-982b-541380cec154@grimberg.me>
Date: Mon, 22 Apr 2024 13:46:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
 <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
 <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_034606_757786_649A5910 
X-CRM114-Status: GOOD (  16.65  )
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



On 22/04/2024 7:59, Yi Zhang wrote:
> On Sun, Apr 21, 2024 at 6:31 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>> On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
>>> +linux-nvme list for awareness ...
>>>
>>> -ck
>>>
>>>
>>> On 4/6/24 17:38, Yi Zhang wrote:
>>>> Hello
>>>>
>>>> I found the kmemleak issue after blktests nvme/tcp tests on the latest
>>>> linux-block/for-next, please help check it and let me know if you need
>>>> any info/testing for it, thanks.
>>> it will help others to specify which testcase you are using ...
>>>
>>>> # dmesg | grep kmemleak
>>>> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>>
>>>> # cat kmemleak.log
>>>> unreferenced object 0xffff8885a1abe740 (size 32):
>>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
>>>>      hex dump (first 32 bytes):
>>>>        c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
>>>>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>      backtrace (crc 6328eade):
>>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>>>        [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
>>>>        [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
>>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
>>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>>>        [<ffffffffc262a881>] 0xffffffffc262a881
>>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>>>> unreferenced object 0xffff88a8b03647c0 (size 16):
>>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
>>>>      hex dump (first 16 bytes):
>>>>        c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
>>>>      backtrace (crc 860ce62b):
>>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>>>        [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
>>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
>>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>>>        [<ffffffffc262a881>] 0xffffffffc262a881
>>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>> kmemleak suggest that the leakage is coming from lo_read_simple() Is
>> this a regression that can be bisected?
>>
> It's not one regression issue, I tried 6.7 and it also can be reproduced.

Its strange that the stack makes it look like lo_read_simple is allocating
the sgl, it is probably nvmet-tcp though.

Can you try with the patch below:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..bfd1cf7cc1c2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,6 +348,7 @@ static int nvmet_tcp_check_ddgst(struct 
nvmet_tcp_queue *queue, void *pdu)
         return 0;
  }

+/* safe to call multiple times */
  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
  {
         kfree(cmd->iov);
@@ -1581,13 +1582,9 @@ static void 
nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
         struct nvmet_tcp_cmd *cmd = queue->cmds;
         int i;

-       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-               if (nvmet_tcp_need_data_in(cmd))
-                       nvmet_tcp_free_cmd_buffers(cmd);
-       }
-
-       if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-               nvmet_tcp_free_cmd_buffers(&queue->connect);
+       for (i = 0; i < queue->nr_cmds; i++, cmd++)
+               nvmet_tcp_free_cmd_buffers(cmd);
+       nvmet_tcp_free_cmd_buffers(&queue->connect);
  }

  static void nvmet_tcp_release_queue_work(struct work_struct *w)
--

