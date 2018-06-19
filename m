From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 14:59:00 +0300
Subject: [PATCH v4 3/3] nvmet-rdma: support max(16KB, PAGE_SIZE) inline
 data
In-Reply-To: <051c25edb1b0c0aa84b8195a95bdd3eb30d710f5.1528219321.git.swise@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <051c25edb1b0c0aa84b8195a95bdd3eb30d710f5.1528219321.git.swise@opengridcomputing.com>
Message-ID: <98819370-459b-cad8-e89e-e2a128178dba@grimberg.me>



On 06/05/2018 08:16 PM, Steve Wise wrote:
> The patch enables inline data sizes using up to 4 recv sges, and capping
> the size at 16KB or at least 1 page size.

Question: any reason for that cap? Just seems like an arbitrary limit...

   So on a 4K page system, up to
> 16KB is supported, and for a 64K page system 1 page of 64KB is supported.

Well if someone asked for 16K and got 64K its a bit of a surprise
isn't it? without exposing knob for this, using 64K OK I guess, but when
we expose controls for this its a bit surprising.

Would page_frags work better here? (page_frag_alloc/page_frag_free)
Given that most likely the backend device will work with 4K pages, the
fragments won't cause gaps...

Thoughts?

...


> +static int num_pages(int len)
> +{
> +	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
> +}

Steve, can you explain why is this needed? why isn't get_order()
sufficient?
