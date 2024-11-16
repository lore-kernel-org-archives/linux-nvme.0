Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAEED68BDD
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2024 00:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ub+hhbIuAfONcEAapKR7TEJICFZwPInFyKrgiiMvBE=; b=3/TrYZYEb6OdpgjQJYEAskWh7R
	2rPV6yWfs6MeXG70Nw5okYPQX5uORlq7u2nnVSr1ZPz+myh1GQ7PYpj+qDIDPihynHQ8ocHElliCl
	uv8idi1TrI5/MYcJV479/S/kUloNrugjNxwTs8lLAETuamLX1AX47sJHHPLPlmDSW8OikQ0ppTxz8
	s/vhi3K4Bc00muXRVesXwsoLG0BvBpL0sFLKcjYezQaNl1Q5zqXl9i6J2EQt1wsP6bYkw+Jyfq64a
	v06PJSs6AIbO1bm+AvD0zg7A76Vw3B3TTq5AYsUYAAuZqqTTpsdSJOv7JbLHxyUrGLhB5nFSjrfY0
	HBXboNiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tC6EK-00000004bLx-1629;
	Sat, 16 Nov 2024 00:00:00 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tC6EI-00000004bLC-2iKc
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 23:59:59 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso19797315e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 15 Nov 2024 15:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731715197; x=1732319997; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ub+hhbIuAfONcEAapKR7TEJICFZwPInFyKrgiiMvBE=;
        b=c/uYbxSdts2/pfjLZl4jr4vFI7NFsMK41RgCiWVMf6Avpgn1l40U9hvZMRrWqOVPhD
         sFdcvBlgImJQQh0HRbW2ihnzp1OKx68D2cUSFe7Pu/aSDpDlgwmrZDLF8OY5/Kb9GsPx
         HeAb8zj6IUB2ax6gKWtQOkD7XKiAghsHC1Pyilh+N8L3HucSmmF2uNbp0c0HSg+JfXeT
         QvAYG9TQjMzudxC8VZw3clNi6TKCElA6ljgOEqz0dvCU22+sH+CK2Mi5E4Njb6qUgnQN
         Paa6Tu9d2HLGtI7uCPuDUt0ZDl0D8L4Shm1fX/WJintIa7ijBIqCQDeXKslTnEIoPdHr
         CVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715197; x=1732319997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ub+hhbIuAfONcEAapKR7TEJICFZwPInFyKrgiiMvBE=;
        b=SP/q2D8B1bH0omdM1H2YLxN9uxbcgVMi34iMWXqkudrGNn91UnQoafnBdxZjjluZGN
         0fbD8SBI3Ia6dtZwgpq36k31fn2p9Vc8B2btI3w7OxY2+gSiu3yJiEVl3Qt2G6I/Tph8
         syCI4bd506r8J7UoqLYWMKFsfG2375MCJDiM55syy5Uohcekn81xp+ZmhtO2Ut6VaQMz
         5B6reQVpsCAI1GGrBsBg0lDIG40jX2iVjE6Vty2dbPzsCAUENu22HLln2abNDIeIPUH3
         9mg1yqkmQ4zaF4HiKzFw+9RcE3AhL24+eS884F0C0mk5M72oFnlNT8QpQp6TO3qmQByE
         yhIw==
X-Forwarded-Encrypted: i=1; AJvYcCX65enTXbuZbpTY6jG3L80f8r+TncxHklj5dedktPvnhyGDRuRRw06KH6PBNy2l3ZxhEMAtKUVYYCM8@lists.infradead.org
X-Gm-Message-State: AOJu0YztWelqoRaZESBzD3tpqPI6mVxrlkCAEA16cEw2TE868h6ys41d
	FOZyCmK0ZX3Bwulsm7qO6E+MU5NN59bZ2TkVpUH+IA8HyWWmram6
X-Google-Smtp-Source: AGHT+IGft1DvkMAO1kWM1kUCxMyoddKfZKvRD3xbOGm0Jf3Bj/9DDcNLrhNQNG6hJXFMXzx//UWwIg==
X-Received: by 2002:a05:600c:3b9d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-432df7211a5mr37471815e9.4.1731715196605;
        Fri, 15 Nov 2024 15:59:56 -0800 (PST)
