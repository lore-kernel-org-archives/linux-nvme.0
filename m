Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D143FC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CY7hTlC8jUEtboz0AV3dlkYH9l+EM86n6p+k66Yr8tM=; b=PPaavQIX4fU9VbrEg4YWyq105c
	SHOK554T1VOpk1Mw12FwDEUC1+Cpr5emrhm4NIsgBU8rocs6gRsDK4g9c0Vh0i/4ToPrp5cKrbhzg
	AHAvz6kbyvgVEKVxnMzk2mu1e8dEXumWUAYEZ2B8p+4tXEBgzrQGgIDKQibl8J1VyM/bR421kuMIc
	jV43RObAEb670KXHBqTGE+dSXNoa6HWnVsJLBA4l/yImvlK6MO0NAbMhXZmI6w4CPzBGz86tm96gF
	ZkOLPA6sin8jGMTJ0rlwc5CTCnHKXsWl2L8rolOxa+BVs95FtW96C1uqc7bpJl+Mm6G3VwASRvTBY
	Cr9mjyIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lz4-00000000EWF-1Mwd;
	Fri, 25 Apr 2025 16:33:02 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KwP-000000002S1-2TSO
	for linux-nvme@bombadil.infradead.org;
	Fri, 25 Apr 2025 15:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CY7hTlC8jUEtboz0AV3dlkYH9l+EM86n6p+k66Yr8tM=; b=FYBEw977Z1obbgyVRhVZiQUCv2
	F5vPtlu6lhG5vWZFGPFRQsr3pC8RpcxHS+rC7OHGuF73Ic7xzN3A6svHp9AY4ivAk2LFOltJ6E9tT
	mD35nxbiA164RfclVNX3K2X45eOYA0kpxdLgBC1+mIEAz8VuWqQRpVAX0j7TbZnC+DN2Q8IuoJaWs
	NtmL+Y4VJlLgPOJDZ/N+AQyvhstdE1OGCXaC8/kepHhCGpiaGD1TknWx9b2OYlt2iIas0qbtymGMc
	i6j3dY8CnUQkHb/+Yeik8uamcm8h1IJhtEiBNYAjCOPUzfuXTfuaM9qS4vjN+2MU9HwubJNiclXxQ
	GnuBIDWQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8KwM-0000000C68k-1nq3
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 15:26:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B784C68B05; Fri, 25 Apr 2025 17:26:04 +0200 (CEST)
Date: Fri, 25 Apr 2025 17:26:04 +0200
From: hch <hch@lst.de>
To: Waiman Long <llong@redhat.com>
Cc: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Message-ID: <20250425152604.GA15999@lst.de>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com> <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com> <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com> <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com> <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com> <20250425145450.GA12664@lst.de> <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com> <20250425151140.GA14859@lst.de> <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a85a074-d4fe-404e-9438-131963a51051@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_162610_669294_EDE486A6 
X-CRM114-Status: GOOD (  10.96  )
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

On Fri, Apr 25, 2025 at 11:22:50AM -0400, Waiman Long wrote:
> The nvme-6.15-2025-04-10 branch used by Kmaljit includes some v6.15
> commits like the cgroup commit 093c8812de2d3 ("cgroup: rstat:
> Cleanup flushing functions and locking") but not its fix commit
> 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with
> cgroup_rstat_lock"). That can cause system crash in some cases. That
> problem will be resolved if nvme is rebased on top of v6.15-rc1 or
> later as the fix commit will be included.

The nvme branches are always rebased on top of the current relevant block
branches, i.e. block-6.15 in thise case.  Everything else would create
merge issues.

