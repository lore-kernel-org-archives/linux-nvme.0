Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17BB5CEFCFB
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 19:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5ExmjzRt11H31bMlKYOhViS+00PGFmBw8wszOB9k6Y=; b=uVaI2aR2gE15UB4dzalyT7kPib
	ST/ICyYl/cEFTd0fzrtFkKcSU9qh3GDjP/siCNJl7bSCd/5U1hV9GAW9ObTxB3qQlLDgWpDpn7JlL
	YuchV6iU+Y+uqJ/wjLOOBp3UJO7PHfD/V5wg6tuM+qrNZPAHHohs7HxiDZSp/I55vtxg9StMqP6FE
	d57yVFYlPmiouNbhgI7sJ0RI8mnZQP5f9WkRtD2BVkT9kXQtiZL3URnGtbe3JEd7ZLUolj+LzPO/3
	/BzHQKmjTDpOSC/tJKCwPo8PaL7FzyJIZKx2zGP9Ab5JXHKT75pdKMtLDtCeo55yczUB5Uq7j1BQg
	e/iyeSIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdCnI-0000000DlHj-1Sdw;
	Tue, 06 Jan 2026 19:32:40 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdCnG-0000000DlHG-10Mn
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 19:32:39 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43246af170aso101135f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767727956; x=1768332756; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5ExmjzRt11H31bMlKYOhViS+00PGFmBw8wszOB9k6Y=;
        b=HbUTaOqt54zyV8e/dxf1Nr3zoB38tEttxQr6VOZO9lRuOSQxboRM2wDlwwY1I6SzTU
         hgwgPlY4McUuvjZ7uOzyaaSOn84XjJKubrUlAETLrAcLFiznVnud65AS2BYCt0XDbLr7
         A/pWUp+Qe3F4/lLIUYSdSKquc0ClUnQOTNy1mI8BauNwSpW0f83p0/BSv3hPAtH1QpTY
         oPLDCBY/0oZYWCN0EE0DftdAIoZTKKQfKD9qXQi8A3KTGWf5KX3JFSouDH9Zv+uRUnp/
         pYE85HALPWsdbGzMGQ8PotGKWP4tBQgJ9D58tqx38a62GikCMPg2/7T/F6fjC9jCJltO
         mJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727956; x=1768332756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5ExmjzRt11H31bMlKYOhViS+00PGFmBw8wszOB9k6Y=;
        b=RH6j6LMgR+43Fq1Fpvpdo44Jy6nGJC6vxkOHmL6WlIH6s0ivA9ehOzMHOpw6YGTw2A
         S1e1mxnpdIRl1aCbWvm4YK8uqdQhbsGpvu85Exe2pbsSdFYKEt2SPba+n9WROVxXj3Wu
         gHaM2wsQ2MsaMcZieEF+L6Oo8+df/LLfcwRWqWLEe9WDpVUPzszznDxu0Ec7kKSRfyup
         UmV40NUzMpA9QyfJBdFjiB6+p04ePQZS0bYwHbQv0auVYx1khDOG6X2QYO5QRgF0ZMLH
         TQLd1bTyrzrs3yTkGkNHwnMMGQ4/8YQQZBZx9peDctvEQPgqiSMwYsvyV1XJs26FHMlP
         cifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBzzi3RYg9BAscsHn1r0yQT1+XPIOaR4vTFZoqekCECS+26tPYxJ2UbS5htwstiauFtUWz0nynPxmn@lists.infradead.org
X-Gm-Message-State: AOJu0YwYVg48mSDK1FVMYwIoJnTflIVcSL6ftzBSvn3hz980Wmfn10qn
	2e3MqYPe+uJ1e+rsXzlmMPSxV3qYsNq9DhgdefdECE+n8+Z83t+RMK7c
