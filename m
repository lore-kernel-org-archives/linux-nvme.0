Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46ECD2A532
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TOhvNEUeJ975PE4WMmGFl/Jt7yj22Rk1tp6GgrblBI0=; b=rTY9rs8FlMcP8VHlrZP9678eNf
	wa6SwkwoaNQAhSiPBekvRVLFVtxOmG67Z0qeQJRA/VRk/Ne0S340xU4NtgZn4e8Cczw0ozo0pi9IE
	5R1N2BwoW3jQlopBmPIihz1J+1JbRAXyenfdAnI4Iga5u6Uwf3RKBbhdYrOiACV2nV2Skt9etahvt
	bukBtL4d9XDVc9XqTnmdy5O+jXb4ygB4rWnNcUhugDcSOclXDuFpMk3RzMEv72DEZwUPgw6hM26x1
	qr3p5NNsry4PJiCEoDR0AQ65W3/pQp9pfkMfay5uwJUEAese3kP4O5ZE/1bNb7ETBYoqFCC1FWVQi
	Z6476IEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRGqu-00000008foV-2Qwb;
	Thu, 04 Dec 2025 21:27:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRGqt-00000008foH-0jeT
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 21:27:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C1EF601FF;
	Thu,  4 Dec 2025 21:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00006C4CEFB;
	Thu,  4 Dec 2025 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883621;
	bh=AWIxMj3gEkNRjjY5m4Py2eu04uIx7dxKAjYDcD0/NIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGOcy4bmct46NJepvzzypwOyLe2XtWAR6slSN9G/+gt0kDqMe09NThoCkBFszSgEI
	 3uD7H1OC+eZSfHfN8Um1VID6E5FUqs9Vtv8ecoh1ThvOkVcD9TS9RVOFDVZtQWuwCS
	 iCWg7C1/e54GM4z4/G3XFJKkqAAklbvoP4LNtX+DZ/nPVXR39IiA6LAaIAfbPnmt1L
	 NA91XypZChOLQsWAfDwnzx5x1ItbkeXrtRXZsRcTVc13eXtso6WKbcLojcUk+IHFhD
	 ZXHekos1H1krE8TRTIHoTdmyWw8iZZaNS466ETrI7sRKLx4TrPrA/xJBAOXypjYZ2T
	 XREJDjDZ8ibMQ==
Date: Thu, 4 Dec 2025 14:26:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <aTH8opTiwJxH2PMA@kbusch-mbp>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
 <20251204191555.GB337106-mkhalfella@purestorage.com>
 <77c5c064-2539-4ad9-8657-8a1db487522f@acm.org>
 <20251204195759.GC337106-mkhalfella@purestorage.com>
 <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6994b9a7-ef2b-42f3-9e72-7489a56f8f8e@acm.org>
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

On Thu, Dec 04, 2025 at 10:24:03AM -1000, Bart Van Assche wrote:
> 
> On 12/4/25 9:57 AM, Mohamed Khalfella wrote:
> > I do not see how running this code in another thread will solve the
> > problem.
> blk_mq_freeze_queue_wait() waits forever because nvme_timeout() waits
> for blk_mq_freeze_queue_wait() to finish. 

No, nvme_timeout does NOT wait for freeze to finish. It wants freeze to
finish, but it proceeds anyway whether it finished or not. If the freeze
didn't completele, anything outstanding after that will be forcefully
reclaimed and requeued once we ensure the device is disabled.

> Hence, the deadlock can be
> solved by removing the blk_mq_quiesce_tagset() call from nvme_timeout()
> and by failing I/O from inside nvme_timeout(). If nvme_timeout() fails
> I/O and does not call blk_mq_quiesce_tagset() then the
> blk_mq_freeze_queue_wait() call will finish instead of triggering a
> deadlock. However, I do not know whether this proposal seems acceptable
> to the NVMe maintainers.

You periodically make this suggestion, but there's never a reason
offered to introduce yet another work queue for the driver to
synchronize with at various points. The whole point of making blk-mq
timeout handler in a work queue (it used to be a timer) was so that we
could do blocking actions like this.

