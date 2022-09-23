Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25915ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Aa9eT3/nlIqJee07pmYdPkP0VMs8PyHMV64c9/YvCkY=; b=UgiKJm49jwLjYMUnFyOHkwk8JA
	ou06j/j07V1wCI8280DutlbuwchKVYEE7IiwfqgFFRDFveY4x9UC/38n+QKml/yZfrR3vQ3CoEZeI
	NHIIt41iggIQ2qsILrTqnSKL5vYf/iwdOH0t4y+heriGcmxTnhzw34lEvtdccsCasq6RZgBn3lFcc
	sYukvkz45D8Ug9E3oN1iNK6Ffp84vN4r6uVPDW2rT1DpckXHmkos0sO0X8JOWSJ8/x5S+rtXupxe5
	c5EzZ3Hv/iDSvwvQaUquXVGaSCwu4MXcv0qleucPA7UWISWbZ7Yq5dv7gMcFG0f1FlJdAXh526kMl
	kiqi82VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdCc-002irt-GL; Fri, 23 Sep 2022 07:34:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdCX-002iqm-V0
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 07:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663918459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Aa9eT3/nlIqJee07pmYdPkP0VMs8PyHMV64c9/YvCkY=;
	b=BtK6vnYtR4IGbpfbM/sZ+TXGMSSbNIGcslqqP2t5roGTQhelINT/XKbYGpnk5qoWk4MIMu
	osKJS+dukC0gIbIa68Adq+bEkpE5z4ueOMBm00XXcssB9pYXAN9CNPIqQ+PGIdw6Lzixcb
	ddUjTZSgxBjU62bI9Xde/48ZBCGI0iE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-Wo7Zyv2dPDeas0KAvkbGtQ-1; Fri, 23 Sep 2022 03:34:18 -0400
X-MC-Unique: Wo7Zyv2dPDeas0KAvkbGtQ-1
Received: by mail-pg1-f199.google.com with SMTP id i25-20020a635859000000b0042bbb74be8bso6448732pgm.5
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 00:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Aa9eT3/nlIqJee07pmYdPkP0VMs8PyHMV64c9/YvCkY=;
        b=lmS3tKUNZq5yG4/XoLOi8yWPVr9usWI+u7GfSBT2eUIqtcIkQjZHi8ELE94jYuVhqe
         sSyPVusfFRZDPalwUM+9sEetO3fFZMNes5OZNiSUzkBHFuYwsbhrCAITTYQY7hMac/hU
         ASiRZZvJhza9jwSQmyRgF2ZjCIlcIpJJkK06dbbat3KTZ+hD8T4GGRh1yE5HCEkVTVLf
         BaY0gmZtw1SvDXZYoOuDw5ARRomuriaqb3H995ohS7hM3ok/CaFIk1/R/p2905HO10/h
         Hbyll95PQPLe3kWBUxZYUAVKSOpij+sbRr1yMRDLRsRQGy9NkbHWhP4Hqq3kVmsL4h8D
         b9ew==
X-Gm-Message-State: ACrzQf0nhtCIFftT7rdxqOywOzhqcmRCagRAysOSrUhBuo0eWP8TRNdy
	i7PoFXQkoLrfXjimUtrlkpOI6ITCfOHCLeRTZ8CjuuhSOWVgkyVYZLZTwtncW0EpSPVo2RLscq7
	J/v5/UV0IgAlBupgjn3sJaqfiXbZJoDVxUMlP1VBay2I=
X-Received: by 2002:a63:ff59:0:b0:439:db5:5da9 with SMTP id s25-20020a63ff59000000b004390db55da9mr6426155pgk.88.1663918456107;
        Fri, 23 Sep 2022 00:34:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6AKQH1K8gRyOSKVP9pf9JrlX1VifKdU3+zelnYUQNQh8zZaWoKSFfm6TffoV//HGn6k2s8qK5XsXAIyivJQVg=
X-Received: by 2002:a63:ff59:0:b0:439:db5:5da9 with SMTP id
 s25-20020a63ff59000000b004390db55da9mr6426125pgk.88.1663918455458; Fri, 23
 Sep 2022 00:34:15 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 23 Sep 2022 15:34:03 +0800
Message-ID: <CAHj4cs_5=0DGhe5W5oQ1OA+eBy64MX9gRpA8-3N8Qk3Wh-Dwzg@mail.gmail.com>
Subject: [bug report] workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_003422_193257_A76642FF 
X-CRM114-Status: GOOD (  12.37  )
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

