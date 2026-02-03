Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF88BE87834
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ehtdN2dtUUyw8t9CF8LW9obJiHb6WlF1A+WpekGmvjk=; b=pkX+XD1Ztzi4D179oiCb0sLgw9
	NDH8Uk1ZMV8dpuI3TjA5VkwWoq6kMhR6e3KkHV6acWjgc4G6b+Vc5/48Jjbf9Ka062lAM+IFTS1/E
	23+ezyebWxXA0oJDj1ZYEaoRoiYMGiTUopJKa3Zn/kKXScnHkQp61XokGkimSeNwpUwsWhhdq/K8F
	YWn485Tr46z7M1482Nl/OViHYv2tIl8II+TroD4PN3bP21GSCXw/wMixshie664bdHn42A1PWa7ss
	2gvDLn9LkVbBGBSdgEr+dKeAb8LWh8e5PQR/f6tswwI2or2bjZSMkhR9xzeRpevEg0RLLAzdFQKXp
	EEM4rVFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnHPr-00000006liu-0gmS;
	Tue, 03 Feb 2026 14:30:07 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnHPo-00000006liP-2wsg
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 14:30:06 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so4913996f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129002; x=1770733802; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehtdN2dtUUyw8t9CF8LW9obJiHb6WlF1A+WpekGmvjk=;
        b=E4pVEIEadBU12D21edSFUdAv1nEVstZ3MrsF+3pMUHOwZfmlfQ5wUTmaUaD8A+goVz
         lYESK3fEtnsQq/9m09JDxEibPocrFGyn5Y67q71qZEI9JWRr7Cp6mXV4oDLDhAO7m+ei
         5WXf7MnqLFv+X3F+P90+dVHCC2Ttk6lWnRqnS4mfSAbGgUGHPeElYdA+mz64WhUUovts
         OgCHM/bMhVFFYt1hSiUvcH+lEpaB3DJnoutl/hP/VWblrk5txuzwzJ9QplMKpZ8QOj5s
         Ik1oJmY8CS8MoWP+5rWRu0Y7B8vGnvrhTwRB/4pK0wIYzqnyKcDpxER7AR33bScUbxuu
         DoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129002; x=1770733802;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehtdN2dtUUyw8t9CF8LW9obJiHb6WlF1A+WpekGmvjk=;
        b=XvEtjSeYnjxiMXGpzCdTpH2sr+hsMn2IAGvG8+8w3OMv19x0J98pxVngtea9Qej/3K
         v5zagG1S0YgZoH0kB1wuHNW3arc06UQSgd4OI/9LRhbT8E8BFITwUbocPaGELY2KcReB
         fq8MXeO3HyEYsj1PdX21s8ot5E54cP3UQ1LxKNq9Kuy1Tln/3nTk6t92+eJi2n+A9A3T
         4Dauxqmake82HhV2O1f2AeKlXmeF//fcoPD54Ns+8+gwKRoKfmQGPh+/APvFLn/jVld2
         i3VqoZulrUF8daGqY0JDBoU6gCVCZ0hlYtjc8NzLVJ3yFxfWuRvJTW1inpBBWWWjn0gO
         jPPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUe+QB3dWF6W8SrAwMmxEmg+gvyu37fUawRs5oTzLpQcWL3L8KLdgg/qIcHE2kW4RKsbVrbJ4rfXes@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/mX+rH5bLP+rWHmsGmm8wgOg5x6GJzL7TMV/AELmU2kX2QrH2
	TJlc5tx/NiqHL8g2FJoE+mu8o1RbiNM+jWKwY7gGIJQcVSSahuzpggEN
X-Gm-Gg: AZuq6aJAz6aSxRBa3cGUYZKB0Yy36RcdVNpurQ6YLebJj6iylfK6A70B0+yBNUoPpHK
	etpTbtoPyUtcH/762Ur3fVhesFuj7klEJtWRxSUMzB634YP8MU2n0FjXriJ8X65lCcaGvkXh36J
	3lUR8vpvk3HIIKTQdYwIm1dnJwRdPAm8ncld0qBqCtRQiMLtYzo0xxba2hxn7ijwx4rGGeGnZng
	4faj9/Nf/LQoRMFp8aaAwkpHhTZXSUCMVBvBC0JdqBmGtHV2y0Fcmi4x29IGR1CSnAKlYrb4Tuh
	66nARRseDahZ09r9eCdadcri+Lcb5kzi9Js8NABx/dTuMhz2JF49M7nENLRfIVEvVmcKGAL+WN/
	jVBHF0hYFQBjYw9mszh0cAivLarySzLQ0MdcsHj+OOhZc0sZ9EbIkymLvsvTLUPQiBoWuKHa6A8
	WRydz4LnIH6SYTllvGhHZ9oGdsP9YPZRMAyxBpPUWUp8gbQ/5W30py7x05E7OuwgSstXYRnmkMz
	4KfRaNoaBpfQcbNkDGQBDpDW8wIU3wUmAxpj+ddo3i4jgYfpjYvzAe+fDsOkvAHAVpM3nr4GimI
X-Received: by 2002:a5d:5f54:0:b0:435:95c9:6895 with SMTP id ffacd0b85a97d-435f3a72dd1mr22421934f8f.18.1770129002134;
        Tue, 03 Feb 2026 06:30:02 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322dc7sm52615095f8f.37.2026.02.03.06.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:30:01 -0800 (PST)
Message-ID: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Date: Tue, 3 Feb 2026 14:29:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_063004_783962_BCA75823 
X-CRM114-Status: GOOD (  11.37  )
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

Good day everyone,

dma-buf is a powerful abstraction for managing buffers and DMA mappings,
and there is growing interest in extending it to the read/write path to
enable device-to-device transfers without bouncing data through system
memory. I was encouraged to submit it to LSF/MM/BPF as that might be
useful to mull over details and what capabilities and features people
may need.

The proposal consists of two parts. The first is a small in-kernel
framework that allows a dma-buf to be registered against a given file
and returns an object representing a DMA mapping. The actual mapping
creation is delegated to the target subsystem (e.g. NVMe). This
abstraction centralises request accounting, mapping management, dynamic
recreation, etc. The resulting mapping object is passed through the I/O
stack via a new iov_iter type.

As for the user API, a dma-buf is installed as an io_uring registered
buffer for a specific file. Once registered, the buffer can be used by
read / write io_uring requests as normal. io_uring will enforce that the
buffer is only used with "compatible files", which is for now restricted
to the target registration file, but will be expanded in the future.
Notably, io_uring is a consumer of the framework rather than a
dependency, and the infrastructure can be reused.

It took a couple of iterations on the list to get it to the current
design, v2 of the series can be looked up at [1], which implements the
infrastructure and initial wiring for NVMe. It slightly diverges from
the description above, as some of the framework bits are block specific,
and I'll be working on refining that and simplifying some of the
interfaces for v3. A good chunk of block handling is based on prior work
from Keith that was pre DMA mapping buffers [2].

Tushar was helping and mention he got good numbers for P2P transfers
compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
previously reported encouraging results for system memory backed
dma-buf for optimising IOMMU overhead, quoting Anuj:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

[1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
[2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
-- 
Pavel Begunkov


