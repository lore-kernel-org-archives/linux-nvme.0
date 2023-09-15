Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E419EE642F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Sep 2023 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aBD/QY2QBucAHGj52Ld7agUK/IQJ5o5yP9JCds+UOhA=; b=SGxA+EbEIjx448Hu7rgbgW0Q+w
	wuKfDkfC22qBka8XlY5flbYmqOK96eLAHBxDvzcVqpf+YrvtJ89v7jT1x/4125Gm9ollh2hWMj4Up
	TakOoiLEbx7U0OGY57QEF1qSYreVo1siQN+EXDWSmqUGY8SLUzfwnjebWwpZAdkputV8aONgavEID
	V7WKj7DHuxDntZiN6P1ec8rCA6XRLn85kmkxSnqBv3rNi2u1jW0IHaDdqNuuKP7W0xp6Df0gpzlg9
	HSqTIP91DHR4uZ7iEc28LYq0H0y8xEPqce6XeajYggguYsfRjaF6KVZhngIr9COUXNnEl3/vGQRFW
	BXyFMFGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3RC-00A4HQ-1w;
	Fri, 15 Sep 2023 07:40:26 +0000
Received: from out-219.mta1.migadu.com ([95.215.58.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qh3R9-00A4Gr-0g
	for linux-nvme@lists.infradead.org;
	Fri, 15 Sep 2023 07:40:25 +0000
Message-ID: <044b5a7a-a8f4-e8d9-ce69-ee3d3c74462c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694763617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBD/QY2QBucAHGj52Ld7agUK/IQJ5o5yP9JCds+UOhA=;
	b=t0uu97bZOpgNbwYGjeME0945oeseGi0GfNVdo9Mrqy+IQvkYPQ1Cc1lPuCUpUqW6tUUfO0
	yZIDAdHOC90sQU8R7PiSDjKoPjN6EA7qJ7QEYRPWvyVnfyCqdEJYdp6UE4xG0+tTVYSmpG
	rAU5qNF3hz4YJPi4o76VTBK58VKBJuU=
Date: Fri, 15 Sep 2023 15:40:08 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep
 warning
To: Yi Zhang <yi.zhang@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
 <CAHj4cs_RiEb4SNdZ12xqEDgu7n-pObO6iUe8MMY6tq9xO6SLRQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAHj4cs_RiEb4SNdZ12xqEDgu7n-pObO6iUe8MMY6tq9xO6SLRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_004023_679161_A5EFF40A 
X-CRM114-Status: GOOD (  14.82  )
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



On 9/8/23 16:08, Yi Zhang wrote:
> On Thu, Sep 7, 2023 at 4:12 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Hi Yi,
>>
>> On 9/7/23 14:41, Yi Zhang wrote:
>>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>>
>>> Confirmed below issue was fixed by this patch:
>> Thanks a lot for the test!
>>
>> And I had got another similar lockdep warning about nvmet-rdma.
> Yeah, I've filed this one last year, but still not get one solution.
> https://lore.kernel.org/linux-rdma/13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me/

Hmm, it is a false alarm given the conn_id in cma_cm_event_handler is 
just created
by cma_ib_new_conn_id, so  conn_id should have different handler_mutex 
with listen_id
(which is the parent of conn_id)  though they share the same 
event_handler. And the
cm_id (listen_id) in the chain

nvmet_rdma_free_queue -> nvmet_rdma_destroy_queue_ib -> 
rdma_destroy_id(queue->cm_id)

should be created by rdma_create_idin nvmet_rdma_enable_port.

And the similar thing also had happened to rtrs.

https://lore.kernel.org/linux-rdma/CAMGffEm22sP-oKK0D9=vOw77nbS05iwG7MC3DTVB0CyzVFhtXg@mail.gmail.com/#t

>> Besides make similar change like this patch, another option might be
>> check queue state before
>> flush workqueue. Thoughts?
>>
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -1582,7 +1582,8 @@ static int nvmet_rdma_queue_connect(struct
>> rdma_cm_id *cm_id,
>>                   goto put_device;
>>           }
>>
>> -       if (queue->host_qid == 0) {
>> +       if (queue->state == NVMET_RDMA_Q_LIVE &&
>> +           queue->host_qid == 0) {
>>                   /* Let inflight controller teardown complete */
>>                   flush_workqueue(nvmet_wq);
>>           }

I guess the above can suppress the false alarm as well or similar change 
as in this RFC.

BTW, I suggest we need to move forward from the lockdep's report by 
either suppress it
or ignore it to save people's time.

Thanks,
Guoqing