X-Gm-Gg: AY/fxX5dpDdF8/hWDByKtp+m1mQrHJAbE6kg9mj1Bv/WOQcJbyl0MfV8aOgfWTi3WA0
	F3UPiqnz1uKZKCaQM9jFazFFCkQls2xJazT36TzskZNErZMw2wjplSkQcy5ZsJfAf72B5dhZFva
	jt9CGQayJjeghEul+6Ung/wB29Qwpyaq/gIZ61rMRi5p4UmOPZKmaXY63qNSB/dPV3wJSNBpOuq
	NJHvU8NNUogQ3uIZix6qWtLWt88gBxgFoavVOdUziJngLMt4heXtcaNiEOB1rAvAI5RWfCCdFzW
	aiVll5gXXeIx8VsyVfGlCX8P47fHwer3WCGWFhLGZAEloXtYncLofHWDcR4zKUxTxF/OqHIsUZ5
	f1dCrZL26dwwvZ/T9G/jn2ESaGtPQxqOmR1VrG7+ml+//bxwGbYRoNQoWoIiq9M0NpajV3XGVkJ
	mkkSIfaBwroTZIsCDTKr/6hpAjbfAlEps07DNKrDaOeIVuUXlHQPto9zepayGrzQWsiKliaVkE/
	1oxlzGMs1j+JCbDlGBju3xcbOxm822KLw/SdHEfSDlx06aS4kfCvZvwWM0GOBiP
X-Google-Smtp-Source: AGHT+IFIh4UFL5ktKvizijTqM9ls5ooe70zcSXJi12HfQ2Im3m/BSeK/gwa0FGVa9q2qDIVhMmmdpg==
X-Received: by 2002:a05:6000:3104:b0:431:cf0:2e8b with SMTP id ffacd0b85a97d-432c3778e47mr273696f8f.29.1767727956009;
        Tue, 06 Jan 2026 11:32:36 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e6784sm5933503f8f.19.2026.01.06.11.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:32:35 -0800 (PST)
Message-ID: <275fdece-d056-4960-a068-870237949774@gmail.com>
Date: Tue, 6 Jan 2026 19:32:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/11] io_uring/rsrc: add dmabuf-backed buffer
 registeration
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 David Wei <dw@davidwei.uk>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <b38f2c3af8c03ee4fc5f67f97b4412ecd8588924.1763725388.git.asml.silence@gmail.com>
 <aVnGja6w4e_tgZjK@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aVnGja6w4e_tgZjK@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_113238_303883_461F443E 
X-CRM114-Status: GOOD (  21.26  )
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

On 1/4/26 01:46, Ming Lei wrote:
> On Sun, Nov 23, 2025 at 10:51:30PM +0000, Pavel Begunkov wrote:
>> Add an ability to register a dmabuf backed io_uring buffer. It also
>> needs know which device to use for attachment, for that it takes
>> target_fd and extracts the device through the new file op. Unlike normal
>> buffers, it also retains the target file so that any imports from
>> ineligible requests can be rejected in next patches.
>>
>> Suggested-by: Vishal Verma <vishal1.verma@intel.com>
>> Suggested-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...
>> +	dmabuf = dma_buf_get(rb->dmabuf_fd);
>> +	if (IS_ERR(dmabuf)) {
>> +		ret = PTR_ERR(dmabuf);
>> +		dmabuf = NULL;
>> +		goto err;
>> +	}
>> +
>> +	params.dmabuf = dmabuf;
>> +	params.dir = DMA_BIDIRECTIONAL;
>> +	token = dma_token_create(target_file, &params);
>> +	if (IS_ERR(token)) {
>> +		ret = PTR_ERR(token);
>> +		goto err;
>> +	}
>> +
> 
> This way looks less flexible, for example, the same dma-buf may be used
> on IOs to multiple disks, then it needs to be registered for each target
> file.

It can probably be done without associating with a specific subsystem /
file on registration, but that has a runtime tracking cost; and I don't
think it's better. There is also a question of sharing b/w files when
it can be shared, e.g. files of the same filesystem, but I'm leaving it
for follow up work, it's not needed for nvme, and using one of the files
for registration should be reasonable.

-- 
Pavel Begunkov


