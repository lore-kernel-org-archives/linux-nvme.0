Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00D606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bM01kauT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQh2M+72
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UoFgbUFr390e5Xu0VCDxVTfIqMC+VP5cBukPS2Qt+oc=; b=bM01kauTi30VaBS3Hbxkz6n2ZV
	zkf2untzQbbxptPhUgZLzuBQfkPdTF0/ugnyj0LzGCX4sOtTufEx4oDWElIPx8A6LyvmGYUE+hkg6
	KTFTi6fiJyXEYl/I9R8Q/1XeVV1gK3/d2Nei2wsZ6Oi+pNWAa8wl0BZHMI/T6vzYFsJEC3vcpJcER
	LwpfnV2F5EWT/E5INQLoTGcZgeQybBCcUAKdUlFceB+X1e7lXaBZpkErA0sVIlBi3F7AQGvEL6keV
	DEV7DmiEqIoavMRrWiQX9GZVH4b2btBRJhd6tRxHNQlERXTAJ6sZyuqPGYXtJPBvM27ZHBhyi/AID
	Xd94cG5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeYy-00000006A63-0rzp;
	Wed, 04 Nov 2026 17:14:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOeYw-00000006A5t-25Fu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 17:14:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 93E816021D;
	Wed,  4 Nov 2026 17:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499331F0093A;
	Wed,  4 Nov 2026 17:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812453;
	bh=UoFgbUFr390e5Xu0VCDxVTfIqMC+VP5cBukPS2Qt+oc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=oQh2M+72G011a64t1DPXJOY1n2qjCueRpbSlNGk381Yw80jocTqJFuwhNo1od1Hpr
	 aAt3mHZXGj4EKpHai9EZCvyS1ifQtjXR9gXvNouxi4xF/T5ASBDOJjXIQ1tGjNp27f
	 zaLEEK2T/X9tvVigRBPwxf43vVqmrwHICQN+k7PMan+PuA/4/wCv+E7rZQjmDpMnYA
	 kvjlwA6h90nrEIuZW/nIYZoIFY09sT7SfbJKXqqaA0Vh+sBwY5vnwyAluPB3VLIQ83
	 1+eMz/zGaa77SNGlqVVv0xnlsUDbag2kLBgrphuLaNfW0r3CUAjqydvCTxH3DJfDHn
	 2PAeDwDzVrO2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 03788CE091F; Wed,  4 Nov 2026 09:14:13 -0800 (PST)
Date: Wed, 4 Nov 2026 09:14:12 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 01:30:39AM -0500, Qiliang Yuan wrote:
> list_splice_init_rcu() makes a list look empty to new readers, waits for
> the current ones with the given sync function, and only then links the
> entries into the new list. The sync function takes no argument, so it
> can wait for RCU readers but not for the readers of an srcu_struct.
> 
> Passing synchronize_rcu() for a list read under SRCU still builds, but
> leaves SRCU readers on the entries while the last one's next pointer is
> moved onto the new list head. nvme_remove_namespaces() does this today.
> 
> Add list_splice_init_srcu(), which waits for the readers of the given
> srcu_struct instead.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

I am not inalterably opposed to adding a list_splice_init_srcu(),
especially if quite a few more users show up, but here is what I was
expecting people to do:

	static void synchronize_my_srcu(void)
	{
		synchronize_srcu(&my_srcu);
	}

	...

	list_splice_init_rcu(l, h, synchronize_my_srcu);

We need at least six uses of the above idiom to break even on the line
of code required for introducing a list_splice_init_srcu().

							Thanx, Paul

> ---
>  include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 1a8a465a5650d..d4dcaeb83e2b6 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -18,6 +18,7 @@
>  
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rculist.h>
>  #include <linux/workqueue.h>
>  #include <linux/rcu_segcblist.h>
>  
> @@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
>  void synchronize_srcu(struct srcu_struct *ssp);
>  void synchronize_srcu_atomic(struct srcu_struct *ssp);
>  
> +/**
> + * list_splice_init_srcu - splice an SRCU-protected list into an existing list
> + * @list:	the SRCU-protected list to splice
> + * @head:	the place in the existing list to splice the first list into
> + * @ssp:	the srcu_struct that readers of @list use
> + *
> + * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
> + * instead of RCU ones, so that none of them can follow a next pointer
> + * onto @head.
> + *
> + * Note that this function blocks, and that the caller must prevent any
> + * other updates to @list.
> + */
> +static inline void list_splice_init_srcu(struct list_head *list,
> +					 struct list_head *head,
> +					 struct srcu_struct *ssp)
> +{
> +	struct list_head *first = list->next;
> +	struct list_head *last = list->prev;
> +	struct list_head *next = head->next;
> +
> +	if (list_empty(list))
> +		return;
> +
> +	INIT_LIST_HEAD_RCU(list);
> +	synchronize_srcu(ssp);
> +	ASSERT_EXCLUSIVE_ACCESS(*first);
> +	ASSERT_EXCLUSIVE_ACCESS(*last);
> +
> +	last->next = next;
> +	rcu_assign_pointer(list_next_rcu(head), first);
> +	first->prev = head;
> +	next->prev = last;
> +}
> +
>  #define SRCU_GET_STATE_COMPLETED 0x1
>  
>  /**
> 
> -- 
> 2.43.0
> 

