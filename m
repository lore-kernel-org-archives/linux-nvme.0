Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06446D5E148
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 09:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ykZFkyB8p0gqYmn4Qyhv2rmmlGum0XDX30qrZC0f80M=; b=RWoI+Aosll8D2HP+1UUxU7Aloo
	D4lxMZte9c46o8R+LzuzuKcQA3Wi51+ZIbW4h6cgoawc5ZMcbsKwY+vCxQrlU3Jzuhwg7V2w177f6
	vUGHxmWhHRpLcrTl0xG2jm8ElpfDmM/SISDZ4nct7O32LGEMz7GSZPCJPVqJOR6BzPcGXOecpYOwp
	yQfdVYM+1Pm6IfCCMfPfjb9sOAxDY8D4RhuBftiwHQvKsMO7UpDtGGlW5TpoTbW9vs3iK/5mNLJzU
	Zeg/rwVa4WZkD4SYBZOdhd5eDcFvkjq7jbYxzD4/tuQnasuqnwzcJKRFueZRR1YiY6rz6xQqesBvN
	70KkG6Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Kqd-00000009sNH-1ES6;
	Fri, 08 Nov 2024 09:00:07 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Kgy-00000009qKr-1i0T
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 08:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731055806; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=ykZFkyB8p0gqYmn4Qyhv2rmmlGum0XDX30qrZC0f80M=;
	b=CZ5YSaZ108xZwsFGHYBxqn0GdiTjI5pmSoWmdFtHNTprkjNzqgY5BZZwf+5W9i0sGtZ5iagT6WSCyvQNAv/PxsWTrgYxs+fGheVWJEzp2dWDlf0DLCymNzVrqTzkp0qeFb39J6+eRm56GNnYOYjJzF+jcTjQT++t/Fs3VatXy8o=
Received: from 30.178.81.252(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIyhaCQ_1731055803 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 16:50:04 +0800
Message-ID: <b905f531-c8cf-4e3c-9112-753016d6b948@linux.alibaba.com>
Date: Fri, 8 Nov 2024 16:50:01 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2 0/2] Introduce service-time multipath policy and
 document
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20241108084741.40986-1-kanie@linux.alibaba.com>
In-Reply-To: <20241108084741.40986-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_005008_620392_A710CFB8 
X-CRM114-Status: GOOD (  10.27  )
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

Wrong version, please ignore this, sorry to bother.

Best Regards,

Guixin Liu

在 2024/11/8 16:47, Guixin Liu 写道:
> Hi,
>    This patchset introduce a new multipath policy, service-time, and also
> add a new document to introduce nvme-multipath and all policies supported.
>
> Changes from v1 to v2:
> - Add more detail to message body.
> - Add a document to introduce nvme-multipath and all policies supported.
>
> Guixin Liu (2):
>    nvme-multipath: introduce service-time iopolicy
>    docs, nvme: add a nvme-multipath document
>
>   Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
>   drivers/nvme/host/multipath.c         | 53 ++++++++++++++++-
>   drivers/nvme/host/nvme.h              |  3 +
>   3 files changed, 138 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/nvme/nvme-multipath.rst
>

