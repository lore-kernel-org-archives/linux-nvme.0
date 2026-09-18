Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7C5C982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWbnyU0SIgiw4rSTlOVLNiUE31FvcrcAMlwh1SgQDVU=; b=zwFG7hATi4RY0R0mKmRFPXgZmv
	hkgKisrGOoOHi/BMex4QbZxNs/u/4uS9KLupA85VVFN8h1W5cnNqD+o7X4Eep+0TNoJ5se1R12QnE
	y8hP3NQ00H2sQ3H2kgoFFwz7GHXtuButYLytgId++HBxrWpm+3H3Q4zkQ8LJ3lEbSvB5YQmxX4dIc
	KKPdTpG3eg+SlCbZesyLJCLOSuXJwlRYl1q+kM83Ivbw6ejlwVE5BmttBLPJBsbltAOAhF5wqw61Q
	D9vrA9g4GyaIg2pVeY5jw3qX1wkRt+5ZHSexHne3X3W6Q4sPBsJZwAqhKcNOQ7IJHW5OzXlnIRSTF
	NPcMUYDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aKi-0000000Eqlt-2vDR;
	Fri, 18 Sep 2026 15:17:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aKh-0000000EqlJ-0TF5
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:16:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 22D7B6053D;
	Fri, 18 Sep 2026 15:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6269B1F000FF;
	Fri, 18 Sep 2026 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744617;
	bh=vWbnyU0SIgiw4rSTlOVLNiUE31FvcrcAMlwh1SgQDVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nPC+T5cUcjp6iaN/J40YL68Dl+5bJoR7Rw5WTThvM3jFy3nWIVshYKMj9XXJUqoMR
	 MXf0sRUt0t6r/OasTbxsgTRjKq64QY0fS1ztlPaqSxh2ixrSQqUrGvnENhOAmVykSR
	 x8OPoMNZRm8AXX90K/4c+YDX25l3dHNUgeWTUS+utU+HdH7HkwiGU5jF67oOyjn4q1
	 JNP84gLuk7y6QcUhGZ1O+YldtrsjMtj0yG6zUOzDdFHweN55vuyxkzEVK4wconYMUk
	 EueTij/SfG+UF0T/ieaLWhBccNa9QSJ3QrGg/iwjWZv8Dxe4F2ITZvxbCzEVBv+O/W
	 f4DYaK5f8Lt/A==
Date: Fri, 18 Sep 2026 09:16:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: fix underflow in ANA log bounds checks
Message-ID: <aq1V5znTxOjqRGMX@kbusch-mbp>
References: <20260915021956.3142320-1-4ncienth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915021956.3142320-1-4ncienth@gmail.com>
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

On Tue, Sep 15, 2026 at 11:19:56AM +0900, Daehyeon Ko wrote:
> The number of ANA groups advertised through Identify Controller sizes the
> ANA log buffer. The ANA log header and group descriptors independently
> supply the number of groups and namespace IDs to parse.
> 
> Both bounds checks subtract an untrusted object size from ana_log_size
> before comparing the current offset. If the object is larger than the
> buffer, the size_t subtraction underflows and lets the parser read beyond
> ana_log_buf.
> 
> Check the current offset before the first subtraction and compare each
> object size with the remaining buffer instead. This rejects inconsistent
> ANA data before dereferencing a truncated group descriptor or walking an
> oversized namespace ID array.

Thanks, applied to nvme-7.3.

