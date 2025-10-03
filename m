Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68741CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f4Mt9oOnls6w5MPF8ho/fXbxaWOpw5mAu06nZFZDF08=; b=QpUxZVjJ68weocdA5RZP3/U7tg
	DDwMZJRCWAQ7YPl4QpDW50IVl9IQFoSYzmTTqn4EJRonomdzwunQoClEf8gC68tY8hy61tUrF8eTz
	m6uT0UrREK5LLVjRcj4sqKRPq1aweQIHBIc1KuyfMgXwx/oegegoym4119FHfpLdZNUfhMk4YBUfV
	R4AfddhF7P3bLOHPOu/z3Hy6BGth/cYiDgpv5V71us2FaHbRUkUns0VCblrxFRYCfYbZMqYPQmt6+
	3PaaNi3tphEy/vThwYSa/SwLp9IHR++MhMcn9Rxiy+VfXoXoinc31LoTlaqVOKvzp7E+lw9LrcvDb
	qqN2X0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cRt-0000000BzBy-09ki;
	Fri, 03 Oct 2025 09:51:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cRr-0000000BzBL-0DH0
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 09:51:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A24243FF3;
	Fri,  3 Oct 2025 09:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0531CC4CEF9;
	Fri,  3 Oct 2025 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759485094;
	bh=WfLYqcOX9sMYZKj4wlYxcoZbm5OgeeZwYCvrlL3mENw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dcXqUEWfJ0IiMLVaZtd6pUxE4O/0uoOsxh3H211dEstLJpAFvkOtBNIpUxteL2aI1
	 8AaH40SjPRGeNBKJEoRDFxa8iKd/gVFAiPe9Fby25bUYuqEJ8eeSgs4ekHkdeMGbws
	 KXt1pkuppx59pH0cKSFfbeOV3YqAPZ0jS0avN2iNwP6qmCnpGAjmaR6aiWs/3KjoOR
	 WxtkgzG7XpVSyn2YdqNWPyZKzJPQH9ZyBtZ6OgAGI1SgoXlxEQ6ucGlC+G8Arstk2x
	 YHifqR7C4foIwGfJw8FjId0SRo+NWovjyeVk9BwLUMz93dNUwBcFuqkRfkw48gpU/7
	 wOaS8NN/1l0tQ==
Date: Fri, 3 Oct 2025 10:51:28 +0100
From: Simon Horman <horms@kernel.org>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 2/8] net/handshake: Define handshake_sk_destruct_req
Message-ID: <20251003095128.GG2878334@horms.kernel.org>
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-3-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_025135_106953_610FA4A0 
X-CRM114-Status: GOOD (  14.44  )
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

On Fri, Oct 03, 2025 at 02:31:33PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Define a `handshake_sk_destruct_req()` function to allow the destruction
> of the handshake req.
> 
> This is required to avoid hash conflicts when handshake_req_hash_add()
> is called as part of submitting the KeyUpdate request.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v3:
>  - New patch

Hi Alistair,

This is a not a proper review: I'll leave that to others.
But I notice that both Clang 21.1.1 and GCC 15.2.0, when run with
-Wunused-function, flag handshake_sk_descruct_req() as unused.
Which is the case until the following patch.

As both this and the following patch are small, and touch the same file,
I'm wondering if a simple approach is to squash the two patches into one.

Or perhaps no one cares. If so, sorry for the noise.

...

