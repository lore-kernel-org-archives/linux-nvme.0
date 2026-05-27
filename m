Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6BCCD6E43
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 19:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aD0wXRMgWm8nu7e2x0fHjH5rbgqWUDPqOK6D0AtAToI=; b=YQdodY9Pmv9YCQqi4tDU3ltggF
	kAnF3t0dATDT4gsed3j4stV3V1tva86NWoR/tf0oC93B2/5OtpM88WtiKAPmPu0uPJkgdi2ybMPdR
	gfiIlaRumQ4ABC62E+GwYjILq9sj8Kk9mcbmHqHMNACDbGPHTQ6+97H9spGd+rooWVBpHTrY9+HSN
	Nvd9nGAEu7fZTKbGKAAil/IyCu1dWL/EvG5h6AsB0cDwuEe6EIWWn39n+pWYMce/eMZ2NOsYUlN3x
	z1AoWf7dvlCApqFl2iGl7CQrtSv672QDn/yMCb8Y0kNmEqxXxqymfhA25uFbgloi0jqnIIW2FAw9m
	0+Jef7hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKKn-00000004hIC-0Mvf;
	Wed, 27 May 2026 19:54:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKKm-00000004hI4-12Pa
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 19:54:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 36D406057B;
	Wed, 27 May 2026 19:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677191F000E9;
	Wed, 27 May 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911670;
	bh=aD0wXRMgWm8nu7e2x0fHjH5rbgqWUDPqOK6D0AtAToI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MB1ixG47K6gO42nZZYVin/rVIoHK4LmHUYsH9mfycr4iQrH/ZqlKnBELiK3aEkeZq
	 T4D3Qe9SO51GxEbWPzG/LP/lVQVb1iyhHsk8Ugbn1A8pAvqJ3pgmd/wOV4IJhz6nfc
	 EFQ/gZPS22GP4D9lALIKHnXl1bE7RVn0KJmYWuwU76W1wf4858HXz7K7sI7OXZsbv/
	 DRxhgK0aoTgN8MsjzN6MbdBoAoF3icy07SoDHxUpdalfAQsbp/2Lekvwf7PLSl8MCV
	 OZKAC0JMrpa3LPMDjwAzk4Zo4McggbEXIstTOewHkJeo0KaF8BQrM4LagYxrybwnYN
	 cqkKKd+iNMoLg==
Date: Wed, 27 May 2026 13:54:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hare@suse.com,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	chaitanyak@nvidia.com, venkat88@linux.ibm.com, gjoyce@linux.ibm.com,
	wenxiong@linux.ibm.com
Subject: Re: [PATCHv4 0/8] nvme: export additional diagnostic counters via
 sysfs
Message-ID: <ahdL9OwiSTR5yxu7@kbusch-mbp>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
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

On Sun, May 17, 2026 at 12:06:47AM +0530, Nilay Shroff wrote:
> Hi,
> 
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
> 
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.

Thanks, Nilay. This looks good to me. I'll queue it up if I don't hear
any objections.

