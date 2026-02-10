Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988CCEA3F0D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 06:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:References:Mime-Version:Date:
	Message-Id:Subject:From:Cc:To:In-Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EjD+pRaHTolG3P0dFiBqPrhrRtG+Zz+PQwJlGziWUZ8=; b=A2SdU0d+ceakA7
	l3wWhiv3GKz02fFyR7i7J14HNjhClRi5usA9J5ySLQA9w3l+XkqB8ByA4ZiMEYIcYiQqlLiNFfhDe
	mStgisPRyYLnECYuEVTJXLans69nw4RToRwlhfexM9XfQFVJiVhQgeKCawqOUfy61Wyrn9HCE1lmg
	0zAHsSToEYCYFUZwD/Qdb1I9AvsJbyBacLSmR0pPyaIgURmt68uamoueSwoSr0GagGyi3TnD5Kvhz
	iAPA+rARHepfNAWeQwLq6wJOeiXH5qF/EL6iumK+xNzzIbvajNpVYzIrOhKqy58AocelrkqbBr2h8
	JjhSwVDm7nR44JASTasw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vphis-0000000GZ2A-3BEj;
	Tue, 10 Feb 2026 06:59:46 +0000
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vphip-0000000GZ1V-2oTA
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 06:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770706777;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=EjD+pRaHTolG3P0dFiBqPrhrRtG+Zz+PQwJlGziWUZ8=;
 b=ozVs0UXOFBlEeE2cBk9Rw2e5fJAokY5WmKHFGqvTR2oGGrenp8IRHeek84EpSLAjuSJl7i
 FwZneB+jhpJQvl+5seJnAL8je83y2+pbb36AkWFYEZXkhAcv7lDwOZ8ypoorrlka6h8nlK
 d6NBY7lRD7KNlLplpzXTQC+H4TSGhk4nkWG48y6mpREx6RDHTbMPWAKgWsN/f9Lyt6SbQ0
 GKWtA3YUgPfTcPVp2pQ3XgmWt/zfRQtwfbYgVisYCmDFo/0/arFz0cD6lyyPdeJ3cTA7IL
 9EOCBzmL/KkLN0b5N6LZC328TcPIgQdngzM68hFiN4kl6zeHLp+JA1m99JNdzw==
In-Reply-To: <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
User-Agent: Mozilla Thunderbird
To: "Bart Van Assche" <bvanassche@acm.org>, 
	"Keith Busch" <kbusch@kernel.org>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, <sven@kernel.org>, 
	<j@jannau.net>, <linux-block@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>, <neal@gompa.dev>, <asahi@lists.linux.dev>, 
	<linux-arm-kernel@lists.infradead.org>, <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Message-Id: <a8cdbf1c-eaab-4ab2-be7c-df8fd0317df4@fnnas.com>
Date: Tue, 10 Feb 2026 14:59:32 +0800
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Tue, 10 Feb 2026 14:59:34 +0800
X-Lms-Return-Path: <lba+2698ad757+887853+lists.infradead.org+yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <6b18e0bc-efa7-4bd5-b12b-a313941d2ba1@acm.org> <aYoaWwI-sl5hK6s_@kbusch-mbp> <b2069052-ac7d-46f6-bdd5-a96533144f9c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_225944_555596_594951BF 
X-CRM114-Status: UNSURE (   9.16  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/2/10 1:51, Bart Van Assche =E5=86=99=E9=81=93:
> On 2/9/26 9:33 AM, Keith Busch wrote:
>> I had to look up the original commit that introduced the WARN,
>> 65d466b629847. The commit message says "Creating new debugfs entries can
>> trigger fs reclaim", so that must be the path that enters back into the
>> block layer request_queue.
>
> Thanks Keith. It's probably a good idea to integrate this information in
> the source code comment above the blk_queue_enter() call.

Yeah, I'll add the information in the next version.

BTW, I'd like to add something. The original lockdep report is:

[REPORT] Possible circular locking dependency on 6.18-rc2 in=20
blkg_conf_open_bdev_frozen+0x80/0xa0 - David Wei <https://lore.kernel.org/a=
ll/63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk/>

And we see there some contexts like wbt/nbd can freeze queue fist and then =
create debugfs
entries, and it's fixed by the thread:

[PATCH v9 0/8] blk-mq: fix possible deadlocks - Yu Kuai <https://lore.kerne=
l.org/all/20260202080523.3947504-1-yukuai@fnnas.com/>

And the warning is added in this thread.

>
> Bart.

--=20
Thansk,
Kuai

