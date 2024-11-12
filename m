Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F81D41D41
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 01:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aVq0uu6RAxyyvIV/qZ+1X+k8aJ/GC57qpswexV+1pKs=; b=WWI0lIMNb4AyKORBotPqmOdJQQ
	x7xQJ9wBfQK7UlI13oVnMtlzZTydMS+eAjjPLkbCVWd291a/fIH8KkSfUzaSxy19DeMrvn9mauJrH
	5uyDzjfTsEgMvefH9LwtbNSzbw6NyyJstTfV8wm7qCvwmv/lSHnudA2qtacLxKDleseXyJlvXUkVp
	FIsvStU3E8GFB0P4KJveUnQd05jrG7NvOPib93xhTxdjuXnUAbt/5eSQFdxMkMApyPtHjXiFXYudK
	uStFzm1BowqWsaAC5X5LYWu/pcWVVzDjfGb17GEssa0dLEWLqaPdzFNm7Q4Kqkdxsh+Q0/kPWkeRf
	aFQwapmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAfle-00000001sKt-2chi;
	Tue, 12 Nov 2024 01:32:30 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAflb-00000001sI6-34hp
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 01:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731375144; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aVq0uu6RAxyyvIV/qZ+1X+k8aJ/GC57qpswexV+1pKs=;
	b=yN4IPQDY1OqLBzvdqI2qF7iwWl8SgyHkdQwjdq0AwCNMbjlT0+sOLpAHUtRd/zfKMPr2P+Tjk0Ay3oUJ6XPyJUM9nxjZRVJOYm7iG54mCIbj2+0XoYFKfdDbWLL9vhESbH8IoJwmQMjsUGKZeQ9eHxaQ3WFwF/fzk+15bTHp/t0=
Received: from 30.178.81.245(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJF5qto_1731375142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 09:32:23 +0800
Message-ID: <b4bb6fe3-2464-4c3e-bafd-c3cf5427e83a@linux.alibaba.com>
Date: Tue, 12 Nov 2024 09:32:20 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet: fix the error of point math issue
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, linux-nvme@lists.infradead.org,
 oe-kbuild-all@lists.linux.dev
References: <20241111104035.31770-1-kanie@linux.alibaba.com>
 <ZzJExEvGZAXZX-Nz@kbusch-mbp.dhcp.thefacebook.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ZzJExEvGZAXZX-Nz@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_173227_939162_F62C9A5F 
X-CRM114-Status: UNSURE (   7.87  )
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


在 2024/11/12 01:54, Keith Busch 写道:
> On Mon, Nov 11, 2024 at 06:40:35PM +0800, Guixin Liu wrote:
>> Fix the wrong place of parenthesis of ctrl_eds and data point in
>> nvmet_execute_pr_report(), switch to "void *" first and then do
>> the addtion.
> Thanks, I folded this inot the original commit.

Thanks to fold that.

Best Regards,

Guixin Liu