Hello

Below issue was triggered with blktests nvmeof-mp/012 on 5.19.10, pls
help check it, feel free to let me know if you need any info/test.


It can be reproduced within 100 cycles run with ."/check nvmeof-mp/012"
dmesg log:
[  350.579057] run blktests nvmeof-mp/012 at 2022-09-23 03:07:21
[  350.660517] null_blk: module loaded
[  350.668386] null_blk: disk nullb0 created
[  350.670913] null_blk: disk nullb1 created
[  350.691777] device-mapper: table: 253:0: multipath: error getting
device (-EBUSY)
[  350.691799] device-mapper: ioctl: error adding target to table
[  350.746159] rdma_rxe: loaded
[  350.753345] infiniband env3_rxe: set active
[  350.753356] infiniband env3_rxe: added env3
[  350.892769] nvmet: adding nsid 1 to subsystem nvme-test
[  350.901787] nvmet_rdma: enabling port 1 (10.0.2.222:7777)
[  350.940242] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000017d82f43
[  350.940886] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000017d82f43
[  350.940983] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000286b8895
[  350.940989] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.941605] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 289
cm_id= 00000000286b8895
[  350.941659] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000017d82f43
[  350.941713] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000286b8895
[  350.941778] nvmet:nvmet_start_keep_alive_timer: nvmet: ctrl 1 start
keep-alive timer for 5 secs
[  350.941781] nvmet: creating nvm controller 1 for subsystem
nvme-test for NQN
nqn.2014-08.org.nvmexpress:uuid:4721a245-d23f-4c00-b1d0-8d273c3db004.
[  350.942139] nvme nvme0: creating 8 I/O queues.
[  350.942158] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000c5dbee70
[  350.942354] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000c5dbee70
[  350.942412] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 000000000c220555
[  350.942416] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.942636] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 000000000c220555
[  350.942697] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000c5dbee70
[  350.942740] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 000000004eb27b13
[  350.942747] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 000000000c220555
[  350.942935] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 000000004eb27b13
[  350.942992] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000e169966e
[  350.942995] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.943213] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000e169966e
[  350.943259] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 000000004eb27b13
[  350.943302] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000025dab642
[  350.943308] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000e169966e
[  350.943443] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000025dab642
[  350.943484] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000a5657f4f
[  350.943487] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.943677] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000a5657f4f
[  350.943715] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000025dab642
[  350.943746] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000eb92556a
[  350.943748] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000a5657f4f
[  350.943880] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000eb92556a
[  350.943916] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 0000000026cb2a8f
[  350.943919] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.944127] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 0000000026cb2a8f
[  350.944170] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000eb92556a
[  350.944199] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000046325928
[  350.944202] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 0000000026cb2a8f
[  350.944336] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000046325928
[  350.944376] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000b31e4e71
[  350.944378] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.944568] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000b31e4e71
[  350.944604] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000046325928
[  350.944634] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000e1a31e4f
[  350.944636] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000b31e4e71
[  350.944769] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000e1a31e4f
[  350.944804] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000c3020c44
[  350.944807] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.945029] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000c3020c44
[  350.945078] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000e1a31e4f
[  350.945115] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 000000006accc65c
[  350.945121] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000c3020c44
[  350.945267] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 000000006accc65c
[  350.945312] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000ca3d146d
[  350.945314] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.945510] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000ca3d146d
[  350.945555] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 000000006accc65c
[  350.945591] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000b0b8d1eb
[  350.945598] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000ca3d146d
[  350.945735] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000b0b8d1eb
[  350.945781] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000969b9167
[  350.945783] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  350.945980] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000969b9167
[  350.946025] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000b0b8d1eb
[  350.946051] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[  350.946073] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000969b9167
[  350.946285] nvmet:nvmet_execute_io_connect: nvmet: adding queue 1 to ctrl 1.
[  350.946337] nvmet:nvmet_execute_io_connect: nvmet: adding queue 2 to ctrl 1.
[  350.946378] nvmet:nvmet_execute_io_connect: nvmet: adding queue 3 to ctrl 1.
[  350.946427] nvmet:nvmet_execute_io_connect: nvmet: adding queue 4 to ctrl 1.
[  350.946479] nvmet:nvmet_execute_io_connect: nvmet: adding queue 5 to ctrl 1.
[  350.946540] nvmet:nvmet_execute_io_connect: nvmet: adding queue 6 to ctrl 1.
[  350.946595] nvmet:nvmet_execute_io_connect: nvmet: adding queue 7 to ctrl 1.
[  350.946650] nvmet:nvmet_execute_io_connect: nvmet: adding queue 8 to ctrl 1.
[  350.946708] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.222:7777
[  350.946739] nvmet:nvmet_req_cns_error_complete: nvmet: unhandled
identify cns 6 on qid 0
[  350.960438] device-mapper: table: 253:0: multipath: error getting
device (-EBUSY)
[  350.960452] device-mapper: ioctl: error adding target to table
[  351.074392] device-mapper: table: 253:1: multipath: error getting
device (-EBUSY)
[  351.074405] device-mapper: ioctl: error adding target to table
[  355.638030] nvme nvme0: Removing ctrl: NQN "nvme-test"
[  355.825297] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 000000000c220555
[  355.825306] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 000000000c220555 queue->state= 1
[  355.825316] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 1
[  355.825360] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000e169966e
[  355.825365] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000e169966e queue->state= 1
[  355.825375] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 2
[  355.825387] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000c5dbee70
[  355.825392] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825419] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000a5657f4f
[  355.825422] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000a5657f4f queue->state= 1
[  355.825430] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 3
[  355.825438] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 000000004eb27b13
[  355.825443] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825504] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 0000000025dab642
[  355.825509] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825513] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 0000000026cb2a8f
[  355.825517] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 0000000026cb2a8f queue->state= 1
[  355.825525] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 4
[  355.825556] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000b31e4e71
[  355.825560] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000b31e4e71 queue->state= 1
[  355.825569] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 5
[  355.825577] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000eb92556a
[  355.825582] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825640] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 0000000046325928
[  355.825645] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825648] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000c3020c44
[  355.825651] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000c3020c44 queue->state= 1
[  355.825657] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 6
[  355.825702] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000ca3d146d
[  355.825705] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000ca3d146d queue->state= 1
[  355.825712] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 7
[  355.825719] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000e1a31e4f
[  355.825721] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825775] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 000000006accc65c
[  355.825779] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.825782] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000969b9167
[  355.825785] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000969b9167 queue->state= 1
[  355.825791] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 8
[  355.825839] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000b0b8d1eb
[  355.825844] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  355.945236] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000286b8895
[  355.945244] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000286b8895 queue->state= 1
[  355.945253] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 0
[  355.968634] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 000000003d55212b
[  355.968712] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 000000003d55212b
[  355.968794] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 000000008fee8ffd
[  355.968799] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  355.968887] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 289
cm_id= 000000008fee8ffd
[  356.005186] nvmet:nvmet_stop_keep_alive_timer: nvmet: ctrl 1 stop keep-alive
[  356.005186] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
traffic based keep-alive timer
[  356.005192] ------------[ cut here ]------------
[  356.005204] workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
!WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
[  356.005226] WARNING: CPU: 3 PID: 1086 at kernel/workqueue.c:2628
check_flush_dependency+0x16c/0x1e0
[  356.005240] Modules linked in: nvme nvmet_rdma nvmet rdma_rxe
ib_uverbs ip6_udp_tunnel udp_tunnel null_blk nvme_rdma nvme_fabrics
rdma_cm iw_cm ib_cm crc32_generic dm_service_time scsi_dh_rdac
scsi_dh_emc scsi_dh_alua dm_multipath ib_core nvme_core rfkill bonding
tls sunrpc ibmveth pseries_rng crct10dif_vpmsum fuse zram xfs ibmvscsi
vmx_crypto scsi_transport_srp crc32c_vpmsum
[  356.005520] CPU: 3 PID: 1086 Comm: kworker/3:4 Not tainted
5.19.10-200.fc36.ppc64le #1
[  356.005526] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
[  356.005531] NIP:  c000000000177adc LR: c000000000177ad8 CTR: 00000000ffffffe1
[  356.005536] REGS: c000000015353660 TRAP: 0700   Not tainted
(5.19.10-200.fc36.ppc64le)
[  356.005540] MSR:  800000000282b033
<SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48002222  XER: 20040005
[  356.005553] CFAR: c00000000014d18c IRQMASK: 1
               GPR00: c000000000177ad8 c000000015353900
