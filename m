Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64839606A325
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=W8+uSZCK;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5r/jS5Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1SAuxh+V8BJJlzZvvGKmODX7I1luUnKPYcmkjJ4SNs=; b=W8+uSZCK2w3v2fGYcm/auX+8q5
	P2FvUSrToFMu7ESjd6VGElJdOapEO5g6DTJwI8l5rhPq8sG4Ru4Gos2FHQjh96GPskAhkOQTOx54u
	J7T6SbAENHLBNzk5NpoyoqOeqUWa/GhsewUVety4KMY9/96weUb0XhGaZFY7/IamfFglL6uXaQtkK
	FLP5wP2GR/v5JawmW0DJU8YmkCa/bTfYnZ+BvDodPrqEeg4ZEKGHQKpDfL6fenAqri7M64m9HB7JO
	aGoyZnQAgqqhiW6jZW5Jk6gaH5sMFyO5f8elSz1ITker/wGqwDV4hJUyJmaR4w3iRvJ7Yqv55gfn4
	fBeKptqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJeJN-0000000Cxcz-1kB3;
	Wed, 21 Oct 2026 21:57:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJeJM-0000000Cxct-2im7
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 21:57:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1F8A43BF0;
	Wed, 21 Oct 2026 21:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3E81F000C1;
	Wed, 21 Oct 2026 21:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792619847;
	bh=g1SAuxh+V8BJJlzZvvGKmODX7I1luUnKPYcmkjJ4SNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A5r/jS5Zs+T6o2Sx31lLhsBu3B7Sb4BmA4h/CKNIs+gs9nnZI453ubX5qtzsYK0MU
	 sDCgs+whVajIvPXt0TqKNnrI8kSDrA3/S1d+/aFiTTPnR1vnip3ssEjO6UbO09xc1V
	 UtD44LGC0xn9QQJYHd6ZXR1HyUhLzqrpOCyw2zC8YCGq04itofVUZn7iktcIt5dCo+
	 gYsVS/kEGXzuSHSSU9BGKcT2jut/PLtW0oAFDMrV4JIGbXxq9/+6ccNDbMMUQ4/2Q5
	 NOFk6sBxOvQMGqm8hWyMhW6dX8lQRsqqxw3lQBxG6zp/k30iJ4ODeMtnK91u+GDnVp
	 ZaMjn4+rPRJxA==
Date: Wed, 21 Oct 2026 11:57:26 -1000
Message-ID: <66f87058e7e811af340d920e654117eb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: peng yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
In-Reply-To: <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
References: <20261002152821.410591-1-yupeng0921@gmail.com>
 <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello, Peng.

On Tue, Oct 20, 2026 at 06:01:12PM -0700, peng yu wrote:
> Hi Tejun, does this patch look good from the cgroup perspective?

From the cgroup core side, this looks okay to me. However, the current
implementation will block the shared submitter when throttled, and it
would probably need more work to behave well.

Thanks.

--
tejun

