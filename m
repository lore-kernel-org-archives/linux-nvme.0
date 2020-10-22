Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DC0C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:38:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84470222E9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="op5QsSBs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2UVHMfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84470222E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A5VgsmWyLHdpEIrWw+6wqwoyxq8d7mtOwsvBB5gWeQM=; b=op5QsSBsnFzYmhzWo39XcFWQZ
	NI76lNTvh6znefP35WUrhxPJHt/4iHYdLpcGoXuIXpbBSR4mA20NFHF+IZ1ymJwVHAfF5aUxgYydX
	q/Y3j54pwgf7EwkgIYTX4vedCS397aOGT2P36VuBWiho3IHGXpabAovqbpfxzIaHS7IeYflu1cLZT
	gdavlauVIA7Bxu87szqv662AHOfR3NMt6ZSTObCgqn9AalEFbAxzZDm1PGNcGf9bEKqbUf1ZESgo5
	SJgwY5tg38MDeZxiezzNeXgLRqtp5BTgxo0AX3hrCYw8NHifhxFO4On54G7S+zw9PMz51ZLAPE2i4
	YJuQ4STDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVanU-0002KE-RH; Thu, 22 Oct 2020 13:38:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVanT-0002JU-At
 for linux-nvme@merlin.infradead.org; Thu, 22 Oct 2020 13:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ZXrXXdhf0IAMJvCAxqPoe7q6NUOwxU439U9bffB082s=; b=D2UVHMfKznJsLIIOdtB1iZW8cL
 vFkzmIW57xJr1I7yWlzDQL/NzAmGM9UnI01SFFF3E0KVu7ei03IsjjbdQmFc+tvABgxe4lqEBP1G6
 h13qXe26mkEvpMjBbuCp1UVSE9YBIX5Q8IBs4FqtCKECnBbo+sSQNA/rdXNbXhMzjC2EavA9T7J5D
 vHpfUxvDFvp45pBkykVqsrxDqxOPdV9bwCfRBifxvJKVdhLgyc7H30Xh+F55uIX2t8S1J2qmN1BTb
 4GEDckTPosBgrfuu0YuPjK6Pahv0Vt3NBVM5jzrVo+n4chRT4Jhkyjna23NjuBKgx2dv8TYnH8WCr
 pil3latA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kVanS-00087T-GB; Thu, 22 Oct 2020 13:38:26 +0000
Date: Thu, 22 Oct 2020 14:38:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: soften messages logged by error_recovery
Message-ID: <20201022133826.GA31124@infradead.org>
References: <20200911200254.111005-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911200254.111005-1-james.smart@broadcom.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Both hunk fail to apply to the current tree.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
