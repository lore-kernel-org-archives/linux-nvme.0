Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AFD61156
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 02:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6AFD61156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=//U5TU7ihO4nDmzt5qKsnd8rf+a47M9ypfICfv10inY=; b=gKE/nkvnjoxcPH
	ziCsDsw2+Njd9aVgfdSXmC1KCLabcc7zOZJwlTmPnQPV7BtuMmz4dpfLp3PpGV+QHBENfjK1UIA6m
	ugqpdCjr0fvUnki9klIuTL5W8vb+4M3r8OYaoyiLOmSkjQb7GCxQTa2sZbgTb8bKdStSbxg/5N63q
	VmcnsogiFz3JwlF3YFeFH30SI6prIXPgiAd4Xzi8amY1Jz5OePE3DJmLdyS7iNvOeyEKuozHKIffI
	4DfmuqQhO+OOCDFU2tBJD7OiPlKsZOtOVIti2WRwADjBaKEH1JwjjPbCiBUd51nyFpHFp9ZkiRH44
	5hrtz4q4S5bXfHvY248A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mV3L0-005PRz-8f; Tue, 28 Sep 2021 02:59:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV3Ky-005PRa-73
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 02:59:21 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3357061156;
 Tue, 28 Sep 2021 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632797959;
 bh=ZCqctSiAbGHQTJCx7tStnezzQHZS+2tZgMiwfi/MgE0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oE1BKgt6eOP767FGnkzr+f/yOwimI8b2fNrgwu7SuSt3Dvcby+Shx+7JBoCjV0LW3
 D6Or/myzTfzTKZxPJ7kxl0FoFdC3QbGQrQeMDS/XAWfy/Ys2I6Jn976RF2YeBAANAJ
 xGpTuk/bceeXO4UB8uXCpNWUra6cfmkKUmAaNN+OK9kQdChnzycQ+UazbAnyY4z6NQ
 7+npQUiStaTyVThFpM6iguYzmASCfXVP4paJVs/8q9nV2yLjhSBmZueDW9ScmOP1AD
 NuZrIEwOTv6YL28YBkukFpysB2nBllg1/M9h/fG+j8XRMW4GrjiQEvkwRdmEZrzuGx
 bDXHEXTHkT6xg==
Date: Mon, 27 Sep 2021 19:59:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Steven Seungcheol Lee <sc108.lee@gmail.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
Message-ID: <20210928025916.GA389836@dhcp-10-100-145-180.wdc.com>
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
 <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEwC4zKuXf-kwZmPrb1o7iGD4mqF_8zJ8n1PQ0KcohFAzg@mail.gmail.com>
 <20210928024307.GE387558@dhcp-10-100-145-180.wdc.com>
 <CAGrZSEw-YnoeJbt3_JQ6v81YWV6Lc3ao7eh8dNA0+aS8p7mWBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGrZSEw-YnoeJbt3_JQ6v81YWV6Lc3ao7eh8dNA0+aS8p7mWBw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_195920_292790_272AED1A 
X-CRM114-Status: GOOD (  11.05  )
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

On Tue, Sep 28, 2021 at 11:51:30AM +0900, Steven Seungcheol Lee wrote:
> I only mean lbaf, lbafe field.
> other than lbaf, lbafe fields are not used.
> I thought It would be nice to add other fields as well, since the
> structure will be changed with lbaf, lbafe.
> should I comment about other fields instead of just mentioning spec ?

The driver currently can't access the new elements, though, so what's
the point of defining them? If you want to enable these formats, then
this change needs to be part of a larger patch that properly enables the
feature.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
