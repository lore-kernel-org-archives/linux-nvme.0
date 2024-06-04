Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFC6C27C50
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 21:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jaugznEUbIr1t+8hPuoTXys0fk4kmzGkWUCp9gDlqak=; b=kldL/d+lSYERStdS+snq4BjGSV
	EZp98hmxoUKeh3t51TUhlMP1b2O4bMPmHbKNjQNL1yMaJBF7jNIOoOyj5xJsyl7qDQ7DOyLiH+jkc
	jiYZTC+Jt/K1N4sH+G7lWCJj/VGFGUznvav1p3mAyvCkYfYHO5FycU3FkWjJFa5J2uZ3xvZ0c1Wfk
	CfbPXO2dNzeAfsovMwvP1TD/SnBCTH1ycFM9wqrmz613fSn8MVDiBD2OtzsAqRdQ7OeNR17ihjFdn
	a825o4dF0TqLPPOaAyxlR7I1yrnj+aib98L6Y0/U8NwlbDk+fILAWI/leOCbXcYZe1jiTQgHmElVu
	GijMgZgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbr6-00000003sbt-0bLg;
	Tue, 04 Jun 2024 21:38:08 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEbr2-00000003sZO-3YgA
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 21:38:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7900CCE0A89;
	Tue,  4 Jun 2024 21:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E893C2BBFC;
	Tue,  4 Jun 2024 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717537080;
	bh=a0SurtCVK6gmdLViDFjLX0U6xpqpO+B0F3wfwsYzIP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qR/8kbIqzzfXjQ8+bnu7E3Kxwi6A/1QNFgAUImP3fIhZVWpugf8iThoHSLSZOwNE9
	 PF9ZQ1R8KEzcZZt9sTJ2AGsmP8zHAIfVSzHAwLcS970olPNz3hUFwqMEQOzJzqo8Gj
	 Vi+Y2j6SF0dmZGXt+BmDzYckngt6N5vkgnntncHwH2Bf59m1U6bauMrkcPMvDiqBco
	 9A/ZxZmtyN2QnVRMcHFSkFbxKDz5pudO4Oy3hh8M/jgcLr+NobGZzQarK3roCWJJUA
	 mcv+nFpGeHJCuBtJwG8XAzXCYJgsBQg7utIkRvZHTzq6+Rhs2gPGvJpiBaWcK04chY
	 K5Oj74MCd9O4w==
Date: Tue, 4 Jun 2024 15:37:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jigao Luo <jigao.luo@outlook.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [Question] Configuring CPU Cores for NVMe Target & Host in Linux
 Kernel
Message-ID: <Zl-JNqNySZk71_3F@kbusch-mbp.dhcp.thefacebook.com>
References: <GV1P195MB205539399CE53BDAF0D58AE6EEF82@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1P195MB205539399CE53BDAF0D58AE6EEF82@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_143805_085143_ED8E4BB5 
X-CRM114-Status: GOOD (  16.78  )
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

On Tue, Jun 04, 2024 at 11:10:30PM +0200, Jigao Luo wrote:
> I am benchmarking NVMe over Fabrics Target and Host using both the Linux
> kernel driver and the SPDK driver. In SPDK, there is an option to specify a
> core mask that limits the CPU cores on which SPDK can execute work items.
> The SPDK team provides a benchmark report that demonstrates the core
> scalability of NVMe over Fabrics Target and Host: https://ci.spdk.io/download/performance-reports/SPDK_rdma_mlx_perf_report_2401.pdf
> 
> I am curious if there is a similar parameter available in the Linux kernel
> target/host driver. I have not been able to find such a parameter. Can you
> confirm if it is possible to configure the number of cores used by the Linux
> kernel NVMe driver? If this configuration is not available, could you
> provide me guidance on understanding core scalability in the Linux
> implementation?

You're using RDMA, so you can assign CPU completion interrupts however
you like through the /proc/irq/*/smp_affinity interface.

On the submission side, you can steer user space programs to some subset
of CPUs with the "taskset -c" command.

For the kernel side, you can mostly set which CPUs can dispatch IO with
the "isolcpus=" kernel parameter.

