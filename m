Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2058C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:09:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F8F20781
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DICqMKW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F8F20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HPZgMkGcbISQ+BCWCHaIHYj7x/mpAEIcR57l94e8T6o=; b=DICqMKW1PJJ6yr/92bP3z/nXc
	w97GQkb1kUYRdOf1nc+sokmgOPu9r6zERBziVhCTEjY9JTDgnSWFaO9ktUx0v3yIEZ9WSANtqXR1c
	1CezYbPCdEbKFzSjPbv2E7Qp9jkWz1rsaP26Lm3CEbpLhtpJnV7NA+HmNi891xRk77+v7PYPqPiBB
	lYxm+QOIrDJex63rf2skaN3/hYssTgObfijcvQMakpaHkvQVtuKwuBVWA21GnvHjIg8EVImCFN2MR
	Ohxdhbd0HhmbOQd0TnVuTC3Edg/gmuiXPA6x1NmepdlU0YqZZn/Q6Kxx3PGRWTJ9b8Y49/kCtsrej
	88K5hEhRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5sNx-0008RJ-Pr; Wed, 12 Aug 2020 15:09:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5sNu-0008Qd-Tk
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 15:09:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A9996736F; Wed, 12 Aug 2020 17:09:39 +0200 (CEST)
Date: Wed, 12 Aug 2020 17:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 1/3] nvme-core: fix io interrupt caused by non path error
Message-ID: <20200812150939.GA29544@lst.de>
References: <20200812081837.22144-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812081837.22144-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_110947_074000_0D832419 
X-CRM114-Status: GOOD (  12.29  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12, 2020 at 04:18:37PM +0800, Chao Leng wrote:
> For nvme multipath configured, just fail over to retry IO for path error,
> but maybe blk_queue_dying return true, IO can not be retry at current
> path, thus IO will interrupted.
> 
> For nvme multipath configured, blk_queue_dying and path error both need
> fail over to retry. We need check whether path-related errors first, and
> then retry local or fail over to retry.

Err, no.  None of this really makes any sense.  The existing code
actually works perfectly well unless you really insist on trying to
use a completley unsupported multipathing configuration.  I would
storngly recommend to not use dm-multipath with nvme, but if you
insist please fix your problems without impacting the fully supported
native path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
