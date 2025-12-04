Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE046D29FB0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sxd/Aif4YOWMwisvLZs1jz8UDO3+wD2UJitwu5+0+40=; b=mIxkpO8kLX9GVuruPVt3XwCcOA
	k7Rd6giJN/1rSrTrV5ZIgC9xQFiB4W9OkyhVMObfLzB+qqSeJdC2e2q3oObPkggQKRzxz2C/yJDaU
	raSF+oKCewvUIz8wurEx2eLbePduIH6F2fRYxeFgQFW66Cvmk9crj3JwqlGjwMQhr2aKgG/EB27tX
	2qO4kk9I2LH7kgW7WmpuDBw4iSqfc3n1O8W+gl4sXTsCxVxFQeAMwGkTkxwTp0iquux4W1Pn32Jty
	tJsZKzzj0FKqO2+QPQWQ+/kHWSZ+kQigFx5ULy2TtFwfn0kinlKQ1t8K3fTVSj2FsCBMFZr758NML
	jw/sA2IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREfT-00000008TsQ-0p2e;
	Thu, 04 Dec 2025 19:07:07 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREfR-00000008Ts2-19E7
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:07:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dMkX86PqhzlxWdb;
	Thu,  4 Dec 2025 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764875221; x=1767467222; bh=Sxd/Aif4YOWMwisvLZs1jz8U
	DO3+wD2UJitwu5+0+40=; b=aA1XOYX6RSpT8owyMnR+f1C+LVSP+WXgI1mbf7U1
	VrBv+EyKudu3LzWT4/8cbIKwlh5fDVdw9JAWqpGAmJTBVTsgMcLy9OmdUu//t++O
	qjwyEI44j0fwfKecnwTZRVmDsQevOKrqPHi1pV0RsCZZTQZG7QcR/p8FlnKVbPd8
	vq7V9h+fib6qOGIjfhcDa85m4m6HGtw5vQGhg5qshMz68C8SCSqBWQHAoGM4x6cY
	ax6373nIg3XTHMBkuKRag5EdcTFxv/i2HEs0+hAGdTesyeR+7x6EXBzta8aJfKkH
	Op1rg+VbxTry6veh8LgpD52p85pKpxLUs+AHfpRsK4YiQw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JGOgnh3WSgQO; Thu,  4 Dec 2025 19:07:01 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dMkWt4TLVzlfdfW;
	Thu,  4 Dec 2025 19:06:49 +0000 (UTC)
Message-ID: <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
Date: Thu, 4 Dec 2025 09:06:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset() instead
 of set->tag_list_lock
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, Waiman Long <llong@redhat.com>,
 Hillf Danton <hdanton@sina.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204184243.GZ337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_110705_336828_B8F41BF2 
X-CRM114-Status: GOOD (  10.30  )
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

On 12/4/25 8:42 AM, Mohamed Khalfella wrote:
> Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
> take synchronize_rcu()? It is not in IO codepath, right?

Introducing a new synchronize_rcu() call almost always slows down some 
workload so it should be avoided if possible.

 > I can not think of an easy way to do that. Suggestions are welcomed.

I can't find the implementation of nvme_dev_disable_locked(). What
kernel tree does your patch apply to?

$ git grep -w nvme_dev_disable_locked axboe-block/for-next | wc -l
0

Thanks,

Bart.

