Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41012EF48D1
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 05:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Mime-Version:To:Message-Id:Content-Type:References:
	From:Cc:In-Reply-To:Date:Subject:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6lsmNm9wphqJ24y8FQPYzZCLpAxsG55lgs1zXhsbm4=; b=JlhmY56UG43tbKanHO34H+3RXk
	m3e5BGeI4qBuBbatlTzkMyBnvhxkUF25xp+s+dkPuUmu188yjSJ2p9UFQeFjXuRojXiDJN5sCT7vu
	n4Geq2+dkkgYTfgVyCxr3TXQ8RgkTebLWvrIvAlw8jN9xon9OjXzKb51vGENnIsch5MVzHkeaJteq
	vXHaVkfLIlx1jkFHNBGRnXRlk58P+HUZ6lhLQHIoQbcf3HbJTmupxu/5Te8r3ywT9CVdge+hInvTB
	hZRYjZPliGLgqhaITUlEhDVh2ONVohxXa5SkfbNH63f89PZM+Oyhp1nwosROx/ZkuZkNaxssarpm2
	YMNDoZiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqlua-000000031Vc-2qJn;
	Fri, 13 Feb 2026 05:40:16 +0000
Received: from sg-1-14.ptr.blmpb.com ([118.26.132.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqluW-000000031V6-2ydq
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 05:40:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770961203;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+6lsmNm9wphqJ24y8FQPYzZCLpAxsG55lgs1zXhsbm4=;
 b=ZS4LpFHwroAqFIlbJGjBgR3llpP+yjrqNSmCOq+jepj+yCyLzmC9L8DESZ1QC7Da71xH2m
 Q/JS6fZPu80FT+eXq7P9vTmkpKzFVPvd2znA+hJpBVj7m/G9aeI2+cxHXh6IGKOthxI9wB
 XCntRxu63sY1nHnvCQ2LZ8XlXIIgA21MTHN8yzqzfSJMBAzl9xqYoiW+gtk5PkrYeV70DN
 VglZYPHta1EXhZBPVoCO5xmwm0fvzXG4PTWdjQIOpSZVRwTnIcuXgX2IHkeNr+hqeX6UWx
 Xeo4uBzkqD9erwMowC7OZ3YIWZfKk1jPK/XChQdKd+edulpbu1qNn/JPCuisjQ==
Subject: Re: [PATCH] blk-mq: use NOIO context to prevent deadlock during debugfs creation
Date: Fri, 13 Feb 2026 13:39:58 +0800
In-Reply-To: <aY6sDstii_R_zOfs@fedora>
Received: from [192.168.1.104] ([39.182.0.132]) by smtp.feishu.cn with ESMTPS; Fri, 13 Feb 2026 13:40:00 +0800
User-Agent: Mozilla Thunderbird
Cc: "Jens Axboe" <axboe@kernel.dk>, <nilay@linux.ibm.com>, <hch@lst.de>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>, 
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Yi Zhang" <yi.zhang@redhat.com>, 
	"Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	<linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
References: <20260212080135.1673063-1-yukuai@fnnas.com> <aY6sDstii_R_zOfs@fedora>
Content-Type: text/plain; charset=UTF-8
Message-Id: <5c47b46d-1aa7-4ce6-baa8-97f8a3ecc327@fnnas.com>
X-Lms-Return-Path: <lba+2698eb931+2f83b3+lists.infradead.org+yukuai@fnnas.com>
To: "Ming Lei" <ming.lei@redhat.com>
Mime-Version: 1.0
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_214013_474848_A75AD06F 
X-CRM114-Status: GOOD (  12.25  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/2/13 12:43, Ming Lei =E5=86=99=E9=81=93:
> On Thu, Feb 12, 2026 at 04:01:35PM +0800, Yu Kuai wrote:
>> Creating debugfs entries can trigger fs reclaim, which can enter back
>> into the block layer request_queue. This can cause deadlock if the
>> queue is frozen.
>>
>> Previously, a WARN_ON_ONCE check was used in debugfs_create_files()
>> to detect this condition, but it was racy since the queue can be frozen
>> from another context at any time.
> debugfs lock doesn't depend on queue freeze, so the implied deadlock isn'=
t
> obvious.
>
> Can you explain a bit why freeze from another context may cause dead lock=
?

It's probably fine to freeze from another context concurrently, I mean the
checking will cause the false warning like:

Re: [bug report] WARNING: block/blk-mq-debugfs.c:620 at=20
debugfs_create_files.isra.0+0x54/0x60, CPU#220: kworker/u1036:7/70421 -=20
Shinichiro Kawasaki <https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/>

So checking itself is racy and should be removed, meanwhile there are two o=
ptions:

1) use noio for debugfs creation;
2) move debugfs creation out of queue frozen from nvme target;

BTW, I added the blk_queue_enter/exit() protection for 2 because I think it=
's
safe, and can prevent deadlock if there are any implied deadlock related to
queue frozen.

>
>
> Thanks,
> Ming
>
>
--=20
Thansk,
Kuai

