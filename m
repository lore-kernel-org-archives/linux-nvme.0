Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3F8CD4F35
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 01:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YE3L5VAgzoQWOHqB3Rk/jnMG/XnJ1XD/9vBp3BPJiDk=; b=wLv0w8bWV6iJdH0YEbXDfm+w0a
	Yo7q/tqlnU44yTadhRykUBX9aFSBFylV0JO/Er7s3roS5eH066BjPx3P4yVFofk65fw+Y98bSEtUu
	DB48beFjKmA0zBepbWBIk5/YHoEggRn/JLcqKPkmHLupQ+Hj3+9Gbz4GhG4mpZ73/bCl/ymVin5zD
	VFpUR+V/Qvz0PJIVmdy6ErMaRJi0SRZ2R2M/SIexV/uiiQmijtdadjjdBAc3OAzEVGvg8yrcHi7uA
	9e5TN2KXMRx/6rkzf3wRkO7GrZaQuWL94M0MwE1omkYlBijV1vAI2ijImNwDAVKtQFyNnChUXDoFS
	eiUC6KbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMJ5-00000009jFy-2feQ;
	Thu, 13 Nov 2025 01:39:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMJ2-00000009jFQ-0zv1
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 01:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762997961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE3L5VAgzoQWOHqB3Rk/jnMG/XnJ1XD/9vBp3BPJiDk=;
	b=ZvvkeVxi7zKc4+VVeIt/E12kFHJMCUhxbKMXsgUgKdLb+R6Nknjo3V1iCsqc5doTTk8TsA
	pXGn5gfTR+1/DQE03M2g/Jer7Jdc2EnzVggVwHlaN2sToVDHSBfM8r6GuWWhtdkiYX2vlv
	L/UMaitaZdu6WbNBqaDxYCUEfmZeU4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-fUfLTIZSPE24s4BrvPuQOA-1; Wed,
 12 Nov 2025 20:39:14 -0500
X-MC-Unique: fUfLTIZSPE24s4BrvPuQOA-1
X-Mimecast-MFC-AGG-ID: fUfLTIZSPE24s4BrvPuQOA_1762997952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43DEE18007F2;
	Thu, 13 Nov 2025 01:39:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753CF30044E0;
	Thu, 13 Nov 2025 01:39:01 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:38:56 +0800
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
Message-ID: <aRU2sC5q5hCmS_eM@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora>
 <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_173924_350538_7AF6115B 
X-CRM114-Status: GOOD (  25.10  )
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

On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
> On 11/11/2025 8:08 PM, Ming Lei wrote:
> > On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> > > On 11/11/2025 11:25 AM, Ming Lei wrote:
> > > > On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> > > > > As CPU core counts increase, the number of NVMe IRQs may be smaller than
> > > > > the total number of CPUs. This forces multiple CPUs to share the same
> > > > > IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> > > > > performance penalty can be observed on some platforms.
> > > > 
> > > > Can you add details why/how CPU cluster isn't aligned with IRQ
> > > > affinity? And how performance penalty is caused?
> > > 
> > > Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
> > > L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
> > > dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
> > > remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
> > > cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
> > > CPU31, it will have cross L2 memory access.
> > 
> > 
> > CPUs sharing L2 usually have small number, and it is common to see one queue
> > mapping includes CPUs from different L2.
> > 
> > So how much does crossing L2 hurt IO perf?
> We see 15%+ performance difference in FIO libaio/randread/bs=8k.

As I mentioned, it is common to see CPUs crossing L2 in same group, but why
does it make a difference here? You mentioned just some platforms are
affected.

> > They still should share same L3 cache, and cpus_share_cache() should be
> > true when the IO completes on the CPU which belong to different L2 with the
> > submission CPU, and remote completion via IPI won't be triggered.
> Yes, remote IPI not triggered.

OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
remote IPI is triggered in case of crossing L3, which is understandable.

I will check if topo cluster can cover L3, if yes, the patch still can be
simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
and adding nr_sub_nodes.


Thanks,
Ming


