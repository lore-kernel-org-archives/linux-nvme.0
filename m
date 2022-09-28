Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD63BC04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WQtjPSxqerk86d3wZpAVTWJbyOfKjvr/BLVyMfHM3bg=; b=N0y8jzl9cgQZwNBKhJLYVJoFr1
	tdPmZlqBWgeqCwNiuccLPLJ3K6+1koYpRe2M3Z857TdgygW9MSgfiX+nOA5Nw9YgGjPe3bPZ8lsxO
	tnHvobRKpA+aon4hc40MNOsicAjjN1ZOGcQorDXo523aKXFSU3Cy2iUvJdJAit+cG52dpxybhBX6B
	4wPrlesaQCVMjhoCZDxYoMUgEhlE2KQuAITo+jH7KBjZAAt1UBG6tfNRuSEUAGHFMiNFxU+mS/h5C
	bYdmiL0a3m8iNEq/Q4GmWijakANuFqne7efNd3xk6ai7zVImm/LcuBWLfwYXkpnm4tZ93CP822WwD
	/ZsCKbCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQe7-00EGRP-2N; Wed, 28 Sep 2022 06:34:15 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQe3-00EGPP-W1
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:34:14 +0000
Received: by mail-wr1-f44.google.com with SMTP id r7so18203586wrm.2
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WQtjPSxqerk86d3wZpAVTWJbyOfKjvr/BLVyMfHM3bg=;
        b=GAoqKa3iOMtgC7m5iEWLZjref1LsfpUxxKh6XSO25Vjc6+k1v24b76flll1WrlKVpZ
         NQzWBFp4/h6ldzNiD6poH/ZLQ+npiB8wbricKbj0dhfoyFsxEeZujwkhK7ijlFpqnRzZ
         bosxxuwaocbOBYYLWP0JZg1RFCxa644d4L4gFJzea6yuBY/tyrn7wXhm3QdOl24jMsVP
         TPRAJ5+R2+vqrBoE0bN2WbcoI3J9yeYFulSeVKo2Pwdn40k8b4IVrkBWapjvRW0z5Hkf
         sOniDdp+ay0Aj/YPKBlwANeTf808SHZkgT8oWr+3U4vW8YI70O8gY75BN8ahOBx47n/n
         gQ1A==
X-Gm-Message-State: ACrzQf14AvPFWE8W9j12iqCu4cs9eglBmbpO93tXBTtOAn2GMd/IJeWH
	8gNmK/pdo+ySxX7niQjbALk=
X-Google-Smtp-Source: AMsMyM4+zS62zp/1iPqosZGDbYqOLkvAvh/cAkIe4ZDgsigurOD5lmXm0sRCf0imXFVInibq/asxJA==
X-Received: by 2002:a5d:47c1:0:b0:22a:5858:993b with SMTP id o1-20020a5d47c1000000b0022a5858993bmr19004971wrc.99.1664346849283;
        Tue, 27 Sep 2022 23:34:09 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bj7-20020a0560001e0700b00228d183f9c2sm3267360wrb.89.2022.09.27.23.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:34:08 -0700 (PDT)
Message-ID: <027150bd-531f-d78b-3e21-4b8919a47ce8@grimberg.me>
Date: Wed, 28 Sep 2022 09:34:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] workqueue: WQ_MEM_RECLAIM
 nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
 !WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs_5=0DGhe5W5oQ1OA+eBy64MX9gRpA8-3N8Qk3Wh-Dwzg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_5=0DGhe5W5oQ1OA+eBy64MX9gRpA8-3N8Qk3Wh-Dwzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_233412_072185_DD3CE774 
X-CRM114-Status: GOOD (  17.01  )
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



