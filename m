Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14281C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tUYp6a+xGLyYOwUZUBhpLjfoPn8DKdApL5lcZLxp6IY=; b=f1V9Uare2i+LCGYTWNTRm9Mjwo
	R5a7GdRtDTs1PCtzpWeApcDEmYmoHAVNglWS/klXm0aMVu3K+kiSCcOQwGUQh1bwDP9OUpVWQTlhu
	My3yUQFS82nH7n+tBaj2vblTWssXBw+z0b2MC2JkQqbxA2TZU/hKzRb6Ryobk+NIZ/lPp1dX20wLB
	rxOusvcqvvOvtl5AmVvydGwdkuoN+AfJ32AoMEzVjZ88c1BWbCYfSSduw6NeeUkjHb/dTVB4j7zv/
	PxkAmGfaPc6JUMyCowAJIpmh37+KOqcjrFv7BTS+kRSOC+paZr3Y2AwifxEboE8nj+NF+Rk1L8qwh
	FjmM30tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAE07-005MIp-1l;
	Mon, 04 Dec 2023 18:49:03 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAE05-005MIW-0D
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 18:49:02 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c032962c5so29774575e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 10:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701715738; x=1702320538; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUYp6a+xGLyYOwUZUBhpLjfoPn8DKdApL5lcZLxp6IY=;
        b=QGuK39In0W0vVycWXR3E2JJUATFg5MHPS2on2wSv2X7dTrIty1NuMvdWVC0dgwsvG+
         XRJpkQIg9wujO4pJrex56POrQRbcvj56me7tM5OD4WP9fOsQ+Tm2cSx98215Qgbx/g3q
         PCXuedwR4XZtfUtGcbEmYeU4Mf0FwtgGgS9j+W4zQ0Qjq5BoM2QeuiDtYdwQrq7Viix2
         8+IR4ikQIzYk+xzKvT8+/bU1n7AhWYZAkBoPZ6/3s8HQMEH3ccp9g3DnAttm6XqK5q0q
         KTWgfm23e+921m+ILFqYzbN7h8Cr/fJbZVouP+GGpJ1mvSVUPmuFnGxiASKKbaNM/y3G
         QeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715738; x=1702320538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUYp6a+xGLyYOwUZUBhpLjfoPn8DKdApL5lcZLxp6IY=;
        b=ApwvAuaNtOqAtlVvWMCpltBWMgnBIO5pgueULGZvJhU/jjA4Hea77TRueUL05n0hkw
         j3eQ7druNpPlJ07C6M1MOjEerS/S/fkGxTIqj6b8T0hwhQDCaqlHbj9B/MOTPEJsyvJX
         MW61IEfJYJu4B5o4XoQZpYT1xu91sRn/qose81fqq4cZnIKGg9oX7XVNhPS0c6PXOL9r
         STjgM1Mzfr0ziClxPC4sIkT8/FUnI699ydhJuipzd8NEVUISRpLAPAPB0LFtnlCrc5E5
         3Dn4/M+2LjIt6LK53ByLdvA8XTvhnsEY//Hsy0D/bv9bJdbtKF78OH1uNgL2KBDMFb/a
         cGGw==
X-Gm-Message-State: AOJu0YwbImUitd1L2/wHTlKzdTLF2EDjuWETQ3C6rVFoJYEQ5hHJYhhz
	n6eEYNXIk3iPE/l4QzyHwzo=
X-Google-Smtp-Source: AGHT+IH6aY56AVBstl9OknQQqt1nEZO3C7vMCaobOip0u6GjpARC5QGAQVxd3HDPhaaFmICk/3D0gQ==
X-Received: by 2002:a05:600c:4452:b0:40b:5e1e:fba3 with SMTP id v18-20020a05600c445200b0040b5e1efba3mr2071997wmn.88.1701715738124;
        Mon, 04 Dec 2023 10:48:58 -0800 (PST)
Received: from [192.168.8.100] ([85.255.232.94])
        by smtp.gmail.com with ESMTPSA id je18-20020a05600c1f9200b003feea62440bsm16296061wmb.43.2023.12.04.10.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 10:48:57 -0800 (PST)
Message-ID: <dc8ab9c2-164b-4346-8720-443c9b9660f5@gmail.com>
Date: Mon, 4 Dec 2023 18:45:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: hch@lst.de, sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <a387fd6a-7d4c-49e0-bb89-be129b10781c@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <a387fd6a-7d4c-49e0-bb89-be129b10781c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_104901_123558_C6604A74 
X-CRM114-Status: GOOD (  16.36  )
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

On 12/4/23 18:05, Jens Axboe wrote:
> On 12/4/23 10:53 AM, Keith Busch wrote:
>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>> index 1d254f2c997de..4aa10b64f539e 100644
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -3980,6 +3980,7 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
>>   		ctx->syscall_iopoll = 1;
>>   
>>   	ctx->compat = in_compat_syscall();
>> +	ctx->sys_admin = capable(CAP_SYS_ADMIN);
>>   	if (!ns_capable_noaudit(&init_user_ns, CAP_IPC_LOCK))
>>   		ctx->user = get_uid(current_user());
> 
> Hmm, what happens if the app starts as eg root for initialization
> purposes and drops caps after? That would have previously have caused
> passthrough to fail, but now it will work. Perhaps this is fine, after
> all this isn't unusual for eg opening device or doing other init special
> work?

The side effects would be quite a surprise when you initialize the ring
from a privileged process and then pass it to a less capable one. Ring
sharing would also be affected. Privilege downgrade also sounds like
a valid concern. The first two will be solved if restricted to
IORING_SETUP_DEFER_TASKRUN rings and

io_is_capable() {
	return ctx->sys_admin || capable();
}

And it still doesn't seem great bypassing it, when the question is
rather why it's expensive? I've seen before in the wild a fat BPF
program running on every call, is that what happens?

> In any case, that should definitely be explicitly mentioned in the
> commit message for a change like that.
> 

-- 
Pavel Begunkov

