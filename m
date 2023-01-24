Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1354C38142
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=28dbxCQ014Vyz6it9ncFX8nXwNR0CWJu8mngypJ6YiQ=; b=x50q8QCR1N3zzEKwYUrFP2W3vv
	io3HFVuLDXZWbiaUAl8LjmvvJzzkt0duP1noS7U9h3StWy5bubJ86CeweTzUisZJg3YE9jsY7dW2l
	zvvKDdEsofl3BQjj3iDTzEChAwIkbcmEzpEj5rnq/aJ/qEKzEoG/XNg5qKANfRTevFtKLWqgr6MHH
	bWPjxb/jidWX+9PVmoQoF6WzpeG1+alzX7m8Uw8I3xtgnLaQB4yBNJ+zw6t34nvFamFOjMnHWWboU
	cGJ6K1KS8OwEd9muwt0dcj7FmFqwPkiEy28kiiI/RtEUUilL18vs9fgDVtypkU1OznSYxoYU9gKvv
	Zpew+fkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKEyP-002ngF-Kr; Tue, 24 Jan 2023 08:48:09 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKEyM-002neu-Ko
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 08:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674550086; x=1706086086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dl7rXKEdq8PvoijCs/oOyLxW6MYTFYAWUkJ0i39JYpA=;
  b=XqLItgh5U6NZkYjHfO8SlYTTvSF8Ls8TRlbSInihGxgvhGoGiA3rHJI0
   w80zRYOBC1OJlSfxCTRABTkaO5n84MgucGX/8M2P/631Ax8162FbACPWg
   ObYPNAu6XDI8wxbsLIvrDDgr0/dIU1xf20Du6mECydn28dYKRed+0ze52
   DPwacPckfBMJGs6L38XU/5HfMIs0110DqdXGv6ZLoRfuLdBFE51qP9DNJ
   dRTvn3TzwDvmLvdcaPTrLM1hYw93K7iF1ruiOv7/wOoVgipGso5f+Y4YF
   6JGvvMil0PDx4VlsdRG/Jr2UVyKF5Km5xreQrP+E9WO3VEpnzBjHWoRAJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390756802"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="390756802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 00:48:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="804508982"
X-IronPort-AV: E=Sophos;i="5.97,241,1669104000"; 
   d="scan'208";a="804508982"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga001.fm.intel.com with SMTP; 24 Jan 2023 00:48:00 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 10:47:59 +0200
Date: Tue, 24 Jan 2023 10:47:59 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount
 regression
Message-ID: <Y8+bP2Oqy3B2XyuJ@intel.com>
References: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
 <20230124062140.GA29175@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124062140.GA29175@lst.de>
X-Patchwork-Hint: comment
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_004806_783763_24B5F2EA 
X-CRM114-Status: GOOD (  11.28  )
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

On Tue, Jan 24, 2023 at 07:21:40AM +0100, Christoph Hellwig wrote:
> Err, no.  We're not going to randomly revert things.  If you want
> to be productive check the one liner Keith reported in reply to the
> last report.

No idea what that previous report is. Care to share a link?

-- 
Ville Syrjälä
Intel

