Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E53CA5FB8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jan 2026 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbL61jtWSPp/FENzs6ChhQstG7JYWtKZKBof7pLDKV4=; b=r6MXECPf/rbeJl64f6/nvhHEvn
	yrDpBAOFqLvyCUjz1sgFp3zfqUHzLNcyYPq4XjoH0yasRDH4zm5EG3Nr9ydBsnVwSC89s3bzsx2Nw
	c6/apsWFSugx68kRlqvSyg29atgF08KO0q70mwd8ptMkEzUSkUuUl0OjsZAElhoTQDXTANc8wCNnB
	u0iYXKl9EOuCxmDPWXdYB1S/OBecT/02+zfczmkBgvIPtOlmbnZkJfAOMcxAAErU5iGMfSj5+1NYU
	mEmw3005eCGVkQegHCVCT5wfnWQxUOdJn51YoOMYQrb9MgxgeBiXxQMhmNicRT9LanaupNhCCEq9Z
	8GV+3iHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFCQ-00000004Dkp-22T7;
	Tue, 20 Jan 2026 17:07:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viFCJ-00000004Dkj-0fwg
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jan 2026 17:07:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3984860008;
	Tue, 20 Jan 2026 17:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5FC16AAE;
	Tue, 20 Jan 2026 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768928837;
	bh=ZPfFdIK7v9EtBydOu/jnCLimg+X7OzRP2hKOXMJQGeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xm220QQEAIGLnhBF0gVMlj9lJ+aHxgzq2jQTCVMcsjfBf3+QQfLkeprGCCoV1mOY2
	 cZ1ghn8M0K1uuhWqrW0ezxL97v7XSY6oUOyK+23vyIvhkMrDE6Rz5hHEScJQMoRm1F
	 N50fuiYEDQnHf/JwfkUECp79W7fzPU+C0CRooa2V8+3keGvyzAvtJEo17jrtRpxDHS
	 230WWqUia86hLvETM89/0oPzd0g0LVSMwO2qh2K6D44/IeH9fvJFFHO47tzodC7hhB
	 E+dRkqyuC0hZ0oGR6k7mSAddIynRD4V72cxMGWmk0gkt/kl6C0hTTeDISQ6FLYJ8Mt
	 IuHM8UOSoQKbA==
Date: Tue, 20 Jan 2026 10:07:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
Message-ID: <aW-2Q9Zv_UNX127Z@kbusch-mbp>
References: <20260116074641.665422-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
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

On Fri, Jan 16, 2026 at 03:46:36PM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.

Looks good to me. It feels a little unfortunate to have to add this
parameter to the callback just for this one use case, but maybe there'll
be new uses for it in the future.

Reviewed-by: Keith Busch <kbusch@kernel.org>

