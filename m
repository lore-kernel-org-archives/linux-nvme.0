Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD8ACEFD01
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovZgk8PxCrhilP9ak1FB2YkidalwKuZZczfXtCx59dw=; b=elXrOUV8GwGtFWXIAcvcZlDlvn
	zLygTx/OpZUKHMsE08LFBgwGaYdHYOGwXYTbU6UJf8Vwr5RdTihFVYwVoC9V/efAT/SMeKh++0IL8
	LjhExGl0Cz5UQY+5oFV5enLHAzpU54ygmYsI3qbOyvfu9ar/zGDyeTivAQauXSLuexZxQ9juKzy+d
	i/BfATxf6YwxjPx+F7CSwnGa9riD1jfO+722Inf2VmBe0467hMkeZ3MH+q7aQaHB2jkbzaYulpYC2
	qJEFMiuFXkPpzQHORhDWDtzjh7++jGJcaN8V9TQH5g2AMUTpAKAw1+P5EArSXD0IDbJ5K9nEZAvEf
	6Bgx8GKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdD5M-0000000DmiY-0lEk;
	Tue, 06 Jan 2026 19:51:20 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdD5K-0000000DmiD-08Pu
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 19:51:19 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43260a5a096so876034f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729076; x=1768333876; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ovZgk8PxCrhilP9ak1FB2YkidalwKuZZczfXtCx59dw=;
        b=ltMhpp70L4AE37esvsdaClVN0YynGUIKccJ+n1vdkP0vCsEZdpyG+xvsFIW9d3UJyo
         1DWGD6m7FzBJ6pKlcs66kDuAdbUheIu05JPKo5tEDyfVPxIt2yt7JB8+VHPLceh5buR2
         XH4YJ5Vkaze/l+dpsx9PFGwXZ2QOmwWO4N8+KTXm3w/FIHkxnlp05/Y2SgE0hmtbLcdy
         f2f6k+y5UvlS0GExYVDpTw4sjQ/5GVmA3tLSbDxftM9M7y+f6cZPwdW0qj5/4rUzDvD1
         qPNYR+H34oSveyPQxb1ujwbuHzscU+tDcjCwkVCzWr2VFRFfXGGkfr2C3unk9fTkY3DR
         u5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729076; x=1768333876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovZgk8PxCrhilP9ak1FB2YkidalwKuZZczfXtCx59dw=;
        b=bcGT3LavzyFU7jD0PEra6m0793pMbWnRijUBeAQySRSwP5gi7hodFqyEN7fVLFgo/F
         yhMI9o+tUkX6Rradu4joc61qvTnPloMIjIJXiq7FvZkBRYFlK49NpPUNNdg+ytirGK8V
         4LWa5kMwX8MSgP3LMEVrk4veLqDt0SuMLIqAkL04tPUcdGO81GQkIAj2nguC2uckie6T
         IUnesrsZDuQ8XxTN4iuZJ9Gbqpspn5iYy7h+tQOCU/7AWL85csvDc/khRAWZogapHG+L
         Pj5ndRc2ox+XEMXrfkynuox4PycK39RFcs822gFQX+8oJi0/1l8NLirLOfW1nYnhIaV7
         6Pyw==
X-Forwarded-Encrypted: i=1; AJvYcCWWx/74zRFEsj6BsOxfYpnsJDJjD06LaBM+IPheWAfj7XVXBDvhmrENIH7r8UnKYCrvNde2mtlVqw7Q@lists.infradead.org
X-Gm-Message-State: AOJu0YxAcESUCbmYnFeVjho9IZvjMkbm/1P6/fXj++DQWiESpWKOTBO0
	IN0Y3CWSmSnqfPDaRnw1i1jMRR11sy/mrY6A1NMSVpnORB9XXzNiuo9z
X-Gm-Gg: AY/fxX5izuM/g6aWa7+yLALeQCPgxUTirozgEogUEZzjGuJhc6mYidfwVmlI8iFuY59
	DMjewdl+hBMJPPknW+TmUKJlQcj8xerNPT/n/rh0X64Jd5g4FSlYLxrKTo9SAC9zzF1okPWIz6Z
	3YcWNamzOLvIB3LTqCJLc4VFRgVyv46Jsj53yTr+lI4i+2uHZuZE+h2Yj+vzkEj8X9c+bzzcLCf
	KQmzpFrwWdim5qmWP8hghiQARyU1b9T7YpgKA4tUuWySiRf5FaGtAB4RCZArS3yNMgmGqhcP7jU
	LxX2MvS0Imv3gtGNBPSroW7y1aki0g7tb8aDgoYwplqpNa3nCF3LpHt0QaT8cKcdAQFb+veLa3+
	Ass/ReCAX47SRsPPFoGfY84DeD3mjvzwBaFhddzKkrk4GymAkG11LPD3skjP10Cq0rBIgvB01qk
	hYYDs7prnr6IHmOXwnm47v3nPdULaZHGXVc7tLMH333ipURbmiow8YSxOY8fSjcFF//uDnVx4cg
	v2NN4dxt/Nth8xAIBtdsVi3Lss1l0bwxtS9GO+yJ5dKBxe75T2DM1N0R5DqWo+j
X-Google-Smtp-Source: AGHT+IFFym+HTWb6WhRU4bKfzHds67XbzvjVQ0ncM7+fS6yOVWLogcdaslK7a3BF15xU4e7GXQY5lg==
X-Received: by 2002:a5d:5f51:0:b0:430:fdb8:8510 with SMTP id ffacd0b85a97d-432c3790ca4mr333772f8f.24.1767729076041;
        Tue, 06 Jan 2026 11:51:16 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm6241105f8f.18.2026.01.06.11.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:51:15 -0800 (PST)
Message-ID: <a96e327d-3fef-4d08-87e9-c65866223967@gmail.com>
Date: Tue, 6 Jan 2026 19:51:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com>
 <20251204110709.GA22971@lst.de>
 <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com>
 <20251204131025.GA26860@lst.de> <aVnFnzRYWC_Y5zHg@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aVnFnzRYWC_Y5zHg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_115118_084774_BAE3CFA7 
X-CRM114-Status: GOOD (  20.03  )
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

On 1/4/26 01:42, Ming Lei wrote:
> On Thu, Dec 04, 2025 at 02:10:25PM +0100, Christoph Hellwig wrote:
>> On Thu, Dec 04, 2025 at 12:09:46PM +0100, Christian König wrote:
>>>> I find the naming pretty confusing a well.  But what this does is to
>>>> tell the file system/driver that it should expect a future
>>>> read_iter/write_iter operation that takes data from / puts data into
>>>> the dmabuf passed to this operation.
>>>
>>> That explanation makes much more sense.
>>>
>>> The remaining question is why does the underlying file system / driver
>>> needs to know that it will get addresses from a DMA-buf?
>>
>> This eventually ends up calling dma_buf_dynamic_attach and provides
>> a way to find the dma_buf_attachment later in the I/O path.
> 
> Maybe it can be named as ->dma_buf_attach()?  For wiring dma-buf and the
> importer side(nvme).
> 
> But I am wondering why not make it as one subsystem interface, such as nvme
> ioctl, then the whole implementation can be simplified a lot. It is reasonable
> because subsystem is exactly the side for consuming/importing the dma-buf.

It's not an nvme specific interface, and so a file op was much more
convenient. And ioctls for registering it into io_uring would also be
problematic. I simplified some of the layering for the next version,
but most of the complexity comes from handling in blk-mq-dma-token.h,
it'd be same even if made nvme specific. In fact, I had it all first
in nvme but then had to move to block/ because of sleeping.

-- 
Pavel Begunkov


