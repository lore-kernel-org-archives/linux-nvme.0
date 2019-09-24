Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D8EC432C2
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:13:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EF8214DA
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXZvmhJ2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv0wgsbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EF8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YMrEPbJqtLI5G+aEBlCvtYNBj4u21qeA4xrlbXr0Ktk=; b=ZXZvmhJ2mdB+EL
	Hc8Z5FTOW7l+Yx6vSeVg0MmMuWi/eqthInxNGlG01TI0KnYeHb5HgJ4XoGaBxByIkz8FeaLzunzCe
	NXsWYRP/mJ03b0P54sJ9dlsjmy8FIkkmh3KFh8VWPuZbMcwabtGLVaq6L4biL8Vmx99EXwEgVviZV
	eym3QOoHPOgozG71aDGxaTaLO1mdps29hO7TOo1aJMO9UXlPPNyL3ghdizIk84tv8K08cmpJEEJHN
	IKHsgXrOJDm8MqiDT2o4F52PaAXHiQD53jLVH0LQTWy5JyqKw4bnF7w25fKNIn8E1CCUnoo76+109
	gL4k5pBl7+7fIG64IwAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCpJ3-00036n-R5; Tue, 24 Sep 2019 18:12:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCpJ0-00034a-LQ
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 18:12:55 +0000
Received: from C02WT3WMHTD6.sdcorp.global.sandisk.com (rap-us.hgst.com
 [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A73A8214AF;
 Tue, 24 Sep 2019 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569348773;
 bh=uEGSj4Anda2bjfe31RjvP95KDrbHY86j43x8NjGSKJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dv0wgsbChYJIA7Gts3Ef8jdh2iJcrAGl4nbHevaigl7aCJ9QhluBAdoPv61s8pKsB
 6J41avP4T1PW4ruZF6UIYI33tJ+Vd/SavbS9ba+9Pc5sSF0rcVU3MnCLWcSLYhOa07
 nj2PIuzPkJzYG3hdoGi6v8EtOCndshEznrlTrK4Q=
Date: Tue, 24 Sep 2019 11:12:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 0/6] nvme: double reset prevention
Message-ID: <20190924181251.GA30811@C02WT3WMHTD6.sdcorp.global.sandisk.com>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <8cc6bc39-a060-3128-bf19-afb06a5c36ac@grimberg.me>
 <20190924150723.GA21929@C02WT3WMHTD6>
 <fc948ff2-b5db-506a-a516-766e0dde5c02@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc948ff2-b5db-506a-a516-766e0dde5c02@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_111254_726208_9BA1C499 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 24, 2019 at 11:07:53AM -0700, Sagi Grimberg wrote:
> 
> > > Keith,
> > > 
> > > The series looks fine to me, do you think we need more eyes on
> > > this or we should go ahead and apply this?
> > 
> > Sure, I think the series is okay as-is. It will clash with a fix from
> > Mario, though, so one of us will have to rebase.
> 
> Mario's patch is already on the nvme tree, care to respin?

Sure, I'll resend. Probably won't be able to get to it today, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
