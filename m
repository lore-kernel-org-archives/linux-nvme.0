Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0C1D31769
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ceBx3cIHttB8VPv/1bsUmb76RI1TKfrmhGkNAR30y8=; b=tOpPsdiS9GbwX039acDJoN+Hd1
	HY23oW+X44IU7eQuTQuHocyIsxhPmzOBnNP0zreyT68zXYEUssdv3JGGtrtnTD6wF1mJeLcR7PS3R
	UKdjZgP/sC8xvkZ2GF+9qzUIz0ior4DHAVrSW/2Fc4TQ7w5fO2Bb3aubFQjxii/RJoOLoB3CI5YGx
	y1mQrVMSjVdzoz96LXwPrQfejfVfKIVhj03jqBWNwh+4Dac1z6+9JBGQJJDUO5vKOvKFlv5easKWP
	oJbyagKrKGfSCWfCfiOPnZEe4tYR8sjWDP9QgnltFK6z9wmJoOl4yVYfLsBJiEfA72liKtP/e6vE/
	yTSbDnhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NUG-00000000Ehc-0OAy;
	Tue, 05 Nov 2024 17:37:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NSM-00000000EP2-2OjI
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:35:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0655C5C4BEB;
	Tue,  5 Nov 2024 17:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB221C4CECF;
	Tue,  5 Nov 2024 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730828105;
	bh=bTTfd0JL1pocATVx+bbcnfvCVG+BFvJaZneVwV8ePLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g61LEcbMjP0OPTdYH8NNCejsvrHy20vfHyiTJIBN00O1J2+YZDQKUXtzwp3mXSSf8
	 zyyNwMH7mtNJ4T9+g88iSnwhq+9qeWB+1u/IASfjKURZjcaJ9W4KeUxE9AW6WRFKDz
	 hOxVQVQ0T6ETzKJBIP5w8GcwzCJSPTDYFxEfekXS6JInsmcZyzw1EH0g8sNM2vLW7S
	 7JIaqybxxWyT7JKyqOCG6l+nefP4uW4DKHuegg7mEJNwlMs++s0rvYY674wg8sq8Wa
	 o5vE49j8xsNfs0us0yYXjeAAkqj2jjDf9qaW70KbhskPvbjOVRqgL22BTaRufSOC/V
	 AriPWEK1PpZUQ==
Date: Tue, 5 Nov 2024 10:35:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	ming.lei@redhat.com, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv4 0/2] nvme: fix system fault observed while shutting
 down controller
Message-ID: <ZypXRi8R4uOIrkc0@kbusch-mbp.dhcp.thefacebook.com>
References: <20241105061212.1008143-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105061212.1008143-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_093506_742952_719961B8 
X-CRM114-Status: GOOD (  13.13  )
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

On Tue, Nov 05, 2024 at 11:42:07AM +0530, Nilay Shroff wrote:
> This patch series addresses the system fault observed while shutting down 
> fabric controller. We already fixed it[1] earlier however it was later 
> relaized that we do have a better and optimal way to address it [2].
> 
> The first patch in the series reverts the changes implemented in [3].
> So essentially we're making keep-alive operation asynchronous again as 
> it was earlier.
> 
> The second patch in the series fix the kernel crash observed while 
> shutting down fabric controller. The system fault was observed due 
> to the keep-alive request sneaking in while shutting down fabric 
> controller. We encounter the below intermittent kernel crash while 
> running blktest nvme/037:

Thanks, this all looks good to me. I think Sagi had reviewed patch 2
already, but I'll wait a day or two before queuing this up in case he
has any last minute comments.

