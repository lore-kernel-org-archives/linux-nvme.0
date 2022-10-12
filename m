Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D2DC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Qdky2gs9ti+MN58zZhPnPX1GtOpmZkyQgYZcEZS2CE=; b=kbYN9lgE9ij4Cnz4/v4I7rJw6V
	aPyLWZNmzkdMLVcX86bU3LbHqaML6Torpip3MH5wt/eG3SUweLZ/6Rn5e+Pa7i40catEPhLJFJ6fZ
	+k+aF23/yRmVdP+NL418zQvoqsbDWz3GEMXfjn6TDCI23sA2GuOutMqqp+ior/h3R8u9u7qriSUe0
	JLLYPp+bt+MtewXhetNAcdjISr379s3H5XnJJT0WVlgYrD/AqgUnRE9fjrev8uPxxqc8ynK1P8Jqm
	4O8CSiXDED1AJ753IFPwt9YbRjrhx4zuaDmO267yFCjqQg2r5WAGog6IsXkoNlOYZdk3X8/DiDOdu
	GyE6j50Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oifYn-008r0Y-V0; Wed, 12 Oct 2022 17:30:25 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oifYl-008qzh-3D
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 17:30:24 +0000
Received: by mail-wm1-f53.google.com with SMTP id c9-20020a05600c100900b003c6da0f9b62so219189wmc.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Oct 2022 10:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Qdky2gs9ti+MN58zZhPnPX1GtOpmZkyQgYZcEZS2CE=;
        b=KtcTMv1ybPo6mpvCuGjAoVF/+/hfqP+90gvuyqi6wAQQ7AMEY+DsIqfT0v3HZ7Mc7y
         JASk28QaCxkFZThse+t/ckP0idin57ouXAbgOTD0TNiN+uX4aZbkzNqpyfH1nGK2ggP3
         ddFJJtQF67VFR26ckFmZ6kHOSVmX+EzJV6XSLX+hlBNVe0Wutr0HI/yDHnbBG4QU2fM+
         OLMiuU73EJGBiPP/D5vZgYkMz/D1IoySaWSjABBT9wbjYM6b+jrDoXNV1CTt9HhQ44iR
         B1XrT8izdyQLjg57pPEna501Vq0WLR6XqX00jvxqgX58SDGHSLqEV+QdEhbZ/4ExjnoF
         LmJQ==
X-Gm-Message-State: ACrzQf14/+YyB0K8pIz+BPoYDp+sK2E/NvL+ffMSmNBZzmcAa9hECimb
	pU4iSFGMTxtBGHFJnn8Fzuo=
X-Google-Smtp-Source: AMsMyM65YhK876O1TdLDF1ozNFMKYo51sO1DsAMzEdipjWwuEvGNWQnMVTdypWbz97ubIQbcnEivag==
X-Received: by 2002:a05:600c:4f89:b0:3b4:a6fc:89e5 with SMTP id n9-20020a05600c4f8900b003b4a6fc89e5mr3453156wmq.149.1665595820339;
        Wed, 12 Oct 2022 10:30:20 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c26d100b003a5537bb2besm2181483wmv.25.2022.10.12.10.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 10:30:19 -0700 (PDT)
Message-ID: <12074b00-7c53-5867-c785-58b96247d682@grimberg.me>
Date: Wed, 12 Oct 2022 20:30:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nvme-tcp request timeouts
Content-Language: en-US
To: Seth Forshee <sforshee@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
 <Y0XUFGXHciDCXRTs@do-x1extreme>
 <f7b44962-09d3-c724-89bc-453c86f4c1eb@grimberg.me>
 <Y0bxdiqgNAGoxeY6@do-x1extreme>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y0bxdiqgNAGoxeY6@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_103023_169685_AF3E817A 
X-CRM114-Status: GOOD (  30.50  )
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



