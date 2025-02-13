Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E231C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7j4Ms9PX8K20OKDDg3LZUMrbeSd6597yKnz58VsFmBE=; b=VreOIDpUwhPinF806MDhgT0D8o
	URCh/gm5U+0cUYjX91NUL0ZbkaLFerVL8AaHuBN7yKtH/HmWK4dbWVqbvcJ47riBAkoJz6YJ7lT3P
	8d386ug3sfAh7zrzdwhOyh8o1MLRCp7ZGtEzZYNZFgC+Rp+UMbPsJz4Eu87esO7PYMuGJvBvL/b1H
	0DSCH6mG2S02c/a3uRUVlowNFB69zA6fA1n63izlWCeKSyNgb/gA2vbcdtWjMKofuQ2gGBZUdPHAq
	ZASF09u07RIv7r4uo1Hn+tsqVDn7mp5RYXmlG4t9YDeCP19K27tLjM2a7Fu/0q0g6vSLJ6l2PsUhW
	XSPH17wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSOE-00000009tCr-0BJt;
	Thu, 13 Feb 2025 06:07:58 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSOC-00000009tC8-0Jaq
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:07:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0A77DA41DE1;
	Thu, 13 Feb 2025 06:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CBEC4CED1;
	Thu, 13 Feb 2025 06:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739426873;
	bh=EWtc2jWO9M8aIAApnh/TB5lWQ3IQ40QWrsnZbIeuxCg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YPhSE53xCl/WlpjZzt2hU/0nA5boSHgmpFwd4OTZw74Vmsyr+4rVXqP+yMc7gR+zU
	 XkHJ4a7GqzHYmLtKiaRlPF9x98IWg8FW6jv04HuN4ikrnE3dXuH/2kqJ44eoC08HMp
	 TvSyBIe/J5PpGmsOHAAfraki1/Mmfcd8xpElGYHrmJkDBFKAfvwciQvcbNK4BzVPQJ
	 b73i7G1ISW0VgMHkLk8Myb1O56zn40d6TPh6S9oaJ3oQKa3yK0gv6QhdTQDbbghIJ4
	 X4HkJcR8qag43+CvXU9//XcXPRzZ+oHiToHd1U51GtkzK7HCWHBB94ugK/epsWLop4
	 Z8YvTUdnsU+oA==
Message-ID: <9455ccc9-75d4-4329-938f-e5691d92caa5@kernel.org>
Date: Thu, 13 Feb 2025 15:07:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: Cleanup the definition of the controller config
 register fields
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
 <20250210002935.1744249-2-dlemoal@kernel.org> <20250213060051.GD19506@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250213060051.GD19506@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_220756_198098_7B978C45 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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

On 2025/02/13 15:00, Christoph Hellwig wrote:
>> +++ b/include/linux/nvme.h
>> @@ -202,24 +202,35 @@ enum {
>>  enum {
>>  	NVME_CC_ENABLE		= 1 << 0,
>>  	NVME_CC_EN_SHIFT	= 0,
>> +
>>  	NVME_CC_CSS_SHIFT	= 4,
>> -	NVME_CC_MPS_SHIFT	= 7,
>> -	NVME_CC_AMS_SHIFT	= 11,
>> -	NVME_CC_SHN_SHIFT	= 14,
>> -	NVME_CC_IOSQES_SHIFT	= 16,
>> -	NVME_CC_IOCQES_SHIFT	= 20,
>> +	NVME_CC_CSS_MASK	= 7 << NVME_CC_CSS_SHIFT,
> 
> While you're at it, maybe use a separate anonymous enum for each
> field and a comment about which field it describes?

I find the single enum for all the fields of the same u32 register to be a nice
grouping of things. But I agree that more comments would indeed be nice.
I can add that. But do we really need separate enums for each field ?


-- 
Damien Le Moal
Western Digital Research

