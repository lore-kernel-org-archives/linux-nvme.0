Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F09FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZcnXQzdoLkMiAZSbe4jqVzjE8JTALKwd6Zkl0Fp74O0=; b=wN/MEZIqQAgdni96QR/wwiULPn
	NKDTK+3YqkY7GlOu6/MHare5CbdU+N5NBJHn3aabqncAPZQDV4bXUWXPrYFZjKv/TN4VL3b+gP/Ax
	Y2Cpxk8kp2j4aF0jKeplfEgrU23al+2PoBuIYllRov8JXoB//VkZeTyud89gyuhjaANVrZSbdaAvn
	ZY3ErnjYXDp/JYClstozsg7IXQPWlp3Zt2NtFqwV3zjhCUeKQ9AueLQGOCwxZd5n0Ls7GLDoFAr0f
	mhMoi1rjMMhMFwN0WubaFVDMZWZZMTMPvizMNu3VZ0FFsTs7fuON7bM8GKzNCK3umqihizDGRFfxZ
	an03Xwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2zd-00DXtD-Aw; Thu, 27 Oct 2022 13:32:21 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo2lf-00DPtU-Ic
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 13:18:04 +0000
Received: by mail-pj1-x102f.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so6324275pji.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcnXQzdoLkMiAZSbe4jqVzjE8JTALKwd6Zkl0Fp74O0=;
        b=3L/WF6BI7qSOXeZwuIM757YSZj42Wkrkpj0lIuH4Q5ucnQGrJoxePTCR7OotFgqknI
         Ar8SFx9XjLa5BR6mC+SEf4chY+dQasRO/Y4s46cX6uPpOFMxp3ORCe7vGGziJo0KuFml
         HA81xDvmziGU8LGvXWhTYsqErMtbPW0ERIzR2uBxRxEXUSGYGUnTrQcefN4mTY4gqg8V
         ptqrhAadrT0zTdcvgLC+i/RmcqDnE4L3lj1FaUpMmHGdQnVQRVltdQBfPWkn9TAczfYp
         NUb9rIuPFsJmnXm8vF9hYVRHf2h5FfcFQ6yveflnW57rfVOvk5gBkE93tsjbQzLr1eIq
         ricw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcnXQzdoLkMiAZSbe4jqVzjE8JTALKwd6Zkl0Fp74O0=;
        b=L+DMa187i2jJhq6Zurqd1LMSaylpVzbHvHX/4PBuo790uwT5lyJC1QP14fgLftYgSE
         3TU7jownoWhyQBfuF/gFaq6Ud/NWxTtjqTXzOSf1l0B43Dn1B7NAxqJDe8veDQTW1sgj
         zZ3T3yvnpAt+zEZG10UNoBStxs9bloqCQM4MK8xMyIhFABbYkYllWLS3aK1rnkcEOdSL
         RFI/rsQWXKezucFegTid8uMpEGJnNbxSjO1n6oI640hbD8uxQRQStp5G/IFufrp8BhHI
         rAvrbVqS+Oo45IxeB/uTNpPFk7NzpqeEhc5RYSza7x6WhLZ662NOAym/8lHmC7TQAw74
         G3lg==
X-Gm-Message-State: ACrzQf2J6fSYN8haysAOKVyLgqhH4qDLljZ0L+l9dOrETS0v1ZPiTUnS
	6Yc6scFke3Mlo0AjoBVIiyFCOA==
X-Google-Smtp-Source: AMsMyM43mmU+J5NGB82NuBGETeZyz85Q2VFP4sj7mXoDMUdDGIldj3UpUWXxo3sxYaJWHVTbT32o2g==
X-Received: by 2002:a17:90a:588:b0:213:808a:9fed with SMTP id i8-20020a17090a058800b00213808a9fedmr961832pji.49.1666876670899;
        Thu, 27 Oct 2022 06:17:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n9-20020a63e049000000b004393f60db36sm1050831pgj.32.2022.10.27.06.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:17:50 -0700 (PDT)
Message-ID: <f49bd086-fe3a-670c-13ce-80f06a855166@kernel.dk>
Date: Thu, 27 Oct 2022 07:17:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 Alan Adamson <alan.adamson@oracle.com>
References: <CGME20221026171201epcas5p1f6333717c7f12b5a8fe362cf09c5447d@epcas5p1.samsung.com>
 <20221026170715.2657664-1-kbusch@meta.com> <20221027054136.GA5939@test-zns>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221027054136.GA5939@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_061755_650871_C6D74264 
X-CRM114-Status: GOOD (  18.69  )
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

On 10/26/22 11:41 PM, Kanchan Joshi wrote:
> On Wed, Oct 26, 2022 at 10:07:15AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The driver is spamming the kernel logs for entirely harmless errors from
>> user space submitting unsupported commmands. Just silence the errors.
>> The application has direct access to command status, so there's no need
>> to log these.
>>
>> Cc: Daniel Wagner <dwagner@suse.de>
>> Cc: Alan Adamson <alan.adamson@oracle.com>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>> drivers/nvme/host/core.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 686c55cb5d1a..da874172a31d 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1156,6 +1156,7 @@ int nvme_execute_passthru_rq(struct request *rq, u32 *effects)
>>     struct nvme_ns *ns = rq->q->queuedata;
>>
>>     *effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
>> +    rq->rq_flags |= RQF_QUIET;
>>     return nvme_execute_rq(rq, false);
>> }
> 
> Can we do this for uring-passthrough path too? Like below patch -
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 81f5550b670d..a91cefc38506 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -556,6 +556,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>        } else {
>                req->end_io = nvme_uring_cmd_end_io;
>        }
> +       req->rq_flags |= RQF_QUIET;
>        blk_execute_rq_nowait(req, false);
>        return -EIOCBQUEUED;
> }
> 
> Looks good otherwise.
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

Agree, we should do it for this path too.

-- 
Jens Axboe



