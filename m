Return-Path: <SRS0=lXTb=XH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D68C49ED9
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 08:20:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08D3F20650
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2019 08:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQooiji1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D3F20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ybfPPoA+D6DNZ6Jaq0sgsVfA27XF/n7boEShbxCz2w8=; b=bQooiji10Nqnss
	10fCxoTHQ9ttonrD9IJR9u/n7hCj240O5KyY0c698UywSW8bF67z8hmRpxhQSVR3jTZzz/WLkpke9
	JMJdzE6Si4RIOvhwqXUywyWLeU+L7ErLZNz7IZwoP6LMzXa1NhC4VCRvNqDsyDuRhsLUYRE13ET/w
	UzC9JGa75Zgps71aSCv4uBxuUpaqYn9031N6h8uSdnDfofcVo5XdYtzUrAO2+5dX+QQBU3z/EQd08
	Jk7nsU6JFhW25ks3LdwVFaU19dyn0TcJOIZ6Z5/CPmu1OPyimu29AsUFV8m1jvfi1CvncJB2yI5GR
	q9h25wjtAP42//WcRG+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8KKv-0001vR-0h; Thu, 12 Sep 2019 08:20:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8KKr-0001us-C4
 for linux-nvme@lists.infradead.org; Thu, 12 Sep 2019 08:20:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EDB0B227A81; Thu, 12 Sep 2019 10:20:08 +0200 (CEST)
Date: Thu, 12 Sep 2019 10:20:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 10/15] nvme-pci: do not build a scatterlist to map metadata
Message-ID: <20190912082008.GC14283@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-11-hch@lst.de> <20190828092057.GA15524@ming.t460p>
 <20190912010256.GB2731@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190912010256.GB2731@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190912_012013_563780_C60AE6F4 
X-CRM114-Status: UNSURE (   5.36  )
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
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Gopal Tiwari <gtiwari@redhat.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, dmilburn@redhat.com, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is in my todo queue, which is big..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
