Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A95C3ABC3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0+NY3EZCovDfzcx21sFykAovrzJyojJYTocWBSG6VA=; b=UqU3EUOFKAtPaqqk2Ko97h05dI
	eFza1E38ozXeuqR0QPsv2Z2PRsFyltuqX9GVFcPNnrVjhC6QEOo6Xtfo64Sc0cmNHnpkwarH4BBrj
	gFkpnZ4LJdO0C4nXQIGTI1iQL/h19jWBduLQqDXWvOiW15s3/0VIq7bpBdgtWnErV+PGPcnIAN7N4
	HQo5V57SE8NjpzgSdPiYMmGhYwYk58DduX2+R0mURNszuSMxDBr7MmMjkBBcrz3qSenqipvR58zJL
	+M9ebR6Vpq5B4biJxZuQnBQJyvt6pAhmkUfGzgEvuNASycMAyfz7odf2Lhwdz0HlPBr4m4iHYHNNn
	2VhZ820w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbUF-0000000F1gs-1TEE;
	Wed, 07 May 2025 09:54:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCbES-0000000EzWk-2W7w
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 09:38:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C98AA629D4;
	Wed,  7 May 2025 09:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6311C4CEE7;
	Wed,  7 May 2025 09:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746610707;
	bh=nCX5VuO5NTi8rhlHb8ANVJgMBobxnz8zGqKJdyB9mlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z3flbJXZ/wSz4EbPZ6jZfjtWvk9A0sZ+Y+qoCGhDMfaFqlZdPINLtEFa0SZYoZ5R6
	 BW/Z6tNd9uI7rnxdoufyKzYm0QNXtoJ6mTWRhcCOPaFQ0xbJojARghZYCE/tlEjBWO
	 s6KwVFIEosfdCMd+Om8Y++z4Zq5pjaLHxdeC4dqfa5ZH+8NSABIVGeeomzZZn4dM1N
	 nBzpRm4+IwIzJvTBUpCImxrn7F8WVA0N/klzhBctdd28NwG7gaY/pKD5WqvYtZLJz9
	 kRXbsaQ0dcODsDa/Ay/DhdYCfpx7L2aLRA5/NUywDF7HdhBy5n2Rm60xzEPSsDbJ14
	 38v91x0JCK5ag==
Message-ID: <cecb2f0b-328e-401a-8643-f543428783d3@kernel.org>
Date: Wed, 7 May 2025 18:37:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet-auth: use SHASH_DESC_ON_STACK
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250507082818.46157-1-hare@kernel.org>
 <20250507082818.46157-3-hare@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250507082818.46157-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/7/25 5:28 PM, Hannes Reinecke wrote:
> Use SHASH_DESC_ON_STACK to avoid explicit allocation.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

