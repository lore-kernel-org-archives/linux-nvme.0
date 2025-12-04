Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF8D29FB2
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oBtxSOgzd1VlGzgFhViRN3bDjRi/zbapb0CSg4HM0OQ=; b=4Ztg5VcuRfnvCIwqBdR0puR088
	pgbPB53RfWz1FG+e2mZDK8HjrkIIw8LZyCjEh7bRBPtrr3RCB19OuG97KuNP/rufToknUVvji3kub
	gHDNSCLRsbVy1h9JolD0twfmZ4TTOAoL6dFZIit4SwZZkfg5i1f0EPwDKmVY0s1aNAfTh/mivdFNf
	w6upA1Dd4YlqIaCL4ne9BJ5aXeZq4CB1BCbMfh7kXGJzSDykp5sowWUpqLEk027sZOGxSvs77XHBE
	Tt1+m8udbEGT1Uuyc+SxgjxaQAAzf2lJye92JJLCVdOQqs0Uif7sDP1P8gFEBREvRmBFwy+LtUmWb
	deHK3jdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRF3h-00000008VPg-0e4M;
	Thu, 04 Dec 2025 19:32:09 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRF3f-00000008VOz-1ZZy
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:32:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMl524dvSz1XM0pg;
	Thu,  4 Dec 2025 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764876723; x=1767468724; bh=oBtxSOgzd1VlGzgFhViRN3bD
	jRi/zbapb0CSg4HM0OQ=; b=YNcB1XcULY1+fahNQL48zDch88kZ2jF3alXFk8nS
	wfBu8etQsjH7LlxJ5apJTtkRZvrzkwEOemE4BUbIw77LyRXrKv0iVN8OHsDYlwMV
	BC/dg3aVdYlCdmDPnWTI9qw+a08jIgGGefs1VSstJpA+lZ4utiZg5lBWoZQZll2d
	29yXzkvE2C5VbGN6VU4dH6kcOH5YBTy/2Q9xPsL46f/zVRToj3E55Cg6Wfyvn46r
	Iguj5oLhAmASLSdb7N4JBt/6WkIA4Wpl8Emk47Ir2yrGGBAJ7VoIvQwdzK6StEAB
	+nayfE9d4ZS0Du3zin/9WSuqcUioFGGb9e2LrmyREisE8Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NaudrHerNdNH; Thu,  4 Dec 2025 19:32:03 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMl4s34Kbz1XM0pF;
	Thu,  4 Dec 2025 19:31:57 +0000 (UTC)
Message-ID: <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
Date: Thu, 4 Dec 2025 09:31:55 -1000
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251204191555.GB337106-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_113207_447323_74345192 
X-CRM114-Status: GOOD (  13.21  )
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

On 12/4/25 9:15 AM, Mohamed Khalfella wrote:
> The stacktraces are from old 6.6.9 kernel.

Please always include stack traces from a recent upstream kernel in
patch descriptions.

> However, the issue is still
> applicable to recent kernels. This is an example from 6.13 kernel.

Thanks, these stack traces make it clear what is causing the deadlock.

 From nvme_timeout():

	/*
	 * Reset immediately if the controller is failed
	 */
	if (nvme_should_reset(dev, csts)) {
		nvme_warn_reset(dev, csts);
		nvme_dev_disable(dev, false);
		nvme_reset_ctrl(&dev->ctrl);
		return BLK_EH_DONE;
	}

Is my understanding correct that the above code is involved in the
reported deadlock? If so, has it been considered to run the code inside
the if-statement asynchronously (queue_work()) instead of calling it
synchronously? Would this be sufficient to fix the deadlock?

Thanks,

Bart.