Received: from [192.168.42.251] ([148.252.132.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab721d7sm71012105e9.9.2024.11.15.15.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 15:59:56 -0800 (PST)
Message-ID: <c622ee8c-82f0-44d4-99da-91357af7ecac@gmail.com>
Date: Sat, 16 Nov 2024 00:00:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
To: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, martin.petersen@oracle.com, anuj1072538@gmail.com,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com,
 linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241114104517.51726-1-anuj20.g@samsung.com>
 <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com>
 <20241114104517.51726-7-anuj20.g@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20241114104517.51726-7-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_155958_711576_A580D68F 
X-CRM114-Status: GOOD (  25.22  )
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

On 11/14/24 10:45, Anuj Gupta wrote:
> Add the ability to pass additional attributes along with read/write.
> Application can populate an array of 'struct io_uring_attr_vec' and pass
> its address using the SQE field:
> 	__u64	attr_vec_addr;
> 
> Along with number of attributes using:
> 	__u8	nr_attr_indirect;
> 
> Overall 16 attributes are allowed and currently one attribute
> 'ATTR_TYPE_PI' is supported.

Why only 16? It's possible that might need more, 256 would
be a safer choice and fits into u8. I don't think you even
need to commit to a number, it should be ok to add more as
long as it fits into the given types (u8 above). It can also
be u16 as well.

> With PI attribute, userspace can pass following information:
> - flags: integrity check flags IO_INTEGRITY_CHK_{GUARD/APPTAG/REFTAG}
> - len: length of PI/metadata buffer
> - addr: address of metadata buffer
> - seed: seed value for reftag remapping
> - app_tag: application defined 16b value

In terms of flexibility I like it apart from small nits,
but the double indirection could be a bit inefficient,
this thing:

struct pi_attr pi = {};
attr_array = { &pi, ... };
sqe->attr_addr = attr_array;

So maybe we should just flatten it? An attempt to pseudo
code it to understand what it entails is below. Certainly
buggy and some handling is omitted, but should show the
idea.

// uapi/.../io_uring.h

struct sqe {
	...
	u64 attr_addr;
	/* the total size of the array pointed by attr_addr */
	u16 attr_size; /* max 64KB, more than enough */
}

struct io_attr_header {
	/* bit mask of attributes passed, can be helpful in the future
	 * for optimising processing.
	 */
	u64 attr_type_map;
};

/* each attribute should start with a preamble */
struct io_uring_attr_preamble {
	u16 attr_type;
};

// user space

struct PI_param {
	struct io_attr_header header;
	struct io_uring_attr_preamble preamble;
	struct io_uring_attr_pi pi;
};

struct PI_param p = {};
p.header.map = 1 << ATTR_TYPE_PI;
p.preamble.type = ATTR_TYPE_PI;
p.pi = {...};

sqe->attr_addr = &p;
sqe->attr_size = sizeof(p);


The holes b/w structures should be packed better. For the same
reason I don't like a separate preamble structure much, maybe it
should be embedded into the attribute structures, e.g.

struct io_uring_attr_pi {
	u16 attr_type;
	...
}

The user side looks ok to me, should be pretty straightforward
if the user can define a structure like PI_param, i.e. knows
at compilation time which attributes it wants to use.

// kernel space (current patch set, PI only)

addr = READ_ONCE(sqe->attr_addr);
if (addr) {
	size = READ_ONCE(sqe->attr_size);
	process_pi(addr, size);
}

process_pi(addr, size) {
	struct PI_param p;

	if (size != sizeof(PI_attr + struct attr_preamble + struct attr_header))
		return -EINVAL;
	copy_from_user(p, addr, sizeof(p));
	if (p.preamble != ATTR_TYPE_PI)
		return -EINVAL;
	do_pi_setup(&p->pi);
}

This one is pretty simple as well. A bit more troublesome if
extended with many attributes, but it'd need additional handling
regardless:

process_pi(addr, size) {
	if (size < sizeof(header + preamble))
		return -EINVAL;

	attr_array = malloc(size); // +caching by io_uring
	copy_from_user(attr_array);
	handle_attributes(attr_array, size);
}

handle_attributes(attr_array, size) {
	struct io_attr_header *hdr = attr_array;
	offset = sizeof(*hdr);

	while (1) {
		if (offset + sizeof(struct preamble) > size)
			break;

		struct preamble *pr = attr_array + offset;
		if (pr->type > MAX_TYPES)
			return -EINVAL;
		attr_size = attr_sizes[pr->type];
		if (offset + sizeof(preamble) + attr_size > size)
			return -EINVAL;
		offset += sizeof(preamble) + attr_size;

		process_attr(pr->type, (void *)(pr + 1));
	}
}

Some checks can probably be optimised by playing with the uapi
a bit.

attr_type_map is unused here, but I like the idea. I'd love
to see all actual attribute handling to move deeper into the
stack to those who actually need it, but that's for far
away undecided future. E.g.

io_uring_rw {
	p = malloc();
	copy_from_user(p, sqe->attr_addr);
	kiocb->attributes = p;
}

block_do_read {
	hdr = kiocb->attributes;
	type_mask = /* all types block layer recognises */
	if (hdr->attr_type_map & type_mask)
		use_attributes();
}

copy_from_user can be optimised, I mentioned before, we can
have a pre-mapped area into which the indirection can point.
The infra is already in there and even used for passing
waiting arguments.

process_pi(addr, size) {
	struct PI_param *p, __p;

	if (some_flags & USE_REGISTERED_REGION) {
		// Glorified p = ctx->ptr; with some checks
		p = io_uring_get_mem(addr, size);
	} else {
		copy_from_user(__p, addr, sizeof(__p));
		p = &__p;
	}
	...
}

In this case all reads would need to be READ_ONCE, but that
shouldn't be a problem. It might also optimise out the kmalloc
in the extended version.

-- 
Pavel Begunkov

