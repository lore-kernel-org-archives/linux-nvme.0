Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD7CC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 14:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2KH7jTZBIBZhvzmYBshrWkNr2V+owGJwqefWyYk5j8=; b=RoW6IUIVV1TGh55w4tL0GfMTn/
	+VJdc3cCXAurUc8lPpfE/TB0j1W9LSHSyiWVwmTKzzJMiFYpo/zlvZqUdNMRhXAPYlNImvKW2fAfZ
	71qcOwqgS1u4bW5lG53WETztvUmsmiiNiSUNQddY4PfjWODirj5yCTON/IoL1CffFcWI430yy8s4r
	ccsZ2UDFCMY3DdkTKWf1a8JEwuaZPFTXwXMHc7OkuOAZJ8KABJBvXEG2XotvwXNsVuNSLaRssL5xx
	agFeNqvMtUmIxG4VQQyWjcDay+0f1DpJI/jzedtvpBpn9qDQCMrg2X9xlYtV3g6JFpGBATIZY0ZFE
	kWo9gu/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noQxl-002Yns-4Q; Tue, 10 May 2022 14:35:45 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noQxi-002YmV-1N
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 14:35:43 +0000
Received: by mail-io1-xd2d.google.com with SMTP id z18so18728456iob.5
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=Q2KH7jTZBIBZhvzmYBshrWkNr2V+owGJwqefWyYk5j8=;
 b=O3L35Wzrzn/NVWRf3erThoEvB4SX8YJYuv87w515bB1TEgYTUIifU+K/kooL+1TWUk
 qx1C8bLKtvNJmk8NkpGgdr4+YVo22DiAoIOd/lS78K6NwS/dnzfPltVTLjoO3RMIKl7e
 tqKIKZBj213gMXNDSpf8EoLymrR68MOPkx9xg+zKtOVgXNAsKXWoANsMNDwNTihpve4e
 qd3AYAoRVZgqdwLi/eetdHLOvW9EjSR/z2iGSjfdKkJpzAUtYymrSamZ1XwTlyXjez3/
 l+qrjEXN3NzOPeUIRhBFxG46BgaijjMEne2uypS/+jvXG6GGvMTbDvaPKzyd3KAhgrUF
 3yDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Q2KH7jTZBIBZhvzmYBshrWkNr2V+owGJwqefWyYk5j8=;
 b=uNC1xkaXisVKSLbF3JhvzWCGRkIEeb8oQNU11VlX7Mx0aAYEBnWLqCAJwPSsWoAOKs
 w/flpmI3x8FnfYox7zfDcBQ0esbJm5EAWSt3XCF+w6C7rj8atarcB7RP4I+fXtoxJeBq
 WeCS2uPLqsbfppq85CuZ4Vx4Ur/cwPBsQ8PlwHKj6PDliwSvEP+NO9oGGdNdF/9PixAp
 Po93KIqIQfXvQls2/PYqKPp77LdllTkYLsTTEujyK3EDVIC/DWqphIm1nQNsi2Y/XhxY
 EoKGxfyn7U4anALlfFn+nJIoVlIGMsM+Kl/kLgO7/7haWdls2l4lfQnP0WmgIvtE1M24
 njTg==
X-Gm-Message-State: AOAM533D0IuhR3aFFcR7sIqhlpLrtc1RhfhpdA1Kwok/OyBLPh5uolMT
 Y5Fw8rvDJlsPaFC5l0xD6L33Xg==
X-Google-Smtp-Source: ABdhPJxYZYINodWtjarzTaNgG21II+gn273WefdihpfHl3jOR98mh7p8OLBueLwj4xnN9DdmxzD3Gw==
X-Received: by 2002:a05:6602:1642:b0:65a:c4a2:85ca with SMTP id
 y2-20020a056602164200b0065ac4a285camr8450754iow.111.1652193338168; 
 Tue, 10 May 2022 07:35:38 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a02cab0000000b0032b3a781789sm4417229jap.77.2022.05.10.07.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 07:35:37 -0700 (PDT)
Message-ID: <8608a963-1969-7979-5438-f545f5534aea@kernel.dk>
Date: Tue, 10 May 2022 08:35:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/5] fs,io_uring: add infrastructure for uring-cmd
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Stefan Roesch <shr@fb.com>,
 Anuj Gupta <anuj20.g@samsung.com>, gost.dev@samsung.com
References: <20220505060616.803816-1-joshi.k@samsung.com>
 <CGME20220505061144epcas5p3821a9516dad2b5eff5a25c56dbe164df@epcas5p3.samsung.com>
 <20220505060616.803816-2-joshi.k@samsung.com>
 <1af73495-d4a6-d6fd-0a03-367016385c92@kernel.dk>
 <CA+1E3r+airL_U0BzmLhiVPVkWdbiAXxxyHXONy9bGx4uuJFhdA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3r+airL_U0BzmLhiVPVkWdbiAXxxyHXONy9bGx4uuJFhdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_073542_346985_23013957 
X-CRM114-Status: GOOD (  22.15  )
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

On 5/10/22 8:23 AM, Kanchan Joshi wrote:
> On Thu, May 5, 2022 at 9:47 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
>>> +static int io_uring_cmd_prep(struct io_kiocb *req,
>>> +                          const struct io_uring_sqe *sqe)
>>> +{
>>> +     struct io_uring_cmd *ioucmd = &req->uring_cmd;
>>> +     struct io_ring_ctx *ctx = req->ctx;
>>> +
>>> +     if (ctx->flags & IORING_SETUP_IOPOLL)
>>> +             return -EOPNOTSUPP;
>>> +     /* do not support uring-cmd without big SQE/CQE */
>>> +     if (!(ctx->flags & IORING_SETUP_SQE128))
>>> +             return -EOPNOTSUPP;
>>> +     if (!(ctx->flags & IORING_SETUP_CQE32))
>>> +             return -EOPNOTSUPP;
>>> +     if (sqe->ioprio || sqe->rw_flags)
>>> +             return -EINVAL;
>>> +     ioucmd->cmd = sqe->cmd;
>>> +     ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
>>> +     return 0;
>>> +}
>>
>> While looking at the other suggested changes, I noticed a more
>> fundamental issue with the passthrough support. For any other command,
>> SQE contents are stable once prep has been done. The above does do that
>> for the basic items, but this case is special as the lower level command
>> itself resides in the SQE.
>>
>> For cases where the command needs deferral, it's problematic. There are
>> two main cases where this can happen:
>>
>> - The issue attempt yields -EAGAIN (we ran out of requests, etc). If you
>>   look at other commands, if they have data that doesn't fit in the
>>   io_kiocb itself, then they need to allocate room for that data and have
>>   it be persistent
> 
> While we have io-wq retrying for this case, async_data is not allocated.
> We need to do that explicitly inside io_uring_cmd(). Something like this -
> 
> if (ret == -EAGAIN) {
> if (!req_has_async_data(req)) {
> if (io_alloc_async_data(req)) return -ENOMEM;
> io_uring_cmd_prep_async(req);
> }
> return ret;
> }
> 
>> - Deferral is specified by the application, using eg IOSQE_IO_LINK or
>>   IOSQE_ASYNC.
> For this to work, we are missing ".needs_async_setup = 1" for
> IORING_OP_URING_CMD.

Agree on both, the op handler itself should alloc the async_data for
this case and that flag does need to be set.

-- 
Jens Axboe


