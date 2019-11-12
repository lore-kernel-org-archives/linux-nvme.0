Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F94C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 04:51:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903FC2084F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 04:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sBTh4GpP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M+u1nfC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903FC2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CCpjWTB8cGz39pIvZ3B9J9EbZZY2wXfszZoLaYKg/M8=; b=sBTh4GpP2wI74x
	xAJRTfv+It9cYRAwspOwsQ28Qwj/+Bo4lpi1m57IhcwQjgD4j0qNtaCJ/wMOHVz/95gxAX7gu49f+
	vLtJmRqWJJ/pCOTixHr6XomDGcFiIRjmzUJzk/pp7Rhi8VhfjcHA4jb+oEPdmrV/LBdIrJy6EnMzu
	mDsvj3KqUfK463tB3+HXIKe2W77kC4yAkxsg4wWnVXguPiroJxMeStrPB42Qf87NmDRs5pbPI4mJN
	7Sm9ldAynTfUdrN3t38UGsZZEXCGUThAMuiQr8EwU32gvaVwFB6gR2xaDHpa0Qq9qMMvY3u6HqVEB
	MPV2qdrx2reagNozFnpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUO9X-00073k-5R; Tue, 12 Nov 2019 04:51:43 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUO9T-00073J-Ic
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 04:51:41 +0000
Received: by mail-oi1-x242.google.com with SMTP id s71so13644898oih.11
 for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2019 20:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lxMkhxUb9dHM2LE7DfPT6tLfRcp2Zgyu3gghM1k53Go=;
 b=M+u1nfC80Amwjf+LKx4RbjLXA3NbrCfS4aebCUIJgjsBcvYTduG4wk+ijJFxHUJawu
 0IGQnWb3mvL20Ad3NV6Vc/jV4NUHxiznZ35nFc/eOIgZfpsudrJUf9CSyNtLh3X/Lti1
 mclVaE4sM7ICd9rWV09nXE6QII0JOHmNuTdU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lxMkhxUb9dHM2LE7DfPT6tLfRcp2Zgyu3gghM1k53Go=;
 b=P9wEfpDdQl9rVydUJyC/M5K17tPdNaNlAbqkMSMIQY1SvZ7wzP8UpFfj1M9Cgat/y/
 HsNEZd7UZiiB+ocrZEkm8MgDMpJXXMM4rqBB1Ov62DfIq/WByKGaty8HdUSlPySHHuOq
 tPK4k7viCxqWl94Dpy6X/SBYS/MtiKG78QHAVwqhAmqcANTafnieSqGcFRHrjOVZfVon
 VkQNpnhXBvWtt6rQhSFTyKb6O0lABSBi9ZoL4LpbFIe0C6tYZBeDPelp8w4lksJhzsR6
 OX881tGh0Q/aznz7MZeVflPVymxdHlqUyrciZ791dOqb6K2VQ3LjeSNQ//IiuWoQd7O6
 hGeQ==
X-Gm-Message-State: APjAAAXTVioTAkdexlVtWc2sNzzFi4nc721rQBltkgytWZqHUlzlxoKr
 cF19Eqx0n1ArkCgo1/tJURFHEtd9/pulFhKROEMegA==
X-Google-Smtp-Source: APXvYqwgd/D99F564mkDTMEYMmU+x0n7mi7eTTsb98jPQPD9+B3YtyPmPT8qxjKnQKduzbESI79nVPCjzCQJ0HDzKhA=
X-Received: by 2002:aca:5686:: with SMTP id k128mr2410529oib.34.1573534294093; 
 Mon, 11 Nov 2019 20:51:34 -0800 (PST)
MIME-Version: 1.0
References: <1269174553.11144711.1573527781970.JavaMail.zimbra@redhat.com>
 <661008349.11145565.1573528695548.JavaMail.zimbra@redhat.com>
In-Reply-To: <661008349.11145565.1573528695548.JavaMail.zimbra@redhat.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 12 Nov 2019 10:21:22 +0530
Message-ID: <CA+sbYW0LqFwsqgQ92AU83c=5VWiEjx+OCuQan+mYN2LYBXnGkg@mail.gmail.com>
Subject: Re: Bug report: NVMeoF RDMA bnxt_roce: I/O 1 QID 0 timeout
To: Yi Zhang <yi.zhang@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191111_205139_640326_12C3F789 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Yi Zhang,
Thanks for reporting the issue.  Seems like the FW on bnxt_re side is
not responding once the issue happens and all the commands are failing
after that.
I will get in touch with you for retrieving the FW information and
further investigation. We might need a FW upgrade too.

