Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44797C4727D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B1E20719
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DbJ37vNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B1E20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bkMMhgw2tqFNtsgjxZ8/Dd56J7qjWj+dvfXewyWLq7I=; b=DbJ37vNxNPxLSD2GvJyc/u7ky
	LC8/GOLZE6jyG2JFvheaN8ZqXnyHHRgFz+ZjkG/UkYuQum4Sb9PckadnEr1txUC6saa3QofBdcRQk
	eWrn7KDO0CJAJIEIwBGFQSyL/CTZhe6HmYT8aYeXJtnA/zN+14VPxR8BGThbpY8tKOvYeeEtQgEks
	okOH4MsibEXFb/yHfV/4wtF0qYsJdm8elAhD1WIrmjXDwk82b8A4hahUqueejAto5h5J0GRhTXucX
	kw74k0wiLRa98mq7jJM/0f0W/hIo8bc7yk9Zfoub9BKtzk9cqn+1gsAqR/Ynq+JHS1bZ3GVfzuKZo
	RhbjO64Ig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL7Um-0003D1-Pp; Wed, 23 Sep 2020 16:19:52 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL7Uk-0003B4-3G
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:19:51 +0000
IronPort-SDR: 9gT+lkzBBrQCBCqIXbrZoAD95nu8i26Lb4/qxdcYYxinA/svf3Lxs1zeCamm9v6TRJiXZyJoSg
 xk+mT6ldBhZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225073981"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="225073981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 09:19:45 -0700
IronPort-SDR: n84VaKhwCX5sjOasLfcX9sZZSHECuBqTrA0blMYILMmYzE0Pj4T36LW9qYLGnfatmwHQT9Y+ru
 ISUKaQw7HwbA==
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="486496324"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 09:19:45 -0700
Date: Wed, 23 Sep 2020 09:19:44 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200923161944.GA17764@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923160327.GA2267374@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_121950_271253_66390B3B 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Joerg Roedel <jroedel@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Bjorn


On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> [+cc IOMMU and NVMe folks]
> 
> Sorry, I forgot to forward this to linux-pci when it was first
> reported.
> 
> Apparently this happens with v5.9-rc3, and may be related to
> 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> which appeared in v5.8-rc3.
> 
> There are several dmesg logs and proposed patches in the bugzilla, but
> no analysis yet of what the problem is.  From the first dmesg
> attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):

We have been investigating this internally as well. It appears maybe the
specupdate for Cometlake is missing the errata documention. The offsets
were wrong in some of them, and if its the same issue its likely cause. 

Will nudge the hw folks to hunt that down :-(.

Cheers,
Ashok

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
