Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3D3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:46:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178AA610A1
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 07:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 178AA610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=402VIZxaunWNjAELEX3RgxCzDNXQgRa1ADpQnY9LeJY=; b=JcCH/i6MBM2rA+
	WAZYhsnzF/3OlAs4y5gJE32+SVLAuceIuF/fqEvWstmMxsxPRfbf10LvZKXnY9t73QE5t2GElReTc
	OoJRnaZfwt90ZFSeqcG4GwH2hyM4VViZZNb651X9IHMHUDU6WfngLE3um9nJEMgWmu+Of/Y6nttGl
	qGBHBVE8TLXGZ1tikvaSSae69JjrBTiGxMfXHaN2nxIWO3msX0Xgi+lYDVFWH+1z1nynNKWr92JAL
	Arv7tyvR4DGiw5GDL9sodpTPIjUa9FOdg3ypptoUGQjR3yZC/wzOm1JYK/ykD75bqeoFNIHdtAdRZ
	67GnrU9hgDOSLuWB205w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSwx6-007ML4-Ua; Wed, 22 Sep 2021 07:46:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSwx3-007MJK-JV
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 07:45:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7BC5867373; Wed, 22 Sep 2021 09:45:50 +0200 (CEST)
Date: Wed, 22 Sep 2021 09:45:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, chaitanyak@nvidia.com,
 israelr@nvidia.com, mruijter@primelogic.nl, oren@nvidia.com,
 nitzanc@nvidia.com
Subject: Re: [PATCH 2/2] nvmet-rdma: implement get_queue_size controller op
Message-ID: <20210922074550.GA16099@lst.de>
References: <20210921190445.6974-1-mgurtovoy@nvidia.com>
 <20210921190445.6974-3-mgurtovoy@nvidia.com>
 <0b93503b-93c6-6314-939a-34bd69c30113@grimberg.me>
 <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <300d5661-c22c-bb8f-e5c3-38902dd946a0@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_004557_828831_07643B51 
X-CRM114-Status: GOOD (  10.97  )
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

On Wed, Sep 22, 2021 at 10:44:20AM +0300, Max Gurtovoy wrote:
> So for now, as mentioned, till we have some ib_ API, lets set it to 128.

Please just add the proper ib_ API, it should not be a whole lot of
work as we already do that calculation anyway for the R/W API setup.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
