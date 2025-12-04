Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F070D2A52A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 20:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCn2qpD9CNnD+VHrPDYRhycXHcj0FEGMiFdnEQwtU4c=; b=nFS6UIZdq8OcJjLkWIAqWscIL/
	1AhE8b9zIbh8F0i1wN2HBRTv+BrqF3YOknjKBBxjLBzFZj7sJD44JkX4xRq/2Yma30hk2IVruqT+0
	RMK/WUz/Ba0HzjTqEk6SpNzqD73A20Pm2XLqm7+i5006jnyEW6F/iiGb9LI3DT/e37hk+/tVc1dfS
	LWq90LnEK3I9kBVQhaUjhFyNu6czC4J7Kvb3/hEM8qJYTiHaXdFB0ztp75JToUaZ+qgr1X1biFOvj
	YiH7tTx0KTIJQWek3knHjSEV2/ka4p8gAwvaUOF+ykjclAYCArQQIyEt7vAVSGhO/qsBEOPFzBMkt
	8BvQr/nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFsD-00000008bdk-3wgM;
	Thu, 04 Dec 2025 20:24:21 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRFsB-00000008bdQ-0XXT
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 20:24:20 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dMmFG5PdJzlm2Cj;
	Thu,  4 Dec 2025 20:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764879855; x=1767471856; bh=ZCn2qpD9CNnD+VHrPDYRhycX
	Hcj0FEGMiFdnEQwtU4c=; b=o37YQ/MrK/oTr8ig/nG60k8PC0RNBxkmExounFR8
	Tv4mZzEg2lkrUbNBfqToURY7Msj+9DuPoTltHolpBxVdjD9E1bUVGqC0vFZYrNAk
	2ExPGwBk5Dj111Te3n5JG4FLTXeYSZqIg2VHW2yb7z7i6GrB2yBKR1v570FnuoEA
	sGfzDDKdAPM3paElUYDfarsywnP5w2pSwthN6+r/Xty30gDJofN/hNeeDFmmZCyc
	QWzEiDwVWCDG1soY0HyOKq3J56pMJRwkPk89BOYweJAfa+FyKBH3867ZunjfWEk0
	HjNlPejQD45hbLL+9drzee+b2kcAdnAb/SDH1FjYlTF6fQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Aarkzny0G2Dp; Thu,  4 Dec 2025 20:24:15 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dMmF315czzlfc3v;
	Thu,  4 Dec 2025 20:24:06 +0000 (UTC)
Message-ID: <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
Date: Thu, 4 Dec 2025 10:24:03 -1000
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
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204195759.GC337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_122419_212125_30CC8D0C 
X-CRM114-Status: UNSURE (   9.21  )
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


On 12/4/25 9:57 AM, Mohamed Khalfella wrote:
> I do not see how running this code in another thread will solve the
> problem.
blk_mq_freeze_queue_wait() waits forever because nvme_timeout() waits
for blk_mq_freeze_queue_wait() to finish. Hence, the deadlock can be
solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
I/O and does not call blk_mq_quiesce_tagset() then the
blk_mq_freeze_queue_wait() call will finish instead of triggering a
deadlock. However, I do not know whether this proposal seems acceptable
to the NVMe maintainers.

Bart.

