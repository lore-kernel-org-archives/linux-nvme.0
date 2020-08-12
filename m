Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EE4C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC882080C
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NYonqr7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC882080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YNqbmj2+sBKmMET7GzaVQsppvCvBc5HdVSOHP1Wp1UI=; b=NYonqr7Akr6aduMDbtyhH7GZA
	2MA6gglpK+vNh6475QccPljDO6MgJ4XJKbeHTuDpqencWMXR8ksN2jW0TEARzN012F9IxoIBgjKjb
	HLLKN4KWRVBUcozS6ICRU9GYCjS2WSg2sFpQCpFv9FHTPPHufjo32MvNz/BPM+4qfSSMh4UKMxkQl
	F4Arf30AFxCqFVZSfwG0AL7CGWsYGm/Sk/4rmtND8WQfz3VkCQ9RYR5Op5BMlqEfLeMX8zZf4YGKd
	M3Lkn1v7OxShxJNIjAS3rQj7tQdi4+cIBVOwbmhlzN5SZ9i9U7aXoGK3Zl8ymS+LVf7/Yn411twMB
	nNVnCD7Fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5sRl-0000IN-Uv; Wed, 12 Aug 2020 15:13:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5sRj-0000Hy-LE
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 15:13:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E3086736F; Wed, 12 Aug 2020 17:13:41 +0200 (CEST)
Date: Wed, 12 Aug 2020 17:13:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 3/3] nvme-core: delete the dependency on
 REQ_FAILFAST_TRANSPORT
Message-ID: <20200812151340.GC29544@lst.de>
References: <20200812081855.22277-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812081855.22277-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_111343_822357_6BE68127 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2020 at 04:18:55PM +0800, Chao Leng wrote:
> REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
> do not difine the local retry mechanism. SCSI implements a fuzzy local
> retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
> software, if work with multipath software, ultraPath determines
> whether to retry and how to retry.
> 
> Nvme is different with scsi about this. It define local retry mechanism
> and path error code, so nvme should retry local for non path error.
> If path related error, whether to retry and how to retry is still
> determined by ultraPath. REQ_FAILFAST_TRANSPORT just for non nvme
> multipath software(like dm-multipath), but we do not need return an
> error for REQ_FAILFAST_TRANSPORT first, because we need retry local
> for non path error first.

This doesn't look wrong, but these kinds of changes really need to
go along with block layer documentation of the intended uses of the
flags.  In fact the SCSI usage also looks really confused to me and at
very least needs better documentation if not changes.  So I think
you need to do a lot code archaeology, ping the authors and current
maintainers and sort this out as well.

More importantly if the above explanation makes sense we really need
to kill blk_noretry_request off entirely and replace it with a check
of the right set of flags in each caller as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
