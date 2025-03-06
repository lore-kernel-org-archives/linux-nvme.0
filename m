Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599FBC282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GzcVtYLuIwXLiUH6fZgTvs8oVMg1+gDbgR6VTBxNxQE=; b=cjO24DCyssDXmIpEcNH2P2HL8+
	dzDY9qARCYHskXHcuB/FvWUTk+/10QH/PIID/DQGua412n/fZ6n7glVDxSfloTXgkAnVciCeyERAl
	b0iia7aok5wXeR+VCNHVUQZ/xZXK7TEpyUqUq3IAiJCvqFq8Kezma8CTboEc6U4YsDXT3DPT6yy5r
	dtzpQkt9gxEo/Cdn7TMk6tuT1DcaPo0DgHsPoTExDPyvyThKOBqJKVSUCv074R2Alaef6WtKnlzab
	9qUCUahhvLfH7/gcdKCC4ASMrSfl3PKljFC0KeWfIo5TCcvDad1AQFv+P1XgentKxHZIL2iuiPQEH
	ehLqFy6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqIEB-0000000CAua-0FIG;
	Thu, 06 Mar 2025 20:53:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqI7V-0000000C9lN-2lxu
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 20:47:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A1A7F5C5714;
	Thu,  6 Mar 2025 20:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A85BC4CEE0;
	Thu,  6 Mar 2025 20:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741294024;
	bh=GzcVtYLuIwXLiUH6fZgTvs8oVMg1+gDbgR6VTBxNxQE=;
	h=From:To:Subject:Date:From;
	b=HzJssaA4Nzx3z2R/4738UEe1wTJb+w0CxYL6RJQze8NYIc4rMfz9dmIuwzR+Y4xUc
	 aRPkiNZILcVGc7c+FPUmyGoDEcl51dSuWhqCrfT07WuNOKA7AQZEgVQiR1u5xY3fGM
	 36euFrnzEhVAqDKRuX0aTdOp6AQzXt2Y2OxPDsfuht+3hJDCe5raWfbRysaeE9GMcs
	 J2UbYteLshONIHUjVhU/jRR+NmJU3kkIV9WNfECdHkceNjWOxUts/c3hlGEgwT0Vqd
	 cNN+xZJZzLNVmxPJcHNYUs3Smqz+o0XoyTEmnP8ZUvITxL+L9CVl3xR45TEdAPujzU
	 JJY/GYgyQxLKQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Keith Busch <kbusch@kernel.org>,Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,linux-kernel@vger.kernel.org
Subject: [bug report] nvme: fio workload hangs on 16m random read
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 21:46:37 +0100
Message-ID: <87a59x6g5u.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_124705_755200_1D1A5732 
X-CRM114-Status: UNSURE (   5.51  )
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

Hi All,

My CI system has found an issue for the following fio workload:

root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1

"fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
"--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
"--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
"--runtime=3000"

fio will hang, some times immediately, some times after a few minutes.

I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.

Can any of you reproduce this? I was able to reproduce this on real
hardware and in qemu.


Best regards,
Andreas Hindborg



