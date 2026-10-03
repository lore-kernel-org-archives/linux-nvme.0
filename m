Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367DACA5FE3
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Oct 2026 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N7Y9hr1d6rNWQJdJJwZOij8ysdYgwFMz7LiXw4Or/Kc=; b=4Zfa+VNFD7Ib8Lb5xu6lIEf05o
	GvMY8fxAh6WyKuaFokOIE7SYamctk5vqckI1tEqmw1n4laarCa4zPNMe7UR0lrw3JX71liauCspBA
	xZ299Wkm9vciqHzpBD78UJnKBt4JZQazsVFWKyXDha5+xOLAftHNFIYKG1L+q/xbTykroO+idpByn
	w5h6nPl2rwW3BGvM52h2f7cnlZ8FPcQqAiFH6Wgyj0dghVBlk7pLGL0HczRl9K4rP5+JHx5k6fj8L
	5zV/3xfrqtnIAplGjTO+jsRFYHhViMVYCMLoY2kEiOXTJrmJrM1jHK4v+zRL4JAjKdCbN/dScvT0E
	lAo1fDRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvXB-0000000DDm7-3rZ4;
	Sat, 03 Oct 2026 08:55:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCvXA-0000000DDls-1u8w
	for linux-nvme@lists.infradead.org;
	Sat, 03 Oct 2026 08:55:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 95339602C2;
	Sat,  3 Oct 2026 08:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8961F0089B;
	Sat,  3 Oct 2026 08:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791017755;
	bh=N7Y9hr1d6rNWQJdJJwZOij8ysdYgwFMz7LiXw4Or/Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LPxFLYw1Msgaf6cEB+RR2Je158MFSKPmdpK7CRrWPtqcxR/55IBb5JZgq5SGzMXT8
	 Rxm7jmMFhxFCri/8XAScsmYvDVaatVzY+SLCIstEJRVSKK/UGxrBFQWbwxaBHfy3cz
	 l1kyK0ETQLbBZGHooS6u7/CA6EWZ9ULazINtGbYVpM4uoCFBLvOfrQ4mpLFWTYPQS5
	 D8iPindiofDlnoeVmEQbjiUmEcCigssV2R8BQWHCB7HxSpjze3Rr8CAsGNNEuJGwu0
	 fkzkhsDDmbAcA8rbZFBdmLL8Z7MmGiGl3IIx2gakjE5eUD0ux8W7tQXR2WgjdW2ajW
	 pAdjJgWvzQZPg==
Date: Sat, 3 Oct 2026 09:55:49 +0100
From: Keith Busch <kbusch@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Karl Bonde Torp <k.torp@samsung.com>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix swapped ZRASF zone state values for full and
 read only
Message-ID: <asDDFcpl2pFFoH9O@kbusch-mbp>
References: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
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

On Tue, Sep 29, 2026 at 04:25:00PM +0200, Andreas Hindborg wrote:
> From: Karl Bonde Torp <k.torp@samsung.com>
> 
> The Zone Management Receive command Zone Receive Action Specific (ZRASF)
> reporting option values for the Full and Read Only zone states are swapped
> compared to the NVM Express Zoned Namespace Command Set Specification,
> Revision 1.5, Figure 35:
> 
> - 5h lists the zones in the ZSF:Full state.
> - 6h lists the zones in the ZSRO:Read Only state.
> 
> The nvmet ZNS backend uses these constants to map the ZRASF value received
> from the host to a block layer zone condition when filtering zones in
> Report Zones. Because of the swap, a host asking for full zones was given
> the read only zones, and a host asking for read only zones was given the
> full zones.
> 
> Swap the values of NVME_ZRASF_ZONE_STATE_FULL and
> NVME_ZRASF_ZONE_STATE_READONLY to match the specification.

Thanks, applied to nvme-7.3.

