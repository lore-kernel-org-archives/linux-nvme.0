Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B12C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3821A2075B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xdX3vz0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3821A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q+nK+keCLdTkJ2yFWhwJ3z+/3Q+j5gXQkmF3n6SNiJY=; b=xdX3vz0gXlxS8w5GjyjdnLRin
	WmLriCPd36zkloXITOjRkyHliSBwJLz0PSdIlYuNGJW844/HzlLj5wcjk4QE/1OcY5laG2WXA/78Q
	XrPFhz2sRwHVS/Qv5EIarCsWiS1UICZjalAu5OFJXxfgv4u9E4w6Z1oeevHH0KFJWkplqqIqGoj1B
	/4ydfbl8N88wrx0EEaB/KnWVxwFdxO/K/DJjqEfsj1kt+XLByqpS9hSsmN9AkWkiDwWDivlJUeBQ1
	CgEWA9aAC0Ama1GdOzqYbnLhwk4UHgnLGiGsVajDLpx/AzggTPBTzCeIu9ldwI/tQ/p62QPw/4Q0t
	uBy9zRKzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vnk-0001fY-FT; Tue, 18 Aug 2020 07:12:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vnf-0001c1-Nj
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 07:12:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A829068AFE; Tue, 18 Aug 2020 09:12:49 +0200 (CEST)
Date: Tue, 18 Aug 2020 09:12:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818071249.GB2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818052936.10995-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_031251_899544_A14615BC 
X-CRM114-Status: GOOD (  10.48  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 johannes.thumshirn@wdc.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Nitesh Shetty <nj.shetty@samsung.com>,
 kbusch@kernel.org, Javier Gonzalez <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> If drive does not support zone-append natively, enable emulation using
> regular write.
> Make emulated zone-append cmd write-lock the zone, preventing
> concurrent append/write on the same zone.

I really don't think we should add this.  ZNS and the Linux support
were all designed with Zone Append in mind, and then your company did
the nastiest possible move violating the normal NVMe procedures to make
it optional.  But that doesn't change the fact the Linux should keep
requiring it, especially with the amount of code added here and how it
hooks in the fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
