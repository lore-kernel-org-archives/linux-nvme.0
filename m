Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D84C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:35:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4BA61107
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4BA61107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JM2UMrgOSX52HMDbe1/OB47cMDtiEMvE1CO5E1zuGvM=; b=MibqjQz566A198qgP1+LZv4/u
	Lg9TwScQ3ck9IXmz3+dtAZM9jyMo8T7FBdRZBPZ6SAQn1i2IaS9klIQQgMnCjw/sbdQ8/5cpizzCM
	pbtASeXkEfxCIhH8lB9m1RiJ4D3ihSxO4t31EQnjopZEE6y0UisOF41rI26PsDV16qWUzgYjR4ION
	T+iaqgPlFoGJaLJO5+O4L/Xbmo6JA+yrhzevJJ4PRVKnho8DcnLWXIT3se8YjcN3vUEZI6fN+FbEs
	LzsKJi/9NfcrVAeGvpvd1NQyEBXmSSFEfmDMG/JC5blJoKL2dqZJC9WZKQLU2bvVAsf5nubOH+r3P
	ggdr/A/NA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYmmb-00BmWe-Q9; Tue, 20 Apr 2021 09:35:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmmY-00BmVs-IO
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:34:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zqPHR4qoP/PPalQhYYIzxb/IJJ0tLTl2H4ZYmo7b9fU=; b=ncFFvhIWbVwoqDU9lx1uJNAlU4
 OS+I9saxu2M48gl5RtJOI1L1t0FLfPxdR1h45ubZIVLELQ1H5PvpSBgOBDUrwTqiRf/GEMyzkc5TY
 95JstAA24LvUM9ixv2Yy1Nbe92D/679AAtXEUHJGtrDsJaqi/bnlFsCzyqLzaYIBS2rjDI+eKWaNL
 ZDkHxwYV98GFzF9KRXF+NsyihlapfOX7Gzok8SE03TWQsp0YkHs0c7e1QYVdd0hfWb7rKrhUJHsTr
 DahzVfUy9+xOFNVzvZ/ymY9HeR1chuoKMSOlCtN3QIkqlniWIUF02TofE7W0ouWtiHqfX7FvPXj30
 bSaMYfUw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYmmW-00BzFy-1m
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:34:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2574768C4E; Tue, 20 Apr 2021 11:34:54 +0200 (CEST)
Date: Tue, 20 Apr 2021 11:34:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read
 support from native multipathing
Message-ID: <20210420093453.GB28625@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210416235329.49234-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-4-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_023456_263499_6E28F2AC 
X-CRM114-Status: GOOD (  12.39  )
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

On Fri, Apr 16, 2021 at 07:53:29PM -0400, Mike Snitzer wrote:
> Whether or not ANA is present is a choice of the target implementation;
> the host (and whether it supports multipathing) has _zero_ influence on
> this. If the target declares a path as 'inaccessible' the path _is_
> inaccessible to the host. As such, ANA support should be functional
> even if native multipathing is not.

NAK.  nvme-multipathing is the only supported option for subsystems with
multiple controllers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
