Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9A60A2606
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JLRHorkM;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FF+6B7TT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=; b=JLRHorkMnGTDDi7Be4a91ykKKx
	ttmANWkKRp2zdyM3srBN33BcrkgaewGmP30s6JZAG1UA03Up8gfC9IrzHhFCM6N0pIz5njYGom3I+
	z7LxsxbF5syHyeQDSfS5pTntKMbNsc0wfxs0HXfIEmKm14cKprBJtPU3LKDyDLCCo4NI5+6Wd0dOS
	eOwsYlL0aufuPbGaYE7Kr9Zic4NE7+5eNwwvtv++JqKSyiS5MHAIgh7fwUPK8GytTYGzw3hNyS5gJ
	vAJxno/MKYyhMklV0tQUyqjYuaBh+XiH7IFnojOxVXQzprfWFZnBa9mLtQFoceiYf01dZBOOt88xd
	2yLuA5hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJXDq-0000000C5Uo-1edQ;
	Wed, 21 Oct 2026 14:23:18 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJXDn-0000000C5QQ-2JGT
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 14:23:16 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4956869750eso6058705e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792592591; x=1793197391; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=;
        b=FF+6B7TTZtVYZOzJeCjT0fJNgwf9uU+Tcrl1ntAv4LcgufBfXW8xT8JdMdLHbtbYvI
         F1I9SgUvStFb7X8GgbR4GCmk2t4O5ULTt2bynsAmCYx4Jdu+NxdS4BD1ZNZkn3hDex6m
         7PzA9xmVpAbBJwpS0x6HgIHCCml3lBXDn6uOZ+/hOqvVNnyOLxXoFDuhF5p+hjVRS1qe
         TndOUDheYDRrYPzS9YWhx1NaQOcIqjkQk/6dH/kWbv2p3u/qhwFkrr6bf2Bes3kB7dAl
         9s4WyJsXQg+NyKzV3iLcWpOPnvD4HtayAuLhugk0pm0RtVvRrlAVfl2aFXDZ9KaVeFsn
         xiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792592591; x=1793197391;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ry0ejq2iOovIh50a5iLZlHQmAJp0KdXz+qWiCMyE90s=;
        b=2v3Sw6E94O0z6N6OkGbQTCLn0wUvU1pw3xwgrkP93iSUyKypyEGffBhUBMiyr/lxNu
         k6/7K1ZQAKo0gCDVY51gtUbojseAFRYFLs3HkQn3CHjKkN9P6/3dH/YCc6UYEHi0NC8O
         4ElDLv9xnbo62C2AfWSxRL2Q1jAzgRGT3DcQOKlNmiwrZH5b/TzT7k5e96VuAHUG6UfP
         TlRK0HjyxPYn62N0yZ2YEbNz5lbUB4EdEwN8qbRhgYJsHOugI2wZeLkm03Fdfp6INA6z
         iitwLobJ+bEzRi0XzWuB+Cox/9NvvtB5zBnkK5xIKQxYURLHGLyezkfeDREtSvwrwbFA
         Kpgg==
X-Forwarded-Encrypted: i=1; AKwUvByWPQmkbPHsW1Y2ptHvV7CWcBoyXYomdkIcxQNbiml+CtIFOyXt1tbl4DQAKbr+JcWOlo+YNLq0pUze@lists.infradead.org
X-Gm-Message-State: AFq9FYJitnsHPV4oTtuHLc0S9K8qRwU6KeCHR2KBMvjtKd+cq3xTMkAD
	FIAE69IZ6VsKwgmL6tdPc/x4CXIqHw1Mc7WrqmPKOrPUpx/EfM50qbFE
