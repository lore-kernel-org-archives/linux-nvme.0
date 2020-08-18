Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DA8C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:49:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC422076E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KNWYTNju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC422076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oR7M9vnf2q9gza6UI8rDPli76mqfWAjTPw72xGG3tfs=; b=KNWYTNjufAZk6rVWaE9hncHes
	f+QCGXVmtZiI1ao4t9K8e/5u+QbVxXx5cRQ8d5K29o7EkiNRh+NkkvuhR4cgTteA1CFvGslPUrrlq
	cRf0Jq5a6vBg7qytF55ChdUoJ3aouZJGPDLk6nEWiL3u9kq87wt2hH03C2VX4RfeLaa/I6g7wW8vP
	nx5bdmwr1ZFMsGil+Q9KO95CI8SDMr5OrehxOPKrP6kxoX2d6ghrmGJEVARFVaBe6kYp3dB88TcsE
	my9PkTNqSoXkT+ztleS9LqSqghqcc0j2TgtWnfQz0UNHqf91efdyyRpPVOE6XHGqxEFAFeqwvnsMh
	v2OWxUKaA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k87c0-0005p7-3u; Tue, 18 Aug 2020 19:49:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k87bx-0005oI-3b
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 19:49:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 79BEA68AFE; Tue, 18 Aug 2020 21:49:30 +0200 (CEST)
Date: Tue, 18 Aug 2020 21:49:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v7 1/6] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200818194930.GA31966@lst.de>
References: <20200818131227.37020-1-colyli@suse.de>
 <20200818131227.37020-2-colyli@suse.de> <20200818162404.GA27196@lst.de>
 <217ec0ec-3c5a-a8ed-27d9-c634f0b9a045@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <217ec0ec-3c5a-a8ed-27d9-c634f0b9a045@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_154933_294333_5F0D0E22 
X-CRM114-Status: GOOD (  13.44  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, stable@vger.kernel.org, ceph-devel@vger.kernel.org,
 open-iscsi@googlegroups.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 12:33:37AM +0800, Coly Li wrote:
> On 2020/8/19 00:24, Christoph Hellwig wrote:
> > I think we should go for something simple like this instead:
> 
> This idea is fine to me. Should a warning message be through here? IMHO
> the driver still sends an improper page in, fix it in silence is too
> kind or over nice to the buggy driver(s).

I don't think a warning is a good idea.  An API that does the right
thing underneath and doesn't require boiler plate code in most callers
is the right API.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
