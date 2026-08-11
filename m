Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64526C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7BrtxDZSYqK7Ssz8XKfAJxDQOQOUT5KYjPUoFcQw4Y=; b=dS6H7Ok0HTkD1zxEmOCPLHqoQj
	XhlnfcXrKBokHbkaX+lq30UkH3n3nmwP3Wq7IA56LGBSJCIuorUQaRa1lea5BgC2Y+cTg8ZA9I/I1
	d7V9wawbw+hIiFaAwhxZMbArQSDa7H0Y8asq3iQjdkrBeHGKpRpax+J+7Oj3h/5tB37Ds22bcxlKZ
	RNvfyOdHMG/KII2izS7NyD0ONEO9Kee4yTGNS3lPvZGsWqKS9c6eDvBJE70iSlfkA41oUwAfoZfKf
	5mu2EtKGzeymrH1XKiibbcH092QDLHuHWK+r/xsxRqkdg+iz8oodhCUdEv70pJRsMbwf509aPiXBb
	2SL2Wknw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoh1-0000000EOJw-3YDo;
	Tue, 11 Aug 2026 15:47:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtoh0-0000000EOJp-34RQ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 15:47:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09E68600AD;
	Tue, 11 Aug 2026 15:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C73C1F000E9;
	Tue, 11 Aug 2026 15:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786463225;
	bh=P7BrtxDZSYqK7Ssz8XKfAJxDQOQOUT5KYjPUoFcQw4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MHFn8ocCeQOEhOGPaJ6jN8TKjft5g9fx20Amhhisl7KxwJSmlDqD80LYrTW2Ek9iV
	 51j9q/peywZ9i2m6uvclhZlnKa2eAGdIVAdVeDvbyyBoKEDLh9hFIkGi1gOVU5BDkS
	 cc6BnFyYIJ0Ffv90nrDtX+OkOqlb+ZstOCWcsMh0Xh5gl/pgvDbD7bg/+l2agHzqNp
	 /iNsTagc69xUqUpY7/fFSSrTvljIUx4Gu9e9a77pQvOCqHCaHaH+3qqXmBDYnDkIVL
	 iSuoUf8eoYOemo7cBamOpq6heDp/xdTIXZHlUPGPsPYPb9HTuernX8RCKAhP08zk1S
	 ebw9qTpLfKmfA==
Date: Tue, 11 Aug 2026 09:47:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?iso-8859-1?B?Suly6W15?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: reject overlong negotiate identifier lists
Message-ID: <antD-Av1yueclXkC@kbusch-mbp>
References: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810155615.3269409-1-Jeremy.Jean@oss.cyber.gouv.fr>
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

On Mon, Aug 10, 2026 at 03:56:15PM +0000, Jérémy Jean wrote:
> The DH-HMAC-CHAP NEGOTIATE descriptor carries separate lengths for the
> hash and DH identifier lists, but each list occupies a fixed 30-byte half
> of idlist[]. nvmet_auth_negotiate() uses halen and dhlen from the wire as
> loop bounds without validating them, so a remote initiator can make the
> target read past the 72-byte request buffer. KASAN reports a 
> slab-out-of-bounds read in nvmet_execute_auth_send().
> 
> Reject list lengths above the protocol maxima before either loop
> indexes idlist[].

This should already be fixed with the inclusion of this one:

https://lore.kernel.org/linux-nvme/20260804033800.3975537-1-kanie@linux.alibaba.com/