c0000000028ddb00 000000000000008f
               GPR04: 00000000ffffdfff c0000000153536b8
c0000000153536b0 00000001fd6a0000
               GPR08: 0000000000000027 c0000001ff807f98
0000000000000001 0000000000002000
               GPR12: 0000000000000000 c00000001ecaae80
c000000000187028 c000000039a48140
               GPR16: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
               GPR20: 0000000000000000 0000000000000000
c0000000026600d0 c00000000f47c018
               GPR24: 5deadbeef0000100 5deadbeef0000122
c00000000f47c0a0 c00000000f47c000
               GPR28: c0000001ff790c00 c008000003c10ad8
c000000010bae940 c000000003074200
[  356.005604] NIP [c000000000177adc] check_flush_dependency+0x16c/0x1e0
[  356.005609] LR [c000000000177ad8] check_flush_dependency+0x168/0x1e0
[  356.005613] Call Trace:
[  356.005616] [c000000015353900] [c000000000177ad8]
check_flush_dependency+0x168/0x1e0 (unreliable)
[  356.005622] [c000000015353980] [c00000000017b908]
__flush_work.isra.0+0x2b8/0x390
[  356.005628] [c000000015353a10] [c00000000017bb78]
__cancel_work_timer+0x138/0x1e0
[  356.005633] [c000000015353a90] [c008000003c13418]
nvmet_stop_keep_alive_timer+0x80/0xa0 [nvmet]
[  356.005642] [c000000015353b00] [c008000003c135c8]
nvmet_ctrl_free+0x190/0x380 [nvmet]
[  356.005650] [c000000015353b90] [c008000003c13938]
nvmet_sq_destroy+0x180/0x2b0 [nvmet]
[  356.005658] [c000000015353bf0] [c008000003c81888]
nvmet_rdma_free_queue+0x30/0x170 [nvmet_rdma]
[  356.005664] [c000000015353c60] [c008000003c82518]
nvmet_rdma_release_queue_work+0x30/0xc0 [nvmet_rdma]
[  356.005671] [c000000015353c90] [c00000000017a38c]
process_one_work+0x2ac/0x570
[  356.005676] [c000000015353d30] [c00000000017ad58] worker_thread+0xa8/0x630
[  356.005681] [c000000015353dc0] [c000000000187144] kthread+0x124/0x130
[  356.005687] [c000000015353e10] [c00000000000ce54]
ret_from_kernel_thread+0x5c/0x64
[  356.005692] Instruction dump:
[  356.005695] 4082ffcc e8be0018 39200001 3c62fed1 3d42fff5 7fa7eb78
38df00b0 388400b0
[  356.005704] 38631af0 992ab7ee 4bfd5651 60000000 <0fe00000> 3d22fff5
8929b7ed 2c090000
[  356.005713] ---[ end trace 0000000000000000 ]---
[  356.005860] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 000000003d55212b
[  356.005892] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 000000008fee8ffd
[  356.005964] nvmet:nvmet_start_keep_alive_timer: nvmet: ctrl 1 start
keep-alive timer for 5 secs
[  356.005967] nvmet: creating nvm controller 1 for subsystem
nvme-test for NQN
nqn.2014-08.org.nvmexpress:uuid:4721a245-d23f-4c00-b1d0-8d273c3db004.
[  356.006304] nvme nvme0: creating 8 I/O queues.
[  356.006330] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000002113af3
[  356.006490] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000002113af3
[  356.006544] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 000000005313c31f
[  356.006549] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.006782] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 000000005313c31f
[  356.006841] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000002113af3
[  356.006887] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000061b71c81
[  356.006890] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 000000005313c31f
[  356.007085] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000061b71c81
[  356.007137] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 000000009c7cb2a7
[  356.007141] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.007367] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 000000009c7cb2a7
[  356.007420] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000061b71c81
[  356.007463] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000a113333f
[  356.007463] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 000000009c7cb2a7
[  356.007635] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000a113333f
[  356.007674] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 0000000012f56b3a
[  356.007676] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.007867] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 0000000012f56b3a
[  356.007907] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000a113333f
[  356.007940] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 0000000012f56b3a
[  356.007942] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 000000003b95f75b
[  356.008075] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 000000003b95f75b
[  356.008109] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 0000000088a63ce3
[  356.008112] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.008303] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 0000000088a63ce3
[  356.008342] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 000000003b95f75b
[  356.008375] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 0000000088a63ce3
[  356.008376] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000233271c9
[  356.008508] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000233271c9
[  356.008541] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 0000000087be52f6
[  356.008544] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.008733] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 0000000087be52f6
[  356.008771] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000233271c9
[  356.008801] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 0000000087be52f6
[  356.008805] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000d4d8d6d9
[  356.008937] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000d4d8d6d9
[  356.008966] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000a9e79829
[  356.008969] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.009158] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000a9e79829
[  356.009196] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000d4d8d6d9
[  356.009226] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000a9e79829
[  356.009231] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 00000000616f9de0
[  356.009360] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 00000000616f9de0
[  356.009389] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 000000005b82f663
[  356.009391] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.009579] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 000000005b82f663
[  356.009617] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 00000000616f9de0
[  356.009647] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 000000005b82f663
[  356.009651] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
resolved (0): status 0 id 0000000016cb5f81
[  356.009784] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
resolved  (2): status 0 id 0000000016cb5f81
[  356.009813] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
request (4): status 0 id 00000000ce50a3b3
[  356.009815] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
added env3_rxe.
[  356.010005] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
cm_id= 00000000ce50a3b3
[  356.010042] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
(9): status 0 id 0000000016cb5f81
[  356.010067] nvme nvme0: mapped 8/0/0 default/read/poll queues.
[  356.010072] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
established (9): status 0 id 00000000ce50a3b3
[  356.010278] nvmet:nvmet_execute_io_connect: nvmet: adding queue 1 to ctrl 1.
[  356.010326] nvmet:nvmet_execute_io_connect: nvmet: adding queue 2 to ctrl 1.
[  356.010370] nvmet:nvmet_execute_io_connect: nvmet: adding queue 3 to ctrl 1.
[  356.010420] nvmet:nvmet_execute_io_connect: nvmet: adding queue 4 to ctrl 1.
[  356.010461] nvmet:nvmet_execute_io_connect: nvmet: adding queue 5 to ctrl 1.
[  356.010508] nvmet:nvmet_execute_io_connect: nvmet: adding queue 6 to ctrl 1.
[  356.010551] nvmet:nvmet_execute_io_connect: nvmet: adding queue 7 to ctrl 1.
[  356.010601] nvmet:nvmet_execute_io_connect: nvmet: adding queue 8 to ctrl 1.
[  356.010657] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.222:7777
[  356.010683] nvmet:nvmet_req_cns_error_complete: nvmet: unhandled
identify cns 6 on qid 0
[  356.023878] device-mapper: table: 253:0: multipath: error getting
device (-EBUSY)
[  356.023894] device-mapper: ioctl: error adding target to table
[  356.137306] device-mapper: table: 253:1: multipath: error getting
device (-EBUSY)
[  356.137318] device-mapper: ioctl: error adding target to table
[  361.045345] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
traffic based keep-alive timer
[  361.209034] nvme nvme0: Removing ctrl: NQN "nvme-test"
[  361.365478] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 000000005313c31f
[  361.365491] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 000000005313c31f queue->state= 1
[  361.365505] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 0
[  361.365540] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 000000009c7cb2a7
[  361.365544] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 000000009c7cb2a7 queue->state= 1
[  361.365553] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 2
[  361.365602] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 0000000002113af3
[  361.365605] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365616] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 0000000061b71c81
[  361.365622] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365628] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 0000000012f56b3a
[  361.365634] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 0000000012f56b3a queue->state= 1
[  361.365645] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 3
[  361.365662] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 0000000088a63ce3
[  361.365665] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 0000000088a63ce3 queue->state= 1
[  361.365673] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 4
[  361.365681] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000a113333f
[  361.365685] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365713] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 000000003b95f75b
[  361.365719] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365742] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 0000000087be52f6
[  361.365746] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 0000000087be52f6 queue->state= 1
[  361.365754] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 5
[  361.365809] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000233271c9
[  361.365813] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365818] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000a9e79829
[  361.365820] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000a9e79829 queue->state= 1
[  361.365827] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 6
[  361.365850] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 000000005b82f663
[  361.365853] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 000000005b82f663 queue->state= 1
[  361.365862] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 7
[  361.365871] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000d4d8d6d9
[  361.365876] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365912] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 00000000ce50a3b3
[  361.365915] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 00000000ce50a3b3 queue->state= 1
[  361.365924] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 8
[  361.365932] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 00000000616f9de0
[  361.365936] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.365982] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
disconnected (10): status 0 id 0000000016cb5f81
[  361.365986] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
received - connection closed
[  361.485420] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
disconnected (10): status 0 id 000000008fee8ffd
[  361.485433] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
cm_id= 000000008fee8ffd queue->state= 1
[  361.485446] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 1
[  361.535383] nvmet:nvmet_stop_keep_alive_timer: nvmet: ctrl 1 stop keep-alive
[  362.033078] rdma_rxe: unloaded

-- 
Best Regards,
  Yi Zhang


