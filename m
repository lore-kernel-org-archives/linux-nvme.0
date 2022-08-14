Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35123C25B06
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nu1E7AmmDIl2LFiTiOoUmoMGabBpkxzR1LmY2ZhmWkw=; b=lSjGdqEj9jxDZ+z0hUt4I2jug0
	tP4/NxM6jgFpt6KYOkbWKH6Ug6KCybN9YB7lfpX/3NNNh6iJf8+D1o0vHm2nz9gwkHIj6EI32pCVF
	RnvwGkeNYVf/+GGxKzf+oyUknUEqUsEwu9Y7cAKkbqA2ILDwx8cd7h3xzrzHfIdR7qyx4l4BKkAfV
	rnUG922f6ny6YEZdbL+UXCCNOh9qQ3m5ksOv0a1H2Psdp5UBy5d0Wo1ijOzOyDteq7tStzyBJ7Vxd
	o3fGOMhAK3ecsb3WS8ybs9sbmfV0usSb81rsjSDjuGPBjfPO+ufUXWOzQzX+dyOBQ10XvYWdKLnYn
	nCjFO5WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNEXz-007409-0s; Sun, 14 Aug 2022 14:24:59 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNEXw-0073z6-6E
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 14:24:57 +0000
Received: by mail-pl1-f182.google.com with SMTP id p18so4461677plr.8
        for <linux-nvme@lists.infradead.org>; Sun, 14 Aug 2022 07:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Nu1E7AmmDIl2LFiTiOoUmoMGabBpkxzR1LmY2ZhmWkw=;
        b=u7jQDdnyItEnpZlyd1Hi5gar2h8feQmKL81iPEgvZqbyu9E0Ucg8vb8MRUHx0yNTnB
         xuRBYXmLaqTtHPm78H7hWu70jcBWyAVgfVTwoMYTsuAHHEoza4aJ06b7QxwPVK/Hbb3p
         ets+1AD6JhP+hPWU95SqCmzrWIHmegGeQvcjZ+0OlSb9A8KOqK0DdCJ1BtKetqrUTLzE
         qGzHlRlvLJlhJcrmEpEvWBAkt9GEQc09XybejWxBTQv0cmQrl75x1zls6bnx2z4z44Hc
         OYvM4tA8ShWqhCiAbmcY3Ivffsb7PmxH1SBldv/9v4y6hNbeu60ZlMGW7aQVF1Tpqxa2
         OZAQ==
X-Gm-Message-State: ACgBeo29cGFTRRFem+Hm31apwgrJRzQZEXFI8IqnBwlmsfJ84GuoXGBs
	y+sn42zT3oqjL970Qu2n6mI=
X-Google-Smtp-Source: AA6agR5HCgWAcQjNp29LelwPDbPAB0mm64U/w5KM+jlUo+hz5aRdPoEqZyCP7VVUl818K/V7bQ1yRA==
X-Received: by 2002:a17:902:6808:b0:170:9453:8203 with SMTP id h8-20020a170902680800b0017094538203mr12696076plk.24.1660487094199;
        Sun, 14 Aug 2022 07:24:54 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id f7-20020a623807000000b0052acb753b8bsm5156039pfa.158.2022.08.14.07.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 07:24:53 -0700 (PDT)
Message-ID: <9ec2e292-1e75-8ee2-a9fc-d5adfab92fbd@acm.org>
Date: Sun, 14 Aug 2022 07:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet: Fix a use-after-free
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20220812210317.2252051-1-bvanassche@acm.org>
 <cd2189da-59b3-c01e-9bd3-5f838258c7bc@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cd2189da-59b3-c01e-9bd3-5f838258c7bc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_072456_251152_401CBE81 
X-CRM114-Status: GOOD (  12.96  )
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

On 8/14/22 04:45, Sagi Grimberg wrote:
> On 8/13/22 00:03, Bart Van Assche wrote:
>> @@ -745,9 +747,9 @@ static void __nvmet_req_complete(struct nvmet_req 
>> *req, u16 status)
>>       trace_nvmet_req_complete(req);
>> -    if (req->ns)
>> -        nvmet_put_namespace(req->ns);
>>       req->ops->queue_response(req);
>> +    if (ns)
>> +        nvmet_put_namespace(ns);
> 
> Why did the put change position?
> I'm not exactly clear what was used-after-free here..

Hi Sagi,

Is my understanding correct that the NVMe target namespace owns the 
block device `req` is associated with and hence that the namespace 
reference count must only be dropped after dereferencing the `req` 
pointer has finished?

This is what I found in the NVMe target code:
* nvmet_put_namespace() decreases ns->ref.
* Dropping the last ns->ref causes nvmet_destroy_namespace() to be
   called. That function completes ns->disable_done.
* nvmet_ns_disable() waits on that completion and calls
   nvmet_ns_dev_disable().
* For a block device, nvmet_ns_dev_disable() calls blkdev_put().
* The last blkdev_put() call calls disk_release().
* disk_release() calls blk_put_queue().
* The last blk_put_queue() call calls blk_release_queue().
* blk_release_queue() frees struct request_queue.
* blk_mq_complete_request_remote() dereferences req->q.

Thanks,

Bart.

