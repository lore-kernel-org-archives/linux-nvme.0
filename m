Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B28CED60F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 06:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfI5esN+3cAIYX7SRuL5o/9EMoY+GAVExJQl3rKr+vg=; b=Qsw3gHvESopZzY5RCTs3YfwC2t
	rPkS+Obj07Lv1FaatBTz6ijKF8VRmywdA9CrFyDP+O0QJeW1oIe+G0jOt099yHif0hZZTv6cJ5oiH
	SBzqn0T4dP3cgN888wXUMR56/xzV5Jqfn2LqHPah+8Wm4cpKZxuoqDbUUopkQTcjJnlVZomgb2q2O
	A3Ach3Nx4w9B13mF8imfXUVgzgfX2v342j9GPrpWaVQwL7Sje1WMEgUh4wZyDA4Y4fg7PJP6CeJqV
	JzrTxilpOtTuxf7/QKFXAdDdCqAwWS6tlFTam+Wc/S+7orWfUJcLmKXLzpDCqzketQvsm/XX604uC
	t7AKzNAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syQRs-000000088DS-12ik;
	Wed, 09 Oct 2024 06:45:28 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syQRo-000000088D0-2xad
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 06:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728456325; x=1759992325;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=T2hK6xz3/99sC4O5f2cRdeWIxz3Ssjx5U9gl5pXCsLE=;
  b=ferIJ2QqldL2/r2V7TeRIslDQLXLDF0fh07yyYH4fNxZ1jCHcIf2aMpt
   iOmChDu8y3pEhM6UiBXIeofThYFp3uQqO7WTVFTjavrflQJf7pb/YHmk5
   mV6vxud7AQ6JaDnPq1JNjfoviSQKHHm21n1BAK+26VgoL7NCkU6VyUrYF
   nZwb8hrDr93k0NAKpmEvgINxKxgG9mfzms9vn/fTBJv/fnB6hbF8eh/G5
   XSsYjWLWr3bmVKhOsccHz3ebGwOFeb6Hj3nsPnN3KT2MfoOU+ik+znG1Y
   m8uYzqKqFOCpLEGv0Bp8KzNYEbK6JhNGfcTnmEKsgDgTIlt+4nnOrR1Du
   Q==;
X-CSE-ConnectionGUID: Q/Hm04nLRoO/3Uek1ZWrxw==
X-CSE-MsgGUID: H89GP7XhR7y2aGYqevXwmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31625189"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31625189"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:45:24 -0700
X-CSE-ConnectionGUID: cGV4m5zaRRKdUBFJT9eqFw==
X-CSE-MsgGUID: Wd0qNWyxTCSP9p+l5eHUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76106536"
Received: from mklonows-mobl1.ger.corp.intel.com ([10.245.246.66])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 23:45:21 -0700
Message-ID: <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
From: Tero Kristo <tero.kristo@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Date: Wed, 09 Oct 2024 09:45:07 +0300
In-Reply-To: <20241007061926.GA800@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
	 <20241004101014.3716006-2-tero.kristo@linux.intel.com>
	 <20241007061926.GA800@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_234525_469721_10B59054 
X-CRM114-Status: GOOD (  13.01  )
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

On Mon, 2024-10-07 at 08:19 +0200, Christoph Hellwig wrote:
> > @@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct
> > nvme_queue *nvmeq, bool write_sq)
> > =C2=A0			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
> > =C2=A0		writel(nvmeq->sq_tail, nvmeq->q_db);
> > =C2=A0	nvmeq->last_sq_tail =3D nvmeq->sq_tail;
> > +
> > +	/* Kick CPU latency while updating queue. */
> > +	dev =3D nvmeq->dev;
> > +	if (!dev || dev->cpu_latency < 0)
> > +		return;
> > +
> > +	for_each_cpu(cpu, nvmeq->irq_aff_mask) {
>=20
> Doing something as complex as this for every doorbell write is not
> going to fly.
>=20
> Even if it was I see nothing nvme-specific in the interface.
>=20
> So please figure out a way to make things cheap in the I/O path
> and move code to the right layers.

Initially, I posted the patch against block layer, but there the
recommendation was to move this closer to the HW; i.e. NVMe driver
level.

See:
https://patchwork.kernel.org/project/linux-block/patch/20240829075423.13450=
42-2-tero.kristo@linux.intel.com/

Any tips where this piece of code should actually be moved would be
appreciated.

-Tero

>=20
> Also please avoid all these overly long lines.


