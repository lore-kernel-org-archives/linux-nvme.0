Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98412C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5bIHwtoWmEiRV77+HcSExKmDlQQafurZIdojjZw350=; b=2Oosy9raohUuAvUbp21bBQD7Bv
	bQZJwBSzMtj9MhGLFN/kkvWsRvWrScEj//+0SjFipnbtaIH9WseSLZPKX3f/6/SrHoHTrAJRFNehd
	WnnuPnWlUDyV19mbRm/Wdia+RDw+Bq231uPpf6pyMilDDM2VSi6jtGheiqkzp1u+/qXYUoHkp+NFU
	upF5G2CCrJWeOd7ifoqVj7wWmzCT2SvKgPt+WzRv1Ih3kvGMKtYrXRmT0CL4YHsTTg+aZT4ICS+eQ
	E3pMM44uxfVZfKd9qsicwY1FvO3zk1etv1xH6iEgL5ILXMPFwWMgMK3Iwcvjp6cD8ZFZU59aeWAEh
	hvv89+1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osKiq-003yT6-Iv; Tue, 08 Nov 2022 09:16:44 +0000
Received: from mail3-162.sinamail.sina.com.cn ([202.108.3.162])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osKij-003yQk-Ts
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 09:16:41 +0000
Received: from unknown (HELO localhost.localdomain)([114.249.57.238])
	by sina.com (172.16.97.27) with ESMTP
	id 636A1E21000137D4; Tue, 8 Nov 2022 17:15:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 9244049284573
From: Hillf Danton <hdanton@sina.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on linux-next
Date: Tue,  8 Nov 2022 17:16:09 +0800
Message-Id: <20221108091609.1020-1-hdanton@sina.com>
In-Reply-To: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_011638_190860_517237F2 
X-CRM114-Status: GOOD (  14.55  )
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

On 07 Nov 2022 18:28:16 +0100 Gerd Bayer <gbayer@linux.ibm.com>
> Hi,
> 
> our internal s390 CI pointed us to a potential racy "use after free" or similar 
> issue in drivers/nvme/host/pci.c by ending one of the tests in the following 
> kernel panic:
> 
> [ 1836.550881] nvme nvme0: pci function 0004:00:00.0
> [ 1836.563814] nvme nvme0: Shutdown timeout set to 15 seconds
> [ 1836.569587] nvme nvme0: 63/0/0 default/read/poll queues
> [ 1836.577114]  nvme0n1: p1 p2
> [ 1861.856726] nvme nvme0: pci function 0004:00:00.0
> [ 1861.869539] nvme nvme0: failed to mark controller CONNECTING
> [ 1861.869542] nvme nvme0: Removing after probe failure status: -16

Work callback exits with error result.

