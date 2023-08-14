Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE948EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQ77JWlcF/3CKlrUcH+wSXPOTkNjnUsQD1YZzzBs6TY=; b=FakMbhk0TNwqsjlxuV7dcCUH1p
	mTI1uoHrQxuLa6jMph9xn02sg2WwE/UdfKrMqVG6hwcyrpcboxkGW22kwfM2vqZ8Io9uMqxPNnlK1
	XyWu4IfaNuzNfnUFJF5k6pTdwfTv4vLPY4G9I6arLwnEVHjQ1cfHYYExm2QalCjIk2WDZzOWIPNK6
	vZVvcAl86C9loul+AkJn/78biLczL4ufRlDTWTi/dlYekK7uP0F+NstlWi8UNH5HZA9jCoBXTO5xS
	uPn12fBuI2bMY6YbMYfUE2DEB8MMqVilLZ8rf85bSf291qEEN6PUT0HVw0McSSfPtcslafLeS6U+b
	bj4eIZjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVcod-000ATV-0j;
	Mon, 14 Aug 2023 19:01:23 +0000
Received: from mail-lf1-f45.google.com ([209.85.167.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVcob-000ASF-0w
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 19:01:22 +0000
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso1985762e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 12:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039679; x=1692644479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ77JWlcF/3CKlrUcH+wSXPOTkNjnUsQD1YZzzBs6TY=;
        b=YqSDb9Oi0VmlavL4fGThB1NPmSAw9D3EJxUlny/biad3xgTaKOux3YLJLhijMS7Bkw
         0IyFHPlXYblbyaPtaQkLOhKLVe1t73fOf6VF+NkpWG2wW8NV92ODVaCYIdY8V7yVvl1w
         hMRp5mHDk5HOaGjibT1tDyjddP4s+ZGtmRhw/k4V1cGcM6FvesBQWMlhP7oZG1EnXpDU
         Ed4gnrAEM+qaLDNDfFhqV4hbwjCpzYoRG6sIS9iBbsxa/uVzelsVgck6pjcHqoiqjcwG
         2hnn36AjzJLLW5gw4O5oFnxElJn7GW9GWVAGTCcTUhne4Uv9dbRzLqsBlzzrvdpZvACl
         Fl0Q==
X-Gm-Message-State: AOJu0YwsuureutoNwGW9DKcqiRn3ryahfpy52fdRMKcGLDBTBX44BdPg
	KAMAxQ5jtMMO6mxiMveMKmE=
X-Google-Smtp-Source: AGHT+IFmLrTLGuDhCCL9vHJGXv/EwdcTHk0uU9kaQdWWrlrg1XR/E2162sm0MRiorOfiuwiNj22ICA==
X-Received: by 2002:ac2:519a:0:b0:4fd:cab4:7d15 with SMTP id u26-20020ac2519a000000b004fdcab47d15mr4727508lfi.2.1692039678801;
        Mon, 14 Aug 2023 12:01:18 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090635d200b0099d0a8ccb5fsm5990701ejb.152.2023.08.14.12.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:01:17 -0700 (PDT)
Message-ID: <1a28b970-1954-a482-5906-c6ee96b248f0@grimberg.me>
Date: Mon, 14 Aug 2023 22:01:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 08/26] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-9-aaptel@nvidia.com>
 <1d5adbe9-dcab-5eae-fff3-631b91c2da94@grimberg.me>
 <2535y5hwqkg.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2535y5hwqkg.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_120121_330137_59135408 
X-CRM114-Status: GOOD (  12.28  )
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


>>> @@ -1308,6 +1407,15 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>        else
>>>                msg.msg_flags |= MSG_EOR;
>>>
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
>>> +             ret = nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id,
>>> +                                      blk_mq_rq_from_pdu(req));
>>> +             WARN_ONCE(ret, "ddp setup failed (queue 0x%x, cid 0x%x, ret=%d)",
>>> +                       nvme_tcp_queue_id(queue),
>>> +                       pdu->cmd.common.command_id,
>>> +                       ret);
>>> +     }
>>
>> Any reason why this is done here when sending the command pdu and not
>> in setup time?
> 
> We wish to interact with the HW from the same CPU per queue, hence we
> are calling setup_ddp() after queue->io_cpu == raw_smp_processor_id()
> was checked in nvme_tcp_queue_request().

That is very fragile. You cannot depend on this micro-optimization being
in the code. Is this related to a hidden steering rule you are adding
to the hw?

Which reminds me, in the control patch, you are passing io_cpu, this is
also a dependency that should be avoided, you should use the same 
mechanism as arfs to learn where the socket is being reaped.

