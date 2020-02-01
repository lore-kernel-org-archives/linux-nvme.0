Return-Path: <SRS0=trMV=3V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF903C33C9E
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Feb 2020 09:09:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAD7206D3
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Feb 2020 09:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BogMTJWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAD7206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y2wvMq8TnEC2GrNR2DZDejLxucz9X1v/lAMTCwd9Iwk=; b=BogMTJWwokEoOZ
	GLH65Kg0bu0GaIvWXGOsHXJ5c5ei7CJ2PDyZhI22WATExkalkshCoxBV6ITJDAPnTv/veDfJF/4Mm
	HIG2fe/QcQzKLizR/9f4U5TRtNBvuB+z/Orosak9odzeV0RsBf+vjIt+xWDGGGipZZzp9+Ns2HSH3
	m2hnxvrW7p7aJqlRUJn+QGzt/prJGHxEpTdWd6U0w8SWi355CF0my/U2WfquLNrg+wFlTGZ3rN8a6
	3RGRDq2VV+9ryzrjWBbZ1afnaIpwvfTesLnlGo6FLi3kP8LeVjqokvbO5bob7/ulKH10b9GJBXJWE
	JzqY3ujURKHYJx9V33Rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixom5-0000l6-Hu; Sat, 01 Feb 2020 09:09:09 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixom0-0000kb-6U
 for linux-nvme@lists.infradead.org; Sat, 01 Feb 2020 09:09:05 +0000
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51]
 helo=nanos.tec.linutronix.de)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1ixold-0003oU-V5; Sat, 01 Feb 2020 10:08:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
 id 7F0CE103088; Sat,  1 Feb 2020 10:08:36 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk, tj@kernel.org,
 hch@lst.de, bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
 edmund.nadolski@intel.com
Subject: Re: [PATCH v4 4/5] genirq/affinity: allow driver's discontigous
 affinity set
In-Reply-To: <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
References: <cover.1580211965.git.zhangweiping@didiglobal.com>
 <c044e71afa25fdf65ca9abd21f8a5032e1b424eb.1580211965.git.zhangweiping@didiglobal.com>
Date: Sat, 01 Feb 2020 10:08:36 +0100
Message-ID: <871rrevfmz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200201_010904_381222_1BF87626 
X-CRM114-Status: GOOD (  10.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Weiping Zhang <zhangweiping@didiglobal.com> writes:

> nvme driver will add 4 sets for supporting NVMe weighted round robin,
> and some of these sets may be empty(depends on user configuration),
> so each particular set is assigned one static index for avoiding the
> management trouble, then the empty set will be been by
> irq_create_affinity_masks().

What's the point of an empty interrupt set in the first place? This does
not make sense and smells like a really bad hack.

Can you please explain in detail why this is required and why it
actually makes sense?

Thanks,

        tglx

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
