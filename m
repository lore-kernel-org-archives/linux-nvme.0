Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4216AC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58346135A
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58346135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=L3Hms2vZWMmPtyga2Ergm5jze
	Ompun618JN6r8Kw4idZHNQ/+vtEGihSRhve1EE5BjQIwB0omqzmaE5mrw3IEKFXOhtGcpKLXX3vvb
	lhbcmE1mgKNs05frJKjw4UGPnjScm+ufMN/nyUiH4Ap3LbH/LHFNLSEhjBY4c/TSVgodebth/MY+R
	Vtj6dT5WIEvenCEqqe5rtH/LzQvDf8uR75ILc5Y09AAjcWCj/YGVNx+IY8nqULGU0XZQLQG882NLW
	uLmUwm2G0UK6tlWbyzGH5zksLK5P3wGZXih3N4bBhiLpaWeUCqQafIqJ2y0WJBNQ4/9u58hDUEVaD
	+JsDSiahw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVrMY-0061Xu-RV; Mon, 12 Apr 2021 07:52:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrMS-0061Wm-Ei
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 07:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=eP6BgCJU0HRMb+hnscQx7cSVRI
 X4P82CQfzRSY5pWxH5hLjNAitubxOEI8et+m7CZB2qriwWU1u8t2iukAJNMWytdcFkk535IZzLCC/
 eCy5ebOwKargX0DSLCR4/R6wQTXEExwKPjGjUZsyoV+3Z1gUNk3uObJqHL1Epafdq/YvntEwKm4nE
 dzADe6kza5X35afTvSJfcEQCR2I/tTfd9weLQy7lFDqRLkRNKqd58m6PNq8UV3K7wBZ6pCiqxOMpy
 mwYDztncQ8ZVu4cxE6SioPa4mvOe8fnVblvb/z1sIio6dbBMCv19wDb8d9BgqjAqbNoPr1Oj6381P
 y0c6JLuQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrMQ-005wVg-2y
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 07:51:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1544468C4E; Mon, 12 Apr 2021 09:51:50 +0200 (CEST)
Date: Mon, 12 Apr 2021 09:51:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] nvme trailing whitespace cleanup
Message-ID: <20210412075150.GA4027@lst.de>
References: <20210410201445.53061-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210410201445.53061-1-niklas.cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_005154_284992_CCF9338E 
X-CRM114-Status: UNSURE (   8.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
