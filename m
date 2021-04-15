Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D63C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B92D6124B
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B92D6124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=A3Ix5p66KFQUxsg77lyRpEnSb
	TlinzlJ9qe0g0kqWC6+tHaw9cnkGs5baXkfLcHicFg4RQNsnxRxqAj2YE5KxRlprj5qG4FLpc+2uD
	0le3B/fdJIdtKsAO+KaVr2dohp1Cl6JuwNOGutQMVRDW+R6K/7FuaUBNhGZTRyJkri3ARs4PL81S0
	MpWvW8U+754floDttcgXt5XY4eM9JQbssqKvEcjhvfgiHsvsFXhlA3oh93EqrwP+Nc1+YGywP8Sdr
	7CwGTA9X6L6WEbvnycQuUjIGDQP/p/gNFznzXG97U4o9Qg6YAwh3hIOxZ84W/5P6FiZ8SbO94r32K
	+w4QnYVWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWwtH-00FIKn-B3; Thu, 15 Apr 2021 07:58:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWwtB-00FIKV-UE
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 07:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=rRKWltxKHXlHEXE3FWPHaepcNR
 diGOHsYr4JvuNtYoSBf+XkO5pUWSiSs7hm9x7M8vVmB/rSuNLA9iLQD02DSu8ZXUI2ppqu6kjgzbN
 4oAhpVhCiUyat6RrSpe891p18s+Foupzj+R3gaTq1orhEeq6NASgRn8+LGw1FaeqrrjysEYdvGq6N
 lZ2DtrPTe0LYzpEOfOxAf0vQNmgnDSKj1XhFI22QBMc9L+KoF0UtdbBaYJSxd/OwSPZ1yanF9tLqu
 8/cr+dSIBbAF6J/ilrQ/5GZSTCq7oTzv2vIXSeNIIMErS1yOuJljSyK3NvR4fuLjzAtb7B4iRQIml
 DGsXPlWg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWwsr-008GA4-4v; Thu, 15 Apr 2021 07:57:57 +0000
Date: Thu, 15 Apr 2021 08:57:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gopal Tiwari <gtiwari@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH] Fix NULL derefence in
 nvme_ctrl_fast_io_fail_tmo_show/store
Message-ID: <20210415075753.GB1968645@infradead.org>
References: <20210414084645.638150-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210414084645.638150-1-gtiwari@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
