Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFB6C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 15:07:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC22E611CE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 15:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC22E611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rA+Lm12cHazU65Aw3c20l8UZVvks4wu2IHshXus1RCo=; b=dPbT14JnAKhb0r
	I5A4oipNmemjXdzUga4vcZdpkQV7CQQfm6gHg9qNwK+eSelaiV9STwA204SwnFVnXStb9NTWTLeYQ
	3zbIa+fr2sLM6JHlk+NiCR+y6VhqbU7LeCJRLtIB+k7hrqhSAyctrxVf7d1edsdLm0Gymf37p7NEN
	//bFSFhqB1MECzOojrJ2nKKHbLuY9lj1MfMnAMNQz8WNmjHIY+Qpi39Y2hKBk/uq2LurX9O5NDHlH
	CTAC8AXOID/4JnY+SOA7ZhZ1J7/DH5mj5LeBJwvh0Tq7uzOk8GGT6+H7StqQk2Lc8/Jr+8vaNht0R
	1gxhFaeHojda81bAvWEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvhz8-007bF8-HI; Tue, 22 Jun 2021 15:06:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvhz5-007bEk-Iv
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 15:06:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B7C611BF;
 Tue, 22 Jun 2021 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624374399;
 bh=/fvRv20eZvxKeA1YnxFpkRvSPtPcCuAkDqaA9272RKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OMHVoCaKYGd7wNzZTT1Ea8ekH17eWlUISGzh1hRk8MUtkFY5xxY+P48K4XXAiEX/t
 p8EORdX/NjwnjvZ+2wfACxzXiGBlpaqgRgUpbOYW9H8bdHa1SYrtxNNbcL6o/Q3+AE
 GzZwWkc+omtr/rnxBPH/dhfcgD+XRJPPjFhe3m5ymrk5uI84oFqtCb1zE5t0WwKLl+
 Ker8b3WGcElz3jpItp6wC5UkC5Yg8zu523wNRHwwyqpn+eAF3tRayFwtX3c3ybj8gy
 v6eWvxs5ByqHx0VwvXwE1hCjEZw0wmnxIXusbVtMSdFxlMcMuJlvlNxr9gS16kJosO
 2n7DzkwfZgLgg==
Date: Tue, 22 Jun 2021 08:06:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH 1/2] nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <20210622150636.GA2359631@dhcp-10-100-145-180.wdc.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-2-cachen@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210622002710.26591-2-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_080639_680809_C6D31F1B 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 21, 2021 at 05:27:09PM -0700, Casey Chen wrote:
> +	/*
> +	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
> +	 * from set to unset. If there is a window to it is truely freed,
> +	 * pci_free_irq_vectors() jumping into this window will crash.
> +	 * And take lock to avoid racing with pci_free_irq_vectors() in
> +	 * nvme_dev_disable() path.
> +	 */
> +	mutex_lock(&dev->shutdown_lock)

Sorry, I wasn't clear in previous review. All of the shutdown_locks
taken after initialization need to by mutex_trylock()'s. If you have to
wait to get the lock, the device is not going to be suitable for
continuing initialization after the lock is available.

And looking at this again, if trylock is successful, I think you need to
verify controller state is suitable for continuing the initialization.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
