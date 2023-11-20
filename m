Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD4C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PzPOM6HdPhfH7Eq33cCQiqS9sxBfqMfvyjtnsT+s9h8=; b=C7E4ekdBdg3M1lc/SlTQ0OVK75
	M94vOMQKqSOFVPMlgKqOUFlzwhSbbdjUzSgAG6wX2qG3AgQvT3uyYwD7U4RejHDk9pY478WoOJDuR
	/VLj8wjjiuoMmV32UPzpxc+lxwYG/M4MqEgeUL1lni8eLqCHLBdMfyO2Ml+ZfNe/7qu54hWT5G4YO
	0M0rmSqvpJiSat+872EiCtmEePO5fkwO4y2MZYdoVW+4mYJJD2e/xrhB1/ui8lhY826Jh8SoJ6d/R
	Bw1FPzZDWLz+BPVxhJDYJg748rRCCTQ3z2twYi5hNEFhb8uQc92/HlTB3lt4wkaVPSUL6ZQyKKng2
	YQIZaGeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r4xO6-00BD75-0Y;
	Mon, 20 Nov 2023 06:04:02 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r4xO0-00BD6X-1W
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 06:03:59 +0000
Message-ID: <92d069e7-6400-85b9-6e82-d32da7b258bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700460231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzPOM6HdPhfH7Eq33cCQiqS9sxBfqMfvyjtnsT+s9h8=;
	b=IRKHVp1EeqVgXgWqj1tjfd+smYNIrqGXcy2JUsjDNNj5rwQhcMdzPyfNPGUsscN3b975dK
	mn7Ap1nPnVu/zebp7HFWtNjPHdskaTLGYXzq53KBN6lVuB8YY/45m7wgN2bhRr9VhXIM3M
	/i2cXvuQ3kDo2goU3rpFldpawbHyrrg=
Date: Mon, 20 Nov 2023 14:03:28 +0800
MIME-Version: 1.0
Subject: Re: [Bug Report] NVMe-oF/TCP - NULL Pointer Dereference in
 `nvmet_tcp_execute_request`
Content-Language: en-US
To: Alon Zahavi <zahavi.alon@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <CAK5usQtOYQoHdOnfYi24kDx+qmA98hDnV7XuH1N2oKd+PyPsBQ@mail.gmail.com>
 <0af842c2-dec8-7e49-7528-e46bacdaa127@linux.dev>
 <CAK5usQsLOcKA55+hZJof2TCc4cZ3+FGqKa1ze9GyPVwDYCVjVg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAK5usQsLOcKA55+hZJof2TCc4cZ3+FGqKa1ze9GyPVwDYCVjVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231119_220357_270644_826520C5 
X-CRM114-Status: GOOD (  13.06  )
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



On 11/20/23 06:18, Alon Zahavi wrote:
> On Thu, 16 Nov 2023 at 05:28, Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>
>> Could you try the change to see if it helps?
>>
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -1062,7 +1062,7 @@ static int nvmet_tcp_done_recv_pdu(struct
>> nvmet_tcp_queue *queue)
>> le32_to_cpu(req->cmd->common.dptr.sgl.length));
>>
>>                   nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
>> -               return 0;
>> +               return -EAGAIN;
>>           }
>>
>> Thanks,
>> Guoqing
> Checked it.
> Although it seems useful to return some error here anyways, it doesn't
> help with the bug.
> The flow leading to the NULL deref doesn't reach this code at all,
> which is probably
> part of why it happens.
> The call trace looks like this:
> ```
>   nvmet_tcp_execute_request drivers/nvme/target/tcp.c:578 [inline]
>   nvmet_tcp_try_recv_data drivers/nvme/target/tcp.c:1232 [inline]
>   nvmet_tcp_try_recv_one drivers/nvme/target/tcp.c:1312 [inline]
>   nvmet_tcp_try_recv drivers/nvme/target/tcp.c:1338 [inline]
>   nvmet_tcp_io_work+0x202a/0x2990 drivers/nvme/target/tcp.c:1388
> ```
> so `nvmet_tcp_done_recv_pdu` is not called here.

My guess is if  rcv_state == NVMET_TCP_RECV_PDU, so

nvmet_tcp_try_recv_one -> nvmet_tcp_try_recv_pdu
                                                 -> return 
nvmet_tcp_done_recv_pdu
                                                     -> 
nvmet_tcp_handle_req_failure
                                                         -> *rcv_state = 
NVMET_TCP_RECV_DATA*
                                                     -> return 0

then back to nvmet_tcp_try_recv_one, it continues to call
nvmet_tcp_try_recv_data instead of goto done_recv.

Thanks,
Guoqing

