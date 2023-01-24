Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A88C25B4E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yqBFIF068+kffBkaLOugZH9XMX+oLUjZ+LM48wXSoSQ=; b=gXLKhLkCKs85EOGsaRs6eAusOJ
	0+CpMXgs0zxw/VefTAZGqr0NbBVowRrY1geT4tq/ZxzNaL9pkAeQ8wM+994OtzJ6Sa0N4DX7+R96+
	Pi/0SogdKzIkIywI3UIaa3LwIh7UQ4ZOzZ5gtTeh8Fs49BrikNROp8ji5sbuYPmK5SCGEFC6ubhHJ
	XbgmQ4izhsPq3erRM45VfeCbb4B1rYraVPNDSzmc6PtT3m9A+nFwDZDGUHamjC+h37BF4xrFVmsl/
	07MrMb51SXuwSDIXBe7JyJXKWTwPmg4soAP7v2Sk2L4cAthMJCL4rthf1LEmoYVJE1HhlqpAc9QS6
	Qp8OAVvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMqY-004mTf-U1; Tue, 24 Jan 2023 17:12:34 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMqV-004mSq-C3
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 17:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674580351; x=1706116351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5yPOhR33/JIDVjameyM+yo/GB3/87AUyw8nkj/3xylk=;
  b=llBQht6FsDcncl8aFnNeYmklsavm7x16tmYF3SaXl5xx08CRNiaZTG0a
   d6VJuCAdDnsUKddMOYwRTK9SVS2gFGHPDYDVtg+5doYnRx03OxJbFDwJm
   WIp/gjeQHfm0/wyXaMIdTpTMe9AYeVz+S8a+5iYIFtSDh0swRxyvhH1qa
   48XjTCYcd/SQaXOmq3ql4LVbkCSrMI+wizlwHPfuMYfJ226j4wuItlXYJ
   nOOi9s/jC0SJ4YTkOBtpwGzC1uwOSUkj+P/wjxEvI3wjwv/eWfDOpNcMc
   4SRGpkU9ShUWVc6qXFvKxZjARr76eNSxl7YQW4WCJO29MyImUgTXGxakO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306700483"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306700483"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907585740"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907585740"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga006.fm.intel.com with SMTP; 24 Jan 2023 09:12:21 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 19:12:20 +0200
Date: Tue, 24 Jan 2023 19:12:20 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y9ARdPA4vckTQ4GP@intel.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
 <Y8+bP2Oqy3B2XyuJ@intel.com>
 <20230124134134.GC25796@lst.de>
 <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8//roUT5byp59UP@kbusch-mbp.dhcp.thefacebook.com>
X-Patchwork-Hint: comment
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_091231_446554_95BE14F7 
X-CRM114-Status: GOOD (  17.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 24, 2023 at 08:56:30AM -0700, Keith Busch wrote:
> On Tue, Jan 24, 2023 at 02:41:34PM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 24, 2023 at 10:47:59AM +0200, Ville Syrjälä wrote:
> > > On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> > > > Err, no.  We're not going to randomly revert things.  If you want
> > > > to be productive check the one liner Keith reported in reply to the
> > > > last report.
> > > 
> > > No idea what that previous report is. Care to share a link?
> > 
> > https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#m759092f541ea29fcb41911890307e70868636a45
> > 
> > Patch to test:
> > 
> > https://lore.kernel.org/linux-nvme/849c43bc-7488-72a6-f6fc-8700639b0c79@leemhuis.info/T/#md13c22b29cd81bd0ce9167c271c582005ba30550
> 
> I'll post the official patch if someone can let me know if it's
> successful. Or I can potentially setup a VM to verify myself, but I
> probably won't be able to get to that till next week.

Appears to work here. I threw a tested-by to the original thread.

-- 
Ville Syrjälä
Intel

