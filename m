Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE96C55822
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnUkZ+BpvB6NJMBSwlqfaw25gpgbDKwOED+dgjvhpkw=; b=Oi9Fr0dPKzRcOildK53d62TGv3
	2JYF+DQg7P32U6wuWGVZ8Q6fU0wj+HAn2Zju+LFfL77C+P+45H46Ve8sI47CTbXF9qbXWfvwVtILz
	wf7WYkyaPEgtyjHIIV1UbypStmaOM2EtXEfpvRd0AYlJBB2R/MDGdiYJRG6jh7C71yKAsq0q/obDE
	siUlA/eyjpIzBgedU30BmMMISpIf8ixOwZpMQiqY0+lBc/Y2PH6CuDTpkmi5Yx77Qn42ABookcyP5
	V7weBe1CjQnqFWKD8PyILUUNdiVrQo2w8V5eDoIP4hVf/Xer7qLtyQ+/Qt7Pl0WlHOm2lQDGG0Sfi
	1gAFwNTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEsW-00000001syR-46pC;
	Tue, 04 Aug 2026 13:08:20 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrEsM-00000001swF-41go
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 13:08:16 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260804130803epoutp021a98ddd097d463ed11e0ef67bebd9ddf~InBjpTa2x2932529325epoutp02h
	for <linux-nvme@lists.infradead.org>; Tue,  4 Aug 2026 13:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260804130803epoutp021a98ddd097d463ed11e0ef67bebd9ddf~InBjpTa2x2932529325epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785848883;
	bh=jnUkZ+BpvB6NJMBSwlqfaw25gpgbDKwOED+dgjvhpkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OShnb30OmDCN7E9+MoRuI4JEsIpY5Hh1ODkmuLwyc8cZxE/AbMZ8qqGRsNeQMT5Al
	 p1oYOv6Rt9OGbQiX1W0ViZE8L/hKWsH6bZQqFTRdmOEd8aGf/aj11dwarZ7c5gDQjP
	 lX5PIVWnZWxcpzcPLT38f4qL0WApg9lCVkJP9Dzw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260804130802epcas5p2b30cb9f257983bef8dfcc34c78546576~InBivRhgm0321903219epcas5p2u;
	Tue,  4 Aug 2026 13:08:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4hDv3k0Lfpz2SSKY; Tue,  4 Aug
	2026 13:08:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260804130521epcas5p4d81ad6c4799150dc98794e56a1e2edf2~Im-M2doGg1490014900epcas5p4Q;
	Tue,  4 Aug 2026 13:05:21 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260804130518epsmtip1fa8d46a6cc1711f0a75e79ae2282e8b9~Im-KEFLsU0310603106epsmtip1j;
	Tue,  4 Aug 2026 13:05:18 +0000 (GMT)
Date: Tue, 4 Aug 2026 18:35:04 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Alok Rathore <alok.rathore@samsung.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "axboe@fb.com" <axboe@fb.com>, "Liang, Dan"
	<dan.liang@intel.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "rrendec@redhat.com" <rrendec@redhat.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Li, Tianyou" <tianyou.li@intel.com>,
	"tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "asml.silence@gmail.com"
	<asml.silence@gmail.com>, "cpgs@samsung.com" <cpgs@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, "alokrathore20@gmail.com"
	<alokrathore20@gmail.com>, "nitheshshetty@gmail.com"
	<nitheshshetty@gmail.com>
Subject: Re: lib/group_cpus: make group CPU cluster aware
Message-ID: <270056930.01785848882032.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>
X-CMS-MailID: 20260804130521epcas5p4d81ad6c4799150dc98794e56a1e2edf2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>
	<561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
	<DS0PR11MB801889FC50AAB91FCCAF8D3A92C92@DS0PR11MB8018.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_060811_643724_43458FD5 
X-CRM114-Status: GOOD (  12.82  )
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

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/07/26 06:58AM, Guo, Wangyang wrote:
>> For higher number of jobs(>=64), we are seeing ~8% regression with this patch.
>>
>> HW info:
>> Intel(R) Core(TM) Ultra 7 265K
>> CPU=20
>> IRQ-CPU are 1:1 mapped.
>
>If IRQ and CPUs are 1:1 mapping (20 IRQs/20 CPUs), the patch would not change anything. Every group is exactly 1 CPU, same as before.

We see its not the case, before this patch, irqs smp_allowed_list was
sequential, but after the patch this changes.

Hardware:
Intel(R) Core(TM) Ultra 7 265K
- 8 P-cores (each its own cluster, own L2)
- 12 E-cores (3 clusters of 4 CPUs sharing L2)
- 1 NUMA node, 20 CPUs total, 21 NVMe queues(admin+io)

Cluster topology (from cluster_cpus_list):
{0} {1} {2} {3} {4} {5} {6} {7} {8-11} {12-15} {16-19}

Before:
/proc/irq/168/smp_affinity_list:0
/proc/irq/169/smp_affinity_list:1
/proc/irq/170/smp_affinity_list:2
/proc/irq/171/smp_affinity_list:3
/proc/irq/172/smp_affinity_list:4
/proc/irq/173/smp_affinity_list:5
/proc/irq/174/smp_affinity_list:6
/proc/irq/175/smp_affinity_list:7
/proc/irq/176/smp_affinity_list:8
/proc/irq/177/smp_affinity_list:9
/proc/irq/178/smp_affinity_list:10
/proc/irq/179/smp_affinity_list:11
/proc/irq/180/smp_affinity_list:12
/proc/irq/181/smp_affinity_list:13
/proc/irq/182/smp_affinity_list:14
/proc/irq/183/smp_affinity_list:15
/proc/irq/184/smp_affinity_list:16
/proc/irq/185/smp_affinity_list:17
/proc/irq/186/smp_affinity_list:18
/proc/irq/187/smp_affinity_list:19

After patch:
/proc/irq/168/smp_affinity_list:1
/proc/irq/169/smp_affinity_list:4
/proc/irq/170/smp_affinity_list:0
/proc/irq/171/smp_affinity_list:5
/proc/irq/172/smp_affinity_list:6
/proc/irq/173/smp_affinity_list:7
/proc/irq/174/smp_affinity_list:3
/proc/irq/175/smp_affinity_list:2
/proc/irq/176/smp_affinity_list:8
/proc/irq/177/smp_affinity_list:9
/proc/irq/178/smp_affinity_list:10
/proc/irq/179/smp_affinity_list:11
/proc/irq/180/smp_affinity_list:12
/proc/irq/181/smp_affinity_list:13
/proc/irq/182/smp_affinity_list:14
/proc/irq/183/smp_affinity_list:15
/proc/irq/184/smp_affinity_list:16
/proc/irq/185/smp_affinity_list:17
/proc/irq/186/smp_affinity_list:18
/proc/irq/187/smp_affinity_list:19

I think this has to do with cache locality effects, when tasks run on
"wrong" CPUs. If you want us to check perf data, we can run that.

Below patch[1] fixes the issue for us. Basically keep the cpu order if
resources are equal, meanwhile keeping the benefit of your patches for
clustering.

[1]
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -109,7 +109,11 @@ static int ncpus_cmp_func(const void *l, const void *r)
{
	const struct node_groups *ln = l;
	const struct node_groups *rn = r;

-       return ln->ncpus - rn->ncpus;
+       if (ln->ncpus != rn->ncpus)
+               return ln->ncpus - rn->ncpus;
+
+       /* Tie-break by id so equal-ncpus clusters keep discovery order */
+       return ln->id - rn->id;
}

Regards,
-Nitesh

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_
Content-Type: text/plain; charset="utf-8"


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_104d19_--


