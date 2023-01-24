Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCABAC25B4E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xk6BfJ0p8ntbRtK/lNH4lzx6UDnfSOiqcBlbhu/8vu4=; b=LZPRVj7nbRcGghgnIgoOWsKqIp
	sANNAGSaP6hd+E/XqT5XBzfn6uY0p/WklkwJZ0gXib/gyghjOjRgT1QAanPv0hXNA2K32m4fVI/QB
	payw99delsqln5t+QXOK93zG5jwrv/xhGpK/Ouu7nlLK4Z1R9XQuJ8k0brHG+BD9wm6DS0cjzpkv9
	zvtAe8mLqaJrMQrxKN60ZkvgGHtVd0h0kGkHJDowO+xqGYFnWiM8yYnEi0X4luJDK1MJRnaq8FX+4
	yo4bsM9Vk1xjLuyYkYvZpZHOiK/CrnAAmpgYKvnLURjkcoLRKRHAzVDXTPBPwkUL3mW/L/tKCDoX/
	JRXjCjnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMpv-004mOg-SY; Tue, 24 Jan 2023 17:11:55 +0000
Received: from mga17.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMps-004mNs-V7
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 17:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674580312; x=1706116312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5rPRxziFRlIVlHQ3JuhXOuLds1hFr2+bLman/mjKsh8=;
  b=bJuQ2o5PgF9ON3rTBY18OwNlncuMoUnGXeCuWE1f+UVHNpvj413zc0yh
   lsmdrS8ZZ3/0aTRXIubcQUQrd1C4Ak+SdrrS2YCXSoq7WTk31iiXH9ZKG
   JhExq+Q7lslEVp5/BVMXVeGblWrGZINShbahiam4mak/IfU7wlV9ReYhp
   GSWP8PDp2WGrU8J4885HDDbDtyZph+vO2XQxYAw87D02Im8a2Slk5Syb7
   T/UV29aPIohu3BvZiLEFGh9XXB9YnOWZjkE9s1KjSmvh+5XBnbLXe1CE1
   aYEYKPXS+eUrfwUznarrS/+ihFlaMQc+/uq0Sgh2zfjT3oQw/qvpvDrBe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="306700303"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="306700303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:11:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="907585507"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="907585507"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by fmsmga006.fm.intel.com with SMTP; 24 Jan 2023 09:11:40 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 19:11:39 +0200
Date: Tue, 24 Jan 2023 19:11:39 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression on aarch64? panic on boot
Message-ID: <Y9ARS0qwEXz/bhPc@intel.com>
References: <Y8XINx8fpGPKudW6@cormorant.local>
 <20230117055819.GB13795@lst.de>
 <Y8ZA30EoAFaFPwVC@cormorant.local>
 <20230117063735.GA14468@lst.de>
 <Y8l0ePagRXDHQByr@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8l0ePagRXDHQByr@kbusch-mbp>
X-Patchwork-Hint: comment
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_091153_038267_A147A2DB 
X-CRM114-Status: GOOD (  21.21  )
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

On Thu, Jan 19, 2023 at 09:48:56AM -0700, Keith Busch wrote:
> On Tue, Jan 17, 2023 at 07:37:35AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 17, 2023 at 07:31:59AM +0100, Klaus Jensen wrote:
> > > Good morning Christoph,
> > > 
> > > Yep, the above works.
> > 
> > Context for the newly added: This is dropping the newly added
> > PROBE_PREFER_ASYNCHRONOUS in nvme, which causes Klaus' arm64 (but not
> > other boot tests) to fail.  Any idea what could be going wrong there
> > probably in userspace?
> 
> Prior to 6.2, the driver would do it's own async_schedule, and that
> async probe function would flush the first scan work.
> wait_for_device_probe() was then forced to wait for the scan_work to
> complete, which brings up the root device.
> 
> We're not flushing the scan_work anymore from our probe, so this should
> fix it for 6.2:

Appears to fix my Tigerlake Thinkpad T14 gen2.

Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b294b41a149a7..ff97426749976 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
>         nvme_start_ctrl(&dev->ctrl);
>         nvme_put_ctrl(&dev->ctrl);
> +       flush_work(&dev->ctrl.scan_work);
>         return 0;
> 
>  out_disable:
> --
> 

-- 
Ville Syrjälä
Intel

