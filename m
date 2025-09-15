Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39615CAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJWBy0KtfYZdfsePqJV3Q8ldjT2OGxtq1nBqe6S0LDM=; b=Dgpu9yv3OUsljRBvhgLlCLfY16
	q5xxJFnYV9VJHg+a0LHWE70HMxnHU1kZbOVFNFAbq7d/LwJrukiuhtvEBZrcn0Di36QRrR9OPU7GB
	FIS3MC16z7IRBMO87O6hCY/pGiF0xX1kNbPgp35s2nT36WIyXOokT5AKZERbyj5hFt3C3/fgGcKsq
	Jv3wzcYwtPF/8IbYbc/NNEKSSmphXLXlZIyKeo0PelylSiKuohB9lZG16CIV4oJE3+/s43LHwkfRi
	R1lpt2tOdD4biPrm5e36bu1pjwCKOEtqVSgJ8CBnWeK2/k5LtrsV4MkteXp1eNByGQOMoAi1+h4ZB
	Gzfee+Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC1K-000000056Zg-1wx0;
	Mon, 15 Sep 2025 16:25:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyC1I-000000056ZE-3VD1
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 16:25:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 38C9860202;
	Mon, 15 Sep 2025 16:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B518C4CEF1;
	Mon, 15 Sep 2025 16:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757953535;
	bh=GJWBy0KtfYZdfsePqJV3Q8ldjT2OGxtq1nBqe6S0LDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bTYbIxSqV0E09tVvZmeATqspyA3tKQs6nfqgIzcb1YQDAYT3XvYCTD4CI8JdqKkYZ
	 Rhl29j4q2ZfqSGJ4LjulCrep9FEaO1IkU7fbkYacY/zGY30o6A86/bcsqE4tKnSjjh
	 NQ/ND8IzaYQOyn2w6mMrUXUrBqYrIN9sXc+sp+KVwKKGc0D5Lvb+u2NePM6PtEykBE
	 sXQdHd5lOUQG/Mj11bNSr6bzNexrte9xxAhmFC4Xz3V/xO9s4gq5JrAsYQJd8wi6Nl
	 2OLuuAB2S8hkO9cmOkcPwAS50uyYqAoXg9SZieWVPwnSiRjsPCLWhyp0ijVUtuQOmj
	 oRZmYUXlBFq3Q==
Date: Mon, 15 Sep 2025 10:25:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	hare@kernel.org, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-tcp: send only permitted commands for secure concat
Message-ID: <aMg9_TG8IG9jnbwv@kbusch-mbp>
References: <20250909103509.10343-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909103509.10343-1-marting@netapp.com>
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

On Tue, Sep 09, 2025 at 04:05:09PM +0530, Martin George wrote:
> In addition to sending permitted commands such as connect/auth
> over the initial unencrypted admin connection as part of secure
> channel concatenation, the host also sends commands such as
> Property Get and Identify on the same. This is a spec violation
> leading to secure concat failures. Fix this by ensuring these
> additional commands are avoided on this connection.

Thanks, applied to nvme-6.18.

