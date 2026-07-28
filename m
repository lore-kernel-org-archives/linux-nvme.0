Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D237C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMumBf6pcwJN35QNg21EPnkz/AZt8LVlK2YGNnvhzR0=; b=opIf8INXm2yLjNNrQePNTv2uYh
	6LBaVjF1K/5AyvCjBoL4PJFnUxl/T5m2LxlXWJP7Z+MylZyFDCGl2pGtird9cFGa1H8wFNvq7EdOV
	MWOamNAVpvpJH53W1tmqECaU0ApX2Aojg1SQZQIfiYY77OnSRNcER1Nty/lo5+vkx5xwVXEHIQbtQ
	oXxne+wVk1HkKGFmAFdkEwG/AQ6CAHOpvu/6MKmZ4WcyV9krcLvqUZ6dp5b7IHEz/rTP9/tPpX/x3
	KpnBMKiw9y3m+2p8dF5NLGjKAGH8NAcW57DkGhGvisYPXA/Zv+dv+vkOXkBkzS1gEGCv0LuP5Ktp4
	4+d3XPOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wozl0-00000007FEv-1yhP;
	Wed, 29 Jul 2026 08:35:18 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wozkv-00000007FB8-1EFl
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 08:35:17 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260729083503epoutp0464ea8448ebefe006dbac0040965bf576~GtbfPB_x80385403854epoutp04c
	for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 08:35:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260729083503epoutp0464ea8448ebefe006dbac0040965bf576~GtbfPB_x80385403854epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785314103;
	bh=nMumBf6pcwJN35QNg21EPnkz/AZt8LVlK2YGNnvhzR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=saiJoAhy/r7KRwVHHR7YIjl+Nj7jXx0336/L9WpCTejiCSFqRiZqSbxMvaUbv8NU+
	 kkSUaNQ8zh8zuU9bBheB7sAGTwYiYPlFaARqwxR9n2aNYqgqXqjBwiJx3DUq/t9TEv
	 QBtUstpUNwLJo7RQ4CaoQbXAPVsNOYFEScxUaHCY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260729083502epcas5p2956791f6317ffa4deaefdfb2eaa3c15c~Gtbeng5sa2833528335epcas5p2F;
	Wed, 29 Jul 2026 08:35:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4h95HV4cXxz6B9m7; Wed, 29 Jul
	2026 08:35:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958~Ge8rj7-9K0791907919epcas5p40;
	Tue, 28 Jul 2026 14:53:33 +0000 (GMT)
Received: from green245.samsungds.net (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260728145330epsmtip1f20094ebf53bcd1bb08fe2dba866c798~Ge8oxGFnu0743207432epsmtip1b;
	Tue, 28 Jul 2026 14:53:30 +0000 (GMT)
From: Alok Rathore <alok.rathore@samsung.com>
To: wangyang.guo@intel.com
Cc: akpm@linux-foundation.org, axboe@fb.com, dan.liang@intel.com,
	hch@lst.de, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	ming.lei@redhat.com, rrendec@redhat.com, sagi@grimberg.me,
	tglx@linutronix.de, tianyou.li@intel.com, tim.c.chen@linux.intel.com,
	virtualization@lists.linux-foundation.org, asml.silence@gmail.com,
	cpgs@samsung.com, gost.dev@samsung.com, alokrathore20@gmail.com,
	nitheshshetty@gmail.com, Alok Rathore <alok.rathore@samsung.com>
Subject: Re: [PATCH v2] lib/group_cpus: make group CPU cluster aware
Date: Tue, 28 Jul 2026 20:23:03 +0530
Message-Id: <561480862.11785314102640.JavaMail.epsvc@epcpadp1new>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260113022958.3379650-1-wangyang.guo@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958
References: <20260113022958.3379650-1-wangyang.guo@intel.com>
	<CGME20260728145333epcas5p427c6b6d72bff02de3f29e6a6a2108958@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_013514_798402_01E74143 
X-CRM114-Status: UNSURE (   8.25  )
X-CRM114-Notice: Please train this message.
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

For higher number of jobs(>=64), we are seeing ~8% regression with this patch.

Tool: fio with io_uring engine [1]
+------------+------------+-------------------+  
| numjobs    | before     | after patch       |  
+------------+------------+-------------------+  
| 1          | 89         | 88.8 (-0.22%)     |  
| 2          | 169        | 168 (-0.59%)      |  
| 4          | 338        | 337 (-0.30%)      |  
| 8          | 533        | 533 (0.00%)       |  
| 16         | 538        | 541 (+0.56%)      |  
| 32         | 685        | 716 (+4.53%)      |  
| 64         | 933        | 859 (-7.93%)      |  
| 128        | 941        | 867 (-7.86%)      |  
+------------+------------+-------------------+  
* Metric: IOPS (K) (Block device, QD = 1, bs = 4K, Random Read)  

As shown in the table above, while performance is comparable at low job
counts, there is a drop starting from 64 jobs after this patch.

HW info:
Intel(R) Core(TM) Ultra 7 265K
CPU=20
IRQ-CPU are 1:1 mapped.

[1] fio -filename=/dev/nvme0n1 -direct=1 -size=4g -rw=randread \
-numjobs=$(numjobs) -bs=4096 -ioengine=io_uring -iodepth=1 \
-name=uring_test --registerfiles=1 --ramp_time=5 \
--group_reporting --thread


