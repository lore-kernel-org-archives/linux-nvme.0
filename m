Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4992BC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:08:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18B97207DA
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xFrt09hl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmYYeZp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B97207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=vEseSgtRx3aoHzPNtAU0ZAGAkgDtKQW4iB2TxOpUZfI=; b=xFrt09hlJM6ox4giExxZxjK7C
	6c2hAKZ/VNA2izlRjEiz/+K40rCRSwNz6iEB7dBH2IPSAzse8XWVl8LAQajuUlqdZryLJdwKup84w
	rbNoii0hkDZ5CJWLlZAGRKMVyXticTpOdeduKJuc8Wy8dfM3u1DxI7vA2euucWQPKOpMzrKAtiefy
	WWLH9XdEJbuRQjGppgGjBu6gUKty4Jpngu/bOE9Hrbr5qDUNgCsrVnpL38kSfSE2ONERxWqr1Abxg
	DxKo9mhg8LCBrq1tafxG1BX/b2FPP82pwaB+1P0lqzEQOc2BZwedIu9bYS4O2VZrJ79hN79fE0xAF
	6ORQBrXqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k84A4-0002e6-IP; Tue, 18 Aug 2020 16:08:32 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k84A1-0002by-R5
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 16:08:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597766904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=dYdNi+ENgsH6NHoOgMjsQ3J9WHSHt0RgNRpSBWf5LDc=;
 b=KmYYeZp27cuvSzmnHYt9q9t45m/RvvvaCSDh1vRHpQVd9en5MmecZwAjAbDUo19v8gHNZv
 SjcmYE6X2wQ3qVZRFVS1eDlkSunW2eXYT2aN3yhw8heq8HZWmpxb52U2MHmoY/Sk+nEtD1
 03eLZJdbj87PO8lQqIiiHgr0jV1AQMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-fMOr-KLPMr-fFKDnVcEIzw-1; Tue, 18 Aug 2020 12:08:07 -0400
X-MC-Unique: fMOr-KLPMr-fFKDnVcEIzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A068807330;
 Tue, 18 Aug 2020 16:08:06 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 405957DFC0;
 Tue, 18 Aug 2020 16:08:06 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0DFE7181A869;
 Tue, 18 Aug 2020 16:08:05 +0000 (UTC)
Date: Tue, 18 Aug 2020 12:08:04 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <1476432272.38046616.1597766884817.JavaMail.zimbra@redhat.com>
In-Reply-To: <934717176.38045698.1597765603125.JavaMail.zimbra@redhat.com>
Subject: regression with "nvme-rdma: use new shared CQ mechanism" from v5.9-rc1
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.24]
Thread-Topic: regression with "nvme-rdma: use new shared CQ mechanism" from
 v5.9-rc1
Thread-Index: pZSrAssP8UpjJvu5K5fy3epZLAA1rA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_120829_943371_3A122F66 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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
Cc: yaminf@mellanox.com, kbusch@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

With Sagi's new blktests nvme rdma[1], I found one regresson that lead nvme/004 hang.
By bisecting, I found it was introduced from [2], could anyone help check this issue, thanks.

[1] https://marc.info/?l=linux-block&m=159738590701657&w=2
# nvme_trtype=rdma ./check nvme/004                      -------> hang and never finished
nvme/004 (test nvme and nvmet UUID NS descriptors)          
    runtime  1.647s  ...

# ps aux | grep rdma_rxe
root        1657  0.0  0.0   8292  1632 pts/0    D+   11:54   0:00 modprobe -r rdma_rxe
        
# cat /proc/1657/stack 
[<0>] disable_device+0xa2/0x130 [ib_core]
[<0>] __ib_unregister_device+0x37/0xa0 [ib_core]
[<0>] ib_unregister_driver+0x9d/0xd0 [ib_core]
[<0>] rxe_module_exit+0x16/0x7d [rdma_rxe]
[<0>] __do_sys_delete_module.constprop.0+0x170/0x2c0
[<0>] do_syscall_64+0x33/0x40
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

# dmesg
[  273.577444] run blktests nvme/004 at 2020-08-18 11:54:22
[  273.615610] rdma_rxe: loaded
[  273.623675] infiniband rxe0: set active
[  273.627962] infiniband rxe0: added eno1
[  273.639520] infiniband rxe1: set down
[  273.643611] infiniband rxe1: added eno2
[  273.655617] infiniband rxe0: set down
[  273.659713] infiniband rxe0: added eno3
[  273.673854] infiniband rxe0: set down
[  273.677946] infiniband rxe0: added eno4
[  273.695954] infiniband rxe0: set active
[  273.700236] infiniband rxe0: added enp130s0f0
[  273.717858] infiniband rxe0: set down
[  273.721954] infiniband rxe0: added enp130s0f1
[  273.739460] lo speed is unknown, defaulting to 1000
[  273.744941] lo speed is unknown, defaulting to 1000
[  273.750413] lo speed is unknown, defaulting to 1000
[  273.757853] infiniband rxe0: set active
[  273.762139] infiniband rxe0: added lo
[  273.766229] lo speed is unknown, defaulting to 1000
[  273.771681] lo speed is unknown, defaulting to 1000
[  273.777135] lo speed is unknown, defaulting to 1000
[  273.992958] loop: module loaded
[  274.024550] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  274.039541] nvmet_rdma: enabling port 0 (10.16.221.68:4420)
[  274.066081] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:e5372c18c860491bb18adb3b5b025a20.
[  274.081395] nvme nvme0: creating 32 I/O queues.
[  274.120241] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[  274.132037] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.16.221.68:4420
[  275.171715] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[  275.311794] rdma_rxe: not configured on eno1
[  275.321210] rdma_rxe: not configured on eno2
[  275.333410] rdma_rxe: not configured on eno3
[  275.347527] rdma_rxe: not configured on eno4
[  275.362830] rdma_rxe: not configured on enp130s0f0
[  275.383157] rdma_rxe: not configured on enp130s0f1
[  275.406067] rdma_rxe: not configured on lo
[  513.938222] infiniband rocep130s0f0: set active
[  558.930867] infiniband rocep130s0f0: set active
[  558.948955] infiniband rocep130s0f0: set active
[  603.930414] infiniband rocep130s0f0: set active


[2]
ca0f1a8055be nvmet-rdma: use new shared CQ mechanism
287f329e3131 nvme-rdma: use new shared CQ mechanism

Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
