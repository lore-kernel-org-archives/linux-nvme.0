Return-Path: <SRS0=YlYz=BJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE56C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741552083E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 21:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FBAtTyrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741552083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R/SjO+RKrnbuxS3dz5bV5HVnMTeWc58NDDChGMb8Xi8=; b=FBAtTyrWtepldO2cNmO4I0gb4
	t8L3GHU23nJ6KVtm6UdWCQ+V4NANl/78IqQSTMq+TiJ6TRfxRyPEXo6KP6fGzwL3Md4gFbpjcSIiQ
	LeKFU6m7cEWHTKN3LhpXL+M2S+1JJnGDKPQZNnIMhKJ9eEEx1Y79g4Cc6/k1AYedtY56e4nqUoWQe
	IxXqO9hyZKPnje4adL+yppc1ks7NcqPWctSaVkBwY8FEOT9AmK4AQKVd6KASjsvVJplbv+SHP4e5o
	daRb6FRFIZfh5WZoFUUbru2JY3qaKN7tTSb+ulWlKV3PiiSbc/F7yGXDe9CqqSThBhAq8OkLeRJhO
	9a3heoWuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k1GAE-0000rI-4S; Thu, 30 Jul 2020 21:32:34 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k1GAA-0000qq-TK
 for linux-nvme@lists.infradead.org; Thu, 30 Jul 2020 21:32:32 +0000
Received: from localhost (shahjada-abul.asicdesigners.com [10.193.177.218]
 (may be forged))
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 06ULWPp5014748;
 Thu, 30 Jul 2020 14:32:26 -0700
Date: Fri, 31 Jul 2020 03:02:25 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Hang at NVME Host caused by Controller reset
Message-ID: <20200730213130.GA10741@chelsio.com>
References: <9b8dae53-1fcc-3c03-5fcd-cfb55cd8cc80@grimberg.me>
 <20200728115904.GA5508@chelsio.com>
 <4d87ffbb-24a2-9342-4507-cabd9e3b76c2@grimberg.me>
 <20200728174224.GA5497@chelsio.com>
 <3963dc58-1d64-b6e1-ea27-06f3030d5c6e@grimberg.me>
 <54cc5ecf-bd04-538c-fa97-7c4d2afd92d7@grimberg.me>
 <20200729085711.GA5762@chelsio.com>
 <4a7044cb-f85e-4a59-4ebc-273cbb483042@grimberg.me>
 <20200730162056.GA17468@chelsio.com>
 <3566a3b8-3b71-4a6a-5c63-141f5dd28c48@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3566a3b8-3b71-4a6a-5c63-141f5dd28c48@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200730_173231_081621_91D54202 
