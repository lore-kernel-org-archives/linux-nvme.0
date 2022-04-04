Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC3AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/TzCLb1GbKboGgilj9E1k/qjcATj9ekUppo8Ze2qiw=; b=NcU7aKHTC5rMb6Z3fxyReoOjap
	Dhq3ndPDozYpdyO0OmZNVTnifhM6riX01be8t1QEPWIyMXl3PaH4EBsRo+xp8vRytn1s42ttqFqK4
	wycPzpcZDgJj6QF/je4LqkgS2yWQmZk8ZR+lob1kzl+qQvIJNsVZzWatteomO0IpuLqLfO8zWGY5N
	J5Pto3W9BQVLGe4LWAhN3uDFy9c+eecvHFaItv9hFPeq15UCwZqdBcudsT+Wv3L3ReOGI8EZSoTeP
	98XU6jRxMG8o8/InUy0pAzwKN4i5DXDn7Cazca9J/KyCbkIOD9iPlmuz1wnIcx3IgAgje9D8UQsJs
	GNRhcDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbHz1-00Dpw3-GF; Mon, 04 Apr 2022 08:22:43 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbHyy-00Dpuj-NB
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 08:22:42 +0000
Received: by mail-wm1-x335.google.com with SMTP id
 f6-20020a1c3806000000b0038e4a0fc5easo5094246wma.3
 for <linux-nvme@lists.infradead.org>; Mon, 04 Apr 2022 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=W/TzCLb1GbKboGgilj9E1k/qjcATj9ekUppo8Ze2qiw=;
 b=DSQ+JPrUVvx/uljBfq4a3ySV0YwGQR2CfaX8bKkt4ilPDWIZl2a6Fr4Pu3pGtpcd3E
 A36uArXC3WCRu81ta3Y9FjvHgpHx/kbWlipcgiWmsRvZQEA+9tbmjBz+AOpB9ZqMx6Ph
 MDePZAV8nv0aAiIAnMgbUPL+1AFsXez9PX9IjKXZLidsAUKyXCjyGL+O57urnWzyJ3kI
 U+h/Z1+sAILiPmwjLcOwbiSld8mDAW9z19kVm7UXlOezMut85fKinyfpN4QhbN+SPXJr
 54+NpzrqllL7d4K+N+snN0MuFbXyOV22Tx+4iOaWqB+nQf7J+zOGMTqspLziWLzua3e6
 nUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=W/TzCLb1GbKboGgilj9E1k/qjcATj9ekUppo8Ze2qiw=;
 b=DCuOLMxdtuze+GDUoUXsWM9fcBAwO7jWlF5J7P07wVPaPDOQeB4GlNvmXw9XVH7pAH
 IIisF8uk9zMUpPDuXdZOOUlrgj9ucu6JZWoh2IuPPkOBG8zPIOuzQ6Dhu+elohUcv6aw
 jWPZzB4Rr+RjpbgBHWjP4PSY0wZZMj5YtbYMZ/Xv6V9Df6oCthwoGuY5qj1Nydaep08E
 fmiTJYknuCv2Z2As2UmA47oDGpH1LSVxNu7w3Ii2s/iRhYAcix/M5r2BTY00kf3JMeNK
 NMfpdy04WTtj0/wixSkVVnXgdf+8V+M7wRz01Vl/dMKo/yPYe7wkGzATwsrVFufTBSWs
 +Tmw==
X-Gm-Message-State: AOAM530rXOzvAq8Sx1BLab6XhgFE7uWxAx0i4NR31U6P6OFO/vOGO8mn
 1vzk5VboLUyfXjeEe8uftxUfVzDkghQ=
X-Google-Smtp-Source: ABdhPJyPPsUg30vlh380C1VLD1PdXGROirLq+VRfWjp4JqalVyZVsSAY/uq8OLk+I4JWx+Kt71cYjg==
X-Received: by 2002:a05:600c:40f:b0:38c:be5c:9037 with SMTP id
 q15-20020a05600c040f00b0038cbe5c9037mr18536702wmb.44.1649060556343; 
 Mon, 04 Apr 2022 01:22:36 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.129.65])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a5d6243000000b001e33760776fsm8666039wrv.10.2022.04.04.01.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Apr 2022 01:22:35 -0700 (PDT)
Message-ID: <e039827d-ab7b-1791-d06c-a52ebc949de8@gmail.com>
Date: Mon, 4 Apr 2022 09:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC 3/5] io_uring: add infra and support for IORING_OP_URING_CMD
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, mcgrof@kernel.org,
 pankydev8@gmail.com, javier@javigon.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110834epcas5p4d1e5e8d1beb1a6205d670bbcb932bf77@epcas5p4.samsung.com>
 <20220401110310.611869-4-joshi.k@samsung.com> <20220404071656.GC444@lst.de>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20220404071656.GC444@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_012240_801903_3B57A572 
X-CRM114-Status: GOOD (  21.14  )
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

On 4/4/22 08:16, Christoph Hellwig wrote:
[...]
>> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
>> +{
>> +	req->uring_cmd.driver_cb(&req->uring_cmd);
>> +}
>> +
>> +void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>> +			void (*driver_cb)(struct io_uring_cmd *))
>> +{
>> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
>> +
>> +	req->uring_cmd.driver_cb = driver_cb;
>> +	req->io_task_work.func = io_uring_cmd_work;
>> +	io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
>> +}
>> +EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
> 
> I'm still not a fund of the double indirect call here.  I don't really
> have a good idea yet, but I plan to look into it.

I haven't familiarised myself with the series properly, but if it's about
driver_cb, we can expose struct io_kiocb and io_req_task_work_add() so
the lower layers can implement their own io_task_work.func. Hopefully, it
won't be inventively abused...


# io_uring.h

static inline struct io_uring_cmd *io_req_to_ucmd(struct io_kiocb *req)
{
	return container_of();
}

typedef void (*io_tw_cb_t)(struct io_kiocb *req, bool *locked);

static inline void io_cmd_tw_add(struct io_uring_cmd *ioucmd, io_tw_cb_t foo)
{
	struct io_kiocb *req = container_of(ioucmb...);

	req->io_task_work.func = foo;
	io_req_task_work_add();
}

>>   static void io_req_task_queue_fail(struct io_kiocb *req, int ret)
> 
> Also it would be great to not add it between io_req_task_queue_fail and
> the callback set by it.
> 
>> +void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret)
>> +{
>> +	struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
>> +
>> +	if (ret < 0)
>> +		req_set_fail(req);
>> +	io_req_complete(req, ret);
>> +}
>> +EXPORT_SYMBOL_GPL(io_uring_cmd_done);
> 
> It seems like all callers of io_req_complete actually call req_set_fail
> on failure.  So maybe it would be nice pre-cleanup to handle the
> req_set_fail call from ĩo_req_complete?

Interpretation of the result is different, e.g. io_tee(), that was the
reason it was left in the callers.

[...]
>> @@ -60,7 +62,10 @@ struct io_uring_sqe {
>>   		__s32	splice_fd_in;
>>   		__u32	file_index;
>>   	};
>> -	__u64	__pad2[2];
>> +	union {
>> +		__u64	__pad2[2];
>> +		__u64	cmd;
>> +	};
> 
> Can someone explain these changes to me a little more?

not required indeed, just

-	__u64	__pad2[2];
+	__u64	cmd;
+	__u64	__pad2;

-- 
Pavel Begunkov

