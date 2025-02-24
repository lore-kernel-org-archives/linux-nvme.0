Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245DEC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PL+PbSNf1MD51iAuorkitpZad7jmmCyEGl4AOIBdAQs=; b=ERb0T/tjEsL4meQFWq8Sor2Ek9
	6cOr23OBjy/0cMIH659uNaaPiStQ7NoG4JdvGhTRhlX75gpxSpCR3PF1aPVNDQ5tckw7w9SVSNIlc
	GedUlAHl6dx+9+ltEKnfPCVLwkO/utPRKXq233HLPhn0dhbDKBBtMtSOanD5qJqHPc1kS3Yu/OvtV
	eVHdM0xmprif2kUQIJpZ69y6H1suveNZ7DbBHEeB1A/X1+32KkhRztDJ5NrnCTEHGbnIfuadF0H6A
	cVO5qymQ+xklGhI6XGJe1JJMIAfr9T7dlD3RukvnwRnoSsba9W+tw47hm1/oMF1/d5XA68focVA5e
	3Bjdk1ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgzh-0000000FNrR-2sBi;
	Mon, 24 Feb 2025 22:32:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmgzg-0000000FNqu-271Q
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:32:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D61FA611F9;
	Mon, 24 Feb 2025 22:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFE2C4CED6;
	Mon, 24 Feb 2025 22:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436327;
	bh=n3rJrnAXDngqJENSqWN/yd6E5Snq2U2rT7EzvW52S+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ooc9naPNiyyycLnIIMM+sn4ae6F3T8Pw1TEfJVj5mwvierOtTvh/wcn4KaBhZHFJ0
	 /ELxb+5t4SFYOMoNW87uKlxUyUi5bAmwxz/FMOX+2cf2YIoJZLVHhTGHGRq/JrfdW7
	 e7OBqvpRnLwl8T8EuTBO/tD5xleUuNYBZAF3dJ27C7RuTAaJYtJvgxu32HjRvHkn3K
	 L0rO+y7JbzPC5VmTRT/foH8PVgJwhaJFw/smI35AnTqRqGYyohDgDzxB9td7I45Hp7
	 asOxGWtkdY4Q/fn/mRsECPvQ0LDug7ZcEdOsKOeCBGWFAbePuZ5xsfU3UgkKkQNNtq
	 wnqnA1gdSLuog==
Message-ID: <3defd803-650d-40d1-b1fb-e32a5d4318e4@kernel.org>
Date: Tue, 25 Feb 2025 07:32:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nvme-ioctl: simplify parameters
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-7-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250224182128.2042061-7-kbusch@meta.com>
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

On 2/25/25 03:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The uring_cmd handler already defines a struct to group all the
> parameters needed to submit a request. Reuse this throughout to simplfy
> the function signature.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

