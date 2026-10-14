Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE2CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=; b=1fGtYhRAEy/jLD60kAYeZSV/Kp
	5girhrdfZLZraNzkqsVXT5nbtzgi8D6sOhjxfxPkaevwpR5t9szqhcPyF4nCRNkSxOprFKbyG03nS
	jga7nx+uI28qLjBBbLIqCmndK32Svyqd8xERuXVQwr6tXY1L6pFTauexDcAtIe5MsSRjjb7JDFN0a
	F/5oTaIlo9KTrzyMzOEK6ldmREn11mXiT3L7xm3ihjXYU882L2hk4cyjzb3hM2lkWYIhlI/HEqhwf
	IEHhgapbcoGmCoRzfpP9ycYn5jA+3imPQfulNKutGNWG1PjzI+Zf8HprR8M/oqPDQH8HBCjOABVFT
	shJ54Vdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxd-00000000TIv-0wdJ;
	Thu, 15 Oct 2026 15:01:37 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH07f-0000000FkHR-0jFu
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 14:38:28 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso1525427a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 07:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988705; cv=none;
        d=google.com; s=arc-20260327;
        b=UIDcwV/LnXEnVFvL7pndh4AP8vH8wAF0BtwTJtlpYGrQlc7tPFw5pFyAxIP/X99Q7Q
         G1N5d97J+/0g1opOTMQV7GcfmHip5a70tEjGiig2af4FhxehJ+Rc6O8/OLjkQsSvV7J6
         TDvhTZQckoBbyHxoBFc/sTJ+bwS8Q2ZImWMiQbPyl2+JkC+RJmaPnDaUEN8DI24a43nD
         19Z3/MTdfEtDOTqZvNbJuRU50oBJcZ5jPBPF0WBW3nl6Okr9tIYVLeZ8xOu3SWbHbkiy
         xeTZWv3hn2b1L+gpEyyZlEOnORDfBj0UoTO7yQAsB57uEkRWnFEll0GHuVEYQ6YeWTka
         r9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        fh=Mu0EkMVxGHJiE7SYiRHzJhLRCgoSehKjG9hUKXr5ddA=;
        b=X/utZqk/pzjtOA0GPNGdUJPvw3PLfzs0ZClIvhIIuerWTpfwT+Gzmq03jtYkJtqP2w
         EiAKhEfD76CgdKrG2B25vxoT1oUfjhdzUmFl+ItEEl7U7N/4O6VgQXF6tfudEZVO5SkS
         wi/6GNYRa/s7keRoWzMP8pvNi3YI66x2BR9exuvZQfHkGZncS9U9Qg5YtCBbIpaZZUOX
         GiPE8Ht0PyIkxfOKaKo8sZo6vUXEanMsP/7FXZUF0rbMreohqKBQhmE+4M7KhX/Es4SL
         wbDH/IhDZDXZiohH5CgQRj/rE2FXKTalk9KgREWARAZ5Cq5oszMKGV86rMdojjxHwgKU
         eHgA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988705; x=1792593505; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=ADl2VZYmULio4eN/sE95+2zCA6ZjBhFbUmJ96aofGi7iPt9m/oMfIhlbaCUrx2Y7Mk
         u7gESple1sCo6xWLlDnknDoJnJ2bPyyJjVXqmr8VbM1eWUEP5i8pBuL68oHx+H4RuWak
         W6bA2mwWecsZXYOU4Pkrrmyd7VlfsF7hJVdvWgucBzN0xHNj6v0CESoZ+oLHlI7ckGrV
         U0wwq6cQgZRa5kIxp4R7nQLhMSCe3mF+FOzxVDVqiF/HCSW61JBQ0qwcGi8LCpG3HPeg
         1dvyDoNldw2tOVh7lxb61AkW0MQ3vyAY+WQM2S9b7RpzEEREmCDUa4qUGygG7+F8tJrZ
         Dkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988705; x=1792593505;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ht8GLTCoCKkoVxwpD5KYA+Pz/0xMc+C2begOQBfsCnM=;
        b=YS1BvaaM08bgoeqIb/0GoiGw9ezcNb9gwTIzJ97/4xp0N5NP2DRU4IXzzuikIrHIYx
         abH3swhLkwnuREOSTcbo3yJDmyWCHt4Yy1H5jVUEFTFj8IEzv+z11dEaL2Up3h/25a9z
         oYrViG+gcSFKslPwRDYpg27jHXqsvvkCqrhN2XxwTe5AzmOohFOSj8ECZ4xc6brBL85t
         /K8VdrnSBlPyPqVkLgvcXEV5gMtryI9PG99QW4gmrwalKKHBfmZsrP5fH5g3Q9dAxn5Y
         LmWhKp1a9BoNrYR0FOf8Go9uoee5K3oMxtv7/Eq1sK9SMGlICrAAwDlvY2lXG0C/ybFy
         i3vQ==
