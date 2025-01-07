Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC17E77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mI4N7MSq+mp/+6HQ8o/Bg2y+z82YjyfpZ11jQucqLTs=; b=eVU/9Z80OwM4QE4ebp+ZykELSX
	zIAD83d0racmzsW64gTrpjauRmCW0OezCVwrMiu+c4bxDQ+qMI60mlY8PMQn6Uj/8Frb5O7odqbli
	CG0Y8k720em/sMan/doGv/AXWNIyTPqKDknoVMjZnfWziXVV6zOEN0nFUYqIAFzIKpj1tScSauWTT
	e5wGb0UNRfEBnemw+Uxffu85Qyi8iWVEuYFk0gQWx1owwwJu8fMQiDr9/vKhegiy74qXgYCAc3y41
	gmjdFzD4hs3uJ5T9u2IWvlihNGlicQZIJEaOk6kWLYFO8Y66qbLmg0s0stPNST3UgtrAwOnBOiXhb
	xb9OSDJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6n1-00000004KyY-3CaS;
	Tue, 07 Jan 2025 10:26:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6Sj-00000004GCr-0ZvN
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:05:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 88CCA5C5BB9;
	Tue,  7 Jan 2025 10:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40471C4CED6;
	Tue,  7 Jan 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244324;
	bh=8jmwATyEWLLwjfjL024kECAWxrvcDtaSF8/ccLUrRk0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DIw6BHFNgyqts2cNELuVQttSkjcAkkJIgJaA61FIsDemIS6AdCijrFRkuBPWpkx/5
	 XhXPZPpKu4jNf8F3ktCmp532okyjwpacmYaujmIEIY7tqvPxSC/vUkU4mTqPgh11vZ
	 qEBLJ/dv9nxgfP2LKKinCS4zWPgSbTg0EANUofB5h4Wvr0qgnsPDb4Jm2LPBcV4TUX
	 dY4kkhRg6Z+OD+L17EVG5TMpLu58NApwtG91MsrzYJqtyVsnXh6ktikKwLYqjhS23H
	 1+ZkCaZ5vF1vnzJjKeXGEzZilHvOO9Ne+HWM2IDakE0CLmCE3ostPXxHmkaYuoQr7k
	 1ewQaWGyDJo8Q==
Message-ID: <7b657b32-dd25-4826-9c2f-dfd980610de2@kernel.org>
Date: Tue, 7 Jan 2025 19:05:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs entries
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_020525_531182_CAF2919B 
X-CRM114-Status: GOOD (  10.43  )
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

On 1/7/25 15:30, Christoph Hellwig wrote:
> De-duplicate the code for updating queue limits by adding a store_limit
> method that allows having common code handle the actual queue limits
> update.
> 
> Note that this is a pure refactoring patch and does not address the
> existing freeze vs limits lock order problem in the refactored code,
> which will be addressed next.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

