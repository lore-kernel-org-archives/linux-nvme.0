Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D617C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:38:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E104461107
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E104461107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pxopW+FVg5EVHTevSyNdtQqIXx/FRONQryajbkr9PNw=; b=cXPqXD+em6UHjZf21sIQnQ+mY
	7sDVrAlBPQfiwuhSh91ikW14VBM4vw92MwTKd/GdtRrJHCT/DQDOGzXiCPD+oHqNUeFk8qE8FhGEk
	klEoTqLPTRzIk7MbkhBzJhbjM4qzBrIuGPc5OSjKNyJ+weceGavuTw7Z/jsSUb6WJLk27jX15nN4Q
	uFQ0VTj/5onCxMYuzGdR7M+93Qa8GICrVLcDSFpr0dT/aqzTgssEZyg+AeVle/cYWRNcJrouxqSRs
	Yh7kSpudvgSq13LSDMGS45Re2y/fgRQUEJImydaYK5rFkfc+5daJ6TezzjpDDIWHbJFQtgi1u/4oV
	quucVSkrg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmox-00Bn2d-CB; Tue, 20 Apr 2021 09:37:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmov-00Bn2B-54
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7fKP0vDBjQk4OnYDgzl2PodjNXUeNrujp40UPM+djkE=; b=4UgS2v06PlROulLZ0VaVA7auJe
 NvKtSxwBhZJ5qyLFnHB64ub5NL2jX8FS55tDDR5qpcPsNYPgMIBDOX/ZVkGdbTIiCy2RKLNecooSj
 94IzmMIOmCKmEiBelIqcM8C8Y0Q/KykW2YufVXUdMQltJp9HLKF34SEaQtaCCTCBlb9p2q4GOMrqk
 ZPaopaQknhw+zmvVSGcz7Y42i8dGdnrbjv3YoMuVKsq1oWqrkyVqdt7gjOa2DYtybdj6a4OJwkERr
 wMAoD0946KkTtgkcTNQywFgi9WKrkSdlOk8looKB+hvOqlBO3rBOS/SwMhjQ17Q8s/UUBJ9KcF6Ct
 cYa4JUDw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmos-00BzRC-MP
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:37:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CC71A68C4E; Tue, 20 Apr 2021 11:37:20 +0200 (CEST)
Date: Tue, 20 Apr 2021 11:37:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210420093720.GA28874@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_023722_894657_19874AE1 
X-CRM114-Status: GOOD (  11.66  )
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

> RHEL9 is coming, would really prefer that these changes land upstream
> rather than carry them within RHEL.

We've told from the very beginning that dm-multipth on nvme is not
a support configuration.  Red Hat decided to ignore that and live with the
pain.  Your major version change is a chance to fix this up on the Red Hat
side, not to resubmit bogus patches upstream.

In other words: please get your house in order NOW.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
