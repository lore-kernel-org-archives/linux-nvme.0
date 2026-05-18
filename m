Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB143CD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=; b=ReKVFH81eplhQdpEjW0oJD1Qvr
	5qX7DWtzmNsh49bCL4bV2RRngH5GzCHITstvcg9zaeGPvlcdsaWHxM181MvMqv12p92MOi6Jqt2Lv
	JE7I6fgEFJH3i0jze9ZDFWwzBub3lpo2MobZh8OqF9/C2F3UULJp274jGEqk84voOM5zx/TNChE9p
	kWm0zE8Am3KAofodd36hTAldUSFSXHDR1uIuhm2S8j7RMoyohH6z6Eop9nVmcOZPaZkNFi4GXWYuU
	WHH01y3viPaCrjDj6Qeq8iVoZAGdmlZ3WgKCii00uxDzVCiV+Jr6EPC4trsOlu5HCO41Rz0ywJOPr
	vCO5TltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtza-0000000ExTZ-46Va;
	Mon, 18 May 2026 09:10:31 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOtzY-0000000ExSE-2rlv
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 09:10:30 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso4350066a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095426; x=1779700226; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
        b=CK47huzn1qCHo5p5yDSoC4KfPoCWV7Gz4zwFordYmaLgWSKTXh9dBV+aK0NiN47llT
         Yk8tht3QublpBO9QAwk6iNGR6w3WY5LMu0NXpaDohTjb/AD6gwr7kx4vN6QYNjs20tK1
         b13zl4Dh91/5snnAndfNGm2+KXMSTPM4Z9zQSHnqJE5bash1qOvYfb+nkPWE7kIP2oUt
         rXCKIrk5uq0puUkZRrc1MsnLbMRm3MrSk9+sg7mv8wUej/u1Ogwt0klXE0cAR9bgrTqe
         r1YqzYtzcjS4akjJAAwAK2wiQoAgIzwRraTr03PTFdaET1Gx7ldzBcPWaNFHH9nl0hvt
         UUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095426; x=1779700226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NK6QaM0AvluQNq8GVPqTX/wBbD7FgigoEBmBlLT11LA=;
        b=dxNnNZzaIKiOwAV8i+B4ESVq7kvf2uSJEQQ8xyDWa1eB/YPyhnA3JYZc3IU07tvXkM
         6m0JD0A/SNG+vRYDQrqLZAFFLnu366B2Vc8wdEsvYDOYTUxc3MvP9XIMulR1gdJTXZzu
         xLaZVdTkgzl6TgmGde1uWs4Lv7UfK+L5UORuTuje+hXaN38pZ0KOkY96ZKZxpU7RgLWm
         kyq/oNOu0J+ASTuteH3CDOEBlkoT4b5xrYubZgzB1bAX25yIgVdGekYGUnbFeDts8nxF
         upFM7IlnPu+2xJa5bvxmGksM6+c4HuG4t8W0CYt2LSg2iT9q3CKiNiZJwWhhJDAiMMiy
         Ol9A==
X-Forwarded-Encrypted: i=1; AFNElJ+yntJ9KuJuC2MP7pxbKbZAnNTOOXo2gy2MC11XVMO1BBhCF8jyh+2LTEh7XXyCEs2UDKTUUI5fMmA+@lists.infradead.org
X-Gm-Message-State: AOJu0Yzdt32WSbYu3YMd8NGE/e4bUd6tTinAVUQc7aOdwrCfA1Ev/YSu
	+yaIHDD1k6SiOgr//roxGlEz4//OfPfHXyLPXLfWqLFD59faRmLXuhRI
X-Gm-Gg: Acq92OFJ7qNhqcLvhTj/Z9b56TGINPuGjmpZZLM34tQziGLRDOp/OCWcOAo6fsdg7ir
	cl+oh8rZaBsoUGK1k85eH1jZ8bZReZ1byc2Cgaf1R8ZQTlMU4qBtniTJtsJyZeZwa8CC3btgvb9
	ORop4psYX43bnMAItkAaEWplRjVh69lFm88I802J+SBqpDfi0oKl/vu1LB5LNTseMoXxnKprnEQ
	kJC4ZgpNwxNPP52s7YRnXwo7QsexZtSAvpsvnuwE8167kzBU7vLcVGKz4zIPaBLSyK15sg5PBZh
	t38JCMoNThdOx4OXyUsG5QxxdeHLeYGIcOouwhuojmGP+8PzMjjMg34Iv7wBV0GaSRH7XEXKYiP
	ST/KjMwH7A+Hy8GBdAAkbOkEljOqYpcT4vqTYA07R2exIhlidaTRLTvR9dTM77X3Gio3ammNjEr
	A/7Kxd9GUFBCczwuMHGlVA2AxRCOvMfrBdfopnI1Rta0ShOkYusfpYoezfW1rxxTwKR2m8T6K8B
	CmXwdIE5Z3DelEQ3tqFqyW66JQrYKKUBz6iIxIFNY4HmUgdXU2rio4eFp6P/v0uh84nbA==
X-Received: by 2002:a05:6402:4150:b0:67e:153e:51cb with SMTP id 4fb4d7f45d1cf-683bcd9e33amr6611396a12.16.1779095426574;
        Mon, 18 May 2026 02:10:26 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310b4069dsm4929655a12.1.2026.05.18.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:10:25 -0700 (PDT)
Message-ID: <d14967a9-979d-428e-8190-6a756da1c130@gmail.com>
Date: Mon, 18 May 2026 10:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 03/10] block: move bvec init into __bio_clone
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
 <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
 <20260513081238.GC5477@lst.de>
Content-Language: en-US
In-Reply-To: <20260513081238.GC5477@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_021028_819357_F9CD1591 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

On 5/13/26 09:12, Christoph Hellwig wrote:
> On Wed, Apr 29, 2026 at 04:25:49PM +0100, Pavel Begunkov wrote:
>> To quote Cristoph: "Historically __bio_clone itself does not clone the

Sorry for late replies

> It's Christoph.

Oops, typo, sorry for that

-- 
Pavel Begunkov


