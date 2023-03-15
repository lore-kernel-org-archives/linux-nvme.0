Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594E1C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qszqR4Q2HKSwX+8B4r+IHhklT9mWizA59u4tTu92FEQ=; b=ecPNxU6CkYhD/l053CdvTGv6nL
	SQstEwNI6DPzSsNGQpWHo/H0Z/UJ+BhNxSFvLGH2kANz6l1Hxzas7bR0ZIpfy3whgeJerUKqwftGt
	ea19ISKJoM0fM2gmM7xY3Tx3wng+CI52DfCnzbf2OD3OpsZikdQVISjWdP8/ZU1/UTAuE4W26uKMr
	lY1MCT3Sk67YB8qrp11gXzPTo15OxN8giOC9GpidWdnnHw5IhWAWW7TAvWazWapfK3VV852tT6Mqn
	Rc1ytyTNFNKHFwWN6Ogapgwr4OjiUXQa7l36yye9acwk/VTUBty5vQ4sMiFJwYfp6r6cCFANolj6o
	pHS/cEyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcajR-00EkMQ-0K;
	Wed, 15 Mar 2023 23:40:33 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcajN-00EkLi-2R
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 23:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678923629; x=1710459629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CLbcap+Pozt8qfe5Yth9magdLrHUDhbjvojYRoHEIKo=;
  b=O27cnBJbbH+uC14H9YcDrr3mZSXrCMF/gGI3u/27PNpLpsgCh77K9qWf
   m0iRY0xXNoMGa5l8u8yJwQsxz4hKxfe2nYZH2ZnrOW3/6jGPka4qbUTHq
   phPjnfWrEOH+Zgl9bfmL38+KO29YakTllc4FyK2JdkxAyrbNpu3NXEP5A
   AVUixl4riLPCNsefdnrRSbwY2A7JxYsEQUAWz8h+WMGqPyS4mKIoo3+Fa
   Ehimv8GBpV1bTq1mIb+q5vc2cGab2hs3b0DTNX0oTrw89Nm5jnW5ioNMA
   L0Uiup6mtmzGvzlAOjDjUavXCXntP89Fsc/ETDO9np9iyzRevVh3Hx49W
   g==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225729190"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:40:26 +0800
IronPort-SDR: aMYe2ppscWOBzwOtgZ57wZuktGV0DDopdj74NSwtdZHkp/c1EaihJaGABmfv+9YRojHTJ1hI9U
 4e9av2PYamp8QO+6VypzkFkcW5NfHsWIhgMfW+21YAzueRpZimSfby+R37R0dy8eMGMk8b4vDw
 jhdQruoV8XAYjAFtbKLAKMReGLfDnQEEHtvVA8RXNcx8YopfxGzj9JwKqiO1Bo/oXPuuAShW/J
 Cd8l1ikBKtEoMO/afRfRcOm+sZByiRnveuJounWLkTdmUfelq2LYFJhTPnrsVxRoL/vL2nae+D
 eLM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 15:56:52 -0700
IronPort-SDR: 4uGWpPwj6+UvZXhfJhmDIqVJjtLFB8DO1qMoprXLz6uL8qGKqxRLL5bjC2LVZzConEOjDgZr5a
 dNveT/gcvdrUGVTA6t5MAOIQUjgChDs6jMJSEA3vdv60oHz9DRcBw+4FCXjif5Mi8LXWWlngxJ
 3R8+X3wq6PeRHMsyMfgpurAA5Zu3mksMDt6ebQ1lSnePjtrYtuZ88VM1XbvhGBkwUPboddGs+i
 W0nRku/1jCC1p0z/XlXmcXLGceTt0CymZC1Unuu3BoTYyi0wQjZzngQsMvHAyu+wKVm0mNxxcf
 STE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:40:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcRhp1QNLz1RtVn
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 16:40:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678923625; x=1681515626; bh=CLbcap+Pozt8qfe5Yth9magdLrHUDhbjvoj
	YRoHEIKo=; b=Tgg7BvgeY19bhBEQH7gV42xdLO6tRwfhueneo2lTBZ98a5hK35/
	97/2UT/PtW3WHnyTfH/KxAbn+8g81esN6z15VdWA9/gA0pOh7FTJOSrREiMYqwjY
	hJ73f8ozyMh9CxCgka26PuRxWB47TE2pT83pW+VAZIW6K9vPLlLfu5l0eGzOlCbt
	H+XT4N1S7EFlwUzlgrfhm4MRiCBWCmDPCmPMVX0rxBR2+LjnhTiJjP7+JkCpVtzg
	hlqcintG0UoJAvJXH5RbYok1P0JgvOCbODYwc5IUbXvrIsjwOl8DLXo9siB+jvqF
	lIwG+j6tC5kEfpmBL3MFAkNNV8j3Gn2jbIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k_6aUaHhQ4UU for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 16:40:25 -0700 (PDT)
Received: from [10.89.80.69] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.69])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcRhn1vrFz1RtVm;
	Wed, 15 Mar 2023 16:40:25 -0700 (PDT)
Message-ID: <7b46a57b-5d75-999d-d41e-91145513660d@opensource.wdc.com>
Date: Thu, 16 Mar 2023 08:40:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] nvmet: rename nvmet_execute_identify_cns_cs_ns
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20230315142032.507083-1-hch@lst.de>
 <20230315142032.507083-3-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230315142032.507083-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_164029_855004_7C81FFB4 
X-CRM114-Status: GOOD (  13.61  )
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
> nvmet_execute_identify_ns_zns is a more descriptive name for the
> function handling the "I/O Command Set Specific Identify Namespace
> Data Structure for the Zoned Namespace Command Set".
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


