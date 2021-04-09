Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59492C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:49:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94B86115B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 09:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B86115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/DKWC7W74WcT52pgNJqJAAvQm97+Glmvb5c5Q9ZEDjo=; b=RmrnIEkuIxeinLLiscrtbu4z1
	wfrtbPqcdQWG8rFBTznITffS9XezNPnmxMDWsemFpeDGuMAxn6ti5S8B21hfQDIscjLJJGfPzJbhj
	P6b2B8ktNjpOZPA0HhwMPoJyw1i8mC/FyH/x0H7ELTPDoo+0YoBBCydyDati5iNc4A0Lhrr49ZlMX
	A8SMRYnOZ9fXkTP+DfuDrKNYjRT9kBDRHzJZy2GtI+zlHQHkHIdVJMuQIOxo3hyPPOXitvWzwsfkd
	M/DtSCMvzY4OcD1Q6OKFwYj45QwzUKmDL55YcZtH8vNfJnSzTGYNZIrQPSFRunUVP2hLipOr5Prv1
	1rhkJZwVA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUnlb-000JbI-VQ; Fri, 09 Apr 2021 09:49:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUnlY-000JZL-0D
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 09:49:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6CFDA68B02; Fri,  9 Apr 2021 11:49:25 +0200 (CEST)
Date: Fri, 9 Apr 2021 11:49:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Message-ID: <20210409094925.GA15760@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-10-hch@lst.de>
 <CA+1E3rJU_WT9f2Gzdk66kho+5h2h-gkmrq8SpsvO-Oz073Y6vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rJU_WT9f2Gzdk66kho+5h2h-gkmrq8SpsvO-Oz073Y6vQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_104928_922650_7DB519EC 
X-CRM114-Status: UNSURE (   9.39  )
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

On Fri, Apr 09, 2021 at 02:48:20PM +0530, Kanchan Joshi wrote:
> This new helper needs to be added inside nvme_find_ns_head() as well?

Yes, good idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