X-CRM114-Status: GOOD (  26.61  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: bharat@chelsio.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thursday, July 07/30/20, 2020 at 13:59:37 -0700, Sagi Grimberg wrote:
> 
> > > > > > > This time, with "nvme-fabrics: allow to queue requests for live queues"
> > > > > > > patch applied, I see hang only at blk_queue_enter():
> > > > > > 
> > > > > > Interesting, does the reset loop hang? or is it able to make forward
> > > > > > progress?
> > > > > 
> > > > > Looks like the freeze depth is messed up with the timeout handler.
> > > > > We shouldn't call nvme_tcp_teardown_io_queues in the timeout handler
> > > > > because it messes with the freeze depth, causing the unfreeze to not
> > > > > wake the waiter (blk_queue_enter). We should simply stop the queue
> > > > > and complete the I/O, and the condition was wrong too, because we
> > > > > need to do it only for the connect command (which cannot reset the
> > > > > timer). So we should check for reserved in the timeout handler.
> > > > > 
> > > > > Can you please try this patch?
> > > > Even with this patch I see hangs, as shown below:
> > > 
> > > While it's omitted from the log you provided, its possible
> > > that we just reset the timer for timed out admin commands which
> > > makes the error recovery flow stuck.
> > > 
> > > Can you please try this:
> > Sagi,
> > 
> > Now the below malloc failure at Target is causing blk_queue_enter/wait_event hang at Host.
> > 
> > [  +0.000004] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> > [  +0.000001] Call Trace:
> > [  +0.000007]  dump_stack+0x57/0x6b
> > [  +0.000005]  warn_alloc+0xf7/0x160
> > [  +0.000003]  __alloc_pages_slowpath.constprop.123+0x831/0x9f0
> > [  +0.000001]  __alloc_pages_nodemask+0x2cd/0x300
> > [  +0.000004]  kmalloc_order+0x1d/0x90
> > [  +0.000002]  kmalloc_order_trace+0x1d/0xb0
> > [  +0.000002]  nvmet_tcp_install_queue+0x3f/0xd0 [nvmet_tcp]
> > [  +0.000004]  nvmet_install_queue+0x86/0x120 [nvmet]
> > [  +0.000001]  nvmet_execute_io_connect+0xf4/0x1b0 [nvmet]
> > [  +0.000002]  nvmet_tcp_io_work+0xa46/0xadb [nvmet_tcp]
> > [  +0.000002]  process_one_work+0x149/0x380
> > [  +0.000002]  worker_thread+0x41/0x3a0
> > 
> 
> OK, that is a new bug... Lets take care of that separately.
> 
> > This malloc failure may be expected as I am running reset controller
> > script in a loop without any sleep(It took more than 4 hours to
> > hit this malloc failure on my target machine). But I think the
> > hang issue at host needs to be addressed.
> 
> The I/O won't complete unless you disconnect from the controller, it
> shouldn't hang.
> 
> BTW, in order to handle a controller reset during I/O and when the
> target all of a sudden becomes unresponsive in the middle of the
> reset sequence, requires some more fixes, which I'll send out soon.

Ok, I would be happy to test it once you are done!
Thanks,
Krishna.

> 
> 
> > 
> > 
> > Host side dmesg:
> > [  +0.000198] nvme nvme1: creating 12 I/O queues.
> > [  +0.005365] nvme nvme1: Connect command failed, error wo/DNR bit: 6
> > [  +0.000165] nvme nvme1: failed to connect queue: 1 ret=6
> > [  +0.000418] nvme nvme1: Reconnecting in 10 seconds...
> > [ +35.705727] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
> > [  +0.615556] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex, Tx/Rx PAUSE
> > [  +0.001146] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes ready
> > [Jul30 05:51] nvme nvme1: queue 0: timeout request 0x1 type 4
> > [  +0.000020] nvme nvme1: Connect command failed, error wo/DNR bit: -16388
> > [  +0.000170] nvme nvme1: failed to connect queue: 0 ret=-4
> > [  +0.000148] nvme nvme1: Failed reconnect attempt 2
> > [  +0.000001] nvme nvme1: Reconnecting in 10 seconds...
> > [ +13.311922] nvme nvme1: failed to connect socket: -110
> > [  +0.000125] nvme nvme1: Failed reconnect attempt 3
> > [  +0.000001] nvme nvme1: Reconnecting in 10 seconds...
> > [  +2.586017] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
> > [  +0.557409] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex, Tx/Rx PAUSE
> > [  +0.001144] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes ready
> > [Jul30 05:52] cxgb4 0000:02:00.4: Port 0 link down, reason: Link Down
> > [  +0.551397] cxgb4 0000:02:00.4 enp2s0f4: link up, 40Gbps, full-duplex, Tx/Rx PAUSE
> > [  +0.001073] IPv6: ADDRCONF(NETDEV_CHANGE): enp2s0f4: link becomes ready
> > [Jul30 05:53] INFO: task nvme:5944 blocked for more than 122 seconds.
> > [  +0.000125]       Not tainted 5.8.0-rc7ekr+ #2
> > [  +0.000111] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [  +0.000177] nvme            D14392  5944   2796 0x00004000
> > [  +0.000123] Call Trace:
> > [  +0.001375]  __schedule+0x32b/0x670
> > [  +0.000125]  schedule+0x45/0xb0
> > [  +0.000138]  blk_queue_enter+0x1e9/0x250
> > [  +0.000137]  ? wait_woken+0x70/0x70
> > [  +0.000116]  blk_mq_alloc_request+0x53/0xc0
> > [  +0.000122]  nvme_alloc_request+0x61/0x70 [nvme_core]
> > [  +0.000121]  nvme_submit_user_cmd+0x50/0x310 [nvme_core]
> > [  +0.000123]  nvme_user_cmd+0x12e/0x1c0 [nvme_core]
> > [  +0.000142]  ? _copy_to_user+0x22/0x30
> > [  +0.000135]  blkdev_ioctl+0x100/0x250
> > [  +0.000122]  block_ioctl+0x34/0x40
> > [  +0.000129]  ksys_ioctl+0x82/0xc0
> 
> That is expected, without multipath, the I/O will not complete, and
> unless the target restores (or host disconnects), the I/O keeps waiting,
> that is the expected behavior.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
