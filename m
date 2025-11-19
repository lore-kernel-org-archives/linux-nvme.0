Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73292CF2569
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 01:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aj/ywx73k81CNsOcA+I92pYtR8bwljudVgYjAUUAFmg=; b=y7ZjhE4HsW/1+46vwREZkfDXwS
	IDKg+tt0mFWMkL0VHS2wXh8O1By8T7UGMhkKY9lXQadi0Jxn5E//aTGPxNRn48o4uJErTnSawz42W
	/++WJgDVZ4qbHgFQYDVhP2z4F8Ed8LbgnlW+jMRIc0GWnGkkwPNfsOdPuA1YePeE2LuuUPBuwNOns
	NBwgSq323SXap4Ni5nAesSKKdFEqDZKl+esqlIWQtO1bupk5C1aFfy7YBTlYOwanHmLEOhz6HNaG/
	1D5nKLx+rd86DIzXROBSE/91BwRgT60UUa9dZzejav8hUkMfiyUKCX71eppz3KxlaphLgkQoGxmSC
	Le59x07g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLXNR-00000001MSy-14Kd;
	Wed, 19 Nov 2025 01:52:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLXNM-00000001MSY-3imK
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 01:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aj/ywx73k81CNsOcA+I92pYtR8bwljudVgYjAUUAFmg=;
	b=fndKsSeXSCtyRz6iPvU2W1zfpR682l7SaorvsFCBSb8l23ErFwbgmamXKSAwLHv9WzSauO
	CGlOJe5ScaSIPOu0plhSPa1b3eqJMI6myeLyv3Aexgw7sgUK5/agdKqtEr/uPUrT5en5qN
	swsR5PAQo1RI3R3jLtwASFnB16gnHV4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-vRIljo3vNcaB4O5-uj7jAg-1; Tue,
 18 Nov 2025 20:52:42 -0500
X-MC-Unique: vRIljo3vNcaB4O5-uj7jAg-1
X-Mimecast-MFC-AGG-ID: vRIljo3vNcaB4O5-uj7jAg_1763517160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F9718AB400;
	Wed, 19 Nov 2025 01:52:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFC67195608E;
	Wed, 19 Nov 2025 01:52:30 +0000 (UTC)
Date: Wed, 19 Nov 2025 09:52:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aR0i2f91VGv47swo@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora>
 <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
 <aRU2sC5q5hCmS_eM@fedora>
 <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1d6b4e-038c-48dc-830d-5eadb3ac943f@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_175253_346655_BE294DA4 
X-CRM114-Status: GOOD (  23.14  )
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

On Tue, Nov 18, 2025 at 02:29:20PM +0800, Guo, Wangyang wrote:
> On 11/13/2025 9:38 AM, Ming Lei wrote:
> > On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
> > > On 11/11/2025 8:08 PM, Ming Lei wrote:
> > > > On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> > > > They still should share same L3 cache, and cpus_share_cache() should be
> > > > true when the IO completes on the CPU which belong to different L2 with the
> > > > submission CPU, and remote completion via IPI won't be triggered.
> > > Yes, remote IPI not triggered.
> > 
> > OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
> > remote IPI is triggered in case of crossing L3, which is understandable.
> > 
> > I will check if topo cluster can cover L3, if yes, the patch still can be
> > simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
> > and adding nr_sub_nodes.
> 
> Do you mean using cluster as "NUMA" nodes to spread CPU, instead of two
> level NUMA-cluster spreading?

Yes, I think the change may be minimized by introducing sub-numa-node for
covering it, what do you think of this approach?

However, it is bad to use cluster as sub-numa-node at default, because cluster
is aligned with CPUs sharing L2 cache, so there could be too many clusters
for many systems in which one cluster just includes two CPUs, then the finally
calculated mapping crosses clusters inevitably because nr_queues is
less than nr_clusters.

I'd suggest to map CPUs sharing L3 cache into one sub-numa-node.

For your case, either adding one kernel parameter, or adding group_cpus_cluster()
API for the unusual case by sharing single code path.


Thanks,
Ming


