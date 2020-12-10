Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228CDC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 20:21:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D3123ECD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 20:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D3123ECD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Subject:Message-ID:To:From:Date:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/uMvBf40eHjdS60NTqQ8yF/pbwpIkfHLP+yrtywBu+4=; b=RkG8DBw/1WU/qJ2XD4lhRER+Lt
	vEVBDPYXjCzkMFYjlpgNaWxV0a2n540/Cp145j7CjMra1AkJp1jzSYvqJ+Pv+N84d9TsWYipo5OPb
	DmLpuPpHmGLPbh1O+1qvbQfxKRTG/AAhGm98awfSmh4MiJR7Rs4Mv7GU4E9a14908rn5I60ZRn14x
	fK6ZZxVNK1X3UvvK2/q0RQF/jITiMgC1ZuqmgcNvTvwt3wd5C6dfTv0c/wi74Qz/wWGag7ZQJ+rbt
	Hfim7+6KtNcc4fCqT84b3LCQFOpKYTZM+Q7K8iG+XY42qVKI8VDUJYy7LqjIdlgM2cVBVPzbhWIcG
	Nm+2NQKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knSRT-0003qg-I9; Thu, 10 Dec 2020 20:21:35 +0000
Received: from mib.mailinblack.com ([137.74.84.110])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knSRQ-0003pu-Dl
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 20:21:34 +0000
Received: from localhost (localhost [127.0.0.1])
 by mib.mailinblack.com (Postfix) with ESMTP id E3B021A5235
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 20:21:27 +0000 (UTC)
Received: from mib.mailinblack.com (localhost [127.0.0.1])
 by mib.mailinblack.com with SMTP (Mib Daemon ) id KIJAED7Q
 for linux-nvme@lists.infradead.org;
 Thu, 10 Dec 2020 20:21:27 +0000 (UTC)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [92.103.151.219])
 by mib.mailinblack.com (Postfix) with ESMTPS id AFFB31A5233
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 20:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 8130427E06A1
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 21:21:27 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id hdc2gFEc0mey; Thu, 10 Dec 2020 21:21:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 0870627E0682;
 Thu, 10 Dec 2020 21:21:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id sFdAgt-MXPjt; Thu, 10 Dec 2020 21:21:26 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id E1AAF27E064D;
 Thu, 10 Dec 2020 21:21:26 +0100 (CET)
Date: Thu, 10 Dec 2020 21:21:26 +0100 (CET)
From: Samuel Jones <sjones@kalrayinc.com>
To: linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <253503002.21820362.1607631686785.JavaMail.zimbra@kalray.eu>
Subject: nvme-tcp: Queue deadlock (stuck PDU) on NVMe TCP host driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3895)
Thread-Index: 7XxI17DpXdnQfdaASF/vQLJNMXjEYQ==
Thread-Topic: nvme-tcp: Queue deadlock (stuck PDU) on NVMe TCP host driver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_152132_624548_F088498C 
X-CRM114-Status: GOOD (  16.80  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi everyone,

We are observing an issue when testing the Linux NVMe TCP host driver with a Kalray target, on Write workloads that are above the inline_data_size threshold. Sometimes the NVMe TCP host driver never replies to an R2T sent by the target, causing the command to time out and the connection to be destroyed. We have been able to verify that the R2T PDU is received by the Host and acknowledged to the target by the TCP stack, and that the R2T PDU is seen by nvme_tcp_handle_r2t(). However, the H2CData created by nvme_tcp_handle_r2t() is never pushed back into the TCP stack. We're using Linux 5.8.17 on the host, but the relevant code paths haven't changed significantly since as far as I can tell. The same tests using a different host stack (SPDK) work fine.

My understanding of the issue is as follows, I'd be grateful for any clarifications you can give me: Data reception and transmission is handled by a single function nvme_tcp_io_work which is scheduled on a workqueue. It can be scheduled by several sources:

1. RX Data on the TCP socket
2. New TX space on the TCP socket
3. nvme_tcp_queue_request(): the driver has a new PDU to send
4. nvme_tcp_io_work reschedules itself if it thinks there is more work to be done

This means that the nvme_tcp_io_work can be called in parallel on different threads. To handle this, there is a mutex (send_mutex) for the transmission routines and the socket lock is taken for reception. However, different threads do not spin on the send_mutex, they simply call mutex_trylock(), and if they fail to take the lock, they just skip the TX stage. However, I believe that there is a race around the use of the send_mutex which can lead to data in the send_list being ignored, potentially indefinitely. Consider the following:

Thread 0                                                         |  Thread 1
nvme_tcp_handle_r2t (from io_work)
---------------------------------------------------------------->
                                                                 nvme_tcp_queue_rq (from blk io)
                                                                 nvme_tcp_queue_request: adds entry to list
                                                                 takes send_mutex
                                                                 goes to sleep in kernel_sendpage
<----------------------------------------------------------------
gets queue->lock, adds entry into list
schedules workqueue
exit io_work
re-enters io_work
fails to get send_mutex
exits io_work without rescheduling
                                                                 sends one PDU from the list
                                                                 releases send_mutex
                                                                 exits without rescheduling

If this occurs, the H2CData PDU will not be sent until io_work is rescheduled. If we are lucky, this will happen soon, because of other activity on the socket (new responses from the target for example). If we are not, the H2CData PDU will never be sent and the queue is deadlocked. Eventually the block io timeout will kick in and tear down the queue.

I have not been able to prove formally that the above sequence is what we are observing. I have been able to test rescheduling the workqueue if the call to mutex_trylock() in nvme_tcp_try_send fails, which fixes the issue for us.

Furthermore, I have some doubts about the fact that nvme_tcp_queue_request does not check the return code of nvme_tcp_try_send. I believe the author assumed that, given the list is supposed to be non-empty, that there is no point in checking the return value. However, it appears to be me that nvme_tcp_try_send can return a transient failure - there is a code path that checks for EAGAIN in the sub-functions and returns 0 in this case. Surely we need to check the return value of nvme_tcp_try_send in nvme_tcp_queue_request and reschedule the workqueue if ret != 1 ? What's more, nvme_tcp_io_work only reschedules the workqueue if ret > 0, so we still have a problem if nvme_tcp_try_send morphs EAGAIN into 0, as the nvme_tcp_io_work won't reschedule the io_work...

What do you think? I'd be grateful for any comments you may have this.
Best Regards
Samuel Jones


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
