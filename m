Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9013BEB3621
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPUJZhW0yrGl3ZI7H6Eu4afjawhu8PsPLJY8ch8v4KI=; b=AZ4g/qF8qaAQtNHdZ7WDaUc4dO
	Nku13WAX65NVTHjVQRSGE5HucGqyeLNjA8TtlvGePau12ZbJJdDOB92kEgOLhbL2va9oRwxvA8ntr
	ikhiE4zmzQJaaBx2tNq8cpl6nU5RQ76FSXU04TXY73+9GtV2ZG5gBH2Wtx+KfUt32z6HipAcIBIPB
	bMI+uNsk37Jn5kmZJ71nCKOeFX1zWAV8u0K3ds3tEYuPDQ0yQM7gzkkUWHeq+/H5PzMAhDacJtq2O
	XDhuY/BzXGe8arhasyEJtTk4QN3+gEc78xjYm+XX9oIXbAhkk8k33WFBN53Gm6vFANWucB5WXDY9k
	T8K8oJSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx6oS-0000000DZDW-3u9k;
	Mon, 02 Mar 2026 17:12:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx6oQ-0000000DZBz-3Ll0
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 17:12:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B90F438BF;
	Mon,  2 Mar 2026 17:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39725C19423;
	Mon,  2 Mar 2026 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772471526;
	bh=lPUJZhW0yrGl3ZI7H6Eu4afjawhu8PsPLJY8ch8v4KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPzyL4Mhv+GSZ5WSflCo5kC+u83yOZpQt28v3vNo3gjVE6MC8tv+vi0pot0HC4GOh
	 +azdFiMw7UYL4FXx7Nq5tHzriQ2DmKA7+zRPbmXY/yFOVTxqVQblhn4wk9qgQKaNHL
	 SWE0Q6O5QJHcr2YBcIj/LNFtV0U5FI0HKdPJ5YK/aBpizAq2eGxEmruZcr7hb+Cw3K
	 BflO7VM6boSSArbj9Yvx4GFHNi1qEeOw7PsB/UTDfi9e4QOkZJtV0la+Rz3isL1Z9z
	 ZRWSLGA0b/TrpDVULtZQzhcKGlnkUDE9xNOJ0IsjCPwjo+ZmkFLstnWC1ioxd5xNl9
	 w/VM5o2nE6ekQ==
Date: Mon, 2 Mar 2026 10:12:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, emilne@redhat.com,
	bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <aaXE4s3AT45UIAN8@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
 <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
 <e43b914c-2ca5-455e-b0fe-3ce2eb0c64bd@redhat.com>
 <aaCNtpPzP9TIDNjE@kbusch-mbp>
 <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869034b1-c7e8-4e35-b153-43fd787a8edd@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_091206_856710_9A98C3EE 
X-CRM114-Status: GOOD (  10.03  )
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

On Mon, Mar 02, 2026 at 08:16:19AM +0100, Hannes Reinecke wrote:
> I really would like to go with the nsid based solution from Keith.
> That would avoid quite some cumbersome code here.

I've seen various documentation that assumes the current naming
indicates the nsid, so the scheme follows at least some people's
expectations. I don't know if we can make everyone happy here, though.
:(

I've fixed up most of the multipath races that get us closer to allowing
nsid suffix, but there's one left: nvme_remove_head is called outside
the subsys lock after detaching the head from the subsystem list. That
could cause a subsequent add event to call nvme_alloc_ns() before the
mpath side has completed del_gendisk() for the old nsid.

