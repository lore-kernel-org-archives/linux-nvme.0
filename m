Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716F7CDE00B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7ONiwnLByZbOF45tBIezGg+CcCcsyF9mf8LCr3JvTA=; b=z55Dh2OObksqruRXF5e1f19pUp
	o206UnTRO9YhrMjIyNgy7M1410LQhoo6EOckyD4bxnUJlJfwbsavXcsCDegFlPttWfUw0LP7sgFAR
	W3vtV/dmOEh4X/K3iWG3fJr3B9ZR6sj4YX4Ctq8ryCPXfzUA5ntrBLfJ/9kxN7m4RG211abBtSJvp
	hvOx+V71/53Z+oympdAf50nOs6QQlSF/9twzm//6Bi5W2Zo4XeoAGSgmHp/WGkEAqgKLTFaGdMDfj
	Ft2MCFqDa+WktgblIzkfoT5Bgw1jAex/yl0UXaNGoBvh7teCqre/Ox92NGG/7z+4LjpWs6RItrkjM
	zMwSFOCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcvEu-0000000A4rZ-0nPS;
	Fri, 26 Jun 2026 01:20:16 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcvEr-0000000A4r9-0gy9
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 01:20:15 +0000
X-UUID: 2a897cfa70fd11f1aa26b74ffac11d73-20260626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f7b54674-d5b1-4f6b-979a-47dc54e0d9a0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:38f61f10bc495e838a83045d2d30a347,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2a897cfa70fd11f1aa26b74ffac11d73-20260626
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 415538314; Fri, 26 Jun 2026 09:20:06 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de, shinichiro.kawasaki@wdc.com, liuxixin@kylinos.cn
Subject: Re: blktests nvme/062 lockdep — defer TLS inline send to io_work?
Date: Thu, 26 Jun 2026 09:19:41 +0800
Message-ID: <cover.1782436781.git.liuxixin@kylinos.cn>
In-Reply-To: <ajtk1CaN1pBreS4O@shinmob>
References: <ajtk1CaN1pBreS4O@shinmob>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvmet-tcp/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_182013_522217_FBD3237A 
X-CRM114-Status: UNSURE (   6.41  )
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

Hi,

I'm looking at the nvme/062 failure Shinichiro reported on linux-7.1.y
(PROVE_LOCKING=y, blktests v5a62429536b1) and would like to sanity-check
a fix direction before sending a formal patch.

Link: https://lore.kernel.org/linux-nvme/ajtk1CaN1pBreS4O@shinmob/T/

Problem (reproduced on linux-next, same test)
---------------------------------------------
With PROVE_LOCKING=y, nvme/062 (TLS connect) fails with dmesg:

  WARNING: possible circular locking dependency detected
  ...
  tx_lock (tls_sw_sendmsg)
  ...
  &set->srcu (blk_mq / kblockd context)

The #0 stack is nvme_tcp_queue_request() doing an inline nvme_tcp_send_all()
from queue_rq, which calls tls_sw_sendmsg() while blk_mq still holds srcu.
Lockdep already knows tx_lock -> elevator_lock -> srcu, so the reverse
order triggers the cycle.

Teardown fixes (__fput_sync, memalloc_noio_save, 26bb12b9caaf) are already
present in current trees; 062 still fails — this looks like the TLS send
path on top of blk_mq, not the disconnect/teardown chain.

Proposed fix (one line + comment)
---------------------------------
Skip the queue_rq inline-send optimization when nvme_tcp_queue_tls(queue):

  if (queue->io_cpu == raw_smp_processor_id() &&
      !nvme_tcp_queue_tls(queue) &&
      empty && mutex_trylock(&queue->send_mutex)) {
          nvme_tcp_send_all(queue);
          ...
  }

TLS traffic would always go through nvme_tcp_io_work on nvme_tcp_wq (same
as write_space / backpressure paths already do).  Lab check: nvme/062
passes, no lockdep splat in dmesg.

Does skipping inline send for TLS queues (plain TCP unchanged) look like a
reasonable fix to you?  I can post [PATCH] if this direction sounds OK.

Thanks,
Xixin Liu


