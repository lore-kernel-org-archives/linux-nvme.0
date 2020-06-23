Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFECEC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:40:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18AB2053B
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qlR57uy4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOJxywei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18AB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M91dvBf4bJjWCgbsSpNMamrFqaQPko7jsDEOsYPntB8=; b=qlR57uy4tqBGJC5OzwQiCnABj
	bluQHlUEs3uT7ZHEt+BwRxvCZbaXJYwXPTQ0uWJMQhVX4rtYA73HkXNYerDN18dTfdfxvELI1XnP2
	pTgdYll37hD3pgi7MKQ1akl+K/q+RBsQSvWShJuqzL2NDU6ezVwXBwwlHuglnIvvQP+FAgoL525L1
	WqXocbf9LHq267GJGus6m1rJQuGkXFlRxVQTsPE//t47QGLxO5Qr7Dfg8N1dxyCtJU/6nqExygWJd
	ahBt07JtPvhopffZhc6HqtYiCakR999nFknd60wVRDh2J/Ac7ocXYUUgkYlt9YbrlPm4ZnIa9xXmC
	d7JC31+9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnk6J-0007NH-Nc; Tue, 23 Jun 2020 14:40:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnk5x-0007MW-72
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 14:40:17 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0CE362053B;
 Tue, 23 Jun 2020 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592923216;
 bh=2gzWQlrlUbt8yYSj3sO6iIOtsSAOWbEMJh9zFKnUe2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IOJxyweiOt7o/Z2CRcui4ao8o1ebr70thXezTE5YZXPjHqEztwWy49qsTzyrhoG+B
 YkAp6n7KmAJDAEKAdAPxGcN+xCraiaZ4KPRSR1oxLFclIX87YCfokQEO2Thhdfr4G1
 mtl5M8jX9U99IMl3/tsVByW80AomcjrO2Essh3Ss=
Date: Tue, 23 Jun 2020 07:40:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200623144014.GB1288900@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
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
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> From the NVMe spec, "In order to make efficient use of the non-volatile
> memory, it is often advantageous to execute multiple commands from a
> Submission Queue in parallel. For Submission Queues that are using
> weighted round robin with urgent priority class or round robin
> arbitration, host software may configure an Arbitration Burst setting".
> Thus add Arbitration Burst setting support.

But if the user changed it to something else that better matches how
they want to use queues, the driver is just going to undo that setting
on the next reset.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
