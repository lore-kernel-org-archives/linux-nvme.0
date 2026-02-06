Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8340EE20AF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Feb 2026 15:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=; b=AwgARF1hF63rdUE/tL7ELNEypJ
	caH5qhmVudollSLcVXObbb4VIbKCcSoz0fwTzlI7ogJqROv5Pg7wowLCkquAa8H3udh2ShxS9wz6C
	dlKgjQ0/yrnU89MbII+Iiat/hnwfiZ6bz6QBbJrkuCkYwI30KZP0ggA0vizjtOeMcZezBsqkJ26xc
	a7OEJnbeYRqMt/ycxRsKcyTuPVSiuu+z1dBXercMQXds3OVSsNe/21QFBvnrlph3E0V4FvCCFIPlf
	zKc4Y29CmK67CthugF3GIwb0YW7LnMtwrLc3WeV1+IfPr8ROWb3W2I48qyCgo+cKgplfyHifPQb7q
	B2WJJEaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNS4-0000000BTRt-29Wt;
	Fri, 06 Feb 2026 15:08:56 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voNS1-0000000BTR2-2tmB
	for linux-nvme@lists.infradead.org;
	Fri, 06 Feb 2026 15:08:55 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-65956402da9so1650276a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 06 Feb 2026 07:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770390532; cv=none;
        d=google.com; s=arc-20240605;
        b=WfxMczwxVONIL/jqOaejGn9N6BjEPXN4g2kxguDYHky3R2FzmrWgMGMs9VrlBNQP1O
         OxixGm1+J0hmOlpuRlwQG2BChNxugBg6TT2sdHsvGUX5DAZFSgNHbUAbx5xzNmw6t969
         WQtafNfdTCqvCJ+Zp8UKzQ4CixHRCYEpSTU7+5FOJvqg80PuJhmQbviFB5EWig9CuCcg
         TFMIqBRQSFepGnsbbyn1hR7K+CJVPA6HWOULZbVZal7IjNQyFdjilLFzrP0iKFV32mxO
         k7EcJaEsfqM0Yq0i7uDLaOU/n6z828U+JqGJagsckVFaEXcyI5Zhrg0CEjfSOimge9G8
         pkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        fh=svTqqHU1uuMHg+U287m9o+pGAtYe08lL2b2zTG4e0VI=;
        b=N2rANpetGI7iJWdYUHTJ8eOqxy5JleHBFTX2hT+cR0rj/mTZD/3XUUpYwrSEk1y1vu
         GdXd9orB0hU3OrrVS9n8wSCp3zVwBMoA7ErWkED8Q7JX8K/3jxk+AnRthuKfzwUajX5/
         34I1Bhcmq+Uy3R2XYxmXEnRn4BOY4NpyriWiBINJ54pG2Mo8wFj8yT7cJ/huYBjWGgM8
         HrBfL2Fzr6/8FnrmuJoPYpkIjmEaD/kVjsj3ireifRSoM2I3pFltHYpCHhv/9i7o4yds
         LYMlxHziVqpbkD9nZHucGbCkuNCFtXKSGQG/LsAaMWGVa+pPPp1gqV2y6OBy9DfUkWjT
         d61Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390532; x=1770995332; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=TE30qutqCOjPzIKAHD6rkowjHOKcYuS8GseYsQbSsUOMRO53TIbfiQ7SkTIOj+SHJw
         E5sDfi2VzNF37AtwQyNAKYRQPAMr20JpAgVg3yvANdsnHcSQBHbD0CJaRXQK1koMqKzP
         Bh/mWj7UcnKInsg38x4OeT9W1ssqFZ7/fChORmPzN3zXYvnSXJLvTuKh2gLNHTxbhkRl
         YboOZ1WZgtwdZtyoZW/VjoG2TwRre8FNhXyTL68Wo5GuLRi8LihwDGJoy6SZ2jJydP+P
         4kNT9twTYPf399x6uEv/Y8HcJhUDUXHMxn8zRT5+RM8e+3sXXpSgo0PwxBEZD8Oub5T+
         xdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390532; x=1770995332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV2wXVQGGux8HdfCehvXRHDBtsaFVEwot7iSA9nA38k=;
        b=woMvecgW7ATiEqrIzkIiw5yY6okitOfbSkxlyRsrsYgcGHuudB34SGOwUTavihp9HR
         dNO61552Pv6bHFB0EWkulYbfVQchbhLt8Sf951QnqYBfm5hNzyuzT5eJrtjEThmDjWL7
         eIETM2HORIG7/bDrlytudmLaEUonOUmyMyZpycXr5yZyczouxcBlm1FaLklE/Qkle85F
         REmTJnasoiXCCsqP+gsCNbK+l8wpXkkaz9nVoVBmQIk6VH7SMN5KuS+obKa+BUoxv69d
         /nRFjemNzrb1sOLfR4y1+MQQ6AgR8BvoCOXfQuEC/RpL9iY/HmLT1w3HSKJTYlted6dB
         oYdw==
X-Forwarded-Encrypted: i=1; AJvYcCXZIYGIyveowh/nlF0lj2HnF6D1B0FXkaK3YoFjmyFO5cMtAhJf3kDzmrvlFOGfFGNB4pL050GUuvAL@lists.infradead.org
X-Gm-Message-State: AOJu0YyX3YYIu0/xn8HP3csM3NleDqY7u9vBfUJXcxAZEwKqYTlLrNOg
	6NI8GHTAcHjohlrDkmV0LeGQ6XLzDrFGGZFeQYcxNSkfTafDWmdA2s22ihRr14cJV7T7n7Z26Xw
	R7jMlAkkjTNCjdIkb6a7LErNBOsWx1g==
X-Gm-Gg: AZuq6aLkMPnE5VNK3mri6TwyOM/w9jxjdxIvHAdycldASCUTNX+WFDzZNtXv/ROifQ5
	TkJSmCh6Zqdo7FFYkLsSVvwAYcGxmdIh7l2l3nf63mBPuqpoV1l9zK+NvhGFRHDCVk96IYSv/Pb
	B0pcyajFAA5x35Xo7PlRfYXzsXUJ12Osi3Ji0ejx40eIBJJ0opFTJpXfnVA4M+q/lHnB2VpwLW7
	9TzeMYnDq606d3IYWiPUUp8smZza9ktXx6wmnkVmG8kWdNRT13QWwSPkSsPNZZ/NNc/OgPpONrR
	a/uQBJXZZHXNty1iJ4lRsmZaOid01mgUr58MwRj1VjDcP/rrZE8s4ZSfhA==
X-Received: by 2002:a05:6402:278c:b0:64c:69e6:ad3e with SMTP id
 4fb4d7f45d1cf-65984192b46mr1665335a12.33.1770390531549; Fri, 06 Feb 2026
 07:08:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com> <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Feb 2026 20:38:13 +0530
X-Gm-Features: AZwV_QhSbcTXF1vOFniIsckdgf0WRvSvELPcT6UCzLuL9aGCZaYlbLnCwaCB9sE
Message-ID: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_070853_989647_A8385BBB 
X-CRM114-Status: UNSURE (   7.83  )
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

> +
> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
> +       spin_lock_init(&fence->lock);

nit lock should be initialized before handing its address to
dma_fence_init()