X-Gm-Gg: AYBFou2HIA+shvj8WaWCFM9ePkGeFDftlBz5UNClCtXQk3dzf6zFEG0lVCcWXdBni39
	JG5yDB6P1LUDjaanBql523XK0Oy2LqNcAVj6n7EAP1bbNfd6ecb/+H/6muJY9DQKXJpx+gxIYAw
	HwMZ/OhfVbn3UIfznDU8w3YeAXaG3iO1ImqwNkwc9r6YJPwOjxF8yZsgrHDLZYyc5jU+11SuJTA
	fRvl3CvO1ml71z82ruP1jit2cj3Tp2oDyFRKosLg34w1Kg42gqAxL9mGnHp7SUFeH2FBcuvDkwU
	BI4jNqewS4G9dPscxFiyMGeChhUlja0ar973eOZagk7OqqOFk+Jje/yi18cDp9PWhgZ42XmjEEY
	wCUyD3wiimYcx5qZupq3Y6J2L1MZRfZdXdSPMsf1bEXcj6BM8CchXz5rj1hDR5CCyAMRoIFeJK1
	QTsTvN0OMS2dUOcUq5YpgHhucAIhoQqkyiaJ/+JbR0AH0NIZ/d6+I8DJPwIILO3bDsDiXdUjZoW
	7gOUwC4tZ333Mh/c3uHwmhqmhR5v0ttpiXHD+mrBFyRwhUgqBXw3eAt+nhf0+cIj4DbEYage68m
	DKuA9p4Ko2xkc9g6uh1p8SXrKJssHsvr1hD9H6J6c3P8/EFaWiOSbf4x//+UrxZHpvja7nicajl
	XKOHlk5Y=
X-Received: by 2002:a05:600d:864d:10b0:49f:e941:d6e with SMTP id 5b1f17b1804b1-4a1fdd399dbmr32967835e9.21.1792592589343;
        Wed, 21 Oct 2026 07:23:09 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-19.dab.02.net. [82.132.213.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb80ef02sm83229375e9.5.2026.10.21.07.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 07:23:07 -0700 (PDT)
Message-ID: <d0c8cc97-6a21-4c64-b55d-16af783fdb59@gmail.com>
Date: Wed, 21 Oct 2026 15:23:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/io_uring: enable dma-buf backed passthrough I/O
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 joshi.k@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20261016103453.1129150-1-anuj1072538@gmail.com>
 <79627452-98d3-4e8d-9c37-ceda0796d59c@gmail.com>
 <vx4ugjq6wol6elipmwkuhtpk3qnanpwou6g73dxrjona3nepd4@pvetkgijfsx5>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <vx4ugjq6wol6elipmwkuhtpk3qnanpwou6g73dxrjona3nepd4@pvetkgijfsx5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_072315_635160_0C07CC2F 
X-CRM114-Status: GOOD (  17.69  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anuj,

On 10/19/26 14:40, Anuj Gupta wrote:
> On Sun, Oct 18, 2026 at 11:06:16PM +0100, Pavel Begunkov wrote:
>> On 10/16/26 11:34, Anuj Gupta wrote:
>>> From: Anuj Gupta <anuj20.g@samsung.com>
>>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>>> index 3aa5d2f2dfbb..6343da1f6c05 100644
>>> --- a/drivers/nvme/host/ioctl.c
>>> +++ b/drivers/nvme/host/ioctl.c
>>> @@ -458,6 +458,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>>>    			status = blk_status_to_errno(err);
>>>    	}
>>>    	io_uring_cmd_set_res32(ioucmd, status, result);
>>> +	io_uring_cmd_detach_dmabuf(ioucmd);
>>
>> It's not great spilling the responsibility for [de,a]ttaching
>> between nvme and uring_cmd code. Is there a way to stash it
>> all under io_uring?
> 
> The natural place would be __io_uring_cmd_done(), but that runs from
> task_work, while the ref has to be dropped at hardware completion, like
> io_complete_rw() does.

It may queue a task work but is called from whenever. It would work
if we drop there and in __io_uring_cmd_do_in_task(), but I agree
with you that it might be confusing to the user.

> Hooking io_uring_cmd_do_in_task_lazy() would avoid changing the NVMe
> call site, but would add a non-obvious side effect to a generic
> task_work helper. How about a separate helper that drivers call from
> end_io instead? This keeps the dma-buf handling in io_uring while NVMe
> only reports that it has finished accessing the data.

Sounds the same, but I don't have a better answer, so either is
fine with me. At least with your versions we can add a warning
for misbehaving users.

-- 
Pavel Begunkov


