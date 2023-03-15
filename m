Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16FC6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d7NMUaSy8MpeA3hpxSWNpumweVtOM/r+E0lbc4G603w=; b=2hPi9L4MIxS24W3Zb53Kx3XmJN
	iKiMV43xSnB2uPwPIzv2PFHiB9XfSDbIAXmTXu4OQ07SMmLdEnHXSEKNIucyr5Wov0gY0gdm24pA5
	ZavegEvTUbdQcCnQxzCRgvsMDmK4e+M62B1hm46e0yFpCAuGjRV2IIGofcL7JycnDX6EUXxonp8Ql
	EJGIsfEnSGs/NvHdNzqsX79FLqX1scTLPn4vjPfn531U+Pt1HHcji0UDHzWXMygaPmW57gv1S1not
	KboIkmEM7KdK15+0U/AQ4yaULh+NcK743MM7W32//RrqNE7KfoNzIg6DicvJVoIR1MIJvkEN66zLO
	uZZIwz2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcaiu-00EkIX-1s;
	Wed, 15 Mar 2023 23:40:00 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcaiq-00EkHz-2R
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 23:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678923596; x=1710459596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1qMjAEQy80ruippSBYIuRveTVj78fY+wolxn4uIy0e4=;
  b=gVg8Iu0V2puhStW8K4CuorBTD76rrvFa65ywBm8Ya1ynoSxJJPoJavnz
   LdSxalkr2gLcSWZcMYrwwcHHL8WQJ0V5BheGZjDO3KCe+dPZVXe1aZg/B
   YyzGiWx9WJXJm212/WU3ZXRDY7lBEV9EPizm2FxX/LzV0PeE1wZLzw1RX
   vslTFCqcqInh24pt1DAqBN0EUSo+wcDR/5dQQ3bH85AM04BOcLDP+ZSWH
   5RiZAHF3JJ6VCF8BIjovRCZhJ1o0LJbewxxFpl/k0S8xSxwysvOA6yPff
   D1W0dAg4YoZtBeaLVfSKttZm4CWaeJg+LpuJRZSBA1nDI6A17xqg1Jk/A
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="337759546"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:39:53 +0800
IronPort-SDR: b0sVYSDaBDoJouSvSO8pLH/cI94ZdLZm3kH33gEHnNwTsV955lXXWa1aJoeZ4NZj8Sni1kG0n7
 mD7hMD0or4vsTCH16pdKdofXZ//tQMQfXD9cd+2cY0g18CSAsICb/hrXYOJ+5JniBA49buf1CY
 7woNQX9IAPDj5zXpY/Wiuv3Jj/W6vRtnBAeB9F0lYlkbb/omZjYIbH2iYL7TsIwZk7NEzDEX9h
 xkDOP5dg2wL1jw/ggcswwVD4z7mcjexQpkKrJ+c0pcEuZGrtt/b0AsQsdfCM72YArdOX8DM865
 kXM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 15:50:38 -0700
IronPort-SDR: 3+OikAXzr7uqYPEjyCu3vakS5T8hCCR4IfcPNcFHmSmxhEJn+HtMdYWTN48WZdGaaLdLUJ8ucP
 d8k84IfbPh/q8UCPRsiieYOisraTqJjQlmrvi8a179TNFCJN2ZTpzZp86YEg3xC0+ZqiW46Jus
 y9ZAtgS/sGjHpLwj482q/uC3Hve9E2750+FEFEduQTaTB1qhYJV+u7GZBS4Pfpoy1Gcd45nj87
 N4GA1zOKHR0t2hTS5tUm/MraEUHca7sFzrz9D+ifJkOJRh2/wsNekgDGRJBTlllNm1NvymEtit
 UAg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:39:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcRh94F5Yz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 16:39:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678923593; x=1681515594; bh=1qMjAEQy80ruippSBYIuRveTVj78fY+wolx
	n4uIy0e4=; b=Na6DgqZt72L/amYjTl9v3czDJg9AXjKu1LF3niqxFnHcyqRMY+N
	d6ZkOp2Lu6DEf9DnNvCZoayYIhCufP7MH6F1iflkkFFXWvU54fLnmD6U5V387WbL
	hXR/whbXt4uKH0wcxMP2xRk0n7/NPCvj+4fEFWRiC8zdvLRM/7Ylz8WxUulexHIr
	x6ocNwIkn5o5wTR4pZlXN5LwA6Cr/xAybJraPpKA1oozVAEiNbwFNkFfrkzkb11b
	sZWx5J+Qq7TS+oI5qWE1aNeT6KOci4x3utVZBVdWUgkmFqZZTLXqHRGqezW1LJk1
	1wRpcBHNE4AJSKB5OI7BX1bBan8HjIzc+qw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IBMTgSS0S9Wh for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 16:39:53 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcRh846ktz1RtVm;
	Wed, 15 Mar 2023 16:39:52 -0700 (PDT)
Message-ID: <e1a93c34-7516-1f75-bc35-e15e4835631c@opensource.wdc.com>
Date: Thu, 16 Mar 2023 08:39:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] nvmet: fix Identify Identification Descriptor List
 handling
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20230315142032.507083-1-hch@lst.de>
 <20230315142032.507083-2-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230315142032.507083-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_163956_801406_4FE2F1D5 
X-CRM114-Status: GOOD (  13.22  )
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

On 2023/03/15 23:20, Christoph Hellwig wrote:
> The Identification Descriptor List CNS value does not check the CSI
> value, so remove the code trying to handle it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research


