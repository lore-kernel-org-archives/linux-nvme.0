Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDABC433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 02:05:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49382222F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 02:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CdY/A1Ys";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="J0morUlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49382222F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4n2BYk+Y8phRS6FYy/2oT2J9RDKx9Pw0M2MfKHEnFwg=; b=CdY/A1YspC1dapnqXQ0BboVN3
	YjsKOvu7fc2mS86cKBjS1giJ74X0K29MhB2kuxOE7M8lidiFhfnqkdfWcg8jMRDR+7cUPGQLjZZkA
	se9IWaQtLWMWpR7G2ijNtC6Mjo7nGe/JCjXUr+3F1+2IdVz54BB6BpyhXWFEghv3WezgzbFjJOXql
	rRzwjRZnzLutp+GsJ5F2hyBFBJSnLSYQNBFk6zSNrhXTKSATafDK2cUjxpOP3H5eJ1n+Lo1YdxTZd
	BFcapIip0q9wNPcUydKEfM/JndTNNscQWlvLvNybtmBXSR9wB/EXX+fT0TQ4YoOO7Uya3EFmCHC1m
	KLX362EwQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUh20-0001Cb-AD; Tue, 20 Oct 2020 02:05:44 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUh1y-0001CE-74
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 02:05:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RtB5nLPwx5M3VXe7d/S0vUTaZNVZBcENJ1eLQd+/Nzk=; b=J0morUlZPlFqHHZYIB1SBZJUly
 DnMHCUOtGVjCzCgD5Cy4o/diwxycXnDasuKCQwSVfPdtWzl+ZKP//0yRGGqmemz4WirmkHfHfHsxn
 pRZ4jpBuEMIQg2ggD2tMyQWn+sh3UUz4JuCG0pFmeXNzyvYEYr3U6cttLRiNC+v4Q5xpqpE8KW6RE
 NSHq96JgzqyvKPMHZXUgijm2DHGoPMjYE5L88HZIDrItSJr8FeCi29Ab98zAWNUw0ttIjveVZyHRy
 pmQ/q1dVTCci/lFGuTRDl84U98UV6dGzNNg2IFWisqTvmZs0frOGFEszlmnAbsIEmYY32NLmE6rZA
 HRqWm+cQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kUh1u-00011r-VS; Mon, 19 Oct 2020 20:05:39 -0600
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20201016221905.4686-1-logang@deltatee.com>
 <7fbd6b56-cda5-a9b3-7323-99d9704fbec5@nvidia.com>
 <32db0b68-8e22-4503-e480-d7070e08617c@deltatee.com>
 <BYAPR04MB4965B1360F5F6A1D13FF1DD0861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <efa5f46a-cb8f-11c5-1faf-c9a4cf3e0792@deltatee.com>
Date: Mon, 19 Oct 2020 20:05:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B1360F5F6A1D13FF1DD0861F0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 mgurtovoy@nvidia.com, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_220542_285102_9E8611EF 
X-CRM114-Status: GOOD (  14.55  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-19 8:03 p.m., Chaitanya Kulkarni wrote:
> On 10/19/20 08:40, Logan Gunthorpe wrote:
>>>> +	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << (PAGE_SHIFT - 9),
>>>> +				      max_hw_sectors);
>>> can 9 be replaced with SECTOR_SHIFT ?
>> Oh, yes, that does sound better. Thanks.
>>
>> Logan
>>
>>
> Although it is a good suggestion we are not using the SECTOR_SIZE in
> 
> the target code, I don't think we should change that for passthru. Also,
> 
> I remember that on the block layer mailing list SECTOR_SIZE macro been
> 
> discouraged over use of 9.

Well in that case v2 or v3 can be merged depending on maintainer preference.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
