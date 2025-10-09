Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFD1CCD184
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Isprq6q6LkghppD5uA1BlqTuxnab7pQeDZHphtpTHbk=; b=q775Iqgi37voDWv97SF8wUGYaU
	tkUbuzL7hZNUgwcnGY5w/Ta2bV4DYayt0TtsW01R5qBSzlt6p7EQRo6YCsmdfpsmVtQzF8qC3EA24
	u37fFnBaZbucPaLjtZcsiVRpIEI/hnSZoeuDYNp5Su0Mv7Y7CNZowqM/86gGM4iQMP704/n00kBPX
	ZirSr+X9IAbXhe5E/iV5cZ9iTAGPHB6D3l6OycVkbi7VfZRqs/H6FKuZ3ZIPHZcEU+H0hPSyniq5D
	v+jS6e3RVu0ZflxFCsuKxgyWSsz5v655VVSI50F/5zYzY3+PHAX1G6rb2QHT0wDrRFP/Zxn/CvoxL
	9RAm1XEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sHx-00000006RhX-10QX;
	Thu, 09 Oct 2025 15:10:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6sHu-00000006Rga-2iwi
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 15:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2740245306;
	Thu,  9 Oct 2025 15:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E2DC4CEE7;
	Thu,  9 Oct 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022637;
	bh=Isprq6q6LkghppD5uA1BlqTuxnab7pQeDZHphtpTHbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWszcOpTmJLgvU4gcfh5/I8AqGMap4991PLXSn+dqcFCAm+k9nuYgqDDcOYYw2ty5
	 9PrzmyyRpCe9yHOhzzQCzsJguCYdl6xCTU1vdELDjJj8mpfJJeKc10EZFcR307Iexg
	 qj4DlKvcy4F3N+5/FK2kj6QkXLEdO8IQObVPZUzOiSE05ovQhQKv5WkwYK7zyWVhjA
	 xD/p9POVcmN+1PlbGC8hVh/0nHcULTJg8qH4etKJqpLgNge3EZyH1AK52W0lzHvTH+
	 Atp9s1yqajKgDE66cp1Fl3UGXyfUm0gXIWSCtESZ2TwebuTLzUUUEpDbXCtVE0VJpZ
	 ZqFkxgqWJNKiQ==
Date: Thu, 9 Oct 2025 09:10:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Amit Chaudhary <achaudhary@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, mkhalfella@purestorage.com,
	randyj@purestorage.com, jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme-multipath: Skip nr_active increments in
 RETRY disposition
Message-ID: <aOfQatF6bqyE1OCF@kbusch-mbp>
References: <20250926190823.5031-1-achaudhary@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926190823.5031-1-achaudhary@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_081038_718932_BCC77E40 
X-CRM114-Status: UNSURE (   8.17  )
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

On Fri, Sep 26, 2025 at 12:08:22PM -0700, Amit Chaudhary wrote:
> For queue-depth I/O policy, this patch fixes unbalanced I/Os across
> nvme multipaths.

Thanks, applied to nvme-6.18

