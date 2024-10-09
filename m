Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D813CED62B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMqeygrDRnZkLZfYdb04EQ9i5yeRMyIrwByGC8Glue8=; b=kOrFL+x0ZgSNXo1SJp9NMhRTxl
	Zo47MOSWf42g9J1S4yT5l394PPZuCKeUPmrH47GN+bmPuMDpQhd1hJtQHwi5dejhUjL2vj+kAyZvR
	dpAZ0dP4wO56KnJLPmmQrrVHOGTqZyLe1EwUuAuh4WbDX4l3l1h8bSuCKvFHAo89X3iHdnezhT5uI
	hsXbctBDg6NlrWGapey4TFrc2m2+TJ+ICMrjDAAGy6HBZ5M/uKNHJZKhfzUIM9jF1XgPPQttWh7AZ
	Vjx+w0ei7uh+fiMwbEEnbyCwWGMq8xZClYUd9Psfi/EECo88yIkMq5s8NYPjrqjc9qVkx4w2SRN34
	QYImVsVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syS09-00000008RWq-1Chu;
	Wed, 09 Oct 2024 08:24:57 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syS05-00000008RVz-47bl
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 08:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728462294; x=1759998294;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AMqeygrDRnZkLZfYdb04EQ9i5yeRMyIrwByGC8Glue8=;
  b=Nt4mRQlY6uFmpmsbJTkNSaGsPo0kC+O5tmGBBZwedjmpcfdATxyrwY9o
   uB2mWn0z+0Fsl+V99BRAnS6ibYMvsZwxeodPVrkHM5b2yrCqFWLpphalZ
   1VHBq8P0RWMCWnNIz08G5QFcG+4OFhPHQCkPhtmUuPfUBmxCpepeDJUFh
   rSwXOs1PuiO8lz28b1gxc/P4aoVUGjERTU/3T4p+H6ohuS4e7yjHv1Oke
   ty0JEPo3oLLm4YGaebVfA4T1uc/4CEBXUohAS/RyRA3F4zoZHpMdsEv8H
   WmQfuuQykF9zYyPKQYhI4HxSgynpbn4dnC6BrNdmOZAJdmlZHUQtv04Ss
   w==;
X-CSE-ConnectionGUID: q3wykekUSYulOwR2+4/V8g==
X-CSE-MsgGUID: RJNe1CtrSlumZvKMFOPvVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38334122"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38334122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:24:50 -0700
X-CSE-ConnectionGUID: LfoKvX/CRRGMoOyFu8Vr6w==
X-CSE-MsgGUID: Mfs71pT1T/6Al5E1oGikIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="106932801"
Received: from mklonows-mobl1.ger.corp.intel.com ([10.245.246.66])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 01:24:49 -0700
Message-ID: <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Wed, 09 Oct 2024 11:24:45 +0300
In-Reply-To: <20241009080052.GA16711@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_012454_102557_C0E92661 
X-CRM114-Status: GOOD (  17.77  )
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

On Wed, 2024-10-09 at 10:00 +0200, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> > Initially, I posted the patch against block layer, but there the
> > recommendation was to move this closer to the HW; i.e. NVMe driver
> > level.
>=20
> Even if it is called from NVMe, at lot of the code is not nvme
> specific.
> Some of it appears block specific and other pats are entirely
> generic.
>=20
> But I still don't see how walking cpumasks and updating paramters in
> far away (in terms of cache lines and pointer dereferences) for every
> single I/O could work without having a huge performance impact.
>=20

Generally, the cpumask only has a couple of CPUs on it; yes its true on
certain setups every CPU of the system may end up on it, but then the
user has the option to not enable this feature at all. In my testing
system, there is a separate NVME irq for each CPU, so the affinity mask
only contains one bit.

Also, the code tries to avoid calling the heavy PM QoS stuff, by
checking if the request is already active, and updating the values in a
workqueue later on. Generally the heavy-ish parameter update only
happens on the first activity of a burst of NVMe accesses.

-Tero


