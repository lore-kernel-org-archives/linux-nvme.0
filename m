Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FBC4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6165A2396E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ez/7hQpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6165A2396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AGZFWaZeYDBDk7Q3QXXOtI6pGuNLgSLp1YxrreVv450=; b=ez/7hQpQXEgLfgyLro9tiym3n
	Tw6krgY52JIHMQynJSgnd8pCMgyZC6cl24SELO410s1SJvOBXBppMvi0qyQMr+VP//S0XJg516tAu
	4NMKnm3OLb7aWCQ4VpwYVwBXttBN4XwQnsW0RBZ9Fr4qR4cmKW9IdkvYfal6eLVYn1T2nvwlamfT8
	qhevGh5bvcYAmQmxzuu2+19t4nRfPUjaYkG5bt+J24yO0sG7DrSdQH3h95pKNh6D/lrVLDrNslTHz
	gZw0C73Q1fRD7H4aPESD9n1UysIRToQ3+Ofvyyl1VnqxSL2HMCc3DkdU8HHcjUAeBhIMI2+a7uTIZ
	V87OfpFYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLXAg-0005Pw-61; Thu, 24 Sep 2020 19:44:50 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLXAd-0005P8-Lw
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 19:44:48 +0000
IronPort-SDR: YyM7l6a6+e62yqqHzy8dnXQt4rOfTqRCGGh6TYGvP8hOJng44QDR/PsJs5Ep9UAmTxm6wK6PQw
 x7sQ6888oTBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141336247"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="141336247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:40 -0700
IronPort-SDR: 9E8u/g9+DJXqEJYEfe6YY2wPeNd83X3hmTGz1kbJ1RGdoDRCGp/cSFwecSPWI8ZisEm4oNTPlV
 H9TNfuoxnwHA==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="291360614"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 12:44:39 -0700
Date: Thu, 24 Sep 2020 12:44:37 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924194437.GA85997@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <6CD003F6-DDF4-4C57-AD9E-79C8AB5C01BF@canonical.com>
 <20200924180905.GB85236@otc-nc-03>
 <20200924133938.6b93732f@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200924133938.6b93732f@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_154447_864711_292EEF37 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: Joerg Roedel <jroedel@suse.de>, "Jechlitschek,
 Christoph" <christoph.jechlitschek@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 iommu@lists.linux-foundation.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Rajat Jain <rajatja@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Ashok Raj <ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Alex

> > Apparently it also requires to disable RR, and I'm not able to confirm if
> > CML requires that as well. 
> > 
> > pci_quirk_disable_intel_spt_pch_acs_redir() also seems to consult the same
> > table, so i'm not sure why we need the other patch in bugzilla is required.
> 
> If we're talking about the Intel bug where PCH root ports implement
> the ACS capability and control registers as dword rather than word
> registers, then how is ACS getting enabled in order to generate an ACS
> violation?  The standard ACS code would write to the control register
> word at offset 6, which is still the read-only capability register on
> those devices.  Thanks,


Right... Maybe we need header log to figure out what exatly is happening. 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
