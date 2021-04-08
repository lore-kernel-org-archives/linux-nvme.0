Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8708C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C284610F8
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C284610F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l+EmCaeD/qMBknHkuHDbW0Llo/C6fZg+JFOQgRZADLE=; b=TEd7nT+eSP8lCTsD1FwGEdJ+C
	S55x9KmoXgdS9FX0SJZF85afjsAi2wymX8JfNpw4U6K/QDQ5uI2bG8ekpKyC7nwXsqGcOIBD5rtVS
	AUUlhUQclbN239m3U1erCI9czhg6YMZjhxBgoyr729Er57jZ82pGNCHhdbn5d9/FULwEgI5e4FMm6
	4gChKi5uqLDW0Zqpr3MS/L7BTpx8CDz7KdcRfHc0G2Z7sqO+XmiewpUEfyUQFhMEWdM7/iXx25krN
	NEVz4ORE6nggPcUb/Okql449w5UoA1DKHW7vYwcxJYeqTxu0bNBa0mNb6s82xg9JZHyVwwpfSlhKR
	vRQYvNNCw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUP1t-007Cv6-9q; Thu, 08 Apr 2021 07:24:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUP1p-007Ctp-AD
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 07:24:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6707468B05; Thu,  8 Apr 2021 09:24:36 +0200 (CEST)
Date: Thu, 8 Apr 2021 09:24:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, damien.lemoal@wdc.com
Subject: Re: [PATCH V13 4/4] nvmet: add req cns error complete helper
Message-ID: <20210408072436.GC24502@lst.de>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408001427.20501-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_082437_647993_2BF28993 
X-CRM114-Status: GOOD (  12.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 07, 2021 at 05:14:27PM -0700, Chaitanya Kulkarni wrote:
> We report error and complete the request when identify cns value
> is not handled in nvmet_execute_identify(),
> nvmet_execute_identify_cns_cs_ctrl(), and
> nvmet_execute_identify_cns_cs_ns().
> 
> Add a helper nvmet_req_cns_error_compplete() to remove the duplicate
> code from all the above three functions.

Please do this from the beginning instead of fixing up the just
introduced code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
