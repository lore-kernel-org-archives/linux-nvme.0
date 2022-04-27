Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9062AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 22:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EWm7YC3z47Zub0Wi3X17sSmOSaldsCoos2i25muO2EA=; b=zIsc8bXkiZWXDp1/ubHCswzXdo
	AmGD/hE89XXOWuK6BTFZdYq6ZmnnvtM5Fu3C1phhPP+MA/vh2RzYXr1iY+fVOCRAK5UjqOpO60uY5
	LBnSCgP6Vn27pw6XQdtNG/MAdzInqaDvbKA9Aa7JUKOjc4nv00PVCx8vynYKz5qmfRe9sjJ/0epOd
	ykmWkkXTbTc0H23lINhn2Hl/Tw4DMda6/7Gz+ZVoNAJ9xQzvk8dfkkag1CN2BLARgXyw0lf+Z0uyD
	k6d8aXxT+zDbKVTLfSUqhHBybkvIYX9pwB9aSSbEb7Zh2xGHJaAwzyKeO1hOAn6xW9/h7+nN1myMl
	ZxZmmA5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njqL2-003nsB-BV; Wed, 27 Apr 2022 22:40:48 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njqKy-003nqT-BT
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 22:40:46 +0000
Date: Thu, 28 Apr 2022 00:40:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1651099238;
 bh=mc2xuEpkr5nO27ihz80HnNL+oFPU3ItqOaiQkz8izdU=;
 h=Date:From:To:Subject:From;
 b=dIORIYXuk361o+BZgWE/yhoLnMDe6rfO9XsaHgijKFuYxLtoWCE66XjXUyeSZCMPs
 1bk92uejp9xe5q9QqSL3gqy+u0WaP8UV3852FGnPJ1GXIz4PUu3nvOGRyFvKePPsXx
 EA8ZK7fCvBVMqdiFm8tV/oZ6GFf6uzEYSLXZmRvA=
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: linux-nvme@lists.infradead.org
Subject: Calculation of Host Memory Buffer sizes
Message-ID: <f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_154045_045309_4D3C0DB3 
X-CRM114-Status: UNSURE (   7.27  )
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

Hi,

I am wondering about the calculation of the NVMe Host Memory Buffer sizes.
It seems to me that the current algorithm to calculate this size does not lead
to an optimal result.

Hardware information:

mn        : WD_BLACK SN770 1TB
fr        : 731030WD
hmpre     : 51200 (limited by max_host_mem_size_mb to 32768 -> 128MiB)
hmmin     : 823
hmminds   : 0
hmmaxd    : 8

To me this looks like the disk wants 200MiB allocated that can be described in
eight descriptors.
However the kernel log has the following entry:

[    8.981685] nvme nvme0: allocated 32 MiB host memory buffer.

Tracing through drivers/nvme/host/pci.c the following happens:

The loop in nvme_alloc_host_mem() is only entered once.
  min: 3371008
  preferred: 134217728
  min_chunk: 4194304
  chunk_size: 4194304

Now in __nvme_alloc_host_mem() the loop is called the eight times for hmmaxd,
each time allocating 4194304 bytes (4 MiB).
The end result is that a total of 32MiB of Host Memory Buffer are allocated
which is the bare minimum instead of the 200 MiB that are preferred and
available.

It seems that the logic to calculate min_chunk in nvme_alloc_host_mem() starts
with a too small value.

All of this is on a normal x86 laptop with plenty of system memory.
It's reproducible with current git (46cf2c613f4b10eb12f749207b0fd2c1bfae3088)
and 5.17.4.

Thanks,
Thomas

