Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA24C98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=; b=gnzYld90eDXnSIgvkbh3c6TdY7
	rjceMHyzO/GZigTOl07cGlaYm+PP+ZrcasxOlV3RA92hF09DnlgqyS9bhor1kIpGl4Ng1dS59GPSc
	3XrX1HmoAnFyy57QgRZTOacQsxOgaF4EWiKo+r1fVeJo6RFUY8I2T3XQ/PZBVb3rgPaTF7Eze/1+w
	0qWLeEd42GucJwldb0h5jAkIrOr6QhI/J304yScmhFJobupgBgDk65sk3BeijQ5ueQbp/2tozqasa
	SrdJXAsCH1ncmwCn8+qSlwlpGJJUkmlv0Jp5H1XTMsRSxxfK4f063AFRxFFpp/2I0noM500MipDax
	IGdp+HhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9F1u-000000078SE-3MTL;
	Wed, 23 Sep 2026 04:56:26 +0000
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gP-00000005Y6F-2EFu
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:37:18 +0000
Received: by mail-ed2-x0f.google.com with SMTP id 4fb4d7f45d1cf-6aa13e194easo6429244a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790084236; x=1790689036; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
        b=BgB8Y4VPoSgRWj3Fm23tJkgiB12art8rPU7q8i4qcaAtVQXJtvxsAtfWUGNQheIMTe
         XKSEcFyGSzjKTY6a0LBOn3r/t7Xb9HTM/t2D0VhzLBEXQ9Jy6pulDJVBogsdUSwn/OrM
         9xXyrLFdhthCYOYtpDaKmkyNy9oezo3d0DGnAgs4lfgCTM7WRH04aTzFAUykaiE/EewM
         ZYRmI+9aPE0jeHYxWOruFYvGXUworTyt+8Ge1/PyfjaKFaGr/OIT0DhbLqVECS54wsfE
         D0tlYYtIwiPi0JAHovjfqnx0656IiRoq7QIcYvKX7TdqrUfgbY7/bB0++X1e1YdXaLhV
         giiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084236; x=1790689036;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SSB6/4UTXtVP9h0KYT7VpnYQgkILrKgn1VnZQd7YA4=;
        b=DZj0H2KBaLZEyvhWFQorrCemZCz04T3ZscuqrJV+cxvxlJ6gWzLf9/ho33dzvcRrv6
         Yn+J9C4199j/aJZCpwwKL8D0wEV1ERsvd93OApts520bMmLBzTRE2MOl0NIvK5aaak2y
         ZVC+dIeEWBVMhp6uMJekmI1dWosgUoWhe6l4FTK2ufkDtCCp1QrmBnS0+YfYBaagaJK1
         UUqgC6EZYje5943FxdEqoYbBkzbGRpRDfhlatq5HWA7MkXrvNyMqqc7idIPW7Ys0tLLV
         4LDQMs4Igh+awRi1VLVWXhxIT6UD0FaxjycjR5QPkVe/3uwjHXUEEMDk/RZu05+Uo5Qt
         3n2A==
X-Forwarded-Encrypted: i=1; AKwUvByiRdP/mUm24Jgpb0COYh73y7S/wMSWdwlLBp1f4ohlQiSr9BxbJbPtAnKJxgSvg8N9J/qIhsBFGAWs@lists.infradead.org
X-Gm-Message-State: AFuF++knPo6Q094S89E/ReFnNJGaNb8UMKfeKrIy2mXwpFXMIBPYWA6B
	7Z5Td72hkMeF7QspdPdejqsBKIpG/3VVoppZQj/Gf/j8lOhMMuIoHDJk
X-Gm-Gg: AYBFou1MsaIJoE1Pe92NEs+/QmfHQTVtRrPJRP1CFr8Zeok5uoahF0cHO/6NdvPhavJ
	g7OTJSi4OubQMsVSMmegHiePRq/JBvZtlhDLNzlEOOzTDxEpi77QnA6+vOvpjy/MZCoq0pGkx3d
	F9i9MDY0BsR8oVBxzWLcyqw5t5oDnP4uxqm5TA7CXz4/FbSzOJMPr1Zq37oHRlpPWy4QhKMiabK
	8/zveH7YdEdAaTSKyJS4rfzSOy34HXV40ojQfSFLYpIUGbELrhNBaEft5JpObMpaD99GuPplwFa
	8SbcfuhfKtqgk0joyHV/y/g8DycUJKo0pBmZFNKchn1y/MvZ/6snZhJiuvMa05td2KWrl8aaXCe
	9+VZAWp08jY2/4SKkfK5d/p0+w7gqN2f7PYAAHuWuJoADu62c83F/qTf6yP28Etljd7RzHRejhM
	7ZjQ37nQIOFlkiQJT7U8uFX13Fvl3OgeExUeX3OF3/JPElVmYkcjLeLVMn/zNruWiaVOsg5KosE
	KKyYJ8apSIXNheaUsVQwQFZFgqPGV5c/oXw7oC+qK0v2lzkx6Q5yUNO5ooQICVnsP/dG1QSxdpC
	8GjFU1VqT42R+RBE7c1m2c/inWHt
X-Received: by 2002:a17:907:6d18:b0:c29:448b:f5d0 with SMTP id a640c23a62f3a-c2a15b86ed4mr1180156066b.33.1790084235477;
        Tue, 22 Sep 2026 06:37:15 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-196.dab.02.net. [82.132.213.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aa9b14925sm14081966b.19.2026.09.22.06.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:37:14 -0700 (PDT)
Message-ID: <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
Date: Tue, 22 Sep 2026 14:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
 <20260922132016.GA30684@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922132016.GA30684@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_063717_628487_5786963C 
X-CRM114-Status: GOOD (  17.68  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 21:56:25 -0700
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

Hi Christoph,

On 9/22/26 14:20, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:50PM +0100, Pavel Begunkov wrote:
>> Enable BIO_DMABUF_MAP backed requests. On registration we map the
> 
> This is now REQ_DMABUF.

Will change

> Sashiko had a few comments, which I think are correct - if we use
> dma_map_sg to map the data, we need to use the sync_sg APIs to
> transfer ownership.  That only matters on non-coherent architectures
> with MMU, but we need to get it right.

I've seen that and fixed everything locally that should be fixed,
apart from the sync. I wonder what we can do about that? I can
somehow replace it with the sg variant for now, but sync'ing the
entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
not wise. And I can think of another place that does mix sync_single
with sgs.

> And the reset deadlock also looks plausible.
-- 
Pavel Begunkov