X-Forwarded-Encrypted: i=1; AKwUvByy7AlK9JcONGzPFAqjjZerC7l+iUUkTQfWiKF9Vf7Fn3m+m/VYqxO0ls5jEFi97abmg8DgQtCZ4yVt@lists.infradead.org
X-Gm-Message-State: AFq9FYKEJcjPP2wlLJC3At++BsoRDveRdO4tGcBN1UZiz91wcRENOIDy
	WBBIA1xAiqYNQ9r/rz44N6zwWw53kqi+ygvw7IFa76uhCx4o1yKHnTCiUAiBAAba8QDihEnI7XX
	ENhsCjbVsV1AVgj6+aX7M4j6VpnC/9w==
X-Gm-Gg: AYBFou0ExUj9+NBGwM3RLbjSELtiv+0BNwtqQqCngCBpKm8PxUL/70YKjYBzPNC5RJa
	fbNk2nHnSz076P5zv1zES4WAgzAhmd5dMHc4RsgQJuamM7qobH9l9QiglQ7cS8mb57dkUXF8rOm
	3Yb8DIsw4fxAykSaq81pi/G/pQMhKmonoxk8kYqe07A9doV5PVejcpsQFXIQiDF+I2iOV2qqmma
	79N+fM/M3gDqUbQkYe+aC7HdBGOT6BzZDBl87JdCw5HGeZVHh16ZGcKil3kj8P+M9vckj2VY5JJ
	RiP7xejBizAySPzbxZw8KzlRL3Tp007M/OU3487ebR7pRpcDMI7pBaz+l/KqZdl2TJ6pU/d76YF
	9gJaGlQm1fA8+M9ZOLw8/aA4J/MNXuMJcpGTarts=
X-Received: by 2002:a05:6402:1912:b0:6ac:b9b5:8e8b with SMTP id
 4fb4d7f45d1cf-6b17c2a3670mr12616709a12.15.1791988704432; Wed, 14 Oct 2026
 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1791975048.git.asml.silence@gmail.com>
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 14 Oct 2026 20:07:46 +0530
X-Gm-Features: AclHuK8DZ9QwF2AgJ3SDr4lT4xl3Cf9evBnlWqjNFK8bj0mT2h6JXCYZXSbhb_A
Message-ID: <CACzX3Ases=5auovox0XFNheDHY9iNmxv2BvB0dugC-W3mnjGLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_073827_229567_C6B172D0 
X-CRM114-Status: GOOD (  11.71  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:25 -0700
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

> Tushar, William, Phil did a lot of testing and experimentation on various
> devices with previous versions of the patch set, and I've received lots
> of help from Anuj, Kanchan and Nitesh with investigations, testing, and
> patching. Earlier benchmarks by Anuj for IOMMU optimisations with udmabuf
> showed:
>
> STRICT: before = 570 KIOPS, after = 5.01 MIOPS
> LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
> PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

I've been involved in the development of this series, so I won't add a
Reviewed-by tag, but I tested it on NVMe with both an AMD GPU dma-buf
and udmabuf exporter, using the liburing tests and custom fio plumbing.

Feel free to add:
Tested-by: Anuj Gupta <anuj20.g@samsung.com>

