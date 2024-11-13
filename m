Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF9D41C30
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAUyVZvEoL5wookSgmiY5CDZKc+nYoGrpR8GkK3F/O0=; b=g9C0wEcNhjbnaoRqvTUf+tRI5b
	YK/u0dOdU1tXAuD5C/UTl2JjMbFkjf8Sgi2vac4MSye+gvFSVAoowoYvGcigBVbQTYH5/11azwQ45
	MFqEXUyTiinYy38wvxx+Fr0d1o6/uPh1U28ZlDyxqibmL8sGH0IMtXPQ0Tx3VyfTA1ExJW6Xw6OIG
	rxRvFBe6IBcj/ixWwLfcw0HTA57cJBucH35lExMF/RTbAlrfUZ0rzLGzkoXa2pJG7LtNoneLEE5QV
	1xZ3hlsH4BFroFoZHKZSIwVVRv+AvSrDz2S0rng0pQIBpyyoeU80FDJPNOPRrWLw7T3I60NzK+idN
	kTEP+LXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAuT-00000006Udh-0eln;
	Wed, 13 Nov 2024 10:47:41 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBAra-00000006UJP-27Nn
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 10:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731494679; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=qAUyVZvEoL5wookSgmiY5CDZKc+nYoGrpR8GkK3F/O0=;
	b=FlKCXI6GXOEt2iYpzABqgh+PEGE5mNDiwEpEFlfAAQJQ/qLDksKtA9wKDjUXFSsqfe+yVi8IGHtGWzGMDygHCKXu6VYijrNY6aXDaACXyqNBTey4cITEMBESHou1VZxWGB9a8OKyfeksRo6wXccOdRqlOB9dTtS1U+XqvDklkyA=
Received: from 30.178.82.28(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJKoSnG_1731494676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 18:44:37 +0800
Message-ID: <a9479861-1172-4c7e-9134-378c4d13bd23@linux.alibaba.com>
Date: Wed, 13 Nov 2024 18:44:36 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 0/2] Add the tracing of reservation commands
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
In-Reply-To: <20241014101458.80491-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_024443_022988_DECC0D21 
X-CRM114-Status: UNSURE (   7.71  )
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

Hi Keith,

     I found that this patchset is not aplied yet, could you please take 
a look?

Best Regards,

Guixin Liu

在 2024/10/14 18:14, Guixin Liu 写道:
> Host:
> - Parse the action and rtype to string.
> Target:
> - Add the tracing of reservation commands, and also parse actions
>   rtype to string.
>
> Guixin Liu (2):
>    nvme: parse reservation commands's action and rtype to string
>    nvmet: add tracing of reservation commands
>
>   drivers/nvme/host/trace.c   |  58 +++++++++++++++++--
>   drivers/nvme/target/trace.c | 108 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 160 insertions(+), 6 deletions(-)
>

