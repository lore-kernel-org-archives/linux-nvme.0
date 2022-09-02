Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14611ECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 02:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21tuyaqs1vXmiWanrx2wXGnQAxkSG8CXdu407GW+pl8=; b=TNANXxfe8bMHS3IEsCTaLp497H
	FWHXGbGdtoVjAy0KaANRb/F+70rKVqLe79gyPM4BHGA8PXEVQkU0LxgPBhQkFWCLat3NhzwmscjGU
	+IJ+wkLuYPVwUHmgeOsBbIGpQGI1capMDkaU/nXCHJsp1+HaSSblRCNmd24q4bZqmWd279hJaWkaG
	89INvjxVw49V/sh/Dz7NGqEZE7YB9qzl7Z8CHE6WTiAG4T6EIx4ZGQsinZV0SJVp+EtsQbjqsTdgo
	TBcSZSlrkMAofLrvjxOxhriUiYruPzgAvNOQrlB/aghCVvujsGq1K2Bxx2/0riuGw89Oyg3klQfsa
	uJIR51KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTwZ6-00H1Xd-AB; Fri, 02 Sep 2022 02:37:52 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTwZ3-00H1TT-4u
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 02:37:51 +0000
Received: by mail-pj1-x102a.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so6690201pju.1
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 19:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=21tuyaqs1vXmiWanrx2wXGnQAxkSG8CXdu407GW+pl8=;
        b=zbMKRGazbm1KrHImUnWrYDGuiPfF7phVtFs4j0Z35FsT9/kORv31YVz2ufvqJWP1W1
         oHlPL/Hqp4zo21FgxkC5QtmKosdv+hWChMiqh9U27SyyFQcH/W3kozIKw5V2aEd8CFKa
         17l65BCyOF4cSZPFZLuDBkGFyF9bpIwAnajruqa6B+2eTFyNQ0kWYbSyVzM9YORi3+Xl
         cTo+rADPXgKjccyun8G6Vn2tsH0ZquUIhfhTgGP+dVviWyIeb7O+0sKMzb4WFi3hrhjf
         pGvX13lsc3OD6FcJxZTPUkXdijbAe3izTBG/uk/F85QsMSNhca99t+/Rn8LdI8TMFT53
         7wAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=21tuyaqs1vXmiWanrx2wXGnQAxkSG8CXdu407GW+pl8=;
        b=nwdIdw9Q0/RtQIzYd8kMMbDVOBcqeWmzonq/NdnLDSSKsfEs98qHEB2g5wQiKAM6MI
         mMdJbTpiNDxoz9cKVLgJ9XT02b0UQ4p+34D8C18v6Zfy7iX43G4nW7yviyXOZMxl+zZz
         jngo3bpE6xeeS5yBPtJ0MEWeDF68brbNmin7yIhIvMJorEnzxMyljJFg9FAkBmVsXBTP
         NLd3ZBXmTnRb86fISs3heW4vDaeKPSCvAELCYW1DxTHh3334IC5Pb1xQQBgCqwDUpV8t
         nitu97MqA4ifvDddQvmfAJIERQlEGcJYnsiv/nAQzSD+dRtwNHiv8oDYFth7tDz5eAmh
         NDGA==
X-Gm-Message-State: ACgBeo2wanJqeb56yjyGrR6m3fy/fO/Zrq+MvnNAaJlrKaufA/7tOiVw
	w/YpqEIiaq9RsVGnCFGNUZikj8Dd2XqhOg==
X-Google-Smtp-Source: AA6agR70lXWiSYOehD1/HyPGkVxHRBe3KA2ak/PssCKtf4wb6t+6554LN1MuiOjM/TtyZOXFEx/U9A==
X-Received: by 2002:a17:902:c403:b0:174:3a8a:b6e3 with SMTP id k3-20020a170902c40300b001743a8ab6e3mr32022633plk.48.1662086259048;
        Thu, 01 Sep 2022 19:37:39 -0700 (PDT)
