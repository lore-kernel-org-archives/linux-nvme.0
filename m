Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE28C8303A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IgllKH/91RyYKyW0JnQPM/fN/DG9F+pKG26P2C/IMx4=; b=eWVJehLSZh1F5v0wm0wiJr9pc+
	j4f1spNzBpR9dYzUXGBy23wo5UipF0xBHQ62oJrmVwdNlWLsyUuSyVIeUwSdz92Nokdh9RJYOyVv2
	Sd5VV29PR+CCswN3VCRSRjnhb3f3NQQ4MI79oZjvmEUAGdsWj38QIW2HYtwv9JA6hUIe2V7T3Rjv/
	E0mGQ7rgi2xaBz3lCR6sBRezjg0WBBslRmgfMlU+VQc38oHHTCLuEgLpeWXqX1iMtBDLJVxZyaZ1E
	VTYCKChFaEcV7pJ5LoaBP4utqB9mTWClGv/MY9qjeHaHYJoTON5cX+RyXQEbq4932nz2jqmaXGjJ2
	RUqjQdMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWbK4-00000005ZA3-2UGF;
	Tue, 01 Jul 2025 13:46:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWZtm-000000058Pk-2noQ
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 12:15:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 28AC85C4A48;
	Tue,  1 Jul 2025 12:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53737C4CEEB;
	Tue,  1 Jul 2025 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751372141;
	bh=CobWMxU5S9N/yDcPTuVZJbC41V7T9McLGxapXd2WcLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YR3GUmfTaaF7a2uUciAPifvQA3OasQFv86C859GK9L02RUJvAZr67efT2b27zUpL9
	 Gowo5m7Fpa0GqseX/kJpMI/2sAaKAMUFpn/Pjn9FOLJszZQ4lnt2BtCTtvsQ60xCCn
	 8Qyz2XIb7gN4A5uKEQieXqStWUKqZl6j4+XUYuUeHpX7kM5Bcl8Rz+OO19uhQgmf92
	 qyj4hmhP5ZAgR1K19JSF0O2BQFNUIZU3wBSxszVUGoYeC/XWO1+SALDAt2+fSzL5DL
	 oUvYb+Hrm4eNvDwLUODqIm3o5q10x3xCA7blJEql+13jkc2SMO5CL9bXKhZeAzhAkV
	 Da8wQVDgIRhcA==
Date: Tue, 1 Jul 2025 08:15:39 -0400
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aGPRa43FJW_B1asI@kbusch-mbp>
References: <20250624211444.2835077-1-kbusch@meta.com>
 <20250625060915.GB9391@lst.de>
 <aFxzXOZUFtt6hyPA@kbusch-mbp>
 <20250626051413.GC23248@lst.de>
 <aF1nUYSXvLE33osR@kbusch-mbp>
 <20250627072524.GA1329@lst.de>
 <aF66IGSMATG9-sLy@kbusch-mbp>
 <20250630060016.GA28775@lst.de>
 <aGKZf5gX7_JPe4-g@kbusch-mbp>
 <20250701061609.GA17912@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701061609.GA17912@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_051542_759910_0FC37700 
X-CRM114-Status: GOOD (  14.70  )
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

On Tue, Jul 01, 2025 at 08:16:09AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 30, 2025 at 08:04:47AM -0600, Keith Busch wrote:
> > 
> >   a. Force the application to split each iovec into a separate command
> > 
> >   b. Relax the kernel's limits to match the hardware's capabilities
> > 
> > This patch is trying to do "b".
> 
> a, or a variant of that (not using passthrough) would in general be
> my preference.  Why is that not suitable here?

Why use passthrough? Because until very recently (as in the current rc),
passthrough had been the only way for user space to access write streams
and metadata.

We've had uring_cmd passthrough for several years now, so there's some
decently mature applications making use of it. But can they split
commands such that they dispatch one per iovec instead of as a single
command? I've asked that, still waiting to hear back. I sent this patch,
though, because they bought SGL capable hardware specifically so they
could do this. 

