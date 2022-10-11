Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A72C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8o7KuL/KhcGUHflFXSzoV9LkKPDBS8OCeiuPOs/6XUU=; b=0yL0Os57Of5LK0470ZsN7k4L9m
	zTyZjnc1+4eBtF3DcGeuoJlh9QHQbOBtJBEkqxoLVEbdLY8YVPsR5m+HKkeKY3jkgNOu6UeZgQrww
	EzAGQki/Xkd1SvN5H/nKxf+4KdSAQPO/7s4qyoxexByV7ck1RyJiKovptTIY331ncGNHr+2RHgflp
	PyxAYX8QYTWPONVkgs+rkPgVrZwC2NcFh/Y9M+O+zFZ+Zoa8ZeZK4hrUkpaDrULzeveIcvLbeUfV+
	xaAwpMN8ghOouIuJyGG7VNdIwEt6rRSo1MFci+mlm0lVpEoooPKO6jXp+A46g2VrtvpWXguT4zEeo
	OPY32iFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiHwF-0058PW-B9; Tue, 11 Oct 2022 16:17:03 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiHEO-004pCj-O3
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 15:31:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BCAC4B8124E;
	Tue, 11 Oct 2022 15:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E620C433C1;
	Tue, 11 Oct 2022 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665502302;
	bh=8o7KuL/KhcGUHflFXSzoV9LkKPDBS8OCeiuPOs/6XUU=;
	h=Date:From:To:Cc:Subject:From;
	b=RJG3nDtoIPHTuKFdM5pTfg09mq7+D2rZsjtqtR2OdZHpLVCDALoUzrkRhlL8xyHdB
	 kYyETABDw2KZ7Pk97pCOA6tuu6e240nu34ZBW6ErdR2N+5W7H4mhbEfZQnKISNgJwg
	 RhD8qMCk6M1toaRKYIlkYDRQenB9tFfdyR6FK9CDVGvX4j49mgEiy9YtcYfWvaYUqf
	 XpRbDZbSJoU3KfmbfFnMxHR5eP1dmdEwKF+zM44XKZ/ygKE6TX1dY3g2CGboOqld/D
	 2z2huk6v6qniXjF/LCQnIKbEl+qMqeQnQV21hKPuM1qRP1eKTofomdpR+uaH70AxRh
	 5rXv8itL6ZsNw==
Date: Tue, 11 Oct 2022 10:31:41 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: nvme-tcp request timeouts
Message-ID: <Y0WMXSv8REysoqFy@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_083144_988026_C72C3D16 
X-CRM114-Status: GOOD (  11.04  )
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

Hi,

I'm seeing timeouts like the following from nvme-tcp:

[ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
[ 6369.513283] nvme nvme5: starting error recovery
[ 6369.514379] block nvme5n1: no usable path - requeuing I/O
[ 6369.514385] block nvme5n1: no usable path - requeuing I/O
[ 6369.514392] block nvme5n1: no usable path - requeuing I/O
[ 6369.514393] block nvme5n1: no usable path - requeuing I/O
[ 6369.514401] block nvme5n1: no usable path - requeuing I/O
[ 6369.514414] block nvme5n1: no usable path - requeuing I/O
[ 6369.514420] block nvme5n1: no usable path - requeuing I/O
[ 6369.514427] block nvme5n1: no usable path - requeuing I/O
[ 6369.514430] block nvme5n1: no usable path - requeuing I/O
[ 6369.514432] block nvme5n1: no usable path - requeuing I/O
[ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
[ 6379.761015] nvme nvme5: creating 128 I/O queues.
[ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
[ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)

This is with 6.0, using nvmet-tcp on a different machine as the target.
I've seen this sporadically with several test cases. The fio fio-rand-RW
example test is a pretty good reproducer when numjobs in increased (I'm
setting it equal to the number of CPUs in the system).

Let me know what I can do to help debug this. I'm currently adding some
tracing to the driver to see if I can get an idea of the sequence of
events that leads to this problem.

Thanks,
Seth


