Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C87EB48EE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+YJEGp1DSmzcTN6CxzkrYCwPgy3isnREb/xAJqBC0o=; b=G1UhJHdq9KT5ABjf28Uo2yUVl6
	Qy6u/fXwBsxCvXr2IH3bqL/Qg8su06VLNeYNEtaipP01NKl2eJgCRS6+Sp6q/IRD9UaymmQDdgOBD
	ObRUyppWEiFU8VlTDiFesoX/X7THLOutQ20kj0W8OB2CXWzPfHbWwlxp5k5Fz0warl6rgRnIGS0oO
	4LQ8qTrrzT5bNoYLsG43ewOkgfpXyAssaHha5IHmiZsyEMFb0CiF+jfUo54pmFbmnhymGbqLoPfbc
	T1naaNh6T17wCIureWbUiR1xjE8gECZ2rIL4SeWYh/ttqo4WqkcEJlAHHSBlVvpMxMWaRzxmxLrab
	zXLr3gTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTEJ-00000001qsZ-2dR0;
	Thu, 12 Feb 2026 09:43:23 +0000
Received: from m16.mail.163.com ([220.197.31.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqTEG-00000001qsD-0fAl
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 09:43:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=u+
	YJEGp1DSmzcTN6CxzkrYCwPgy3isnREb/xAJqBC0o=; b=HZdFRS3Y68Fx+3x/go
	8lelx0avh+9FByrFdETMK4oRZkFS1u8KR3QjBknsFJOliyoq0Relp9m9ouMmTvOX
	SFvWInxcuGywCVhfCV9LI6XFlnaZo54uXJdzWdnLBZRnqMaYWalVCSUkYPuP6wNy
	fKvzMpD1tLzYnu+aOGvEoiVYs=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnL6ONoI1p4bGbKw--.42381S2;
	Thu, 12 Feb 2026 17:42:37 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	liuyx92@chinatelecom.cn,
	sagi@grimberg.me,
	sunshx@chinatelecom.cn,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	zhangjn_dev@163.com,
	zhangzl68@chinatelecom.cn
Subject: Re: [PATCH] nvme-pci: fix potential I/O hang when CQ is full
Date: Thu, 12 Feb 2026 17:42:36 +0800
Message-ID: <20260212094237.90855-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aYx1xoY_yeNvTtF2@kbusch-mbp>
References: <aYx1xoY_yeNvTtF2@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnL6ONoI1p4bGbKw--.42381S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw43Wr15GFyDCrykWF47XFb_yoW5Zr1UpF
	WYgayxAr1ktF4ftas7Kw4UWayfua98GF4DKw4fXry7CrnxGFySgrySkFWjq34DX39Yvr1I
	vF4jqws5WaykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pM2NKUUUUUU=
X-Originating-IP: [118.112.177.142]
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbCxQ4JnmmNoI5RjQAA3K
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_014320_585954_E9CC4DA5 
X-CRM114-Status: GOOD (  24.00  )
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

On Wed, 11 Feb 2026 05:27:50 -0700, Keith Busch wrote:
> On Wed, Feb 11, 2026 at 05:47:44PM +0800, Junnan Zhang wrote:
> > On Tue, 10 Feb 2026 16:57:12 +0100, Christoph Hellwig wrote:
> > 
> > > We can't update the CQ head before consuming the CQEs, otherwise
> > > the device can reuse them.  And devices must not discard completions
> > > when there is no completion queue entry, nvme does allow SQs and CQs
> > > to be smaller than the number of outstanding commands.
> > 
> > Updating the CQ head before consuming the CQE would not cause the device to 
> > reuse these entries, as new commands can only be submitted by the driver after
> > the CQE is consumed. Therefore, the device does not have the opportunity 
> > to reuse these entries.
> 
> That's just an artifact of how this host implementation constrains its
> tag space. It's not a reflection of how the NVMe protocol fundamentally
> works.
> 
> A full queue is not an error. It's a spec defined condition that the
> submitter just has to deal with. The protocol was specifically made to
> allow scenarios for dispatching more outstanding commands than the
> queues can hold. Your controller is broken.

Thank you very much. I understand your point. According to Section 3.3.1.2.1
Completion Queue Flow Control in the NVMe specification:

    If there are no free slots in a Completion Queue, then the controller 
    shall not post status to that Completion Queue until slots become 
    available. In this case, the controller may stop processing additional 
    submission queue entries associated with the affected Completion Queue 
    until slots become available. The controller shall continue processing 
    for other Submission Queues not associated with the affected Completion 
    Queue.

Thus, a full queue is not an error. It is a condition defined by the specification
that the submitter must handle accordingly.

In practice, SPDK vfio-user also addresses and resolves this issue. As referenced
in the following link:
    
	https://review.spdk.io/c/spdk/spdk/+/25473

During my testing involving repeated NVMe drive mounting and unmounting, I observed
the following:
1. Using the latest kernel version 6.19 + unmodified SPDK: issues occur.
2. Using the latest kernel version 6.19 + modified SPDK: no issues.
3. Using the latest kernel version 6.19 with an NVMe patch + unmodified SPDK: no issues.

Test Environment:
A virtual machine uses SPDK vfio-user to passthrough an NVMe drive. The VM has 64 vCPUs,
and the backend supports an NVMe I/O queue depth of at least 32 (Note: Since the admin 
queue depth is 32, the issue only reproduces when the queue depth is >=32). The issue 
occurs when repeatedly mounting and unmounting the drive on the host. Reproducing the 
issue typically requires about 10 cycles. Each cycle consists of the following steps:
1. virsh attach-device <VM> <disk.xml>
2. sleep 1.5
3. virsh detach-device <VM> <disk.xml>

Given the third observation - that using kernel 6.19 with an NVMe patch + unmodified SPDK
does not cause issues, so I was wondering if modifications to the NVMe driver are necessary.
Your expert guidance would be greatly appreciated.

Best regards,
Junnan Zhang


