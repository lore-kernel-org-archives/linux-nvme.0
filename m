Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E8C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:37:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516D4206A4
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 10:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bfsfr/5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516D4206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nBYXeZRVfh6ncuSkIkXhsFB+HQiYYc/kveoSdhBqb9s=; b=Bfsfr/5/ESraLrN3CkTC6nSyx
	W3iXstAWBHi9LuszyDnA0sHDEjxjpJNzSSEX+s45gS5e0AyI1q5KX4v83fsFiufoe37RlID2oOUjJ
	Caqb7tmrFHPLIDlBuzBX9fSjQsWB0K25Vi/Z3SO578lG6sTvdv5aR84YvbiSUvJgsKOgrQoEacmNx
	mae8yacbAySOJCQiuOj37Q+ta0yf4R4qx9Ssgu0RbpgdcX/PKg/5pHbboLcF143ZcHmXFkPF6RPPM
	imZSsWdHY4YpIidI1kUQVZ+0VpMXSAP3WwBXKHOV0XnkJFlr9ZDH8WhvM0RCOLyu3bjt29vWk/utl
	Q34c745ZA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6X5s-0004vp-3E; Fri, 14 Aug 2020 10:37:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6X5p-0004vR-HH
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 10:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D24E968C4E; Fri, 14 Aug 2020 12:37:47 +0200 (CEST)
Date: Fri, 14 Aug 2020 12:37:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 09/14] nvmet: based on passthru req control use REQ_FUA
Message-ID: <20200814103747.GC20513@lst.de>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-10-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810185456.7713-10-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_063749_711230_EEF7437E 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 11:54:51AM -0700, Chaitanya Kulkarni wrote:
> The write request for passthru driver currently does not consider
> nvme control field which could be set in the nvme_rw_command from host
> side.
> 
> Update op_flags with REQ_FUA when control field flag is set to
> NVME_RW_FUA.

REQ_FUA has no meaning for REQ_OP_DRV*

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
