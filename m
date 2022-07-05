Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C24CC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9o16xf/ZoYGkZldcX8oZtKn75oa6Yzvv2ZLuqA15U8k=; b=Dpmsr31ooLvslezJ3elULfn9p/
	fcyi4+iOMljS2JGVV0kSDIFKcElLHdga/klaQCGEYJPc4ldIY01phlfBf84ljV47mKwnMtBmKWG5Q
	VV6AgRK4CB8CaMB5N7G2qEgWG8q4QrF8y7yPwetOPYkyRvLp8NqaS7RXiB9c7AcPNtESvuwlb8TDN
	hyL4omPl/uukTeIqbkJONUGFMF8/JW6YqnEtYeie07ykJWziznSClGAgyEWSCEClQbJXotPPnmx2c
	mKq51lx/NGscjplRkclpeYDNpUNvIpZuCfd9TQMTm+uCyQACTYe24+xgAmM2BjMNwznn/BmxDLpj0
	eSWK3SxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YIS-00E2Hn-GF; Tue, 05 Jul 2022 02:28:16 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YIP-00E2Gm-28
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:28:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988092; x=1688524092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oujryl2JYvHnAVojZbyiRWiHZBohIpbls4AWqzG/w5c=;
  b=QNKd48BeDeYVCYsfQ+Va8LfhX47zyCZ5nB9ru8wK3H2HceUu1sYg+5z9
   a/uqdgCiKAYiKFxbN3Uve7URXgRHH+Tky5N3YdIEsTNwdOj+j2CkjnPzm
   m8pRXIo27sX+ZHQIElAjGOVIER7WRqIsQFukgzBbjc5rM9T+eYZL+LjDP
   5wK2VYXrz829Ic6CCr9sYrPz7sZ21W6H1fAthHkUo1RrJPF+01YGcAis4
   V7IsVy5p8PLcnUaEfwYsLehk3WTbm4OawFo95s0NA5dtyJ8B/brAD1UkP
   MqE6x9Jqv355coMinZR8qw99zCIO/pTxACbpKBja1BIPacLLmvG0I/IOZ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205518844"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:28:12 +0800
IronPort-SDR: CMt2t5dtER9SvrZtqXS9x2elSOdoo1XR9FLgdBGQF6xiR99uNnbqakn8Ek3RzflY93QlBNFvpt
 cVrzJ57qfBwAd6s4+Fb1hEzPeDgfajYIPFdCuAyKcqLMpiZN9BB4UpmZgWHWwtFcCNS95JPoUX
 wDWshEQcfujm5YbFlq//Bka6Ivm+jCtbc/m+eBIaf5ZVYOz9EUhnaQQ6lLvA+RBa8OKk5qhH+p
 9sPXGRBwgL6bWiXCyD5gt0QbT4OCVURCilWspuy4EBPeuDikaCl5bHLqIWYoZoHqU0kurdzfWW
 cTxR43Ls8KNXL4+/B/zcjHPD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:45:31 -0700
IronPort-SDR: 9kTNxS0a8l6BWHryst42JtTbzBQOx+F5VZ48HeY4QB41KmXyOJ8Q4KzhcQp2f/KpzOHmSJBQfE
 OugQroOPja+mqlENFO8yZV/5cZReZrCMHFr5vH3A9mxQkFcsOUawHcu6AymS7ILehieH9JbTim
 A6XmM5LQ1q5OWygWzMq3CrVZqJDVDe2opxRJ0wqZpIiH82oNt+yogCV1va+rCQYPSCLtsh2SGB
 MPF1cfmgFHfcVeI4sc0V8hwCtNV1XpN8QUQgY6AOrosOtiG6vTKgoVfc3s9Uzj+aGN1h7FMRHI
 bx0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:28:13 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRRc1plrz1Rwnx
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:28:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988091; x=1659580092; bh=oujryl2JYvHnAVojZbyiRWiHZBohIpbls4A
	WqzG/w5c=; b=MlmPdXXBw3KWQg49di3thwWA6q10X1WR8jTcc0nFg/o32uwvo4c
	QfUr2hXZ74+GvE3lfAA0yNFuI6WsLsL6cwZH2GVv7OcBt9lXRdafmuhsrhl7fsyq
	hlbh9HMJ0OcGnbuN+fj7cErOlYcE+JU12Oex1l7/O5MhZLO4+n3sDsPrT7UG4Uiz
	ex9HzLHP6bZcOwMkyxec8iI9d8m0J/puIwhR/J6B2WGIKwLgIHkzHQy0Q2YPsmqI
	TKtmmrgn2fJ0OPHsVGYxcBJAo3TaRbywsW9Fepr27IyGEH+M0qxCWtTjKIBB+qZF
	ttcVuJwtRzPe6RHmuiNhDaY+oLCpJ5BODPA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O0XxViYVEUVy for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:28:11 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRRb080Dz1RtVk;
	Mon,  4 Jul 2022 19:28:10 -0700 (PDT)
Message-ID: <7424fcbe-ebca-96c4-0236-211e0e44894b@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:28:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/17] block: use bdev_is_zoned instead of open coding it
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-4-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_192813_211785_F6CE94D5 
X-CRM114-Status: GOOD (  13.57  )
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

On 7/4/22 21:44, Christoph Hellwig wrote:
> Use bdev_is_zoned in all places where a block_device is available instead
> of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


