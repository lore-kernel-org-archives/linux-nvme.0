Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C47C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B4A64EE2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4A64EE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nTiN0w/hy8larKSNTjbNGy6QJ2h+fyPYppuEeb6IC00=; b=NDh0W+z8XzLeIF9+orEbuNuMuy
	D+yITQF9vf0BFNM9HCgoUapyg2fl7uUPRe1SFXFoLdr/VJd2YHCBsrM79bng27rmx1xjqJ56XVtZX
	YUDFQPSCQ1LAC8oHPXD9Umtxa1fWpa2SLlBzyS7wgJFQgp5RSrBbCxsvrYeLH3WntbDy7oMoR8zDW
	9ZPrhCm8GmartEFWDFfluMadS6LS1g37i8kc3hfeT8nKi9OiebAac9uY8vJlwGJcZ1hLTxBMk0rCm
	X4Ww0seEjUQEyapoRj5a6Mj1rrmyvFCVyznd4MzjbeL59bapis5eDY4f4JuEL5TbGkJx0ahR37XBK
	yW3gfAFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kL0-00083f-SA; Thu, 04 Feb 2021 19:30:46 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kKy-000831-H8
 for linux-nvme@merlin.infradead.org; Thu, 04 Feb 2021 19:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=W3wFYsuZo6rSbhnnadXYaNkhzPsYyX2m1sRxVxahG9U=; b=E++kGEeqIJz3+hZ9yh5cr8M1pj
 q0Nvqj9CTHQMMIXKAfqyT/fwW297FPCO9iOdB8E929HxMmrKkx46nrw+R1eq9JVlNkVyTy+8WwmaP
 SysBghteURvf7WHb/szvMvRm4ncmdXTYobo0eHAxjeQTaUHYD5v072Fo/IMEbzjdwQaSV2QyaHz11
 bQ3NINsMd/NiN1z3ukhhZXJjJU4FpMjiTpD+QBGG7AjzPbU++ZfK9Jjjo9EI4IRgcgiapjoU1PDa+
 moXldjbQLlU6ys0Pdcl6s5/0c+qo1G3/SBdyf8dCxdRjxzO+bqoYPe80NYadKJzGCTo4Od8qYVsPq
 HxTe/VoQ==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kKt-001Jh1-33; Thu, 04 Feb 2021 19:30:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: preserve DMA offsets when using swiotlb 
Date: Thu,  4 Feb 2021 20:30:27 +0100
Message-Id: <20210204193035.2606838-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, erdemaktas@google.com, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series make NVMe happy when running with swiotlb.  This caters
towards to completely broken NVMe controllers that ignore the
specification (hello to the biggest cloud provider on the planet!),
to crappy SOC that have addressing limitations, or "secure"
virtualization that force bounce buffering to enhance the user
experience.  Or in other words, no one sane should hit it, but
people do.

It is basically a respin of the

    "SWIOTLB: Preserve swiotlb map offset when needed."

series from Jianxiong Gao.  It complete rewrites the swiotlb part so that
the offset really is preserved and not just the offset into the swiotlb
slot, and to do so it grew half a dozen patches to refactor the swiotlb
so that a mere mortal like me could actually understand it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
