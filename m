Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1639E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szouDxqlNXyVt04X/vqQp4vwdcj5rf3Krj8UZR9AhPg=; b=qV7idsilNJZDvdcr52pgMTkfpT
	BVGHbmEMNCNhswbyQ/IlZTMF/wffOIuxdmdLAeSEINNLxQ0+k34IDG01oH0a0vc+rrKoREaHtPy/y
	jR01dYS9scaV9Lp0MZ6J77AfRcM0hEUhvUXPm69wYkYXt+Qedcqtka6S1KRiggd7l7vk++y4gX3qV
	GxWfEmN8Bg9gl6g2irXtAONN94A7u9EeUp+lp9c30UTHqIR43UWQNtwBMJQu9LlEkzCLUAWs91hz8
	b3/iYZFSWsCdQq3++NzURZQ2ZMiIYhBIqY3iuPvMDaajScmcuy7kVzBRAYtValJcNWRHYc8KISa6g
	vmZjaOEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6n1-00000004KyB-0fLV;
	Tue, 07 Jan 2025 10:26:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6SX-00000004G9d-3bFV
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 10:05:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 44E285C5A89;
	Tue,  7 Jan 2025 10:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7711C4CED6;
	Tue,  7 Jan 2025 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244313;
	bh=YfTW/VCU8RjS9S1lJNIo16WQ/Ki1VbCtrWDcuUTA3TE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RuawTMIQ0dmGB+M6Kz6Ulhzj9Kj3RzFx6gq40uH7T2AYtb4YbVFFYdzDpOI61xMWv
	 a0Rx9IW+SkYVgpNmmia+ITJEY8nBaVd4DNp+DrBnYBLOI6lcdFrwH7G4j0MHToNdfB
	 YH51M77EAucAnSuGgpjjiOnvUqD/TM35Y9dTXp0IY91Fgr7LvEpyaNnO0A7zcrHGlP
	 WGB2SahGhi8YwkJ3vow5kuYxzHJsiU9jgZbyVzunVvsAq21txpymMlaN9DFP5V10uW
	 SMtAML03BcSQbxHVZsSS9Ml//mYsdH1pbgulfBMPNeIjKIZSac25BAaW4DeUJygpiO
	 jmv2gpOc0oX0g==
Message-ID: <68c4acb7-8d2f-4163-a0e2-c9c5395dcedb@kernel.org>
Date: Tue, 7 Jan 2025 19:05:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: add a queue_limits_commit_update_frozen helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250107063120.1011593-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_020513_939638_2EE9DDF0 
X-CRM114-Status: UNSURE (   7.74  )
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

On 1/7/25 15:30, Christoph Hellwig wrote:
> Add a helper that freezes the queue, updates the queue limits and
> unfreezes the queue and convert all open coded versions of that to the
> new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

