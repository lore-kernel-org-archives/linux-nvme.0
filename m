Return-Path: <SRS0=pyBt=IM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E14C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Mar 2021 06:34:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2FF64EC0
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Mar 2021 06:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2FF64EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=Ham+pmK8oYq38nZQ7T7wHYGBQJcQiRXNQm9pcdjqMPE=; b=G2dU9SNP5a+cZP4+4lx7QIzkd
	Z94JjTFje4/4KISPkORszIfjOpCrdCrBeqeUkjyIsp3PKRmjdBAUrtL5yiRMw8lPOUXjz51crrPCW
	fOaPZj+I26+ARvPjJi2qk0G2E/XDn6s5g02ijfBYjoBklpvlI9TppQqa/DjK+J10zsbCfzYl1EiVu
	bS0VNTdG6KIaxJ164BUrmgv/i6D/ItxkSd9Bij17pQZb/B2uhsKh5m/tA4BfroxH9CA644aL2SV/4
	5Dq98S9Lg4vUErKTydeHUhycDsGQG/RkEJH15YPl9dWNj69+5vk/ryxUnTPzBTYpQ1+8QFWlofq1l
	x4NPR0Cpg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLKKM-00DxVO-RG; Sun, 14 Mar 2021 06:34:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLKKC-00DxV5-AP
 for linux-nvme@lists.infradead.org; Sun, 14 Mar 2021 06:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615703641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=jhz3DkJzc6SEDWOc/GiZRulgwNd7eS5DBSpt5e/Sk1c=;
 b=Dg+8j81qNik+G6/3oYahLqxH/bcv4YwiIHh0BXy5E6mpDvvb1gwrSpivrT9+zUfrnhZMGA
 qFfZ0jiocE/TtZ6tM7NnRF8F2Ge2hMPyXbRi7speKnHMWAtgupmMJLzwXcAxTs9UdjCIXl
 WftMfzcRHKXzk2A+XKMdId8hC+ycShQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-5POkTTX7NiOWmYA0gU6ukg-1; Sun, 14 Mar 2021 01:32:30 -0500
X-MC-Unique: 5POkTTX7NiOWmYA0gU6ukg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E02B107B02A;
 Sun, 14 Mar 2021 06:32:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D80F25C276;
 Sun, 14 Mar 2021 06:32:28 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id B45B71809C84;
 Sun, 14 Mar 2021 06:32:28 +0000 (UTC)
Date: Sun, 14 Mar 2021 01:32:28 -0500 (EST)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me
Message-ID: <2052426528.19238323.1615703548200.JavaMail.zimbra@redhat.com>
In-Reply-To: <642327227.19237955.1615702580608.JavaMail.zimbra@redhat.com>
Subject: BUG: using __this_cpu_read() in preemptible code observed with
 blktests nvme-tcp on rt kernel
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.16]
Thread-Topic: using __this_cpu_read() in preemptible code observed with
 blktests nvme-tcp on rt kernel
Thread-Index: t/sDkNBZR2MgFCghON0+4fij+PzH5g==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210314_063404_641936_57AA8145 
X-CRM114-Status: UNSURE (   7.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi

I reproduced this issue on latest rt kernel, could you help check it, thanks.

[   76.812567] run blktests nvme/003 at 2021-03-14 07:29:39
[   76.880530] loop: module loaded
[   76.893827] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[   76.895766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   76.898923] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:f1d7a9f1-79ef-42a3-952b-59c7338f3b54.
[   76.899061] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
[   76.899063] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/u64:25/231
[   76.899065] caller is nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
[   76.899069] CPU: 3 PID: 231 Comm: kworker/u64:25 Tainted: G S        I       5.12.0-rc2-rt1 #4
[   76.899071] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
[   76.899072] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
[   76.899081] Call Trace:
[   76.899083]  dump_stack+0x64/0x7c
[   76.899086]  check_preemption_disabled+0xb6/0xd0
[   76.899090]  nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
[   76.899093]  nvme_async_event_work+0x5d/0xc0 [nvme_core]
[   76.899098]  process_one_work+0x1c8/0x3f0
[   76.899101]  ? process_one_work+0x3f0/0x3f0
[   76.899102]  worker_thread+0x30/0x370
[   76.899104]  ? process_one_work+0x3f0/0x3f0
[   76.899105]  kthread+0x183/0x1a0
[   76.899108]  ? kthread_park+0x80/0x80
[   76.899110]  ret_from_fork+0x1f/0x30
[   86.912113] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"




Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