On 10/12/22 19:55, Seth Forshee wrote:
> On Wed, Oct 12, 2022 at 09:33:19AM +0300, Sagi Grimberg wrote:
>> Hey Seth, thanks for reporting.
>>
>>>>>> Hi Seth,
>>>>>>
>>>>>> On 10/11/22 08:31, Seth Forshee wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm seeing timeouts like the following from nvme-tcp:
>>>>>>>
>>>>>>> [ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
>>>>>>> [ 6369.513283] nvme nvme5: starting error recovery
>>>>>>> [ 6369.514379] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514385] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514392] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514393] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514401] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514414] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514420] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514427] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514430] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514432] block nvme5n1: no usable path - requeuing I/O
>>>>>>> [ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
>>>>>>> [ 6379.761015] nvme nvme5: creating 128 I/O queues.
>>>>>>> [ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
>>>>>>> [ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)
>>>>>>>
>>>>>>> This is with 6.0, using nvmet-tcp on a different machine as the target.
>>>>>>> I've seen this sporadically with several test cases. The fio fio-rand-RW
>>>>>>> example test is a pretty good reproducer when numjobs in increased (I'm
>>>>>>> setting it equal to the number of CPUs in the system).
>>>>>>>
>>>>>>> Let me know what I can do to help debug this. I'm currently adding some
>>>>>>> tracing to the driver to see if I can get an idea of the sequence of
>>>>>>> events that leads to this problem.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Seth
>>>>>>>
>>>>>>
>>>>>> Can you bisect it ? that will help to understand the commit causing
>>>>>> issue.
>>>>>
>>>>> I don't know of any "good" version right now. I started with a 5.10
>>>>> kernel and saw this, and tested 6.0 and still see it. I found several
>>>>> commits since 5.10 which fix some kind of timeouts:
>>>>>
>>>>> a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
>>>>> 70f437fb4395 nvme-tcp: fix io_work priority inversion
>>>>> 3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests to time out
>>>>>
>>>>> 5.10 still has timeouts with these backported, so whatever the problem
>>>>> is it has existed at least that long. I suppose I could go back to older
>>>>> kernels with these backported if that's going to be the best path
>>>>> forward here.
>>>>>
>>>>> Thanks,
>>>>> Seth
>>>>
>>>> Can you please share the fio config you are using ?
>>>
>>> Sure. Note that I can reproduce it with a lower number of numjobs, but
>>> higher numbers make it easier, so I set it to the number of CPUs present
>>> on the system I'm using to test.
>>>
>>>
>>> [global]
>>> name=fio-rand-RW
>>> filename=fio-rand-RW
>>> rw=randrw
>>> rwmixread=60
>>> rwmixwrite=40
>>> bs=4K
>>> direct=0
>>
>> Does this happen with direct=1?
> 
> So far I haven't been able to reproduce it so far with direct=1.

It is probably because the ios are actually going through as 4k and
blk-mq tags depth is throttling you. on direct=0 writes are batched and
go down to the disk in larger blocks, and in bursts, which probably is
creating longer latencies...

> 
>>> numjobs=128
>>> time_based
>>> runtime=900
>>>
>>> [file1]
>>> size=10G
>>> ioengine=libaio
>>> iodepth=16
>>>
>>
>> Is it possible that the backend nvmet device is not fast enough?
>> Are your backend devices nvme? Can you share nvmetcli ls output?
> 
> Currently I have a quick-and-dirty setup. The systems I have to test
> with don't have a spare nvme device right now but do have a lot of RAM,
> so the backend is a loop device backed by a file in tmpfs. But it should
> be plenty fast. I'm working on getting a setup with an nvme backend
> device.

I see, note that ram drives are fast, but stall the cpu for memory copy,
which will prevent nvme io threads from servicing new requests, this can
be magnified with large heavy bursts...

> 
> o- / ......................................................................................................................... [...]
>    o- hosts ................................................................................................................... [...]
>    | o- hostnqn ............................................................................................................... [...]
>    o- ports ................................................................................................................... [...]
>    | o- 2 ................................................... [trtype=tcp, traddr=..., trsvcid=4420, inline_data_size=16384]
>    |   o- ana_groups .......................................................................................................... [...]
>    |   | o- 1 ..................................................................................................... [state=optimized]
>    |   o- referrals ........................................................................................................... [...]
>    |   o- subsystems .......................................................................................................... [...]
>    |     o- testnqn ........................................................................................................... [...]
>    o- subsystems .............................................................................................................. [...]
>      o- testnqn ............................................................. [version=1.3, allow_any=1, serial=2c2e39e2a551f7febf33]
>        o- allowed_hosts ....................................................................................................... [...]
>        o- namespaces .......................................................................................................... [...]
>          o- 1  [path=/dev/loop0, uuid=8a1561fb-82c3-4e9d-96b9-11c7b590d047, nguid=ef90689c-6c46-d44c-89c1-4067801309a8, grpid=1, enabled]

Ohh, I'd say that would be the culprit...
the loop driver uses only a single queue to access the disk. This means 
that all your 100+ nvme-tcp queues are all serializing access on the 
single loop disk queue. This heavy back-pressure bubbles all the way
back to the host and manifests in IO timeouts when large bursts hit...

I can say that loop is not the best way to benchmark performance, and
I'd expect to see such phenomenons when attempting to drive high loads
to a loop device...

Maybe you can possibly use a tmpfs file directly instead (nvmet supports
file backends as well).

Or maybe you can try to use null_blk with memory_backed=Y modparam (may 
need to define cache_size modparam as well, never tried it with memory
backing...)? That would be more efficient.

