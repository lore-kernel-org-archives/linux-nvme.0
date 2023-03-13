Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306DC61DA4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFHL6A5eTTP3LD3FZXEcn0RnCA2sYnGlNzQPjbV5W/Y=; b=ulsEfiPsNIilLFOoJm+JE0xb+k
	8gti8U4Nv61CK/gH6qjd6c9hTHWT+I/pRPttbA7XZESRPdqUxxHCPh0Ejd285CSeethKYThubJ7f3
	yeqLhzQl+YgLV440AR1JnTXeIuqTltmxf0hvxnCwnACC8Ac7b3wCLE8UDsxznPB0bZsGyRB4yhSoM
	8vLHS0s8iGMcCfa0JXuM3Q+J3tutH6IJOiFw+Ta93NFXkxfFIZBNV+r1aEO++urEQIN8mIdGgocbW
	+Xc7l7ntZia2vGZHjbof5G5rZQsC+qB2QNopXWlIhaHAaX8ncZXi/tNTZtbTttvX1tsNpc77KTJaB
	60pApa5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdxe-004sHq-0k; Mon, 13 Mar 2023 08:55:18 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbdxM-004sDA-9x
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 08:55:07 +0000
Received: by mail-wm1-f48.google.com with SMTP id p26so7314050wmc.4
        for <linux-nvme@lists.infradead.org>; Mon, 13 Mar 2023 01:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vFHL6A5eTTP3LD3FZXEcn0RnCA2sYnGlNzQPjbV5W/Y=;
        b=zRPK7V08fDA2NMizWaSYQ2fvSp94nCMcj98w5jQk7zvZYJZ5fTDvQWhQShBrMdIqYy
         3+r5KKbNyQOigfYNRIprtingezNA9/cwNWOO5MkgnP0WU8DnYBbHYV2oLRGEMEje9prD
         4mqhNVSLjp7dKD5udW6iYVHRgu1vrPxcKlxor1SEnAex1ufQ/ytdWJk9iM8NcYDJIRcC
         Zh7zpSazui+rGtqjHeXoxkZA7HGb/oFTYgC3+yI9+seYHXkmwPsQxbE4u1SZVNOCCcN3
         NHEBVjAr9KrjvAkS9vAyODlBGcFMN5zQRTU4G9GlNEtbRHBIhIWdblqhBdfJrEAjxAgX
         Sl6A==
X-Gm-Message-State: AO0yUKVxlQ/sXXMcFzI2lz4AEDC0bkQk/t3u41yoOVnuSThLnbkfpz04
	3y4txzprPTNkSJNCnKM9bfk=
X-Google-Smtp-Source: AK7set/CdFlORQUcuKv3MtBLLYbVfyWmHSAPTPVLZyERgBqR9frFAA77cEVfoFsqh3eGyzNcpkuojg==
X-Received: by 2002:a05:600c:1c89:b0:3dc:5b88:e706 with SMTP id k9-20020a05600c1c8900b003dc5b88e706mr9520375wms.1.1678697697571;
        Mon, 13 Mar 2023 01:54:57 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cf706000000b003eb966d39desm8303898wmh.2.2023.03.13.01.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:54:57 -0700 (PDT)
Message-ID: <5126a316-fa63-9ffb-1d44-d6ff1f6b5853@grimberg.me>
Date: Mon, 13 Mar 2023 10:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error
 handling
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
References: <20230307163045.5882-1-akinobu.mita@gmail.com>
 <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
 <1e81d4f4-6b3a-ab7e-e81f-dd0af6590a50@nvidia.com>
 <ZAkg9J+Br3EF2oCU@kbusch-mbp.dhcp.thefacebook.com>
 <dd738a2d-4867-723e-c03e-a9018a7ae633@grimberg.me>
 <CAC5umygNMaJF+DY-q1wTx5EPU7PNcGNcHy5O0L61s_q3WASJgQ@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAC5umygNMaJF+DY-q1wTx5EPU7PNcGNcHy5O0L61s_q3WASJgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_015500_380595_F92964EE 
X-CRM114-Status: GOOD (  24.50  )
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


>>>> Sagi,
>>>>
>>>> On 3/8/23 03:06, Sagi Grimberg wrote:
>>>>>
>>>>>> In timeout and error handling, various information is reported about the
>>>>>> command in error, but the printed opcode may not be correct
>>>>>>
>>>>>> The opcode is obtained from the nvme_command structure referenced by the
>>>>>> 'cmd' member in the nvme_request structure.
>>>>>> (i.e. nvme_req(req)->cmd->common.opcode)
>>>>>>
>>>>>> For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
>>>>>> points to a structure within the page fragment allocated by
>>>>>> nvme_tcp_init_request().  This page fragment is used as a command
>>>>>> capsule
>>>>>> PDU, and then may be reused as a h2c data PDU, so the nvme_command
>>>>>> referenced by the 'cmd' member has already been overwritten.
>>>>>>
>>>>>> To fix this problem, when setting up the nvme_command, keep the
>>>>>> opcode in
>>>>>> a newly added member in the nvme_tcp_request and use that instead.
>>>>>
>>>>> I'm wandering if we should just not reuse the cmd pdu for a subsequent
>>>>> data pdu...
>>>>>
>>>>> It will take more space allocated per request (up to a few MBs for lots
>>>>> of requests and controllers)...
>>>>>
>>>>> but will prevent from propagating this to nvme core...
>>>>>
>>>>
>>>> Is there a way we can do this without increasing the memory usage ?
>>>
>>> The data pdu has to go somewhere. There doesn't appear to be another free area
>>> other than the command pdu, so if that's off limits to preserve the original
>>> sqe, then more memory is needed.
>>
>> If I take a somewhat extreme calculation, where a host has 16
>> controllers, 128 queues of depth 128 for each I end up with additional
>> 6MB, which is not insignificant for a driver...
>>
>> We could go with the original proposal of storing just the opcode, but
>> it then propagates to the core...
>>
>> Or...
>>
>> The cmd pdu has a size of 72 bytes (header + 64 byte command), perhaps
>> we can still reuse the same PDU space but rather take the last 24 bytes
>> of the cmd pdu?
> 
> This also fixed the issue.

I'm assuming this is equivalent to your Tested-by tag?

> Would adding the following static check help avoid unintended changes
> in the future?
> 
> BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) <=
>          offsetof(struct nvme_tcp_cmd_pdu, cmd.fabrics.fctype) +
>                  sizeof(struct nvme_tcp_data_pdu));

Umm, The arithmetic itself in nvme_tcp_req_data_pdu prevents this sort
of thing. What we probably need regardless and is missing is:
--
@@ -2679,6 +2691,15 @@ static struct nvmf_transport_ops 
nvme_tcp_transport = {

  static int __init nvme_tcp_init_module(void)
  {
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_rsp_pdu) != 24);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_r2t_pdu) != 24);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_icreq_pdu) != 128);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_icresp_pdu) != 128);
+       BUILD_BUG_ON(sizeof(struct nvme_tcp_term_pdu) != 24);
+
         nvme_tcp_wq = alloc_workqueue("nvme_tcp_wq",
                         WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
         if (!nvme_tcp_wq)
--

I'll send this and the fix promptly.

