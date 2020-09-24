Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB671C4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113A521707
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxCXEEpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113A521707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=98YneCqxRFae4pd77Ly0IuxfH1B+WU1AEWAL4m2yRw0=; b=DxCXEEpU1QRD0RnbMWBKtLijk
	rUXF++KiX0N/40FbfHRfDWCpveDpQFhD8b0IWjNJKTDvFVbAL7dFBD4VnL/6umMVSntTBFegcw0vS
	VwYCuiJdNG2rl0ewZHiY0AhvypTcbdevkaZIe42dJxRfXAkYBgl3s6rpXw5laUA6pN3V/ndC31btc
	0DujLGLuVhi4G4/nikYVRVc4AFU9zbgiXoF26Vgi+xIIOkEa33pelEkYWl5mwI6vZSW9ywLGimlo7
	TqCqk83s9XNQPK3Hijx9NPdZzdqTlopDNGqwgEl1iDv1FMsuUIRAzB8UsTwyZMhfgx+kqJ3t3fw/S
	alGoqQspQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLXSz-0006ph-3v; Thu, 24 Sep 2020 20:03:45 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLXSw-0006p4-0c
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 20:03:42 +0000
IronPort-SDR: 4FN8drZMDPQJJVYcHJGeo4twvXDXorQGiho9nLcJ7c1WhYXVDyeWJImp4SFuEJBDRx/UFfjid7
 jGG3Y4eYsj2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="161401859"
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="161401859"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 13:03:35 -0700
IronPort-SDR: rE7k9Y2C1CZ+onZsdxfwq3rMXOIxI0PfazBZOvmV8AIsKeex9TwCiMByFH1VnIxlAbirefXbiN
 BXma1uP5kcPQ==
X-IronPort-AV: E=Sophos;i="5.77,299,1596524400"; d="scan'208";a="336143599"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 13:03:35 -0700
Date: Thu, 24 Sep 2020 13:03:34 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209149] New:
 "iommu/vt-d: Enable PCI ACS for platform opt in hint" makes NVMe config
 space not accessible after S3]
Message-ID: <20200924200334.GC86064@otc-nc-03>
References: <20200923160327.GA2267374@bjorn-Precision-5520>
 <20200923161944.GA17764@otc-nc-03>
 <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6HkPBXeRnzeK9TdBSkJOPx=Q775065RRqeaa3XWajuZQw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_160342_200479_663EEF58 
X-CRM114-Status: GOOD (  22.39  )
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
 linux-pci <linux-pci@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 23, 2020 at 12:45:11PM -0700, Rajat Jain wrote:
> On Wed, Sep 23, 2020 at 9:19 AM Raj, Ashok <ashok.raj@intel.com> wrote:
> >
> > Hi Bjorn
> >
> >
> > On Wed, Sep 23, 2020 at 11:03:27AM -0500, Bjorn Helgaas wrote:
> > > [+cc IOMMU and NVMe folks]
> > >
> > > Sorry, I forgot to forward this to linux-pci when it was first
> > > reported.
> > >
> > > Apparently this happens with v5.9-rc3, and may be related to
> > > 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint"),
> > > which appeared in v5.8-rc3.
> > >
> > > There are several dmesg logs and proposed patches in the bugzilla, but
> > > no analysis yet of what the problem is.  From the first dmesg
> > > attachment (https://bugzilla.kernel.org/attachment.cgi?id=292327):
> >
> > We have been investigating this internally as well. It appears maybe the
> > specupdate for Cometlake is missing the errata documention. The offsets
> > were wrong in some of them, and if its the same issue its likely cause.
> 
> Can you please also confirm if errata applies to Tigerlake ?
> 

We confirmed ICL/TGL isn't affected.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
