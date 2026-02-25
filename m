Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8563AFD45F1
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fpk7tbw1NnxpCGy61JuvRTfaQXL6WxnsCaO2aHRbBRM=; b=RtKvQRIGp2erKjyhVLgF+oDptP
	h+8NXGy6zN7hWykGbDJ+LxGY5i3i3hZS42vKQ27c4/gw5XdcAl5t+wBXXODeCbzLpimCgCMW0JRah
	BpJZI25Fv5ar1KdhNfia/eUkS3OUvtSXGZfeF/2sFSIs2XJSKJdbaaM3Q32KVfgTt2bomK5JEwvmy
	5Zij/5MEvUgxcJJLbjwibhEvLt+jIYYSRwQq2rlp+qrTGV36FmUAKJMm/X+xB5MMByLY1qiLw4yOF
	mGtmp0+HDJ4dN+L6P24fKKUwvSdAyifLsmeyQVTp/K1W5yO8g9QCnw6zwbgeRK3Jacx/i0D5VvhU7
	OHv2RVng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMdX-00000004vpt-2wy0;
	Wed, 25 Feb 2026 21:41:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMdV-00000004vpW-0MYl
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 21:41:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E1C5C42DA4;
	Wed, 25 Feb 2026 21:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4258DC116D0;
	Wed, 25 Feb 2026 21:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772055695;
	bh=Fpk7tbw1NnxpCGy61JuvRTfaQXL6WxnsCaO2aHRbBRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DT2z7s3aCz+tTN7U22L3olUcb3ngSga7ZTIHIxxJNmAUchckrNj4LxTJaEwwIFFYO
	 7VwbFDPszcqaBPhTr/d9O3pqgmCJu7HLKXbj+Z1GXtwZtoZWDsR/VW0EDOGKz77Jup
	 GH+X38heNcV6E5kJkBPzct8OTaa+VBO5iGjYLT0qQemNGBR4XqpdTZW9lvap5QfRmq
	 Gp/QvaVXWAf7gFnRVcVz7iyIxf+RNly9yrN1EX59GU3GDawYiZa8+kOA/9XvvMiG0r
	 jdxjADS/Qz4eJz4VuD3c8uyC8KVlRlpO5RGYMIehwbYmqG+sLTEtVaEyG8mnWLE4PD
	 3KN+P9Lo5oNgw==
Date: Wed, 25 Feb 2026 14:41:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, hare@suse.de, chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225161203.76168-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_134137_146251_B671846A 
X-CRM114-Status: GOOD (  13.94  )
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

On Wed, Feb 25, 2026 at 05:12:00PM +0100, Maurizio Lombardi wrote:
> The NVMe fully asynchronous namespace scanning introduced in
> commit 4e893ca81170 ("nvme-core: scan namespaces asynchronously")
> significantly improved discovery times. However, it also introduced
> non-deterministic ordering for namespace registration.
>
> While kernel device names (/dev/nvmeXnY) are not guaranteed to be stable
> across reboots, this unpredictable ordering has caused considerable user
> confusion and has been perceived as a regression, leading to multiple bug
> reports.

The nvme-pci driver also probes the controllers asynchronously, which
can also create non-determinisitic names. Is that part not a problem?

Just on the suffix part of the namespace's block handle, I have a
potential alternate suggestion here. The instance names pulled from the
ida guarantee we'll always have unique names for the lifetime of the
backing kobject. I introduced that a while ago, but I'm testing this out
now and it seems kobject_del is sufficient to reuse that name. The
driver already did that to all the objects when deleting the namespace,
so there doesn't appear to be a reason to wait for the final
kobject_put.

What I'm saying is I may have been mistaken about the naming collision
issues and we can just use the head's ns_id to get a consistent and
meaningful name based off the backing namespaces. There's some unlikely
races with multipath at the moment if we did use ns_id, but I think
they're all fixable.