On 9/23/22 10:34, Yi Zhang wrote:
> Hello
> 
> Below issue was triggered with blktests nvmeof-mp/012 on 5.19.10, pls
> help check it, feel free to let me know if you need any info/test.
> 
> 
> It can be reproduced within 100 cycles run with ."/check nvmeof-mp/012"
> dmesg log:
> [  350.579057] run blktests nvmeof-mp/012 at 2022-09-23 03:07:21
> [  350.660517] null_blk: module loaded
> [  350.668386] null_blk: disk nullb0 created
> [  350.670913] null_blk: disk nullb1 created
> [  350.691777] device-mapper: table: 253:0: multipath: error getting
> device (-EBUSY)
> [  350.691799] device-mapper: ioctl: error adding target to table
> [  350.746159] rdma_rxe: loaded
> [  350.753345] infiniband env3_rxe: set active
> [  350.753356] infiniband env3_rxe: added env3
> [  350.892769] nvmet: adding nsid 1 to subsystem nvme-test
> [  350.901787] nvmet_rdma: enabling port 1 (10.0.2.222:7777)
> [  350.940242] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 0000000017d82f43
> [  350.940886] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 0000000017d82f43
> [  350.940983] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000286b8895
> [  350.940989] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.941605] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 289
> cm_id= 00000000286b8895
> [  350.941659] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 0000000017d82f43
> [  350.941713] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000286b8895
> [  350.941778] nvmet:nvmet_start_keep_alive_timer: nvmet: ctrl 1 start
> keep-alive timer for 5 secs
> [  350.941781] nvmet: creating nvm controller 1 for subsystem
> nvme-test for NQN
> nqn.2014-08.org.nvmexpress:uuid:4721a245-d23f-4c00-b1d0-8d273c3db004.
> [  350.942139] nvme nvme0: creating 8 I/O queues.
> [  350.942158] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 00000000c5dbee70
> [  350.942354] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 00000000c5dbee70
> [  350.942412] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 000000000c220555
> [  350.942416] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.942636] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 000000000c220555
> [  350.942697] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 00000000c5dbee70
> [  350.942740] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 000000004eb27b13
> [  350.942747] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 000000000c220555
> [  350.942935] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 000000004eb27b13
> [  350.942992] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000e169966e
> [  350.942995] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.943213] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000e169966e
> [  350.943259] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 000000004eb27b13
> [  350.943302] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 0000000025dab642
> [  350.943308] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000e169966e
> [  350.943443] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 0000000025dab642
> [  350.943484] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000a5657f4f
> [  350.943487] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.943677] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000a5657f4f
> [  350.943715] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 0000000025dab642
> [  350.943746] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 00000000eb92556a
> [  350.943748] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000a5657f4f
> [  350.943880] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 00000000eb92556a
> [  350.943916] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 0000000026cb2a8f
> [  350.943919] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.944127] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 0000000026cb2a8f
> [  350.944170] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 00000000eb92556a
> [  350.944199] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 0000000046325928
> [  350.944202] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 0000000026cb2a8f
> [  350.944336] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 0000000046325928
> [  350.944376] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000b31e4e71
> [  350.944378] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.944568] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000b31e4e71
> [  350.944604] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 0000000046325928
> [  350.944634] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 00000000e1a31e4f
> [  350.944636] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000b31e4e71
> [  350.944769] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 00000000e1a31e4f
> [  350.944804] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000c3020c44
> [  350.944807] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.945029] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000c3020c44
> [  350.945078] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 00000000e1a31e4f
> [  350.945115] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 000000006accc65c
> [  350.945121] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000c3020c44
> [  350.945267] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 000000006accc65c
> [  350.945312] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000ca3d146d
> [  350.945314] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.945510] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000ca3d146d
> [  350.945555] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 000000006accc65c
> [  350.945591] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 00000000b0b8d1eb
> [  350.945598] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000ca3d146d
> [  350.945735] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 00000000b0b8d1eb
> [  350.945781] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 00000000969b9167
> [  350.945783] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  350.945980] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 1153
> cm_id= 00000000969b9167
> [  350.946025] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: established
> (9): status 0 id 00000000b0b8d1eb
> [  350.946051] nvme nvme0: mapped 8/0/0 default/read/poll queues.
> [  350.946073] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> established (9): status 0 id 00000000969b9167
> [  350.946285] nvmet:nvmet_execute_io_connect: nvmet: adding queue 1 to ctrl 1.
> [  350.946337] nvmet:nvmet_execute_io_connect: nvmet: adding queue 2 to ctrl 1.
> [  350.946378] nvmet:nvmet_execute_io_connect: nvmet: adding queue 3 to ctrl 1.
> [  350.946427] nvmet:nvmet_execute_io_connect: nvmet: adding queue 4 to ctrl 1.
> [  350.946479] nvmet:nvmet_execute_io_connect: nvmet: adding queue 5 to ctrl 1.
> [  350.946540] nvmet:nvmet_execute_io_connect: nvmet: adding queue 6 to ctrl 1.
> [  350.946595] nvmet:nvmet_execute_io_connect: nvmet: adding queue 7 to ctrl 1.
> [  350.946650] nvmet:nvmet_execute_io_connect: nvmet: adding queue 8 to ctrl 1.
> [  350.946708] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.0.2.222:7777
> [  350.946739] nvmet:nvmet_req_cns_error_complete: nvmet: unhandled
> identify cns 6 on qid 0
> [  350.960438] device-mapper: table: 253:0: multipath: error getting
> device (-EBUSY)
> [  350.960452] device-mapper: ioctl: error adding target to table
> [  351.074392] device-mapper: table: 253:1: multipath: error getting
> device (-EBUSY)
> [  351.074405] device-mapper: ioctl: error adding target to table
> [  355.638030] nvme nvme0: Removing ctrl: NQN "nvme-test"
> [  355.825297] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 000000000c220555
> [  355.825306] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 000000000c220555 queue->state= 1
> [  355.825316] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 1
> [  355.825360] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000e169966e
> [  355.825365] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000e169966e queue->state= 1
> [  355.825375] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 2
> [  355.825387] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 00000000c5dbee70
> [  355.825392] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825419] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000a5657f4f
> [  355.825422] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000a5657f4f queue->state= 1
> [  355.825430] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 3
> [  355.825438] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 000000004eb27b13
> [  355.825443] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825504] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 0000000025dab642
> [  355.825509] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825513] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 0000000026cb2a8f
> [  355.825517] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 0000000026cb2a8f queue->state= 1
> [  355.825525] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 4
> [  355.825556] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000b31e4e71
> [  355.825560] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000b31e4e71 queue->state= 1
> [  355.825569] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 5
> [  355.825577] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 00000000eb92556a
> [  355.825582] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825640] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 0000000046325928
> [  355.825645] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825648] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000c3020c44
> [  355.825651] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000c3020c44 queue->state= 1
> [  355.825657] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 6
> [  355.825702] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000ca3d146d
> [  355.825705] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000ca3d146d queue->state= 1
> [  355.825712] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 7
> [  355.825719] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 00000000e1a31e4f
> [  355.825721] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825775] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 000000006accc65c
> [  355.825779] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.825782] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000969b9167
> [  355.825785] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000969b9167 queue->state= 1
> [  355.825791] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 8
> [  355.825839] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0:
> disconnected (10): status 0 id 00000000b0b8d1eb
> [  355.825844] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: disconnect
> received - connection closed
> [  355.945236] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma:
> disconnected (10): status 0 id 00000000286b8895
> [  355.945244] nvmet_rdma:__nvmet_rdma_queue_disconnect: nvmet_rdma:
> cm_id= 00000000286b8895 queue->state= 1
> [  355.945253] nvmet_rdma:nvmet_rdma_free_queue: nvmet_rdma: freeing queue 0
> [  355.968634] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: address
> resolved (0): status 0 id 000000003d55212b
> [  355.968712] nvme_rdma:nvme_rdma_cm_handler: nvme nvme0: route
> resolved  (2): status 0 id 000000003d55212b
> [  355.968794] nvmet_rdma:nvmet_rdma_cm_handler: nvmet_rdma: connect
> request (4): status 0 id 000000008fee8ffd
> [  355.968799] nvmet_rdma:nvmet_rdma_find_get_device: nvmet_rdma:
> added env3_rxe.
> [  355.968887] nvmet_rdma:nvmet_rdma_create_queue_ib: nvmet_rdma:
> nvmet_rdma_create_queue_ib: max_cqe= 8191 max_sge= 32 sq_size = 289
> cm_id= 000000008fee8ffd
> [  356.005186] nvmet:nvmet_stop_keep_alive_timer: nvmet: ctrl 1 stop keep-alive
> [  356.005186] nvmet:nvmet_keep_alive_timer: nvmet: ctrl 1 reschedule
> traffic based keep-alive timer
> [  356.005192] ------------[ cut here ]------------
> [  356.005204] workqueue: WQ_MEM_RECLAIM
> nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
> !WQ_MEM_RECLAIM events:nvmet_keep_alive_timer [nvmet]

There was a miss in the patch converting to nvmet_wq:
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7f4083cf953a..428317fe6da0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1175,7 +1175,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
          * reset the keep alive timer when the controller is enabled.
          */
         if (ctrl->kato)
-               mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * 
HZ);
+               mod_delayed_work(nvmet_wq, &ctrl->ka_work, ctrl->kato * HZ);
  }

  static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
--

I'll send a patch, thanks for reporting