Thanks,
Selvin


On Tue, Nov 12, 2019 at 8:48 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> Hello
>
> I would like to report a NVMeoF RDMA I/O timeout issue, here is the reproducer and kernel log, let me know if you need more info
>
> Reproducer:
> 1.setup nvmeof rdma roce environment
>    target: qedr roce
>    client: bnxt roce
>
> 2. client: connect target
> 3. client: do fio stress
>
> HW info:
> target:
> # lspci | grep -i ql
> 19:00.0 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02)
> 19:00.1 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02)
> 19:00.2 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02)
> 19:00.3 Ethernet controller: QLogic Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02)
> client:
> # lspci  | grep -i bro
> 01:00.0 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
> 01:00.1 Ethernet controller: Broadcom Inc. and subsidiaries NetXtreme BCM5720 2-port Gigabit Ethernet PCIe
> 18:00.0 RAID bus controller: Broadcom / LSI MegaRAID SAS-3 3008 [Fury] (rev 02)
> 19:00.0 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
> 19:00.1 Ethernet controller: Broadcom Inc. and subsidiaries BCM57412 NetXtreme-E 10Gb RDMA Ethernet Controller (rev 01)
>
>
> kerne log:
> client:
> [   65.974085] nvme nvme2: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.45.186:4420
> [   65.974592] nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> [   66.027510] nvme nvme2: creating 1 I/O queues.
> [   66.053178] nvme nvme2: mapped 1/0/0 default/read/poll queues.
> [   66.053802] nvme nvme2: new ctrl: NQN "testnqn", addr 172.31.45.186:4420
> [   66.054465] nvme2n1: detected capacity change from 0 to 1600321314816
> [   81.926738] nvme nvme2: I/O 1 QID 0 timeout
> [   81.930943] nvme nvme2: starting error recovery
> [   88.070471] nvme nvme2: I/O 1 QID 0 timeout
> [   93.702284] nvme nvme2: I/O 1 QID 0 timeout
> [   98.310013] nvme nvme2: I/O 49 QID 1 timeout
> [   98.314297] nvme nvme2: I/O 50 QID 1 timeout
> [   98.318575] nvme nvme2: I/O 51 QID 1 timeout
> [   98.322855] nvme nvme2: I/O 52 QID 1 timeout
> [   98.327135] nvme nvme2: I/O 54 QID 1 timeout
> [   98.331419] nvme nvme2: I/O 55 QID 1 timeout
> [   98.335699] nvme nvme2: I/O 56 QID 1 timeout
> [   98.339984] nvme nvme2: I/O 57 QID 1 timeout
> [   98.344259] nvme nvme2: I/O 65 QID 1 timeout
> [   98.348531] nvme nvme2: I/O 66 QID 1 timeout
> [   98.352805] nvme nvme2: I/O 67 QID 1 timeout
> [   98.357086] nvme nvme2: I/O 68 QID 1 timeout
> [   98.361369] nvme nvme2: I/O 69 QID 1 timeout
> [   98.365648] nvme nvme2: I/O 70 QID 1 timeout
> [   98.369928] nvme nvme2: I/O 71 QID 1 timeout
> [   98.374203] nvme nvme2: I/O 72 QID 1 timeout
> [   98.378484] nvme nvme2: I/O 73 QID 1 timeout
> [   98.382764] nvme nvme2: I/O 74 QID 1 timeout
> [   98.387035] nvme nvme2: I/O 75 QID 1 timeout
> [   98.391310] nvme nvme2: I/O 76 QID 1 timeout
> [   98.395590] nvme nvme2: I/O 77 QID 1 timeout
> [   98.399864] nvme nvme2: I/O 78 QID 1 timeout
> [   98.404141] nvme nvme2: I/O 79 QID 1 timeout
> [   98.408415] nvme nvme2: I/O 80 QID 1 timeout
> [   98.412686] nvme nvme2: I/O 81 QID 1 timeout
> [   98.416961] nvme nvme2: I/O 82 QID 1 timeout
> [   98.421232] nvme nvme2: I/O 86 QID 1 timeout
> [   98.425503] nvme nvme2: I/O 87 QID 1 timeout
> [   98.429776] nvme nvme2: I/O 94 QID 1 timeout
> [   98.434050] nvme nvme2: I/O 95 QID 1 timeout
> [   98.438323] nvme nvme2: I/O 96 QID 1 timeout
> [   98.442596] nvme nvme2: I/O 97 QID 1 timeout
> [   98.446867] nvme nvme2: I/O 98 QID 1 timeout
> [   98.451141] nvme nvme2: I/O 99 QID 1 timeout
> [   98.455412] nvme nvme2: I/O 100 QID 1 timeout
> [   98.459772] nvme nvme2: I/O 101 QID 1 timeout
> [   98.464131] nvme nvme2: I/O 102 QID 1 timeout
> [   98.468490] nvme nvme2: I/O 103 QID 1 timeout
> [   98.472849] nvme nvme2: I/O 104 QID 1 timeout
> [   98.477208] nvme nvme2: I/O 105 QID 1 timeout
> [   98.481568] nvme nvme2: I/O 106 QID 1 timeout
> [   98.485926] nvme nvme2: I/O 109 QID 1 timeout
> [   98.490286] nvme nvme2: I/O 111 QID 1 timeout
> [   98.494644] nvme nvme2: I/O 112 QID 1 timeout
> [   98.499004] nvme nvme2: I/O 113 QID 1 timeout
> [   98.503363] nvme nvme2: I/O 115 QID 1 timeout
> [   98.507721] nvme nvme2: I/O 116 QID 1 timeout
> [   98.512080] nvme nvme2: I/O 117 QID 1 timeout
> [   98.516441] nvme nvme2: I/O 118 QID 1 timeout
> [   98.520807] nvme nvme2: I/O 119 QID 1 timeout
> [   98.525167] nvme nvme2: I/O 120 QID 1 timeout
> [   98.529526] nvme nvme2: I/O 121 QID 1 timeout
> [   98.533885] nvme nvme2: I/O 122 QID 1 timeout
> [   98.538245] nvme nvme2: I/O 123 QID 1 timeout
> [   98.542603] nvme nvme2: I/O 124 QID 1 timeout
> [   98.546963] nvme nvme2: I/O 126 QID 1 timeout
> [   99.846073] nvme nvme2: I/O 1 QID 0 timeout
> [  102.405967] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x41d]=0x3 timedout (20000)msec
> [  102.413114] infiniband bnxt_re0: Failed to modify HW QP
> [  102.418367] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x0]=0x3 send failed
> [  102.424551] infiniband bnxt_re0: Failed to modify HW QP
> [  102.429779] ------------[ cut here ]------------
> [  102.434399] failed to drain send queue: -110
> [  102.438730] WARNING: CPU: 43 PID: 780 at drivers/infiniband/core/verbs.c:2656 __ib_drain_sq+0x143/0x190 [ib_core]
> [  102.448985] Modules linked in: nvme_rdma nvme_fabrics nvmet_rdma nvmet 8021q garp mrp stp llc ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_srp vfat fat mlx5_ib opa_vnic ib_umad ib_ipoib rpcrdma intel_rapl_msr sunrpc intel_rapl_common rdma_ucm ib_iser libiscsi isst_if_common scsi_transport_iscsi iTCO_wdt iTCO_vendor_support skx_edac dcdbas nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel ipmi_ssif iw_cxgb4 kvm irqbypass rdma_cm iw_cm ib_cm libcxgb crct10dif_pclmul crc32_pclmul hfi1 bnxt_re rdmavt ghash_clmulni_intel intel_cstate ib_uverbs ib_core intel_uncore dell_smbios intel_rapl_perf wmi_bmof dell_wmi_descriptor sg pcspkr mei_me ipmi_si i2c_i801 lpc_ich mei ipmi_devintf ipmi_msghandler acpi_power_meter xfs libcrc32c sd_mod mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit drm_vram_helper ttm mlx5_core drm ahci csiostor cxgb4 libahci crc32c_intel nvme mlxfw bnxt_en nvme_core libata megaraid_sas
> [  102.449018]  scsi_transport_fc tg3 pci_hyperv_intf wmi dm_mirror dm_region_hash dm_log dm_mod
> [  102.543833] CPU: 43 PID: 780 Comm: kworker/u98:3 Kdump: loaded Not tainted 5.4.0-0.rc6.2.elrdy.x86_64 #1
> [  102.553303] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 2.2.11 06/13/2019
> [  102.560872] Workqueue: nvme-wq nvme_rdma_error_recovery_work [nvme_rdma]
> [  102.567572] RIP: 0010:__ib_drain_sq+0x143/0x190 [ib_core]
> [  102.572968] Code: 00 00 00 48 89 df e8 8c 28 7f f4 48 85 c0 74 e1 e9 69 ff ff ff 89 c6 48 c7 c7 48 ce 51 c1 c6 05 cd 0c 04 00 01 e8 56 2f fe f3 <0f> 0b e9 4d ff ff ff 80 3d b9 0c 04 00 00 0f 85 40 ff ff ff 89 c6
> [  102.591711] RSP: 0018:ffffbb79c7883cf8 EFLAGS: 00010282
> [  102.596940] RAX: 0000000000000000 RBX: ffff9ed9bdac3818 RCX: 0000000000000000
> [  102.604072] RDX: ffff9ee60fb66900 RSI: ffff9ee60fb56b88 RDI: ffff9ee60fb56b88
> [  102.611204] RBP: ffff9ee60b1d8400 R08: 000000000000079a R09: 000000000000002b
> [  102.618334] R10: 0000000000000000 R11: ffffbb79c7883ba0 R12: ffffbb79c7883d28
> [  102.625458] R13: ffffbb79c7883d00 R14: ffff9eda44b0fbc0 R15: ffff9ee5ff4000b0
> [  102.632584] FS:  0000000000000000(0000) GS:ffff9ee60fb40000(0000) knlGS:0000000000000000
> [  102.640669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  102.646415] CR2: 00007faba43bcec8 CR3: 0000000f4fa0a004 CR4: 00000000007606e0
> [  102.653547] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  102.660680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  102.667812] PKRU: 55555554
> [  102.670525] Call Trace:
> [  102.672987]  ? wb_over_bg_thresh+0x20c/0x220
> [  102.677265]  ib_drain_qp+0xe/0x20 [ib_core]
> [  102.681448]  nvme_rdma_teardown_io_queues.part.35+0x4e/0xa0 [nvme_rdma]
> [  102.688057]  nvme_rdma_error_recovery_work+0x35/0x90 [nvme_rdma]
> [  102.694064]  process_one_work+0x1a1/0x360
> [  102.698074]  worker_thread+0x30/0x380
> [  102.701742]  ? pwq_unbound_release_workfn+0xd0/0xd0
> [  102.706622]  kthread+0x112/0x130
> [  102.709851]  ? __kthread_parkme+0x70/0x70
> [  102.713867]  ret_from_fork+0x35/0x40
> [  102.717444] ---[ end trace b9af855765aeac25 ]---
> [  102.722074] bnxt_en 0000:19:00.0: QPLIB: cmdq[0x0]=0x3 send failed
> [  102.728271] infiniband bnxt_re0: Failed to modify HW QP
>
> target:
> [   44.362119] nvmet: adding nsid 1 to subsystem testnqn
> [   44.362662] nvmet_rdma: enabling port 2 (172.31.45.186:4420)
> [   61.722470] SubnSet(OPA_PortInfo) smlid 0x4
> [   62.127400] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:07212bc2-57e0-4729-9377-4608892fed05.
> [   62.180752] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:07212bc2-57e0-4729-9377-4608892fed05.
> [   80.914135] [qedr_poll_cq_req:3816(qedr0)]Error: POLL CQ with ROCE_CQE_REQ_STS_TRANSPORT_RETRY_CNT_ERR. CQ icid=0x1, QP icid=0x2
> [   92.839414] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
> [   92.845445] nvmet: ctrl 1 fatal error occurred!
>
> Best Regards,
>   Yi Zhang
>
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
