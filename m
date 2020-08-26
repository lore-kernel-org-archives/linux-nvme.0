Return-Path: <SRS0=GC6h=CE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF19BC433E4
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 15:13:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC8A2224D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2020 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fa4PZq05";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs4NxeDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC8A2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sN4foDaUuSoqlokkQ7Q0jixynKoN2f+25mdIDHk5LoA=; b=Fa4PZq05FtZVCT134KV7mCWew
	Md4Xw+EbQWlRgpISj5NwGcYgkbogte7S5buUuSQm2WvWDnKf4C/I2MAp/Y2iGnE6zZqkzL+FVliA9
	4WNsOJlY3ojG9vLzryDN0JNnUpGQoceSlEoWTnw9wsteGGZ2GDMKxKwUgEAR+VQEeLAb/yjTisLkN
	47XQ91obhrvXWPwQxfkoYdsgU7AGAHFT+utXaq0SEZGZVcaagMTjZQ1w9ZsuVKbl/YSa2jG7IXTFX
	bWGQ9PpKM7lOLtR4S3jgYXG9I9ZY889QjU2dffmhMjH0555IECM0JcfTPFDAbM3XEPTP7/S+Xl6zv
	FNqJsNHhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAx7S-00033H-76; Wed, 26 Aug 2020 15:13:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAx7O-00031g-6C
 for linux-nvme@lists.infradead.org; Wed, 26 Aug 2020 15:13:44 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00B1B20707;
 Wed, 26 Aug 2020 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598454821;
 bh=+ZngHm95Ec17RxdYlyQNkRZozlY1xXjvmVWpEzkkpYM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gs4NxeDF9d/7d5S89e0oHulJF3/Qm8sG5Zgg2NZlxzSIfZINEapY80gmmgRBTI1Ob
 hGybqyAHv+ZDWZCJj3j/RE4KfZXHHEceUSQN3qPI2rpZGMRN6sJxlqXfABxRcM5qHw
 L8tm7UO5AEPC59E543Xo6ZKnCLHsueq621mFnKdQ=
Date: Wed, 26 Aug 2020 08:13:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] nvme: add support for non shared namespaces
Message-ID: <20200826151339.GB2149583@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200826104903.85321-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826104903.85321-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200826_111342_531009_CCDCD166 
X-CRM114-Status: GOOD (  12.69  )
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
Cc: sagi@grimberg.me, israelr@nvidia.com, linux-nvme@lists.infradead.org,
 hch@lst.de, nitzanc@nvidia.com, Max Gurtovoy <maxg@mellanox.com>,
 oren@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 26, 2020 at 01:49:03PM +0300, Max Gurtovoy wrote:
> Currently, nvme-cli assume that all the namespaces in an NVM subsystem
> are shared between all the controllers. There is an option to create
> both shared and non-shared namespaces among the controllers in the same
> NVM subsystem. For example, in SR-IOV environment, one can attach 1
> namespace to each controller that will be private and also 1 namespace
> that will be shared among the secondary controllers only. In this case,
> the output of "nvme list -v" will be wrong:

Thanks, Max. This looks good, patch applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
