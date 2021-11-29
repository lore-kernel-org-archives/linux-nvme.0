Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2C4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 16:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILV7h/2DtMSTNJeoZg4Mw4txist26pYjZJQVA2EeDjo=; b=SXmccfwzMKJfnM6B5Iq2U56YxS
	0scWWEeg4a9InCLRhnluHm6NMzaY5BN6uoJmtv9v1exO0eIRrOnTPGguRiFHxNXa/AGbw/I1dves/
	noR3iEaTKXXQdb7dnTJRrfWzHEBkOZDhaO85rGxtiShYFqLclRdCWOR9+z0sR6SvZe5YULptjsW9x
	qtToAIlNJVkC0D+5KGaG+tJ7o5A05ZkZI0aLcp2M4s2AXwIlnwvv1pbMFsiFRs/cfrvMSsGbre9bP
	18FUNkQca/34Q7lZQAjG0ipIpzzeslrOaOBO+gwUvZEOzAMkvNo4a4I9/elDFLiZxk435olrMJbob
	qgOVdcFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrjbZ-001Ql6-Cu; Mon, 29 Nov 2021 16:34:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrjbW-001Qk9-Hd
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 16:34:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8561A6159D;
 Mon, 29 Nov 2021 16:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F81C53FAD;
 Mon, 29 Nov 2021 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638203649;
 bh=kS3HRdvH9zUxYELkE5d5GqTNaRMV/o7y2I7+v9B3DAg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zg57YRVTTRQ+ZZHSiWe1mkUFx0ZoD4yc9oaDrfknYaSI5xCRIY/HvbTZyhVSJv1xz
 Me/HEUjYxSDhVzN/TjP1fP18SXjDPcBTQwFZaKYGHq6KK6iQj+WDqxFzMt+bHOAlEY
 TSMd3HMFpO2UErEsZG6lQfkccGBXpJmbSo5FhgQHGp7hAHdTU/oN3dw6mvZUvn5Nue
 lkAvhaK+RIVH0e0fNy5lBTm/6tH1jvv0a3BUxpUfG2uj+woC4gsqpQcTroX1OutK3i
 9KYbJHt1buRvVZm75AouKS9j5nYmHLVLGerKs89nafqHx84B5IMX4LVtMs2hK44iHF
 2AMpBOwTJwYKA==
Date: Mon, 29 Nov 2021 08:34:06 -0800
From: Keith Busch <kbusch@kernel.org>
To: Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: duplicate NQNs check if devices needed
Message-ID: <20211129163406.GA3582042@dhcp-10-100-145-180.wdc.com>
References: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129111854.44006-1-zhangliguang@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_083410_651675_A53945EB 
X-CRM114-Status: GOOD (  11.94  )
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

On Mon, Nov 29, 2021 at 07:18:54PM +0800, Liguang Zhang wrote:
> @@ -2587,6 +2587,9 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
>  
>  	lockdep_assert_held(&nvme_subsystems_lock);
>  
> +	if (strncmp(subsysnqn, "nqn.", 4))
> +		return NULL;

This seems like an arbitrary way to decide not to check for duplicates.
Shouldn't we just add the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk for the
broken controllers?

