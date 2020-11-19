Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616FC2D0E4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 10:51:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AA2246CE
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXeKVnn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AA2246CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R8JSRxvBr/O1wMZlodt/8Q6rbgLAGMm36W2hcdwVyt8=; b=dXeKVnn4UPbl2c7K4l6NioGnb
	sjPhdbdP2tZJOCD80I+n5ZYofx+r/o26G/TKwNun8tkrV4oU7Mk7UYWSIBvQu5crFgW84CC+5Au+d
	eYF2OglWQNuEOtVtUYZAFVvQqbWrygab94RGeU6j78uGLyelHrVOzbL6d9dDf25X1lvTH2mbv+0Rn
	8l+rRwj0TPA6NrOvlHmQazNGNnID6Yd26YuOR0r1RMxhbUqFH1foU1UP474VquAqp6N+H/6WgvuYx
	o/qIqNvwIXXmjHC/4/dkrK9I2vkR+xYDKjGeKDOMGaR1Mn/RvWILH0cT2buCVGrv830n4nrLglApr
	BgSykxseA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfhX4-0001Wa-A9; Thu, 19 Nov 2020 10:51:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfhWy-0001Vi-7H
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 10:51:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9F7C8ACC5;
 Thu, 19 Nov 2020 10:51:05 +0000 (UTC)
Date: Thu, 19 Nov 2020 11:51:05 +0100
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 2/3] nvme-fc: eliminate terminate_io use by
 nvme_fc_error_recovery
Message-ID: <20201119105105.czsz4tmjrizzqlex@beryllium.lan>
References: <20201023222752.90621-1-james.smart@broadcom.com>
 <20201023222752.90621-3-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201023222752.90621-3-james.smart@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_055112_574043_5077FE83 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi James,

On Fri, Oct 23, 2020 at 03:27:51PM -0700, James Smart wrote:
> nvme_fc_error_recovery() special cases handling when in CONNECTING state
> and calls __nvme_fc_terminate_io(). __nvme_fc_terminate_io() itself
> special cases CONNECTING state and calls the routine to abort outstanding
> ios.
> 
> Simplify the sequence by putting the call to abort outstanding ios directly
> in nvme_fc_error_recovery.
> 
> Move the location of __nvme_fc_abort_outstanding_ios(), and
> nvme_fc_terminate_exchange() which is called by it, to avoid adding
> function prototypes for nvme_fc_error_recovery().

During local testing I run into this problem:

 BUG: scheduling while atomic: swapper/37/0/0x00000100
 Modules linked in: iscsi_ibft(E) iscsi_boot_sysfs(E) rfkill(E) intel_rapl_msr(E) intel_rapl_common(E) sb_edac(E) x86_pkg_temp_thermal(E) intel_powerclamp(E) ext4(E) nls_iso8859_1(E) coretemp(E) nls_cp437(E) crc16(E) kvm_intel(E) mbcache(E) jbd2(E) kvm(E) vfat(E) irqbypass(E) crc32_pclmul(E) fat(E) ghash_clmulni_intel(E) iTCO_wdt(E) lpfc(E) iTCO_vendor_support(E) aesni_intel(E) nvmet_fc(E) aes_x86_64(E) ipmi_ssif(E) crypto_simd(E) nvmet(E) bnx2x(E) cryptd(E) glue_helper(E) pcspkr(E) lpc_ich(E) ipmi_si(E) tg3(E) mdio(E) ioatdma(E) hpilo(E) mfd_core(E) hpwdt(E) ipmi_devintf(E) configfs(E) libphy(E) dca(E) ipmi_msghandler(E) button(E) btrfs(E) libcrc32c(E) xor(E) raid6_pq(E) mgag200(E) drm_vram_helper(E) sd_mod(E) ttm(E) i2c_algo_bit(E) qla2xxx(E) drm_kms_helper(E) syscopyarea(E) nvme_fc(E) sysfillrect(E) sysimgblt(E) nvme_fabrics(E) uhci_hcd(E) fb_sys_fops(E) ehci_pci(E) ehci_hcd(E) nvme_core(E) crc32c_intel(E) scsi_transport_fc(E) drm(E) usbcore(E) hpsa(E) scsi_transport_sas(E)
  wmi(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E)
 Supported: No, Unreleased kernel
 CPU: 37 PID: 0 Comm: swapper/37 Tainted: G            EL      5.3.18-0.g7362c5c-default #1 SLE15-SP2 (unreleased)
 Hardware name: HP ProLiant DL580 Gen9/ProLiant DL580 Gen9, BIOS U17 10/21/2019
 Call Trace:
  <IRQ>
  dump_stack+0x66/0x8b
  __schedule_bug+0x51/0x70
  __schedule+0x697/0x750
  schedule+0x2f/0xa0
  schedule_timeout+0x1dd/0x300
  ? lpfc_sli4_fp_handle_fcp_wcqe.isra.31+0x146/0x390 [lpfc]
  ? update_group_capacity+0x25/0x1b0
  wait_for_completion+0xba/0x140
  ? wake_up_q+0xa0/0xa0
  __wait_rcu_gp+0x110/0x130
  synchronize_rcu+0x55/0x80
  ? __call_rcu+0x4e0/0x4e0
  ? __bpf_trace_rcu_invoke_callback+0x10/0x10
  __nvme_fc_abort_outstanding_ios+0x5f/0x90 [nvme_fc]
  nvme_fc_error_recovery+0x25/0x70 [nvme_fc]
  nvme_fc_fcpio_done+0x243/0x400 [nvme_fc]
  lpfc_sli4_nvme_xri_aborted+0x62/0x100 [lpfc]
  lpfc_sli4_sp_handle_abort_xri_wcqe.isra.56+0x4c/0x170 [lpfc]
  ? lpfc_sli4_fp_handle_cqe+0x8b/0x490 [lpfc]
  lpfc_sli4_fp_handle_cqe+0x8b/0x490 [lpfc]
  __lpfc_sli4_process_cq+0xfd/0x270 [lpfc]
  ? lpfc_sli4_sp_handle_abort_xri_wcqe.isra.56+0x170/0x170 [lpfc]
  __lpfc_sli4_hba_process_cq+0x3c/0x110 [lpfc]
  lpfc_cq_poll_hdler+0x16/0x20 [lpfc]
  irq_poll_softirq+0x88/0x110
  __do_softirq+0xe3/0x2dc
  irq_exit+0xd5/0xe0
  do_IRQ+0x7f/0xd0
  common_interrupt+0xf/0xf
  </IRQ>


I think we can't move the __nvme_fc_abort_outstanding_ios() into this
path as we are still running in IRQ context.

Thanks,
Daniel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
