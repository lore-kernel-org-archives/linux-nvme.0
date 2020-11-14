Return-Path: <SRS0=SkPw=EU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332BC61DD8
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 09:06:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2B72068D
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2020 09:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jcW61hnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2B72068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8vINVqwDME4l6NoEctvBXbBiAKyVeUn+zeDzhzYVClA=; b=jcW61hnkIv+P+Kv0ZR0VgNzlM
	6X+Dq74ys7ihnwDdS9ni7H6MKcBfow4YcHvDWKm/gEdXt/gjCUiM9PgHPUeFB41/GcCcT4hXekDLW
	TcjN6ovtkoX2bgZ4nFFoHlisbUfJEOkiwwgNqXYYnT1l/XW2FhN6Q2awNdbjkxj8+3Rol0MvopTNz
	7mbYR27w5b69NZTLLbl+xh5bXvHdaqW/cuSgLbGRUBFrBraUY76xOYwQ46XSMpfB1OWlSL13h8pAV
	ESgHQGKcunlI3uFi0+HBPjqpJUq/2S6TYVp5z1vUx4QckjGHTXn3TmN5bOr6rwY2j6pAdBMyqfZEr
	529XEngtQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kdrW3-0004HT-7C; Sat, 14 Nov 2020 09:06:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdrW1-0004H1-Fr
 for linux-nvme@lists.infradead.org; Sat, 14 Nov 2020 09:06:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1FCC267373; Sat, 14 Nov 2020 10:06:35 +0100 (CET)
Date: Sat, 14 Nov 2020 10:06:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 1/2] nvme-pci: drop min() from nr_io_queues assignment
Message-ID: <20201114090634.GD18301@lst.de>
References: <20201112082302.82441-1-schnelle@linux.ibm.com>
 <20201112082302.82441-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201112082302.82441-2-schnelle@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201114_040637_686382_A75702CF 
X-CRM114-Status: UNSURE (   7.12  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied both patches to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
