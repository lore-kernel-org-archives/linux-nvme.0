Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ECEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:14:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34EF23132
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 16:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oINWKZfP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WBRWen/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34EF23132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MQ61ndS+gbZyl1Y3aUrP+5gAv3KiWT7AKhjJN9yF2Us=; b=oINWKZfP+oP3Jo+RLDrXC80cg
	9G4BFeUlMY84jp57pvjUiG7DRV1mis5JH1QpEnaWb44FmqF/Gfk/7G34lV2tlwHYRx29bx52bpzQ+
	+Il1IdQ1Nn1QmqM9vzD07eTjIHfT3Qmh8/elpGX2GtDjwgRKFPYG4e6Yzdz8zBWPh8VjLxkvSwxTh
	RmYuEeS1lRERMPKMngOM/qys1WHF+olsNeQSbi1Rs4KuG0w6WMa+tePujm68EZ/Ts0crkhQg06z7e
	vMW0fXXsFWpdZZJH4ohtDd/SCowll02bWOhGySIg7t3kKZTmtQDPrnIBzwg23pDP/gtBcHxizhvs5
	PKM1tvzAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3iWs-0005dT-8y; Thu, 06 Aug 2020 16:14:06 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3iWq-0005dA-7h
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 16:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4whSmh+a52OruwRq1kGHSpS716o8hhEnqikXtT1nC94=; b=WBRWen/HHSiBELIHAt1aJARlGe
 BCPARuLFyVJVnVAwHqTmsW+L0Ey9BywIpKCzrjWGAgS3/om3iRs7KZg4tbJMHiPNeWADbfedPC3ym
 jvLXs2r+tki1CV3e6b6M5TGXThQm+c2SygSwVUF3dP7v1pZnpf967gCgWM3fJNiquvTwmStquHEwe
 WxoJJay9zcUdvsOzGYkfRybmUt6+4I82w33EDNqSySoCPmLq9aFBHmJ12b07LJOOM7nM6PxFBV6yX
 +ihWmEL8miibAV8Sv19B8fLK+HBbgG7rH7PNmY6W6u00uLA/r9G9DS2SqrBu1oz4RVqOC/X7563Zb
 OhmpglWA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k3iWm-0006Ox-Kw; Thu, 06 Aug 2020 10:14:02 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa193003-5d17-08fc-4431-1940abe24370@deltatee.com>
Date: Thu, 6 Aug 2020 10:14:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806073151.56061-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] nvmet: call blk_mq_free_request() directly
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_121404_328701_E5A89970 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
Cc: sagi@grimberg.me, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-06 1:31 a.m., Chaitanya Kulkarni wrote:
> Instead of calling blk_put_request() which calls blk_mq_free_request(),
> call blk_mq_free_request() directly for NVMeOF passthru. This is to
> mainly avoid an extra function call in the completion path
> nvmet_passthru_req_done().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good to me. It seems blk_mq_free_request() is currently always
used with nvme_alloc_request().

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
