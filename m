Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C1C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:53:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891072072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m1jr8c1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891072072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f64356iJczztsrf6oIhLzIM7+/t6EVafGKikSCIrpQg=; b=m1jr8c1zmTjNpNWurwk/C0QEt
	UbnRDuL11WB3D5F1Y5xyDsx52foe5A1m1IaAsfL81/63cf6ICWYa2oJ2vAR2nStl/N7N04l/w1Lj/
	g0ESdDzZagCcFCAtB+b6bEGVgyLvflbGqzbD6bsR+7UrKGyB2/CTUwq2Lyb8KFQmZkEeJQlt05GVf
	oVFfoe33XQZD+Y0sDiucoThAeelm4Cr+xp8eaWTsWBwWlurNRejnTfQzLHqK+QfHsdF7h4FQlqKdi
	hW9GgTJr5jg87gJYwj8sH3tu/OAFfwH3ZtcfZtw/rdmx0LIUbQF6j4LS4RKFvmfDyImtcOff4oCrU
	DYXbndJEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzHN-0007kq-VB; Wed, 24 Jun 2020 06:53:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzHJ-0007jU-L6
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:53:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ACFC668B05; Wed, 24 Jun 2020 08:52:58 +0200 (CEST)
Date: Wed, 24 Jun 2020 08:52:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] nvme: Add Arbitration Burst support
Message-ID: <20200624065258.GA18130@lst.de>
References: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
 <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32d99c016d23d660f5be4a9754b5b9aafe81ab6c.1592980985.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 02:49:57PM +0800, Baolin Wang wrote:
> >From the NVMe spec, "In order to make efficient use of the non-volatile
> memory, it is often advantageous to execute multiple commands from a
> Submission Queue in parallel. For Submission Queues that are using
> weighted round robin with urgent priority class or round robin
> arbitration, host software may configure an Arbitration Burst setting".
> Thus add Arbitration Burst setting support.

What is the value add of doing this in the kernel?  Wouldn't a nvme-cli
subcommand to just set the arbitration burst to the recommended value,
either as a saved or current value be both more useful and also cause
less kernel bloat?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
