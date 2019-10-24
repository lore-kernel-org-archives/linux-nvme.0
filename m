Return-Path: <SRS0=/YZe=YR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D495CA9EAF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6F620659
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qv7QCB9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6F620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=70E7uSzt9zFdIWZWRDe4iR4PnvfFAC54TzkDZBVSMc0=; b=Qv7QCB9FhMs3LJ
	ev90ttCdE1D6ws6pEoJmRYkf7LRM2l4uwI1m5svuHrVare2Vu2H6sUVtsMC06iPAnWVyO+ahylKdR
	u2TUPjB635VcFw3yx6S1xPxjLAIc56ZEwAP9Hx8cqXxQYqXsWQWMtvse4m9tsP/3le1h35iNiy17i
	u7ndiDoN6z7x3/1QmEnqJSOrpUPq3omRdqzVzGAKPGAtERQXhfPSuNuzsKHsqFezHaWocfBN0+YFT
	V1SK74IhsWooqHcOnyIKPuCZdhSi86ZGzxygWNGREwA/LUu1NvJf0aOYpfcU6xN7WAnceD92tLE++
	R3nfosoOPrI5HKP+Aw/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNgkp-000274-JL; Thu, 24 Oct 2019 17:18:31 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNgkn-00025n-3J
 for linux-nvme@lists.infradead.org; Thu, 24 Oct 2019 17:18:30 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1iNgkh-0005m1-1a; Thu, 24 Oct 2019 11:18:25 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20191023163545.4193-1-logang@deltatee.com>
 <20191023163545.4193-4-logang@deltatee.com> <20191024011743.GC5190@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <382906f0-ce0b-282a-9665-8317b50fe374@deltatee.com>
Date: Thu, 24 Oct 2019 11:18:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024011743.GC5190@lst.de>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/7] nvmet: Introduce common execute function for
 get_log_page and identify
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_101829_179611_9B45F731 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-10-23 7:17 p.m., Christoph Hellwig wrote:
> On Wed, Oct 23, 2019 at 10:35:41AM -0600, Logan Gunthorpe wrote:
>> Instead of picking the sub-command handler to execute in a nested
>> switch statement introduce a landing functions that calls out
>> to the appropriate sub-command handler.
>>
>> This will allow us to have a common place in the handler to check
>> the transfer length in a future patch.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> [logang@deltatee.com: separated out of a larger draft patch from hch]
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> First signoff needs to be the From line picked up by git.  I don't really
> care if you keep my attribution or not, but if you do it needs From
> line for me as the first theing in the mail body, and if not it
> should drop by signoff and just say based on a patch from me.
> 
> Otherwise the series looks fine.

Ok, understood. Do you want me to fix this up in a v2? Or can you fix it
up when you pick up the patches?

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
