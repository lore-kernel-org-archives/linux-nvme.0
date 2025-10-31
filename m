Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915DACCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMr12pMLjE66ZLJgfh9u6SnWe7M5oEz8wUdwX9iE4Ic=; b=a3vocNiaiCt/ICWLn5iz60ySxp
	tGraxa5bsWLNF3GbkzuAlWlbFv8iiy+Wj2z0X7ycBYMJPtP5YgXxkte6/L6zm98bMOetg+pbenRq4
	7KQ/MW3C7TEUojsyVB2/fSjAh6EAdWTy/zfptze0EcNwmQ7ROY2zBahF/PvdHjEHnjiKzO3f3+HZA
	/Q2HDrDcoNbrZnPoQsuh8x3CQjpkzeacz0MKfgn8d8JYxL83TzHfcbYIHdKqG1DF2op2ymXWwaw8r
	SO3JXuc4wW/gF197ha7vBZwVMNqwhF82h/4G8Vva0K4GJbP5X2XNjSnTJJZAmQtpiGagWIalLPWxd
	OPrdj6DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEx5w-00000006qAp-29gg;
	Fri, 31 Oct 2025 21:55:40 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEx5u-00000006qAQ-06Aj
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 21:55:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cyvtJ6kM4zm0jvK;
	Fri, 31 Oct 2025 21:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761947734; x=1764539735; bh=cMr12pMLjE66ZLJgfh9u6SnW
	e7M5oEz8wUdwX9iE4Ic=; b=OpmO3xIcXuZXUen+RPg8c8kumkTVrBZ3LPnA8Qvy
	mYEZ3Wu7qgNYPNitoaUA8BKnHDO2shinTSHDeOfg7ftya7SNfranagToCSF7lN0E
	KVU28LDu7UTvnD3qnf8rrzK4OzCy/CBAKOgyykQXhnS8Y0ngjU64St86qFBAMAZQ
	o8Es0EYtpN4ckwkVwRKU/xYQrejzL8vDzdSxQ75utlmUpgAMK93VKIYjmWNmq3Vf
	Ca3sY2WILYoYpzobqnLcguya7EgV/LmgqsRcmMX01bkdtzQLzehZwHXUvsZOi/fF
	QK9E5rGuKsip6GcfbFGHINBcBIlgeJhbz/HH2wIBHdYtQA==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tmX2EuuEY4-X; Fri, 31 Oct 2025 21:55:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cyvt42Yn3zm0pL4;
	Fri, 31 Oct 2025 21:55:23 +0000 (UTC)
Message-ID: <22912f8a-01af-415c-a4f0-9db87eac32d2@acm.org>
Date: Fri, 31 Oct 2025 14:55:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] block: add zone write plug condition to debugfs
 zone_wplugs
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-12-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251031061307.185513-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_145538_488487_C5F872AE 
X-CRM114-Status: UNSURE (   6.91  )
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

On 10/30/25 11:13 PM, Damien Le Moal wrote:
> -	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
> -		   zwp_wp_offset, zwp_bio_list_size);
> +	seq_printf(m, "%u 0x%x %u 0x%x %u %u\n",
> +		   zwp_zone_no, zwp_flags, zwp_ref,
> +		   zwp_cond, zwp_wp_offset, zwp_bio_list_size);

The debugfs output is incomprehensible for anyone who has not memorized
the source code of queue_zone_wplug_show(). Please expand the debugfs
output such that it becomes easier to comprehend. See e.g. the
queue_zone_wplug_show() changes in
https://lore.kernel.org/linux-block/20251014215428.3686084-15-bvanassche@acm.org/.

Thanks,

Bart.