Received: from [10.76.15.169] ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id l194-20020a633ecb000000b0042fe1914e26sm252411pga.37.2022.09.01.19.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 19:37:38 -0700 (PDT)
Message-ID: <db63eaac-08e5-cb78-9aef-14b3c9955e8b@bytedance.com>
Date: Fri, 2 Sep 2022 10:37:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Re: [PATCH v3 1/1] nvmet-tcp: Fix NULL pointer dereference during
 release
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20220901061409.545456-1-pizhenwei@bytedance.com>
 <20220901061409.545456-2-pizhenwei@bytedance.com>
 <33269462-f989-c4ba-a9ac-846b629cd360@grimberg.me>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <33269462-f989-c4ba-a9ac-846b629cd360@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_193749_213901_040EAFA7 
X-CRM114-Status: GOOD (  22.26  )
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

On 9/1/22 18:52, Sagi Grimberg wrote:
> 
> 
> On 9/1/22 09:14, zhenwei pi wrote:
>> nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
>> and waits the inflight IO requests in nvmet_sq_destroy(). During wait
>> the inflight IO requests, the callback nvmet_tcp_queue_response()
>> is called from backend after IO complete, this leads a typical
>> Use-After-Free issue like this:
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 0 P4D 0
>>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: 
>> G            E      6.0.0-rc2.bm.1-amd64 #12
>>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
>>   RIP: 0010:shash_ahash_digest+0x2b/0x110
>>   Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 
>> 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 
>> 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
>>   RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
>>   RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
>>   RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
>>   RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
>>   R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
>>   R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
>>   FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) 
>> knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
>>   Call Trace:
>>    <TASK>
>>    nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
>>    ? __switch_to+0x106/0x420
>>    process_one_work+0x1ae/0x380
>>    ? process_one_work+0x380/0x380
>>    worker_thread+0x30/0x360
>>    ? process_one_work+0x380/0x380
>>    kthread+0xe6/0x110
>>    ? kthread_complete_and_exit+0x20/0x20
>>    ret_from_fork+0x1f/0x30
>>
>> Suggested by Sagi, separate nvmet_tcp_uninit_data_in_cmds() into two
>> steps:
>>    uninit data in cmds                  <- new step 1
>>    nvmet_sq_destroy();
>>    cancel_work_sync(&queue->io_work);
>>    free CMD buffers                     <- new step 2
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index a3694a32f6d5..e18eae5ef90b 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1423,14 +1423,27 @@ static void 
>> nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
>>       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
>>           if (nvmet_tcp_need_data_in(cmd))
>>               nvmet_req_uninit(&cmd->req);
>> +    }
>> +
>> +    if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>> +        /* failed in connect */
>> +        nvmet_req_uninit(&queue->connect.req);
>> +    }
>> +}
>> +static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue 
>> *queue)
>> +{
>> +    struct nvmet_tcp_cmd *cmd = queue->cmds;
>> +    int i;
>> +
>> +    for (i = 0; i < queue->nr_cmds; i++, cmd++) {
> 
>          if (nvmet_tcp_need_data_in(cmd))
> 
>>           nvmet_tcp_unmap_pdu_iovec(cmd);
> 
> This function should no longer exist in the code.
> 

Hi, Sagi

Sorry, I didn't notice this patch is on the way...
https://lore.kernel.org/linux-nvme/Yw%2F0cZFCQQpx3hhZ@ZenIV/T/#t

I'll send the v4 after this patch apply. Thanks!

>>           nvmet_tcp_free_cmd_buffers(cmd);
>>       }
>>       if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
>> -        /* failed in connect */
>> -        nvmet_tcp_finish_cmd(&queue->connect);
>> +        nvmet_tcp_unmap_pdu_iovec(&queue->connect);
> 
> This function should no longer exist in the code.
> 
>> +        nvmet_tcp_free_cmd_buffers(&queue->connect);
>>       }
>>   }
>> @@ -1452,6 +1465,7 @@ static void nvmet_tcp_release_queue_work(struct 
>> work_struct *w)
>>       nvmet_tcp_uninit_data_in_cmds(queue);
>>       nvmet_sq_destroy(&queue->nvme_sq);
>>       cancel_work_sync(&queue->io_work);
>> +    nvmet_tcp_free_cmd_data_in_buffers(queue);
>>       sock_release(queue->sock);
>>       nvmet_tcp_free_cmds(queue);
>>       if (queue->hdr_digest || queue->data_digest)

-- 
zhenwei pi

