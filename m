Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AE0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jan 2022 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ebm/5MPCyWPNoFZD3Qyo0HuR68Tl1qJJ4yymaEAbIwc=; b=zx6qfqonq2BUK6gIygc9hAOyUm
	qcl31/1sfsml5pQkMoisYJNEUBl+i2WNY+KlI/MfTJbMs2cvMqo1CrpN+Au6fLGetdkzRC02ut6Ub
	GE96LfbNniaGpLHQc1V+0WnnuTtexmFM6/r6KYpZUBt+iVzdyA5z0/tkpaVUKHC8/rICK04K/87cz
	XVRSgKl0iJ3a2/yt1qe3i6GnxgErvX1Af4lHSQ/gjKSkiHnNNgLdYWe2tfPP2ElEZbq3LurVl9W2I
	c8Nn1Lqfv/QSsIQCXZveSzihTD/Enp3pX9iAvAfGGY4PxXeOkTWp8OR/qfuOdsiCoROlam+VUasp9
	O0s/Cppw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n4oqz-00CXya-S5; Tue, 04 Jan 2022 18:48:13 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4oqw-00CXxV-Lj
 for linux-nvme@lists.infradead.org; Tue, 04 Jan 2022 18:48:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B0780B81785;
 Tue,  4 Jan 2022 18:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1CCC36AEB;
 Tue,  4 Jan 2022 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641322087;
 bh=mRV2RX6mbu5jwju1FWJMf5I5Sv34UAOO1+OQd6mmZoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kua0Pvm8EU/KdZUSuU9MeigSzlqgE3hfOc/YZGIkFb8vr4WxMHnAk90rQtmqTFFfq
 /H2fNQZ6oimjNRoe0aKyECVZX0bJMCre0zPKPwyA3IKrHbHtk8FvmB35/cSHcYmbE7
 rSBn64dHrODApe4s9iwWmlwZCc/gKr3tIzzXeFZaxjiQQQ+qK0bA9MTTw+hlyE7siF
 REMPJJG1Goj0hGrguJ9hpX2+oMvL1ZCd2z2jPrv0U7QPsYs2u6FxjejoJDxwngqWAa
 zkfu73jzWCm20PdJpOz1sJDbw7unakOw6QFPnoYwa0bHbN9TBbANmXGo/6BTsP+KZp
 cQ3Z/b85CF2Cg==
Date: Tue, 4 Jan 2022 10:48:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 1/1] nvme: Add verbose error logging
Message-ID: <20220104184805.GA2666557@dhcp-10-100-145-180.wdc.com>
References: <20211223215726.71096-1-alan.adamson@oracle.com>
 <20211223215726.71096-2-alan.adamson@oracle.com>
 <20211227160732.GB2207198@dhcp-10-100-145-180.wdc.com>
 <18CFFBBB-81A4-4F0D-9F94-B543F2D83BD8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18CFFBBB-81A4-4F0D-9F94-B543F2D83BD8@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220104_104810_904928_631CAC8A 
X-CRM114-Status: GOOD (  17.34  )
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

On Tue, Jan 04, 2022 at 06:18:27PM +0000, Alan Adamson wrote:
> > On Dec 27, 2021, at 8:07 AM, Keith Busch <kbusch@kernel.org> wrote:
> > 
> > On Thu, Dec 23, 2021 at 01:57:26PM -0800, Alan Adamson wrote:
> >> +
> >> +static const char * const nvme_errors[] = {
> >> +	"Success",
> >> +	"Invalid Command Opcode",
> >> +	"Invalid Field in Command",
> >> +	"Command ID Conflict",
> >> +	"Data Transfer Error",
> >> +	"Commands Aborted due to Power Loss Notification",
> >> +	"Internal Error",
> >> +	"Command Abort Requested",
> >> +	"Command Aborted due to SQ Deletion",
> >> +	"Command Aborted due to Failed Fused Command",
> >> +	"Command Aborted due to Missing Fused Command",
> >> +	"Invalid Namespace or Format",
> >> +	"Command Sequence Error",
> >> +	"Invalid SGL Segment Descriptor",
> >> +	"Invalid Number of SGL Descriptors",
> >> +	"Data SGL Length Invalid",
> >> +	"Metadata SGL Length Invalid",
> >> +	"SGL Descriptor Type Invalid",
> >> +	"Invalid Use of Controller Memory Buffer",
> >> +	"PRP Offset Invalid",
> >> +	"Atomic Write Unit Exceeded",
> >> +	"Operation Denied",
> >> +	"SGL Offset Invalid",
> >> +	"Reserved",
> >> +	"Host Identifier Inconsistent Format",
> >> +	"Keep Alive Timeout Expired",
> >> +	"Keep Alive Timeout Invalid",
> >> +	"Command Aborted due to Preempt and Abort",
> >> +	"Sanitize Failed",
> >> +	"Sanitize In Progress",
> >> +	"SGL Data Block Granularity Invalid",
> >> +	"Command Not Supported for Queue in CMB",
> >> +	"Namespace is Write Protected",
> >> +	"Command Interrupted",
> >> +	"Transient Transport Error",
> >> +	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> > 
> > Tracking these NULL's is going to be problematic and error prone.
> 
> I don’t disagree, definitely wasn’t fun putting them in there:)
> 
> If we don’t define the NULLs, what happens if the hardware responds with a undefined error status? 
> We will attempt to log a undefined/non-string.

Every index not defined below the maximum defined index is automatically
initialized to NULL.

