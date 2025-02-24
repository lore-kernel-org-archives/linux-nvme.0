Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FD3C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/yCeE44bqHsBn5fhDDB6dxdP2tA9kStXEJzNQ8w1kQo=; b=v6niMDqn778OMUxT3tQUA/JV0L
	Mi2+HVv/aZVH5aBwthiBGgAUq2/kH8UYQeS0XcbzM6V+CmKPA0vyCum4BvR93BLQlJfw0nDQhBKhw
	0dknzxdAFF80teCmfEgU6kGYjkK5ZyvyMDOqs42bB6PPNzwXASX/iME1ErZOMNRkH3J5CNLnlkxcX
	HQqbWQSI5bPuaPZ8wBngQzDB300Aptqzl1uwDzjPSg1goHDLXfo6Wvcg7WxfoVl0+EMoQ+niwLboT
	DqEtcP9M1bdo5aTOEEDj7S/PkfBND5EhDXr2st6YrX/Azg21ar67mxOQlpDFdx1WSDkTFRJmA9Qic
	e3NaQsWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgf9-0000000FKSm-1gQZ;
	Mon, 24 Feb 2025 22:10:55 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgf7-0000000FKS7-44W2
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:10:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 74772611F4;
	Mon, 24 Feb 2025 22:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76357C4CED6;
	Mon, 24 Feb 2025 22:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435052;
	bh=EiFR38yVsuH05Eon8HPmhaO6gO9EfG0fnrMiR8muuXs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sH2ItckBtZqP4XORVXsfE2cv57NQSwMAc2T2FxT2iQDrJldLq+GzqXJMzuQqO/4dl
	 BQ9HeEi7h2lpFvVzhESJv8IdAFsptmrtDOnorI3rz/OaEOc/ijxQrkaKYKH6FhRiGR
	 0e6sGKK0ZvxhCR2KwYPgusl1kiVPuY/4NJDymj5LEP1mqhZQ29oTmuWClCQn+zrRx4
	 jb+36U6Ma2fUbDlzh+QLh/c0LxU+MRK3iOHwLcu9hUH9UMFkWE5K3DdgR7lweD+nns
	 ux/ATYOkevFSjua4OyQdiLGGRb/HR7Zn1ZAvBti0iWavgVUpM1eibEW+BIIPOMlx8m
	 1vxKO26qO1k1Q==
Message-ID: <1c7c1d1f-7b87-4f30-9df1-0a0b8ad8bec8@kernel.org>
Date: Tue, 25 Feb 2025 07:10:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nvmet: Add 'sq' argument to alloc_ctrl_args
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20250224123818.42218-1-hare@kernel.org>
 <20250224123818.42218-9-hare@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224123818.42218-9-hare@kernel.org>
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

On 2/24/25 21:38, Hannes Reinecke wrote:
> For secure concatenation the result of the TLS handshake will be
> stored in the 'sq' struct, so add it to the alloc_ctrl_args struct.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

