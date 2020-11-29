Return-Path: <SRS0=SC3Y=FD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E383C3E8C5
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 03:57:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847062078D
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Nov 2020 03:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hIOFnx0O";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sAmVGYxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847062078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=ZIk1R3WxX08HotZaGMc4lKjJXHUauS638LjrBPUIhz8=; b=hIO
	Fnx0ODpv3rsYi1CtmkmcI6aTMpb08KlNrEMG6VDM4H25R7298pef+zP0IYtrT6/Mu5Ss3zq02AwTL
	/ULet2bKd1rLfC60dkeK5uVCgk6P7XfiIHBK1VeF432AlJL2PzSQZKsEpegzg4cxpoAVvXTdx9hiP
	p3QZK2Xn6y4DOg6XTLupV0wa2KyK2zHecMnO1fq+PR6ExjXqKPiHSB86gAmYA3O1sfnMrw/wUBdht
	bB7Eyu7i0i3P4VecFcb8Ta/UdW+UuVoB4MaJwZgpVJ7bLFceAVAJ+IMefWnRIdFGb3YGUthV+038P
	aLAWTqOtWf7fMRrtu9GjkVGnSqHT8cQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjDpc-0003Nv-Ph; Sun, 29 Nov 2020 03:57:00 +0000
Received: from out4-smtp.messagingengine.com ([66.111.4.28])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjDpR-0003NT-KS
 for linux-nvme@lists.infradead.org; Sun, 29 Nov 2020 03:56:50 +0000
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 32EAD5C00C5;
 Sat, 28 Nov 2020 22:56:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Sat, 28 Nov 2020 22:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:message-id
 :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; bh=NK/5PnaYiO8G5x3L25QksWUseRCUL
 DdbExUMxc5jCZg=; b=sAmVGYxKm9USvhRzUeJ4wd0Hy7ubm7OplkjUIGRP/kINf
 ou348axEZ9zJ+pzo3bniYlES5bV8cN6xNzex6iEgqbyUcF6Yr7crQBac/UiAqRRu
 YJK+vVk87A+fVcL4OL1GcwABpzfJP4nsCtWo9AkqlctSHef8f+Hy3LRw+ewvc+h0
 XDUyOI1/J1BAMcmxPzTRto5TpCVG15S1VRDg0w3n2WMmlRt8gyy+NVMYm7S9665V
 hSeouvSU3V5isDgwKtEHzz2NlCYYlGJM3DtQ3DysJ2FSBh33aw6P0GUioeBZZb0L
 rUm27DfGWpph9/N/IYTMrUU02vKSDV6Ja3HRGt57A==
X-ME-Sender: <xms:_BvDX50oAcQAJXkUAtJ02M6gZLifwhqmo853YLa6hmgFGgL0GeZ8zg>
 <xme:_BvDXwF1rV1yWABpldUobZ4sR0itWDzxX-f8M0a7ipPU-b3ZfG2yJ3wPeRBZ4z2XC
 R-LWpWX6yUWfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehjedgieegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfggtggusehgtderredttdejnecuhfhrohhmpeforghrvghkucfo
 rghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhish
 hisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedtudfgtedu
 veduieevvefgteeujeelgffggffhhffhhedtffeffefgudeugeefhfenucfkphepledurd
 eigedrudejtddrkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtg
 homh
X-ME-Proxy: <xmx:_BvDX54PRmwa5QyNqllkowOdejy1L3dibEvPcY4tqN-bxrqgZJs_-Q>
 <xmx:_BvDX20GaLrzDb8_fxSPojWhAWQ-jFTiTqkgadFN3lMFACtzAtiwHw>
 <xmx:_BvDX8Fu0ILFvZVfdQw5i5JaXyA2WzhZxYUhUnM8QDEW05USiKKwyQ>
 <xmx:_RvDX2OSfl9L4cUfpdgqVaG2CkO5TCTN-s0G2k0r0BjBgX_mlBtANQ>
Received: from mail-itl (ip5b40aa59.dynamic.kabel-deutschland.de
 [91.64.170.89])
 by mail.messagingengine.com (Postfix) with ESMTPA id A94573064AB0;
 Sat, 28 Nov 2020 22:56:43 -0500 (EST)
