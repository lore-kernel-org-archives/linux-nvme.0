Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1697C88E45
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 15:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kN5VDR9z03jd/obUeKnZsdviPLlwfqOhB0m2w3WOXPY=; b=xpF9V17oAzgwxYukJ1RMiZplLd
	DcXEPK8jCn+RRTsw42dqqOJ9eJ4EMyZKNA6b3VVyqOKg918mnFR8XdPS3/0f4TYzRsPQiCaN8QH90
	+MlsrTinDJ5u8HX6GTY0QGP8KEjo3xzf0SbGCVnu+1ubmRCneyxzdzjHh/boPcA6zEbbfmM+w41iO
	KaugqcyCj7BUzMRkIorEXxSxYJ42yUQqGeqs9z1ur7vAXdNV2YOuqV33fKOb7KWphXCmx+gYNPbL4
	kR4JfY/HNLV094YsoIx7fK1jBUHPreo2DJ7UTlY6qG3+L+hJoSXPErV1x/hviPtVrp8lLTHAmpwY8
	hI/7+gsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52qy-0000000H0IG-1aaS;
	Fri, 11 Sep 2026 15:07:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x52qw-0000000H0I8-2rqP
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 15:07:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B5A94044B;
	Fri, 11 Sep 2026 15:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BC81F000FF;
	Fri, 11 Sep 2026 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789139266;
	bh=kN5VDR9z03jd/obUeKnZsdviPLlwfqOhB0m2w3WOXPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ei/sFMGKPP0Cqs0z+JFHPh/FDL7fYY6AgSPostXr7NEyO4ZOhoO4m9OhP2+4HUXHb
	 SnXtQOIa/eiFVCZ27chz5KV/etqOnVZESz4BkzG6FIVSy4mJVqRj0yVwVVV1NggGDq
	 OskdxKMBshv4Jqc5Vzj4r999BJDN0j9JMAQDmvQ0/C0AqX0TQIRS+mar/eH724ZEqu
	 IuM75HyM9Z5VuVPiJvzBxUpgAMmw32j2s/eLVDkSHN3cvYhtY9ij8QoYJdifWL+MR2
	 7ohe8XwpIbaPSmSc1uGsKkkoCZ8+MHJodiVdvPpAN8c0OO7GrjEzCM8eW01fbrozMx
	 osBIabDrqZ+NQ==
Date: Fri, 11 Sep 2026 09:07:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: derive the CRTO property from CAP, not CSTS
Message-ID: <aqQZQPs7KzBUVbgw@kbusch-mbp>
References: <20260910180056.81257-1-astellman@stellman-greene.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910180056.81257-1-astellman@stellman-greene.com>
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

On Thu, Sep 10, 2026 at 02:00:56PM -0400, Andrew Stellman wrote:
> nvmet_execute_prop_get() answers a Property Get of CRTO with
> NVME_CAP_TIMEOUT(ctrl->csts).  NVME_CAP_TIMEOUT() extracts bits 31:24,
> which is the TO field of CAP.  CSTS defines only bits 6:0 and nvmet
> writes only RDY, CFS and SHST into it, so the result is always 0.  The
> same controller sets CAP.TO to 15 in nvmet_init_cap().
> 
> NVMe Base Specification 2.4, Figure 36 (CAP), says that when CC.CRIME
> is '0' the TO field "shall be set to: a) the value in the Controller
> Ready With Media Timeout (CRTO.CRWMT) field; or b) FFh if the value in
> the CRTO.CRWMT field is greater than FFh."  nvmet reports 15 in CAP.TO
> and 0 in CRTO.CRWMT.
> 
> Take the value from ctrl->cap, where the timeout is actually stored.
> 
> The Linux host reads CRTO only when CAP.CRMS.CRWMS is set, which nvmet
> does not advertise, so Linux initiators have not seen the wrong value.
> A host that reads the property directly does, for example nvme-cli's
> get-property.  Advertising CRWMS is a separate change.
> 
> Tested on 7.3.0-rc1-qpb-cc-crto-base+ (unpatched) and
> 7.3.0-rc1-qpb-cc-crto+ (patched) in an arm64 QEMU guest with nvmet over
> NVMe/TCP to 127.0.0.1, reading the properties with nvme get-property.
> Before: CAP reads 0x8200f0003ff (TO = 15) and CRTO reads 0.  After: CAP
> is unchanged and CRTO reads 0xf, so CRWMT = 15 = CAP.TO.
> 
> The issue was found by Claude Opus 5 running Quality Playbook, an
> LLM-driven code review tool:
> https://github.com/andrewstellman/quality-playbook

This is a very long explanation for a simple protocol fix. Just say
something like "The NVME_CAP_TIMEOUT requires the value from the CAP
register, not CSTS." Short and to the point.

