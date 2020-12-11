Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BE8C4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 07:26:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2859239E5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 07:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2859239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZC5ySlDYBP84rfqSO8O3kdut0w2wOm5OmqZi+GV5oRE=; b=OXSqKFxIG5A4nJwvvEE4e4lKc
	DOgBSwWQ5xrpk9+cWErXagXH6In8TpCM4nqNqY8QrGIROu6Y+sZgsC/Y537mKD8c1vl5mQbk7FIHV
	yomdEEPLuvGjHCUaBOVSTBFwFs8hpsST7FscJlKJkFLJsmnXQFpFuehCmDkTPGk5RaxaiEdMKpagN
	wDhuqtvp3My4SeDwkzyuoz1hFGjQdVC6BUuKsmXWCmSCrSZ5CSVtlmNyrbKNicpEXNfEBkk7UI1Sl
	qRbTElXjd/Lx3xc9BddRcvGI7JZ4hxeyyXWM5pHZmEGRMVAXHyU17ENXWPRIwSKzeW4jaMjvFbIZ9
	kUMNqyJsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kncpA-0003Nf-69; Fri, 11 Dec 2020 07:26:44 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kncp5-0003NA-Ix
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 07:26:42 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BB7QRbq007602;
 Thu, 10 Dec 2020 23:26:28 -0800
Date: Fri, 11 Dec 2020 12:56:27 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Request timeout seen with NVMEoF TCP
Message-ID: <X9MfI872AfM+WMV/@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_022639_780179_B51F0ACA 
X-CRM114-Status: GOOD (  24.05  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Friday, December 12/11/20, 2020 at 03:17:11 +0530, Sagi Grimberg wrote:
> >>> Hi All,
> >>> I am seeing the following timeouts and reconnects on NVMF TCP initiator with latest v5.10-rc5
> >>> kernel.
> >>> I see the same behavior with nvme tree too (branch:nvme-5.11)
> >>> I last ran this with 5.8, where it was running fine.
> >>>
> >>> Target configuration is, 1 target with 1gb ramdisk namespace. On intiator,
> >>> discover, connect and run fio or Iozone. Traces are seen within couple of minutes
> >>> after starting the test.
> >>
> >> Hey Potnuri,
> >>
> >> Can you also attach the target side logs? it seems like an I/O times out
> >> for no apparent reason..
> > 
> > I see nothing much logged on target.
> 
> Hey Potnuri,
> 
> This issue is consistent with what Baharat reported.
> 
> Can you please check if the below solves the issue?
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1ba659927442..9193b05d7bda 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1122,6 +1122,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                                  pending = true;
>                          else if (unlikely(result < 0))
>                                  break;
> +               } else {
> +                       /*
> +                        * submission path is sending, we need to
> +                        * continue or resched because the submission
> +                        * path direct send is not concerned with
> +                        * rescheduling...
> +                        */
> +                       pending = true;
>                  }
> 
>                  result = nvme_tcp_try_recv(queue);
> --

Hi Sagi,
With above patch I still see the issue but less frequently. Without patch I was 
able to consistently reproduce the timouts with 4 target devices. With patch I 
see IO running fine for 4 targets. Tried the same test with 8 target devices 
and I see the below timeout. I've observed only one instance of timeout. So, 
I'll let it run for somemore time or rerun and update.

Target dmesg:
---
[ 1704.132366] nvmet: creating controller 1 for subsystem nvme-ram0 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.185987] nvmet: creating controller 2 for subsystem nvme-ram1 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.230065] nvmet: creating controller 3 for subsystem nvme-ram2 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.277712] nvmet: creating controller 4 for subsystem nvme-ram3 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.314457] nvmet: creating controller 5 for subsystem nvme-ram4 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.370124] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.435581] nvmet: creating controller 7 for subsystem nvme-ram6 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 1704.501813] nvmet: creating controller 8 for subsystem nvme-ram7 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 2103.965017] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
^^^^^^^^^^^^^^^
---

Initiator dmesg:
---
[ 1735.038634] EXT4-fs (nvme7n1): mounted filesystem with ordered data mode. Opts: (null)
[ 2111.990419] nvme nvme5: queue 7: timeout request 0x57 type 4
[ 2111.991835] nvme nvme5: starting error recovery
[ 2111.998796] block nvme5n1: no usable path - requeuing I/O
[ 2111.998816] nvme nvme5: Reconnecting in 10 seconds...
[ 2122.253431] block nvme5n1: no usable path - requeuing I/O
[ 2122.254732] nvme nvme5: creating 16 I/O queues.
[ 2122.301169] nvme nvme5: mapped 16/0/0 default/read/poll queues.
[ 2122.314229] nvme nvme5: Successfully reconnected (1 attempt)
---


Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