> [ 1861.869552] Unable to handle kernel pointer dereference in virtual kernel address space
> [ 1861.869554] Failing address: 0000000000000000 TEID: 0000000000000483
> [ 1861.869555] Fault in home space mode while using kernel ASCE.
> [ 1861.869558] AS:0000000135c4c007 R3:00000003fffe0007 S:00000003fffe6000 P:000000000000013d 
> [ 1861.869587] Oops: 0004 ilc:3 [#1] SMP 
> [ 1861.869591] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables
> nfnetlink mlx5_ib ib_uverbs uvdevice s390_trng ib_core vfio_ccw mdev vfio_iommu_type1 eadm_sch
>  vfio sch_fq_codel configfs dm_service_time mlx5_core ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes
> sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 nvme sha_common nvme_core zfcp scsi_transport_fc
> dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log pkey zcry
> pt rng_core autofs4
> [ 1861.869627] CPU: 4 PID: 2929 Comm: kworker/u800:0 Not tainted 6.1.0-rc3-next-20221104 #4
> [ 1861.869630] Hardware name: IBM 3931 A01 701 (LPAR)
> [ 1861.869631] Workqueue: nvme-reset-wq nvme_reset_work [nvme]

Work is re-scheduled, which supports uaf above.

> [ 1861.869637] Krnl PSW : 0704c00180000000 0000000134f026d0 (mutex_lock+0x10/0x28)
> [ 1861.869643]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [ 1861.869646] Krnl GPRS: 0000000001000000 0000000000000000 0000000000000078 00000000a5f8c200
> [ 1861.869648]            000003800309601c 0000000000000004 0000000000000000 0000000088e64220
> [ 1861.869650]            0000000000000078 0000000000000000 0000000000000098 0000000088e64000
> [ 1861.869651]            00000000a5f8c200 0000000088e641e0 00000001349bdac2 0000038003ea7c20
> [ 1861.869658] Krnl Code: 0000000134f026c0: c0040008cfb8        brcl    0,000000013501c630
> [ 1861.869658]            0000000134f026c6: a7190000            lghi    %r1,0
> [ 1861.869658]           #0000000134f026ca: e33003400004        lg      %r3,832
> [ 1861.869658]           >0000000134f026d0: eb1320000030        csg     %r1,%r3,0(%r2)
> [ 1861.869658]            0000000134f026d6: ec160006007c        cgij    %r1,0,6,0000000134f026e2
> [ 1861.869658]            0000000134f026dc: 07fe                bcr     15,%r14
> [ 1861.869658]            0000000134f026de: 47000700            bc      0,1792
> [ 1861.869658]            0000000134f026e2: c0f4ffffffe7        brcl    15,0000000134f026b0
> [ 1861.869715] Call Trace:
> [ 1861.869716]  [<0000000134f026d0>] mutex_lock+0x10/0x28 
> [ 1861.869719]  [<000003ff7fc381d6>] nvme_dev_disable+0x1b6/0x2b0 [nvme] 
> [ 1861.869722]  [<000003ff7fc3929e>] nvme_reset_work+0x49e/0x6a0 [nvme] 
> [ 1861.869724]  [<0000000134309158>] process_one_work+0x200/0x458 
> [ 1861.869730]  [<00000001343098e6>] worker_thread+0x66/0x480 
> [ 1861.869732]  [<0000000134312888>] kthread+0x108/0x110 
> [ 1861.869735]  [<0000000134297354>] __ret_from_fork+0x3c/0x58 
> [ 1861.869738]  [<0000000134f074ea>] ret_from_fork+0xa/0x40 
> [ 1861.869740] Last Breaking-Event-Address:
> [ 1861.869741]  [<00000001349bdabc>] blk_mq_quiesce_tagset+0x2c/0xc0
> [ 1861.869747] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> On a stock kernel from
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20221104
> we have been able to reproduce this at will with
> this small script 
> 
> #!/usr/bin/env bash
> 
> echo $1 > /sys/bus/pci/drivers/nvme/unbind
> echo $1 > /sys/bus/pci/drivers/nvme/bind
> echo 1 > /sys/bus/pci/devices/$1/remove
> 
> when filling in the NVMe drives' PCI identifier.
> 
> We believe this to be a race-condition somewhere, since this sequence does not produce the panic
> when executed interactively.
> 
> Could this be linked to the recent (refactoring) work by Christoph Hellwig?
> E.g. https://lore.kernel.org/all/20221101150050.3510-3-hch@lst.de/

The minimum change is to flush the reset work before jumping in the blackhole,
instead of perhaps better options like grabbing another hold on controler
upon scheduling work, with the bonus of figuring out the spot and reason for
rescheduling.

Only for thoughts.

Hillf

+++ next-20221104/drivers/nvme/host/pci.c
@@ -2776,6 +2776,7 @@ static void nvme_pci_free_ctrl(struct nv
 	mempool_destroy(dev->iod_mempool);
 	put_device(dev->dev);
 	kfree(dev->queues);
+	flush_work(&dev->ctrl.reset_work);
 	kfree(dev);
 }
 

