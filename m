Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C98C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xuSJbhDHV1hnmOB0hRVne0+i3U4mZfkf8uodrM2tkdo=; b=V3TvsSzD1gj6/uks5SbL+/DD3F
	QVcufAzShcJV3bZl73AdhMsCh+/ky9bfDhv8TRhBH+uLdsSbYpFAduYm9P1+JAFXQFqQLq7tuFp5q
	3DyWIXkyws4ykTFKg89FaTd+iXc53RbNc4hHRRXNgXc0Hca/hwKKWrVju3jbog0+oZCnaLf013YsR
	Ri/hm1I7BacIef4dTV8QqgHnc8oRzM8tFqXxmZixlGceuPjxgo+fervTdTWC+cmyJArF4hEpJ+MCa
	uGoAvmRi/+SgvAinN+p278QQ7OqChgAnsooi6Or49HyjliBl5SP6gmOkHfZQZYBsFTDptiwGJO0jM
	WvSSUMlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOTf-00G8QM-35;
	Mon, 03 Apr 2023 18:00:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjOTd-00G8PG-2p
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 18:00:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1ACFC61F56;
	Mon,  3 Apr 2023 18:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9698C433D2;
	Mon,  3 Apr 2023 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680544820;
	bh=OAdREJ98WBCtXKCCtZaL+kKO7LD1uHZwB9WFPjq8K74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa7GrQ2bKTddu1wlPxosCMS6U1ezmYu2wgF9fqT2JSfSUaXd+ujyy3IO8G3+B1Xyu
	 vck0maujpj4QLaZth7kAqF/bPqsJ9pDvN9jXP82GwqloKRK2pbZK2la8TbY0UslP5X
	 LdIQiut22SY+zZhi/0/D3M0bjy4ov7VVwMKO8p58iBN0g0BOASCm7vAWptWMTyFirc
	 fwUxZ3+SP1tdq2lsrJsouBc7O2AeJ0yPlDZodnpivc/5rlmG5WkihwVo+tHey5EWMd
	 zhoc+hImWUQB5w5dREWr7CgEGjS+JdyV1Hlp7C97mZxHcxhFFTyOMm8wyFzcywnTDa
	 V1X9tM19Fl+lw==
Date: Mon, 3 Apr 2023 12:00:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Laurence Oberman <loberman@redhat.com>
Cc: minlei@redhat.com, jmeneghi@redhat.com,
	"Hellwig, Christoph" <hch@infradead.org>, axboe@fb.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Issue with discard with NVME and Infinibox Storage
Message-ID: <ZCsUMR3uLx+vPoOp@kbusch-mbp.dhcp.thefacebook.com>
References: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1dbb7c5eca51993e9988849ab2e43e800ecb067.camel@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_110021_989730_EB66C097 
X-CRM114-Status: GOOD (  24.57  )
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

On Mon, Apr 03, 2023 at 01:35:22PM -0400, Laurence Oberman wrote:
> Hello Ming and Christoph
> 
> Issue with Infinibox storage
> ----------------------------
> Really discovered 2 issues here 
> 
> Issue 1
> Kernels 5.15 to 5.18 inclusive recognize the discard support on the
> Infinibox device but they fail in the nvme_setup_discard function call

This first i ssue should be fixed with this commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=37f0dc2ec78af0c3f35dd05578763de059f6fe77

> Issue 2
> Trying to narrow this down.
> 5.19 and higher (6.3 included), no longer support discard on the
> Infinibox device and log this message so I cannot run the test for the
> discard issue
> 
> [   35.989809] nvme nvme1: new ctrl: NQN "nqn.2020-
> 01.com.infinidat:36000-subsystem-696", addr 192.168.1.2:4420
> [   64.810437] XFS (nvme1n1): mounting with "discard" option, but the
> device does not support discard
> [   64.812298] XFS (nvme1n1): Mounting V5 Filesystem 6763a33f-18cc-
> 4a26-894b-8b0f8d79a98a
> 
> I then bisected between 5.18 and 5.19 to this commit
> 
> 1a86924e4f464757546d7f7bdc469be237918395 is the first bad commit


> commit 1a86924e4f464757546d7f7bdc469be237918395
> Author: Tom Yan <tom.ty89@gmail.com>
> Date:   Fri Apr 29 12:52:43 2022 +0800
> 
>     nvme: fix interpretation of DMRSL
>     
>     DMRSLl is in the unit of logical blocks, while max_discard_sectors
> is
>     in the unit of "linux sector".
>     
>     Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
>  drivers/nvme/host/core.c | 6 ++++--
>  drivers/nvme/host/nvme.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> 
> Note that Infindat mentioned this in our case they logged with us
> They say they fully adhere to TP4040 MDTS.
> Towards NVMe-oF 2.0 specification, TP4040  - Max Data Transfer for non-
> IO Commands (MDTS) was released with additional fields to control these
> parameters.
> These parameters are supported in kernel versions 5.15 and above.  ****
> 
> Our storage target will reply with 0 for bit 2 of the ONCS, indicating
> UNMAP is supported based on the DMRL, DMRSL, and DMSL values. 
> (older kernels will interpret these values as UNMAP NOT SUPPORTED)
> 
> 
> Let me know your thoughts please. for both issues

The commit you found unconditionally sets the discard queue limit to the
reported DMRSL, so it sounds like your target is reporting DMRSL as '0'. Prior
to that commit, we'd use that value only if it was non-zero. I hope that helps.

