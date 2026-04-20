Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8CF588F7
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUByrM0hgGw411xUhpo4IlsAMKslD38sohPhIr8is2E=; b=pAktTDF3ezmfp3DkZoRncuYaZW
	vhK2SXW+jHtIAvYsfQQnkNnl/rqSUoB8wB36yuxxJPrNM15ASRPO9nG12lY5IZhck7GGDUIWl5sJu
	Xi11WhjULTA9pgQ41rhvTfKZFcKHPKssy55QWJ+Bw5YUdhn7MCM5tIZdIBhEBN/vww8Nu6D1kbX0V
	C6kWShPGoIVW0d1LSSGL4+Muc61VUVd4SzLN9wGdxXKjFN0gBPI/52NMQEXi8lR5qSd7eQf+qz2MJ
	TpUhmZtCosKSShN/9bN8y448sKN4Vrod4HmoONQU3lMed5UNvHZdwzVBQDIjKr4LHdMA9DUJ7K9M0
	uoESIjfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErVW-00000007Qsy-2Z1C;
	Mon, 20 Apr 2026 16:29:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wErVU-00000007Qso-4AQy
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 16:29:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 542776014B;
	Mon, 20 Apr 2026 16:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15CFC2BCC4;
	Mon, 20 Apr 2026 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702596;
	bh=omtC7E5Bfmrzf+glftZG6f/j5LA+rfKmheu5cQfnGGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJsNjliRCCZzTd9oHn7YSePyaAAsEh6o5tXlK8mAGxdcyM5LWXYtARsDtpKNvdVgo
	 teqoRnQXhzYU9ooctrwURkGuICp9hFQHNNJjzHsNfE7mMFkOXRgj/V36CgAPRPv4Tz
	 qiW0pvs/9AfdC+tbg+LxOZvGXl459YWyYn1l3JCAz6pzzaM95hF0Ta3Ph8t/p0tFUj
	 NWjrh1dbyikdjmoZc86/SS1FnJWMm5sLvRUOn+qdD1eM6st0JON6VXTWc90/rDNAPb
	 qHEbAZZ1LZTglAOLIyuts8W5w8XPsKKyDkjnrWsjGKHG+Y9AUmmkWgOejKqg0iKP7p
	 BXtapxCEmloVA==
Date: Mon, 20 Apr 2026 10:29:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V4] nvme-tcp: teardown circular lockng fixes
Message-ID: <aeZUgRZQ66sOP8Zl@kbusch-mbp>
References: <20260413171628.6204-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413171628.6204-1-kch@nvidia.com>
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

On Mon, Apr 13, 2026 at 10:16:28AM -0700, Chaitanya Kulkarni wrote:
> When a controller reset is triggered via sysfs (by writing to
> /sys/class/nvme/<nvmedev>/reset_controller), the reset work tears down
> and re-establishes all queues. The socket release using fput() defers
> the actual cleanup to task_work delayed_fput workqueue. This deferred
> cleanup can race with the subsequent queue re-allocation during reset,
> potentially leading to use-after-free or resource conflicts.
> 
> Replace fput() with __fput_sync() to ensure synchronous socket release,
> guaranteeing that all socket resources are fully cleaned up before the
> function returns. This prevents races during controller reset where
> new queue setup may begin before the old socket is fully released.

Thanks, applied to nvme-7.1.

