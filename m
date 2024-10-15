Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A504CFC276
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBwRXkAIdv1AimxyczECxXGj9by0IZ10c25ZcV9tBtE=; b=1QZe/iZR8DqNXI6RzA1mc6n408
	e7mJvmizwCTRJWcZ4AzAGm1h8z8egdugWXPtTZ413jN90E2Zy9wKvRyFp0ck5NIsOO/9giqr6Quu1
	/3Q/ZcrFIcAFt1YEPudfS9fuu9q9+Rb1NkNkRkVEiaWX2FwOi4zIuRhfacVRmqsD2jfkHgjsCsWF6
	VlKNFx8t5OpIbkeMSRwd/IEAkRDflYlRQWVM20Yd8kBT4plpSigKZ3UwmE3zfn1Y7VCGfl3bxAVT3
	HHJepCm38J9315HG5yKSx4U3ZtTsXIg/vYDMA0u+3AzqrmDKD2YQ6ljmELSa0VG/fMktbWJWcTO+B
	+PUszxZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0e1A-00000007iYk-3k8q;
	Tue, 15 Oct 2024 09:39:04 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0doG-00000007h48-41wt
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 09:25:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728984345; x=1760520345;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LBwRXkAIdv1AimxyczECxXGj9by0IZ10c25ZcV9tBtE=;
  b=lz6kpYyLFH16iBCIxeTBTJArpO7FpIp/CYG3zY4VgoQ+9gf5Ox53NgWH
   T85Rs7OSTsT6RPyKtzjCB7Q9cP3fkLtxN3vfUmMiLVDgdXVuvgUcSzqFI
   7tdH0ANZLuSB6dq3G6xRO+uTJohhpu+X5nMjToP0e1/KK1OWDgS4NcW0R
   LhcooTyfLuqdsZu01ATHlMB2PblXUlPVvE1SgwyDR9LVQKebvp/nQgrQL
   w1pOiltSu0qNw9ck2a+GS0KRkk7juKF4Lsb8t2NOOphK/bBy5ryAqGsBA
   AoiAgDY2sb/InQIoCjKODbB2jHtfUe3P27OHqWKaegVXS2nL1EC0dBmrv
   A==;
X-CSE-ConnectionGUID: 07R53sHvS/+okB9YDqKVHg==
X-CSE-MsgGUID: wuLI9CWATOCFmeYWkMcMuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="38997770"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="38997770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:25:42 -0700
X-CSE-ConnectionGUID: 9X81IRDMTxOE0jJ7zKZwJw==
X-CSE-MsgGUID: qHE+LER4R2m09qKI09dR3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77850866"
Received: from lfiedoro-mobl.ger.corp.intel.com ([10.245.246.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 02:25:40 -0700
Message-ID: <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Tue, 15 Oct 2024 12:25:37 +0300
In-Reply-To: <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
	 <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_022545_031942_7303A603 
X-CRM114-Status: GOOD (  27.09  )
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

On Wed, 2024-10-09 at 11:24 +0300, Tero Kristo wrote:
> On Wed, 2024-10-09 at 10:00 +0200, Christoph Hellwig wrote:
> > On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> > > Initially, I posted the patch against block layer, but there the
> > > recommendation was to move this closer to the HW; i.e. NVMe
> > > driver
> > > level.
> >=20
> > Even if it is called from NVMe, at lot of the code is not nvme
> > specific.
> > Some of it appears block specific and other pats are entirely
> > generic.
> >=20
> > But I still don't see how walking cpumasks and updating paramters
> > in
> > far away (in terms of cache lines and pointer dereferences) for
> > every
> > single I/O could work without having a huge performance impact.
> >=20
>=20
> Generally, the cpumask only has a couple of CPUs on it; yes its true
> on
> certain setups every CPU of the system may end up on it, but then the
> user has the option to not enable this feature at all. In my testing
> system, there is a separate NVME irq for each CPU, so the affinity
> mask
> only contains one bit.
>=20
> Also, the code tries to avoid calling the heavy PM QoS stuff, by
> checking if the request is already active, and updating the values in
> a
> workqueue later on. Generally the heavy-ish parameter update only
> happens on the first activity of a burst of NVMe accesses.

I've been giving this some thought offline, but can't really think of
how this could be done in the generic layers; the code needs to figure
out the interrupt that gets fired by the activity, to prevent the CPU
that is going to handle that interrupt to go into deep idle,
potentially ruining the latency and throughput of the request. The
knowledge of this interrupt mapping only resides in the driver level,
in this case NVMe.

One thing that could be done is to prevent the whole feature to be used
on setups where the number of cpus per irq is above some threshold;
lets say 4 as an example.

-Tero

