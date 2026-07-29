Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD8DC55171
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 05:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=; b=LnniZE/qUp3o4LqgasEWEAEcba
	G1ncCY8NqQSbZ/ssNNthoDORcwzpgBfEjuOPaFfCHj1qMzQibncv6ilOYa9N03bQJ5iMIkbQ5/IFx
	ZsdXUh7R1M0L2Pp1W4vRwfi1RS4EDUkNfjUym5Yrh0AHeF+RjsYo1F4sCy1bNbqn4/TUiDojsCmob
	nRM/nPqAWMsTkNaVV6FWgetWzClo1KOjtGOPJYNrlImGKjNzG3qoXwGdAo8Ws0PIilLDIKi4oRYig
	oEd58N2zT6mIgovZKfEp8JtclBYK61PGUSObqKX6CAURuKZ7RKalMNYvAO+o4l6yVNRegDmMtpGjB
	zkq/g0jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpfSb-0000000BloF-1uFT;
	Fri, 31 Jul 2026 05:07:07 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp8M6-00000008jVg-1RjA
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 17:46:11 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso11070455e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785347168; x=1785951968; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
        b=kgzN52vLqwDsGHXL8yM13PV0R6Hp6PSq6jLzrqNjwBo1KXgmZWIzYkxHLQAOM8Rr3P
         DS/lmit7hHjVjTnciIbUpDnmJ+4oIF6f4O5euB9vPTCfy5CYQLnI///7HvHXpeQeaLzP
         NeidIzE3+SFDwJXYLTXCFV0svkD43KgbwLWNiPVJn4kpL3mNx1rTLkZ58uU90Ao6unqa
         wupOElWklnVynM2+tUA1EQtAq6P1jX5/+929tRGvluIxXHBAbEYdkHPptJCG62Oot8/Y
         nsxT6DKyDnTDXw+D9BxGRyJ7aipTEBdMxOStJUHcjoFd7+cq7igtFdWDCtpIQ1c/MeZk
         KCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347168; x=1785951968;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
        b=Y0Mr6Er4kkFBj4ix9ufIBITsRlnLwDmpUd0COx/XmpKi3KidkcAYj6i+bJnNs8x44d
         13ETjWsbz2EEhL4YqSlJOtfAtD0VqLm7nK/fyepP/TSOpRNSk7p742qpvkzAAflFV88i
         KE2ZKR8yVcVDf7L2/NJq3JT8BvqJ6TpKJ/zZUHeR6Ms13M2oWom9Hjb+RzqZSPTiNX7h
         Ku6OsMZeh4IoLIKlHlCPoJiUPgo16vo4ug+53hROsIMHJ5acXOc6xAClmSOGNMC08Abs
         /RkOWWUiy3rPB6e4Eo7PFpjoJfiuhQG5kCNwSfXYwKpcdZYgvRe+zU57zwNivKT4IToZ
         WNnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqWmf1snE650eDAiepYiYa1j0JkK1RKsrfFIDSKAx0atDjc100eA92dvw3hGIAh7LHBmZyz/dOVc75p@lists.infradead.org
X-Gm-Message-State: AOJu0YyKpmxyUKGsvtEcW3tY8kvrjxxzB5kB209jb4nVpX+xXJflUnLe
	zPYAEWBkX3jdUXAEqv3yPyu+1OSDyPWHV4AGHXErdm7IcBBqknt4oJz0FoP5TCDNmKs=
X-Gm-Gg: AR+sD12BFvBIbm77dUOnONx74mlrqx6e/89ne+FouP0GPz0KTOBBmo5qFbj0mQ2/pO/
	xuGTbd2xHHQ/gXeZZHW005vs+21NTFm+vOHpMMrasyPQe8evUOb1yZXC3lmt5EWQi8rX2/3ksBV
	DghAeYvzYIqKg3UohUZt8pjS37LmkqwmicT6ly3CaSHzYZncJIiyyPTCqccQdCLaiUn9bxHfSKG
	m0GMJUQBK9kFYPuGutAslmKbzVb8JP2YU0aWsu+BxnP0/PWsZZqrQbM2Qg6Flsf3l4oWGJ9HqOV
	ckshpTAou0EjxM4qp/XX0EMhjPqWHpdvKnuir8N6unUETOH9FeH0g0L5uwkyTaQ4Eom1MBjNDIE
	OJx3n3Zf+3HKghR4bR5GK7vsyeEhnmMmceWlbguP+nugeWGQfOxWJkwALk6CFXZIw5jXFoxc8Pv
	IppGlfkyMp4Frlgc2NCUPYzhuBHFJ1S09bQY749dMxMHfraG1V/R1UawX9e56/BDYuvHyn7xJ1l
	0u/gqclFTpjdVA3oMMG8gohe03sL6icwm3YsCszD91Bq89iWcBxkk+50XqVPf2RHaP93eSymiri
	DfmzZAV9GSUfklfoVebBpIe0vP+J9A04siwiHyk=
X-Received: by 2002:a05:600c:4fd2:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-496c6590660mr98300165e9.21.1785347168019;
        Wed, 29 Jul 2026 10:46:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b1c2asm171605965e9.5.2026.07.29.10.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:46:07 -0700 (PDT)
Message-ID: <5afa3726-6c15-41c8-af19-766eb76b4b46@gmail.com>
Date: Wed, 29 Jul 2026 18:45:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
 <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
 <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_104610_403876_C478D8C5 
X-CRM114-Status: GOOD (  13.29  )
X-Mailman-Approved-At: Thu, 30 Jul 2026 22:07:00 -0700
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

On 7/29/26 17:52, Anuj gupta wrote:
> On Wed, Jul 29, 2026 at 7:37 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>> +static int io_import_dmabuf(struct io_kiocb *req,
>>>> +                       int ddir, struct iov_iter *iter,
>>>> +                       struct io_mapped_ubuf *imu,
>>>> +                       size_t len, size_t offset,
>>>> +                       unsigned issue_flags)
>>>> +{
>>>> +    struct io_regbuf_dma *db = imu->priv;
>>>> +    struct dma_buf_io_map *map;
>>>> +
>>>> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>>>> +            return -EOPNOTSUPP;
>>>> +    if (!len)
>>>> +            return -EFAULT;
>>>> +    if (req->file != db->target_file)
>>>> +            return -EBADF;
>>>> +
>>>> +    if (req->flags & REQ_F_DROP_DMABUF) {
>>>> +            map = req->dmabuf_map;
>>>> +            goto init_iter;
>>>> +    }
>>>
>>> O_DIRECT is checked only during registration; we should recheck
>>> (file->f_flags & O_DIRECT) per request.
>>
>> Nobody should be able to clear O_DIRECT, unless I missed something?
>> And fwiw, io_uring wouldn't be the right place to do it.
>>
> 
> fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
> open fd succeeds. The consequence is that subsequent I/Os switch to

Very exciting.

> buffered I/O and cause silent data loss. Something on this path needs
> to reject this combination.

Yeah, I'll fix it, thanks

-- 
Pavel Begunkov


