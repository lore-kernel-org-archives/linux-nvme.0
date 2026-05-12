Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77943CD4855
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=; b=p2osV2gX/IlD4QFiXNzWL/X9sG
	9gNd//xl8ACfQWuzxnIp5FLb10hsVy1UfAdjdCo6Xa4QPE/sMp03kM4CdzEQFQq3i2FVBZR1EKpSv
	6tq2rqxGQuouc7LZNSZMpFw8zk3NpxCc5+0Y9RXdvx31/cID/C1WAyaR2PbAoHxZwv1Wi7T3OuJjd
	PZzpybD/4SZaJPfpAMILj1kDLQHTGards4JRSiz+iXXk/F2BNUgszVQrKHC4CoRruBiZhIEbTFE5b
	c8JB5rQavQA2JWL+6gmM4d/iTLxmSPmhp8fMN5E7QONy/uk+2ee/kqsZ8X18fH0IHKcSx4SUIC/Ag
	ThqT96wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjRk-0000000GGhX-2xX1;
	Tue, 12 May 2026 09:30:36 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjRh-0000000GGgc-2PnC
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 09:30:35 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd2087858c4so55708366b.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 02:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578231; x=1779183031; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=iHialn3qDfOiA/8ArBoDnbNLovvjb0HLls7sm37aPB3iYMkymhqkxN297yYdBlLYuc
         rw/dm8k15G1bgbUUBY/l+2vQTrDTkicX1sz4GQGcE99BOfshTF2TXNwQgvxspOdanSMP
         eYYiZuQc4x7Ey2pUl/TiMfWk7xhEGufda8i/o07fP/934HTCaYpn8vlmnfygPnJnaNES
         U6TPz3C3EdrD3paAemcvXPnC6w/aNrcbATpAbaEgmtwUw80sWZdsZuUfdzoAoY5/ozQZ
         Kwb/zwTBmilTvbepPnHoQJ44xA/413FGRFGfRyh/xUKJDaTiqKfEfYC+V+hEMALR1vB1
         xqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578231; x=1779183031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGZAkcM+ym8AsbVGOAJ6+xeqYSrWcyKvdgdcKQ4eIYE=;
        b=lH1uk9mqUSfpQGdGQADjOgCh9Dz9Bc7P+k438g9tVugct8HJgXhrA2WWzGIepTeSWl
         9FbE0/F3kdPsgxZK98ealuLNgTWZYOEMWiEyGS5/TmZFUQA/h3H0ygZxdDBJwTSZH+te
         ABEmE1jvmUCn49lQbQilWE7g1Hf+aiw0ea0iBqIR9urJFLEEWKJv9dC3sDxyDDxN8wIU
         P6TTI3oYKk0tnrly7CS8l/DATiX3ocX7pnuhhAvvP7D045yZ8B4ngJIqImiLJCJvmbyn
         sndTCu5sqtBUKJzKW9TidCUnSlVbk0gMEHRk15hbh/hmdLJQW/sBCHcFyTTP40bExQe1
         Gp7w==
X-Forwarded-Encrypted: i=1; AFNElJ/516z+1M/EsIOU5hhJvlbAtpSoFbbhjwcYSSn0UNRal/g/Rv6oN57nxuuxKFaViiEm/me3qBdjqRgS@lists.infradead.org
X-Gm-Message-State: AOJu0YwMURXvu5S9hQK0+pNcCwJdlH3HR9fBgUkQlEuylP2ZTCVRyavY
	cieKyXeJ+trO+/qoASaK9bCp2q9BZRx4BowfSCp83K4uVZi45GN6HSAK
X-Gm-Gg: Acq92OGPgc5S5/12WhBATtS+OqfssE6+ysr5Zw8hXq4xD/ic+5cus/ixesJ89X7euhA
	1Mt6QlWkWvhNC+qoMvvx/v4aBN5vBJ3iPMMybtYaGVdGFXSZzc3Xv8YI8AWwVS5+6CA4xy+PmPg
	AdPKMQmw3w5FSZYmi3Yz3J53B1V0y9iOeZQ3Y1hJWU6ZYZ5u40mtp6izlSE0bUdG2eK08SVCK0T
	qT+4PSndgimqMjlde6ELUanHzSHX4lr1843AT6MoVgPDB0ipKDkKnJJY8D9gKhkxhLPvmvx2JgP
	c2MEPW4f0jxIben4EINtempniq/VhcB6hpziH1gbN9r/8FOkPI3xahHOtyl1zfYlsD2Am90SqMu
	ztBdLgJAbKn6r3sbfWxZhRxotU++sKGvKhZaXvPhzVQ4uVNH0F1FAx712FvNU3xpQZLNjCvh7YW
	tmyLOBlXXWv1WTnfyHgjsE9piRP8VGPUw2i3i49ckY8pPXzQ9JQaIf6cq/7HT2SHybEXLRRASgx
	QsBFPZcZNTHL4VwuLN9iEtugj3/zaC6BxtXD9ZQbSgSC6uGKQ==
X-Received: by 2002:a17:906:99c3:b0:bc4:f3ef:e43c with SMTP id a640c23a62f3a-bcaad52246cmr973369766b.45.1778578230560;
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:30 -0700 (PDT)
Message-ID: <a4748a29-8aa1-44c1-a1e4-b82f4f191d4a@gmail.com>
Date: Tue, 12 May 2026 10:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <20260512070045.GA32030@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260512070045.GA32030@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_023033_623676_6EF8B3BC 
X-CRM114-Status: GOOD (  11.77  )
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

On 5/12/26 08:00, Christoph Hellwig wrote:
> What tree is this against?  I can't apply it against the usual
> candidates, even accounting for the time lag in getting to it.

It should've been a Jens' for-next

> Can you provide a git tree?

git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

It's a wip branch, for now it's just v3 + 2 fixes.

-- 
Pavel Begunkov