Date: Sun, 29 Nov 2020 04:56:39 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201129035639.GW2532@mail-itl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201128_225649_772150_9571859A 
X-CRM114-Status: GOOD (  13.95  )
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
Content-Type: multipart/mixed; boundary="===============0005568745838339827=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============0005568745838339827==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l5oECiFRo5dp+2y7"
Content-Disposition: inline


--l5oECiFRo5dp+2y7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9

Hello,

I can reliably hit kernel panic in nvme_map_data() which looks like the
one below. It happens on Linux 5.9.9, while 5.4.75 works fine. I haven't
tried other version on this hardware. Linux is running as Xen
PV dom0, on top of nvme there is LUKS and then LVM with thin
provisioning. The crash happens reliably when starting a Xen domU (which
uses one of thin provisioned LVM volumes as its disk). But booting dom0
works fine (even though it is using the same disk setup for its root
filesystem).

I did a bit of debugging and found it's about this part:

drivers/nvme/host/pci.c:
 800 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request=
 *req,
 801         struct nvme_command *cmnd)
 802 {
 803     struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
 804     blk_status_t ret =3D BLK_STS_RESOURCE;
 805     int nr_mapped;
 806=20
 807     if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
 808         struct bio_vec bv =3D req_bvec(req);
 809=20
 810         if (!is_pci_p2pdma_page(bv.bv_page)) {

Here, bv.bv_page->pgmap is LIST_POISON1, while page_zonenum(bv.bv_page)
says ZONE_DEVICE. So, is_pci_p2pdma_page() crashes on accessing
bv.bv_page->pgmap->type.

The panic message:

general protection fault, probably for non-canonical address 0xdead00000000=
0100: 0000 [#1] SMP NOPTI
CPU: 1 PID: 134 Comm: kworker/u12:2 Not tainted 5.9.9-1.qubes.x86_64 #1
Hardware name: LENOVO 20M9CTO1WW/20M9CTO1WW, BIOS N2CET50W (1.33 ) 01/15/20=
20
Workqueue: dm-thin do_worker [dm_thin_pool]
RIP: e030:nvme_map_data+0x300/0x3a0 [nvme]
Code: b8 fe ff ff e9 a8 fe ff ff 4c 8b 56 68 8b 5e 70 8b 76 74 49 8b 02 48 =
c1 e8 33 83 e0 07 83 f8 04 0f 85 f2 fe ff ff 49 8b 42 08 <83> b8 d0 00 00 0=
0 04 0f 85 e1 fe ff ff e9 38 fd ff ff 8b 55 70 be
RSP: e02b:ffffc900010e7ad8 EFLAGS: 00010246
RAX: dead000000000100 RBX: 0000000000001000 RCX: ffff8881a58f5000
RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff8881a679e000
RBP: ffff8881a5ef4c80 R08: ffff8881a5ef4c80 R09: 0000000000000002
R10: ffffea0003dfff40 R11: 0000000000000008 R12: ffff8881a679e000
R13: ffffc900010e7b20 R14: ffff8881a70b5980 R15: ffff8881a679e000
FS:  0000000000000000(0000) GS:ffff8881b5440000(0000) knlGS:0000000000000000
CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001d64408 CR3: 00000001aa2c0000 CR4: 0000000000050660
Call Trace:
 nvme_queue_rq+0xa7/0x1a0 [nvme]
 __blk_mq_try_issue_directly+0x11d/0x1e0
 ? add_wait_queue_exclusive+0x70/0x70
 blk_mq_try_issue_directly+0x35/0xc0l[
 blk_mq_submit_bio+0x58f/0x660
 __submit_bio_noacct+0x300/0x330
 process_shared_bio+0x126/0x1b0 [dm_thin_pool]
 process_cell+0x226/0x280 [dm_thin_pool]
 process_thin_deferred_cells+0x185/0x320 [dm_thin_pool]
 process_deferred_bios+0xa4/0x2a0 [dm_thin_pool]UX
 do_worker+0xcc/0x130 [dm_thin_pool]
 process_one_work+0x1b4/0x370
 worker_thread+0x4c/0x310
 ? process_one_work+0x370/0x370
 kthread+0x11b/0x140
 ? __kthread_bind_mask+0x60/0x60<
 ret_from_fork+0x22/0x30
Modules linked in: loop snd_seq_dummy snd_hrtimer nf_tables nfnetlink vfat =
fat snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc snd_sof_intel_hda_commo=
n snd_soc_hdac_hda snd_sof_xtensa_dsp snd_sof_intel_hda snd_sof snd_soc_skl=
 snd_soc_sst_
ipc snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi =
snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine elan_i2c snd_hda_codec=
_hdmi mei_hdcp iTCO_wdt intel_powerclamp intel_pmc_bxt ee1004 intel_rapl_ms=
r iTCO_vendor
_support joydev pcspkr intel_wmi_thunderbolt wmi_bmof thunderbolt ucsi_acpi=
 idma64 typec_ucsi snd_hda_codec_realtek typec snd_hda_codec_generic snd_hd=
a_intel snd_intel_dspcfg snd_hda_codec thinkpad_acpi snd_hda_core ledtrig_a=
udio int3403_
thermal snd_hwdep snd_seq snd_seq_device snd_pcm iwlwifi snd_timer processo=
r_thermal_device mei_me cfg80211 intel_rapl_common snd e1000e mei int3400_t=
hermal int340x_thermal_zone i2c_i801 acpi_thermal_rel soundcore intel_soc_d=
ts_iosf i2c_s
mbus rfkill intel_pch_thermal xenfs
 ip_tables dm_thin_pool dm_persistent_data dm_bio_prison dm_crypt nouveau r=
tsx_pci_sdmmc mmc_core mxm_wmi crct10dif_pclmul ttm crc32_pclmul crc32c_int=
el i915 ghash_clmulni_intel i2c_algo_bit serio_raw nvme drm_kms_helper cec =
xhci_pci nvme
_core rtsx_pci xhci_pci_renesas drm xhci_hcd wmi video pinctrl_cannonlake p=
inctrl_intel xen_privcmd xen_pciback xen_blkback xen_gntalloc xen_gntdev xe=
n_evtchn uinput
---[ end trace f8d47e4aa6724df4 ]---
RIP: e030:nvme_map_data+0x300/0x3a0 [nvme]
Code: b8 fe ff ff e9 a8 fe ff ff 4c 8b 56 68 8b 5e 70 8b 76 74 49 8b 02 48 =
c1 e8 33 83 e0 07 83 f8 04 0f 85 f2 fe ff ff 49 8b 42 08 <83> b8 d0 00 00 0=
0 04 0f 85 e1 fe ff ff e9 38 fd ff ff 8b 55 70 be
RSP: e02b:ffffc900010e7ad8 EFLAGS: 00010246
RAX: dead000000000100 RBX: 0000000000001000 RCX: ffff8881a58f5000
RDX: 0000000000001000 RSI: 0000000000000000 RDI: ffff8881a679e000
RBP: ffff8881a5ef4c80 R08: ffff8881a5ef4c80 R09: 0000000000000002
R10: ffffea0003dfff40 R11: 0000000000000008 R12: ffff8881a679e000
R13: ffffc900010e7b20 R14: ffff8881a70b5980 R15: ffff8881a679e000
FS:  0000000000000000(0000) GS:ffff8881b5440000(0000) knlGS:0000000000000000
CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001d64408 CR3: 00000001aa2c0000 CR4: 0000000000050660
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

Any ideas?
If not, I can try to run bisect on it, but it will be rather time
consuming.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--l5oECiFRo5dp+2y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl/DG/cACgkQ24/THMrX
1yw0Igf9FrDfAoo1WvN71zIi13SEl7hGQtlX5+YkI07By1arr3BgYF85/Jxx9dv5
y1LMPNYiPuUMUs+CQn1ccenE0l1nVLjajGwgiXtTtdH8yMI4DhFJst2SoJ6/g41Y
ABF+S+X7Xuo9FXGLgZ6/AMRgyqw9QbK1YMM8rWBWXd9j7gDNsDKbR1vkGWsaH9/W
CqsKQLiBq4GYRAxhVvF0nRAj81DMra+khnEkqV6/I2NLNdA8c2NLPfEMqlWluMpt
Sosp38MzzwISGeDz3NHy5CZeD8Qhoe4Kt5TKLAYCEBmC5v8vHpbY0+85OaoLcd6u
BFVbiQYoz6L0nePwjwdcobmujiPPkw==
=AzlP
-----END PGP SIGNATURE-----

--l5oECiFRo5dp+2y7--


--===============0005568745838339827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0005568745838339827==--

