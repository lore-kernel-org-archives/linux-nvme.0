Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71C3C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:43:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85F60E77
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 16:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C85F60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1ipQEl3TUbbhGR8nTOfSUXPIHxwzmsawVshkujaDjkg=; b=X+PazDwMtNkL/5
	4SN62sFjfruYRpOCplZnqcl1oQenV/wv7kte8OXIngBFB+wqJaGNyHO6G0ofPw5QOK/3jxGDgqePb
	vmcvyT57xQKA7nHcvxHdHUxp2eGQLNjOo4DrKhK7XNDJ26fTDI7mlvaIukom7w6OWIcBVouL3intE
	lvJVff3gfNFHNp960/vPt3fSdQ/NzGCnjpatbnIjeQFW9c3aGnY8NhJtPgLs/3Hc8Edqz5aCoY2PK
	NXJNlTS5fZHk3emjYlWdlzniFfa1O5IB+TbJ2Exne0z6HMvqwnk1vSqHN8sEtsiW04NhoAKZF6CcR
	TPC8FJIcIHpHBYY0S/5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNeBG-004Eih-Ps; Tue, 07 Sep 2021 16:42:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNeBD-004EhW-Oh
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 16:42:41 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEA4760E77;
 Tue,  7 Sep 2021 16:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631032959;
 bh=/thZpw6aUPnJpTf0VI1FmIzxmgUBHlS2jQmIiTqKvMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k3H1jvaEfULtvC9QE8lESYMokoFLptq1czya9b8n+VhH+dtTx7nyJSUhpiz2miwnz
 02mShlphEPsKu39ofzf2Q3rJ4zeFtKm/Pqr2iZMed4BRuZcEC6x7bYyl5ahRac6ZYl
 kOWvr5itGjbIdJiRYH2000guJ3J5gGxlY3NAwiu/+m1RmKmH1HQzeAYmBioPQsu6Vt
 SGQkN0nBmf8t13yVQjleKz5rS4DZYUx8uxdOa0UyjUVUX9DCmRH2Tjmh3kijO8B1rG
 yoSKONSz4r9JRRaZ5K+8540VgeyufSmpiZtRpi0qi8NTOvZhKNRg+j1of5o1S5HA7d
 89tBDtvgYCsig==
Date: Tue, 7 Sep 2021 09:42:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Samuel Jones <sjones@kalrayinc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: Command timeouts with NVMe TCP kernel driver
Message-ID: <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <20210831023712.GA4046@dhcp-10-100-145-180.wdc.com>
 <1306302519.5246175.1630450012705.JavaMail.zimbra@kalray.eu>
 <6e2770ca-c0ea-872a-377e-a17fa12961d9@grimberg.me>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_094239_935130_2E895EBC 
X-CRM114-Status: GOOD (  22.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 07, 2021 at 11:05:53AM +0200, Samuel Jones wrote:
> Hi Sagi, Keith, all,
> 
> I think I have a better idea about what is happening now. First of all, answers to Sagi's questions: I have 4 controllers with 8 queues each, the VM has 16 CPUs. I was timing on kernel_sendpage. I tried your patch Sagi but it didn't make any difference. Indeed, given that the queue stops transmitting requests, I guess the RX path gets very quiet very fast.
> 
> After a lot of time spent timing various functions in kernel_sendpage, the only thing I was able to observe was that my thread is descheduled and not rescheduled again for a LONG time. I think what is happening is the following.:
> 
> 1. Userspace context grabs send_mutex via queue_rq and calls into kernel_sendpage. This context is pinned to a CPU X because that's the way my benchmark works.
> 2. Userspace context is descheduled.
> 3. nvme_tcp_io_work is scheduled on the same CPU X because it so happens that io_cpu == X. (I have hundreds of threads which are statically assigned to CPUs and spread over all the CPUs of the VM, so there are necessarily some userspace threads whose CPU coincides with io_cpu).
> 4. nvme_tcp_io_work obviously can't grab send_mutex because it's held by the userspace. But because req_list is not empty, it doesn't yield but keeps on spinning in the loop until it expires.
> 5. Since pending = true nvme_tcp_io_work re-schedules itself for immediate execution. Because it's flagged as HIGHPRI, I guess this means it is rescheduled very soon/almost immediately, and my poor userspace context doesn't get enough CPU to make reasonable forward progress. We find ourselves in a kind of livelock.
> 
> This seems coherent with the fact that my problem disappears if I do any one of the 3 following things:
> 
> 1. Modify my userspace benchmark to avoid pinning threads to CPUs => direct send path can execute on a different CPU and make forward progress
> 2. Modify nvme-tcp to remove the "direct send" path in queue_rq and always post to the work queue => no contention between direct send path and the workqueue
> 3. Modify the tcp wq to remove the WQ_HIGHPRI flag. => I guess this makes the scheduler more friendly towards my userspace thread
> 
> Does this make sense? What do you think is the best way to fix this? I guess the WQ_HIGHPRI flag is there for a reason, and that the "direct send" path can provide lower latency in some cases. What about a heuristic in io_work that will prevent it from looping indefinitely after a certain number of failed attempts to claim the send mutex?

Sounds possible. The "pending" check on the req_list was to fix a race
condition where the io_work could miss handling a request, resulting in
a different command time out. It sounds like that could make the io_work
spin without having anything to do, while starving the lower priority
task. I'll try to think of another way to handle it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
