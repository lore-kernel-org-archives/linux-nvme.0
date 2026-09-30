Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BDDCA5FBB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 07:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bgd0mVPJ948cD/Xsm5BN0c44HNmKafNptfUbdYM+II=; b=dRTikaIEQMM5h3E1SQH/FQq+9g
	kH3RqEfFxaAjfptKYJXn/bO0wxxhAJmNA6ajK+BdpJ8Gd5a+1u1AKfSRSZupyme7uYymzWzaDcNWm
	2KhPnaAdB2VfPyf20suoz4Bm4KQQQGaUIMN7Oh3AGIV2uM+RDLQqdz5MyUZ7bOkU6lSY0GniFX2fF
	hyOubdNczt7AOQKH3vCQ8UvQOYwvT/Alzbi0Via+6W6HJVyOu+shxoHUecczR5H5NnSB93WCjEZRu
	GMogZYsYZ5T7tOhoA0HHUO6yW3KpprRhhbLEvA0Pz79p9Seh9mL+02W2B+YpYmGohlCgGcHwjvU6I
	mDvl6F5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBopp-00000005HSK-1mxa;
	Wed, 30 Sep 2026 07:34:37 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBopo-00000005HS6-0AZb
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 07:34:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7B20340A35;
	Wed, 30 Sep 2026 07:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20511F000FF;
	Wed, 30 Sep 2026 07:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790753675;
	bh=+bgd0mVPJ948cD/Xsm5BN0c44HNmKafNptfUbdYM+II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Go0VTqpn1bYrONXD4rNQJNPshyCFNDML7lv7CRp/Cd2Xun8FYaNeXiqYYEGAI5j6s
	 Rs/sSXAfZbyeqO4Ufbq67H3Y4jym6hcqzaVXESJyqsi6lFkmS6rGx1eT//ABjKqPWe
	 04gk0SVqCnZvIY6viAuWYzx9O2XuBOkCjF72LNhKDjNH5F7rveLNbvDqDs1ggKQVtq
	 zJyX9r7IwNfxwghd6BS92xcb9OUF2M8o79ZMQDg0+GNLwg9cL+FBDt4WD+JTMXQwkc
	 gzxsJT3XWQpBseL6UtVN+4LbhyPidYzffLSaVgzmpKAruPs8NXaMIpEuvw6qu3edp7
	 VjF5Ap6LP7y+w==
Message-ID: <6b7f77f5-32f7-46a8-9082-3a7752651037@kernel.org>
Date: Wed, 30 Sep 2026 09:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix swapped ZRASF zone state values for full and
 read only
To: Andreas Hindborg <a.hindborg@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Karl Bonde Torp <k.torp@samsung.com>, stable@vger.kernel.org
References: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260929-nvme-zns-fabrics-field-fix-v1-1-f99b6ffb49fc@kernel.org>
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

On 2026/09/29 16:25, Andreas Hindborg wrote:
> From: Karl Bonde Torp <k.torp@samsung.com>
> 
> The Zone Management Receive command Zone Receive Action Specific (ZRASF)
> reporting option values for the Full and Read Only zone states are swapped
> compared to the NVM Express Zoned Namespace Command Set Specification,
> Revision 1.5, Figure 35:

Not only rev 1.5. The same definitions are in all ZNS spec versions.

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
> 
> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Karl Bonde Torp <k.torp@samsung.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

