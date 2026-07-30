Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C94C55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 23:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=keWNhaZvAN9UXv6Cklyu/Qy5dBpq2j5/cGuZSJT/4hY=; b=fQAtj/UXL9pNNb/BCv5WXY56nu
	PvMouSU7Efrd3p40LIwXOgekT7FXXbQAfeRtV9gpqnSzEpkDQ8smjeeDbtgcm2oN26Nb8NnSxVhJH
	VWjjz9Lh/eFiTQh82uCnxjoauwiVqChBpIeWCVY+MNkbP+Tb3Jh6afzJiHOH6H2I3CZDmv+RfHqKj
	huSFI5clv5K2CwjUNToEaxXQhqIW4HeZxjrMjy+1cTEk3j21cL071xbLpJKXnMcGI0Hj6mPjm/Nvj
	nQWbGQ3ByGXYt89AIzaf4xNvxGkVqg2HJ4Cz3OXr0yVRinxCYwWsqpVl/6vowGKW6D6BXK/+DNjNv
	92vX/mhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZyI-0000000BTmv-0Qo8;
	Thu, 30 Jul 2026 23:15:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZyH-0000000BTmp-1ewA
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 23:15:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F3DC9407BA;
	Thu, 30 Jul 2026 23:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7778F1F000E9;
	Thu, 30 Jul 2026 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453322;
	bh=keWNhaZvAN9UXv6Cklyu/Qy5dBpq2j5/cGuZSJT/4hY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jhvYvm8uUJWeRNdL0c4+CNMzozt9d1q4xDakuCMuT3U5ojJt/kVxjRgzM+EgxrZB1
	 Wdco1BefIYa5VK1zeDDsL1fM1I8PfRikVSf3M/1iAqR2+k91xH+T0ddk++NNaz4pvA
	 U5SDSoVAmsw8V8vtwRJQc5qfBw7DQNSOX+88PkVyaH1j8XNPyeqDa1GCA0NhobXeU3
	 lu7yO/dGWhCoZfSiDrXCx398kmdOcuO6BWWFo9SJ4DQHLAa7BEVAmOwYp6TGxrkoZi
	 QKo9BTsRSM30kTkX/IXGhpcJiuoX5XIPYfZx53PHySzBpcVteDmKCHx0q3NRfa4euJ
	 0qMRs41QHIrtg==
Date: Thu, 30 Jul 2026 16:15:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
 chaitanyak@nvidia.com, gjoyce@linux.ibm.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] net: add helper for device lookup by destination
 address
Message-ID: <20260730161521.22695fff@kernel.org>
In-Reply-To: <20260727151652.3660476-2-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
	<20260727151652.3660476-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 27 Jul 2026 20:46:44 +0530 Nilay Shroff wrote:
> Add netdev_get_by_addr(), a helper that looks up the routing table to
> retrieve the network device associated with a destination address. The
> helper also supports netdev reference tracking.

This does not explain why you're doing this.
Please CC the whole series to netdev or write better commit messages.

