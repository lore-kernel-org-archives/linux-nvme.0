Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A154DC10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2362067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UskX8Wxu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2362067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eAUZjxwzB7MizCFpnGfd35Cnx0EBrDG0TCiZZYYM4Gc=; b=UskX8WxutNzKx1x5Xko6Pekbp
	7Ca4AknCstdw1n2B1oKPiA4WTmc7OGidrlOIoWnv5nlAvdPWLeDd7butYWozBQtSS2S4ZBWNR5R7r
	Zy3zyshPQl9N+Uy11Vf8qU5n6//rMdtnu4k5TCmZBFb/Cs0KF394OvAwAPE+jqBP0qxQlV4n/2Xaf
	jWT6gk0h8tH0RKBstl5IO26gmBceC4811MAvbAn8qMvYQF1f4QRmIKcbqflz53CO3RAW7W+O9zWuk
	ruI+Z0zoxFkaG4RQu3MxU4A0dfTUjO6FzvYbarPjHH0bTMvxKEMxis0VgF/HRGXEm1N9OcxEzd6FK
	MrH+U81cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIbw3-0004MV-HU; Thu, 10 Oct 2019 17:09:07 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIbw0-0004Lj-Kn
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 17:09:05 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 10:09:03 -0700
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="188031188"
Received: from unknown (HELO [10.232.112.84]) ([10.232.112.84])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 10 Oct 2019 10:09:02 -0700
Subject: Re: [PATCHv4 0/5] nvme: double reset prevention
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20191010165736.12081-1-kbusch@kernel.org>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <9490c89d-f70d-8333-1cf2-3bdc0071af6b@intel.com>
Date: Thu, 10 Oct 2019 11:09:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010165736.12081-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_100904_725574_08D4C70E 
X-CRM114-Status: GOOD (  14.34  )
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

nvme_queue_reset()
nvme_atomic_reset()
nvme_queue_atomic_reset()

Ed


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
