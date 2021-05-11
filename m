Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E08C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 21:38:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3FD361185
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 21:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FD361185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZurDFwOOqehXy0k1C+iet6Bbm/F8XYaRhVIHqGU2yjw=; b=CXFUPNQs5f2OfVsNrgvmm2WQc
	C92fCsIFugPYoU9FeCepZa1khnpm4LxCtoTTbtUokhkLT6iH2ekRSbyGpI8PvEfA7DOmVoVLjtEa0
	Nb3c6ltNVrYPfGgmTa8tlZ/hUKBcxZpO0t/xpIqdXgEAMJjhJ9Rl0zSXFSsFhLVizzOx9cI0rQHAL
	k3D6yPDta8gIpfJgyYiStUjPwfQHD1/KsrM8ABGFFM1Cg+c6eJNX8u1qXfEacwN2UdysOqfF76KWy
	Yu0mfi3xtzD2eR6D7SCKUuI3lK0Qq1yQr0DHgWkaRjls+j6JYg1TioPYNJeuLP54t/pXjjM0sEkbm
	rDncLgcDA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lga4d-001LxY-DP; Tue, 11 May 2021 21:37:51 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lga4Z-001LxC-SW
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 21:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w2K8/KxlrrStwsOt8VzgMKgw7hqHU6gROfkR1vHB/Z4=; b=aPgh7+mg5jpqLisCOp96wZq+BA
 nDq4aEfVm6iBvt9WTPrcJx9PkNxZEapj4CmqokxCOhDvSZ4AcoJDLle4E2z2aAQmK5kriS2YyDxi9
 Fwm3v01CA6E6aOyG/CXnZBdmxq5mVeP/EH9+dUk8Qd3brb5Eo/elFULijeYvLxnItWr3M24eYL3Mh
 tPa5PAgu4dZTeJvEug5nXyOTpW1nfHs3t5XB92yggF0cP8ijv9p0G5x4WsLmnaX/5VvasOnaHUGaZ
 9kt6fzlcYPF/jKTpgCoTBTqU29kSPQK0rJ06uDC0g6PegukZUtoHxLCfIyzBk77LWVQLNvIDMCDlW
 1CQcpGkg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lga4X-009vm5-77
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 21:37:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 814C261185;
 Tue, 11 May 2021 21:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620769063;
 bh=w2K8/KxlrrStwsOt8VzgMKgw7hqHU6gROfkR1vHB/Z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f7JmWIlha0J3y3plFVc7q5f/7S5wV76cHIARaHo6qkts+afnTR0MIPhpnvkwiv3FZ
 XOTsosaGV7K+w0+H+CpoJyLFfaL/W7EpF1xMV0KYqXyOiydFYr/Uu8uDCRF6p2vnG1
 kZs3S8tLW8yrXjEZOERrOlxsbBHvv9s86d9MdyKnsdRuh7+iKxZb7Zzlc8R6WzuwnL
 66VWdpZkLtkbiR4Y/ZizQ8aekVersNtyMvFsigi15RyrAMm5Lda/vp1DDZYV9Wfvxw
 JDY5/pOB+3bQALk78pbwtJLoFCBFgNG4w3b69bzEunr2UYI1vZoPaXk6eZETsclrMc
 8uLUWvGa+uFwQ==
Date: Tue, 11 May 2021 14:37:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
Message-ID: <20210511213741.GA1924433@dhcp-10-100-145-180.wdc.com>
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_143745_331096_A77C5AE0 
X-CRM114-Status: GOOD (  13.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 10, 2021 at 03:25:04PM -0700, Sagi Grimberg wrote:
> Hannes, you sent a patch like this before, my comment was that a nshead
> should be removed before the final reference (which who knows when it
> will ever arrive) as if a nsid were to be reused by the controller for
> a different namespace then we'd reject it so I'm not sure how this helps?

Hm, you're considering something like if a user does namespace
management commands to delete one that is in-use (mounted, raid, etc),
then creates and attaches a new namespace that happens to be assigned
the same NSID.

The new one may get different EUI/NGUID values, so this approach here
would prevent the namespace from being usable without additional user
intervention. I think we'd want the driver to allocate an entirely new
head in that case if we could detect that's what happened. There is also
a possibility that the controller recycles the same NGUID for the new
namespace, and that could be confusing for the application holding the
open reference on the old namespace.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
