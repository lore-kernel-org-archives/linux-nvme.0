Return-Path: <SRS0=FTT0=YE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06064C47404
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 15:59:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62642089F
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 15:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hnXnRtx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62642089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YaRhCcKDNTzpohn+BsSsNfrtAwkCJ817J6sw1hAscx0=; b=hnXnRtx9dVb4k//pltMMF4Vp7
	gBufUjPBM77wLtS8F4nGLNFrZ9/SeekgPRPUgEN9QCWtZ5IO1lqZdvhakSQzehzscmPZhGINVc4Gv
	y74LuUgpSi9B1Ybs6MkZDoAxYmb7LFMEwnHfjkG79fGP4GdVbi0uAQuxRAND0ETKkZZGrC6OtFXkR
	rM7/vlVRQ/VUwImucs4WPYXVbphNSBp+Njx/WOja/rpPKlBekdKTLfoVa6hHtKGiUXwNoTEDPcvML
	DZo21emmdpOFm3eaoQm37ewnWko9GxPKPheM5WfiJFv3ymwVxBNk8F1zaAOSw3eG5hvLnYqbTReXg
	Mq/k5d75Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIxJj-0004rc-5z; Fri, 11 Oct 2019 15:58:59 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIxJf-0004r1-QR
 for linux-nvme@lists.infradead.org; Fri, 11 Oct 2019 15:58:57 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Oct 2019 08:58:54 -0700
X-IronPort-AV: E=Sophos;i="5.67,284,1566889200"; d="scan'208";a="188357229"
Received: from unknown (HELO [10.232.112.84]) ([10.232.112.84])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 11 Oct 2019 08:58:53 -0700
Subject: Re: [PATCHv4 0/5] nvme: double reset prevention
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20191010165736.12081-1-kbusch@kernel.org>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <12fd3758-ff71-c02d-1545-5ce8189c2c59@intel.com>
Date: Fri, 11 Oct 2019 09:58:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010165736.12081-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191011_085855_871888_107BCC46 
X-CRM114-Status: GOOD (  16.41  )
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
Cc: Judy Brock <judy.brock@samsung.com>, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/10/2019 10:57 AM, Keith Busch wrote:
> The main objective of this series is to prevent double resets. This sort
> of thing is known to have happened if a timeout occurs at roughly the
> same time as a user intiated reset, like through through PCIe's FLR.
> 
> The double reset could happen because the controller disabling had been
> occuring outside of the RESETTING state when we can't schedule the
> reset_work, which is to occur later. When another reset schedules in
> between these events, the controller ends up in the wrong state.
> 
> The end result of this series is simply to block subsequent resets by
> initializing the controller state to RESETTING without actually scheduling
> the reset_work.
> 
> v3 -> v4:
> 
>    Renamed nvme_reset_schedule() to nvme_try_sched_reset_work() and
>    documented when it may fail (hot remove). I'm open to suggestions for
>    a better name.
> 
> Keith Busch (5):
>    nvme-pci: Free tagset if no IO queues
>    nvme: Remove ADMIN_ONLY state
>    nvme: Restart request timers in resetting state
>    nvme: Prevent resets during paused controller state
>    nvme: Wait for reset state when required
> 
>   drivers/nvme/host/core.c    | 91 +++++++++++++++++++++++++++----------
>   drivers/nvme/host/fabrics.h |  3 +-
>   drivers/nvme/host/nvme.h    |  5 +-
>   drivers/nvme/host/pci.c     | 78 ++++++++++++++++++-------------
>   drivers/nvme/host/rdma.c    |  8 ++++
>   drivers/nvme/host/tcp.c     |  8 ++++
>   6 files changed, 134 insertions(+), 59 deletions(-)
> 

Tested-by: Edmund Nadolski <edmund.nadolski@intel.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
