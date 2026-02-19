Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1833AE9A049
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Feb 2026 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFh8ufN01XGazkRR2X1ifQgkFck0S1wSjFmaIuMhx6s=; b=Iy+zIEL5aZwGEsNYAjKhTHm6uv
	QqSZzF3i1MM9MEcyjJhZmf2cOEzQKoTVjqIrrIhIzCxdYMXYmNnDyjjGKBJHL+HrLdq2mOIlR4hAs
	Z5xdb0q0aE+oKoDidveCh2Kw62rkTGokkLiHoAMpcuAJMnBI4irefEPN85mXMjByl5BBR8wWVgDf2
	uGTvOHihdYcBY67hj9I3kfeS0yyjAANewludhNozjxx/2PaDUMJtEmNI2eGMAwmBC5MBRMigbQubI
	XIYP0FNvSg1AFlHXZNMx4HH0Xng392nNsaxQ97ygWHE/404oto/oY5rlnz/YZ5PXj+6vdWbSbZ6Gy
	ibezJQkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt46p-0000000BOqK-3Wxw;
	Thu, 19 Feb 2026 13:30:23 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vt46m-0000000BOpn-1WI8
	for linux-nvme@lists.infradead.org;
	Thu, 19 Feb 2026 13:30:23 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260219133010epoutp01dc418be70270ff7cd511e6ad84bf81cf~VqPe6UDcx2500525005epoutp016
	for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 13:30:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260219133010epoutp01dc418be70270ff7cd511e6ad84bf81cf~VqPe6UDcx2500525005epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771507810;
	bh=mFh8ufN01XGazkRR2X1ifQgkFck0S1wSjFmaIuMhx6s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=o3SYBzRt+Vmvu8Ikj1qRIVNpwAJrkpKw56fC5mF1WNKzzomJERkImDaCY5Qpjcaus
	 Fxbw7clgNInx+uHIh343+fE0ncf1z38JnB2a3mauOfEHbiAwwg+AvT6RMxqCW+y4/k
	 5AKHSRSkguyr6HDntZ5mqykiKVsnlRCdnf0razbc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260219133010epcas5p2dc75cae4531132e5393a5106150c088d~VqPesrGvx1122111221epcas5p2g;
	Thu, 19 Feb 2026 13:30:10 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fGvPs0gN8z6B9m7; Thu, 19 Feb
	2026 13:30:09 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260219133008epcas5p3d668d010d6e2935eb7cdd022bf36a504~VqPdWVILj1696416964epcas5p3X;
	Thu, 19 Feb 2026 13:30:08 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260219133007epsmtip14753df7f26f6b26a50119176442cf511~VqPcP0d0C3175931759epsmtip1h;
	Thu, 19 Feb 2026 13:30:07 +0000 (GMT)
Message-ID: <bbe35147-af86-4066-8732-c0d786c83df5@samsung.com>
Date: Thu, 19 Feb 2026 19:00:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] io_uring/uring_cmd: allow non-iopoll cmds with
 IORING_SETUP_IOPOLL
To: Caleb Sander Mateos <csander@purestorage.com>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260219014335.9061-1-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260219133008epcas5p3d668d010d6e2935eb7cdd022bf36a504
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260219014357epcas5p31a24ed7f17ebfe2d15f850c2a4114ebe
References: <CGME20260219014357epcas5p31a24ed7f17ebfe2d15f850c2a4114ebe@epcas5p3.samsung.com>
	<20260219014335.9061-1-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_053020_868299_6887909E 
X-CRM114-Status: GOOD (  17.32  )
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

On 2/19/2026 7:13 AM, Caleb Sander Mateos wrote:
> Currently, creating an io_uring with IORING_SETUP_IOPOLL requires all
> requests issued to it to support iopoll. This prevents, for example,
> using ublk zero-copy together with IORING_SETUP_IOPOLL, as ublk
> zero-copy buffer registrations are performed using a uring_cmd. There's
> no technical reason why these non-iopoll uring_cmds can't be supported.
> They will either complete synchronously or via an external mechanism
> that calls io_uring_cmd_done(), so they don't need to be polled.
> 
> Allow uring_cmd requests to be issued to IORING_SETUP_IOPOLL io_urings
> even if their files don't implement ->uring_cmd_iopoll().

For a moment I felt that series is going to change the user-facing 
behavior of IORING_SETUP_IOPOLL and therefore might require a 
documentation update [1].
But the change is limited to uring-cmd and that too for the files that 
don't implement ->uring_cmd_iopoll().


[1] The man page for IORING_SETUP_IOPOLL: "it is illegal to mix and 
match polled and non-polled I/O on an io_uring".

