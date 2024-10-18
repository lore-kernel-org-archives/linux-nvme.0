Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBADCD2127B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s+HlrfHqP69nqmDhgJNxMWvtR8m57Il9I98x50Qn7Cg=; b=y2h+d0RaNpUn3MgRy0YCKY1+aN
	7PD9i+CA9/p6RA3zGqzfYEanL7eFXk/Ir+WPxSctZjsqmiaiCVIGGauUdQ6bLXKFwFq6ZPBaWkwzb
	DXNFtG4sA88BBW4PY+5vQYWKTih/GN4iHdundKFV13DbJzOvZ9kmitnlDjemmckFVL2sLx6O56XNo
	7sX592CF6iQfKbLbdFg1E22gHvP6ys65i4hKLiTq7QXyFiZezZc4uiB10etfmuo23KeoBC1sB0FU+
	vd/j5mjkyxQI8y2CfcguAXH/HjPZ6abz9e49MgzFK/nd7pDVNaA2XE+RqhxP456gw5aNK+J1u+zwK
	+tpASyMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1hyV-0000000HQsd-2h23;
	Fri, 18 Oct 2024 08:04:43 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1hsj-0000000HQBU-0zoZ
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 07:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729238325; x=1760774325;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=s+HlrfHqP69nqmDhgJNxMWvtR8m57Il9I98x50Qn7Cg=;
  b=Esc/YgpHO6kHBc+iQXeSI/G13dzTyREOsig1QbWSs8Egr80bQloJcp+w
   gEJIV8tiAxX4zKL5FakFlkj/k34vvOJBxlRqy/JtcWXHk8SI6RxBfksuS
   YgybIsnzi3ITfed1KsM99B+1ZF88vzoyr5W1RiMmU3rmWpPodZeN1fSCT
   d+Km2poTmTAW7OEmvQXMfq4cij5Cv9sBOtG3S8emTrsRdAEJ0kWHYFVCr
   KrLkiqMDoJVMaHaNJmu8S98j6AH+o4D8xqE6v5BUHLDSZ9YV9emHQodrg
   woWByeJ8MrIMWkov1kd1vlx+2E5kIl/039aF6VN81JxCfT7XT2vLDHS+X
   w==;
X-CSE-ConnectionGUID: yPjaMIw7RLWbJ713ukhwzg==
X-CSE-MsgGUID: QgY2qSieQFq4bjPW6oc4Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="46257544"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="46257544"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:58:42 -0700
X-CSE-ConnectionGUID: kBNgLfcKTdKJVQbYBLmJpQ==
X-CSE-MsgGUID: 7HOiqOcVQpaecsJmkvw2Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="116254824"
Received: from klitkey1-mobl1.ger.corp.intel.com ([10.245.246.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 00:58:40 -0700
Message-ID: <316b41e631572a02a89bab2456cfb373f3e667ae.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Fri, 18 Oct 2024 10:58:36 +0300
In-Reply-To: <20241015132928.GA3961@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
	 <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
	 <20241009080052.GA16711@lst.de>
	 <accb9ceb501197b71259d8d3996c461dcef1e7d6.camel@linux.intel.com>
	 <0feb16b0bc3515b0a77f33a3e18568f62236b691.camel@linux.intel.com>
	 <20241015132928.GA3961@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_005845_307913_FC9D0F19 
X-CRM114-Status: GOOD (  25.91  )
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

On Tue, 2024-10-15 at 15:29 +0200, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 12:25:37PM +0300, Tero Kristo wrote:
> > I've been giving this some thought offline, but can't really think
> > of
> > how this could be done in the generic layers; the code needs to
> > figure
> > out the interrupt that gets fired by the activity, to prevent the
> > CPU
> > that is going to handle that interrupt to go into deep idle,
> > potentially ruining the latency and throughput of the request. The
> > knowledge of this interrupt mapping only resides in the driver
> > level,
> > in this case NVMe.
> >=20
> > One thing that could be done is to prevent the whole feature to be
> > used
> > on setups where the number of cpus per irq is above some threshold;
> > lets say 4 as an example.
>=20
> As a disclaimer I don't really understand the PM QOS framework, just
> the NVMe driver and block layer.
>=20
> With that my gut feeling is that all this latency management should
> be driven by the blk_mq_hctx structure, the block layer equivalent
> to a queue.=C2=A0 And instead of having a per-cpu array of QOS requests
> per device, there should one per cpu in the actual mask of the
> hctx, so that you only have to iterate this local shared data
> structure.
>=20
> Preferably there would be one single active check per hctx and
> not one per cpu, e.g. when the block layer submits commands
> it has to do one single check instead of an iteration.=C2=A0 Similarly
> the block layer code would time out the activity once per hctx,
> and only then iterate the (usually few) CPUs per hctx.
>=20

Thanks for the feedback, I have now reworked + retested my patches
against blk-mq, just posted them to the block mailing list also.

-Tero

