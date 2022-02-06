Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FBBC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 06:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:To:From:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvE3Xnrtg3hn3pZxgRpc4Sp6Rf93bN6QxEmNpw6K4ik=; b=W4K+Xe1YWTteZi4qeUuWYBX/jS
	+eR5uBqceXCaOL8MUpfrha+T/qa57g5PJzVulRW+2D4exGMKG+hy5dN2qoou1avXvUQV06hRv6up6
	WXH9bcWz34J0hXhGfXKCf4Oxp4UQATET9rXPKM3EZBKlF6YTQ6plEJeppCM/bw0tDxd/LaUkSVZDW
	1EPM4z+ZM3jbsQXZCYBfgEBe9MID4oG5iMAuUoGQIphPlXWCmf5HBVDh6bEFeZlcoqyNq8p5Hg7Bz
	QWd9EyfB+e0ELcwOhrOy+fNquhASBFhK3h9C0zigKuyVtsYQPMlgOTN9Zj1LrfxGuWhz5EgReWiMy
	4h7COQNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nGx8n-0096Io-1R; Mon, 07 Feb 2022 06:04:45 +0000
Received: from hiro.icebalm.com ([172.245.134.119])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nGpi0-008f4S-8U
 for linux-nvme@lists.infradead.org; Sun, 06 Feb 2022 22:08:38 +0000
Received: from citadel.icebalm.com (unknown [10.0.10.6])
 by hiro.icebalm.com (Postfix) with ESMTPS id 8D5175F405
 for <linux-nvme@lists.infradead.org>; Sun,  6 Feb 2022 15:59:57 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id 49AD21203D51
 for <linux-nvme@lists.infradead.org>; Sun,  6 Feb 2022 16:59:57 -0500 (EST)
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 2jBhVMCsoPk3 for <linux-nvme@lists.infradead.org>;
 Sun,  6 Feb 2022 16:59:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by citadel.icebalm.com (Postfix) with ESMTP id E4789120AB00
 for <linux-nvme@lists.infradead.org>; Sun,  6 Feb 2022 16:59:56 -0500 (EST)
X-Virus-Scanned: amavisd-new at icebalm.com
Received: from citadel.icebalm.com ([127.0.0.1])
 by localhost (citadel.icebalm.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id gNgutJHYSohT for <linux-nvme@lists.infradead.org>;
 Sun,  6 Feb 2022 16:59:56 -0500 (EST)
Received: from citadel.icebalm.com (citadel.icebalm.com [10.0.10.6])
 by citadel.icebalm.com (Postfix) with ESMTP id CEEE61203D51
 for <linux-nvme@lists.infradead.org>; Sun,  6 Feb 2022 16:59:56 -0500 (EST)
Date: Sun, 6 Feb 2022 16:59:56 -0500 (EST)
From: Warren Chartier <icebalm@icebalm.com>
To: linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <880105512.126.1644184796757.JavaMail.zimbra@icebalm.com>
In-Reply-To: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
References: <1897892278.92.1644177774073.JavaMail.zimbra@icebalm.com>
Subject: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.0.10.6]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: PROBLEM: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in
 Linux
Thread-Index: 8+5vetYbynXNA7W8unIB0RM1a4s1tLF8IUGw
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220206_140836_362492_E1AB71C4 
X-CRM114-Status: UNSURE (   6.31  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 06 Feb 2022 22:04:43 -0800
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

Summary: XPG Gammix S70 Blade PCIe Gen 4 NVMe drive unusable in Linux=20

Full Description:=20
XPG Gammix S70 Blade 1TB PCIe Gen 4.0 NVMe drive is detected by the Linux k=
ernel however when block operations are performed on it these errors are ge=
nerated:=20

[ 3.958786] nvme 0000:0e:00.0: invalid VPD tag 0xff (size 65535) at offset =
7=20
[ 71.726420] nvme nvme1: controller is down; will reset: CSTS=3D0xffffffff,=
 PCI_STATUS=3D0xffff=20
[ 71.793517] block nvme1n1: no usable path - requeuing I/O=20
[ 71.793523] block nvme1n1: no usable path - requeuing I/O=20
[ 71.793525] block nvme1n1: no usable path - requeuing I/O=20
[ 71.793527] block nvme1n1: no usable path - requeuing I/O=20
[ 71.793528] block nvme1n1: no usable path - requeuing I/O=20
[ 71.816389] nvme 0000:0e:00.0: can't change power state from D3cold to D0 =
(config space inaccessible)=20
[ 71.816527] nvme nvme1: Removing after probe failure status: -19=20
[ 71.856406] block nvme1n1: no available path - failing I/O=20
[ 71.856425] block nvme1n1: no available path - failing I/O=20
[ 71.856429] block nvme1n1: no available path - failing I/O=20
[ 71.856432] block nvme1n1: no available path - failing I/O=20
[ 71.856435] block nvme1n1: no available path - failing I/O=20

Some block operations seem to succeed since the Linux kernel looks to be ab=
le to read the partition table from the drive at least:=20
[ 0.672616] nvme nvme1: pci function 0000:0e:00.0=20
[ 0.680459] nvme nvme1: 32/0/0 default/read/poll queues=20
[ 0.682463] nvme1n1: p1 p2 p3 p4=20

However any kind of user operation such as running a partition editor, atte=
mpting to mount a filesystem, etc. will cause the errors and the drive will=
 not work.=20

This drive works perfectly fine in Windows 10 on the same system. The drive=
 also works fine in a Playstation 5.=20

Keywords: nvme kernel=20

Kernel version: Linux version 5.16.5-arch1-1 (linux@archlinux) (gcc (GCC) 1=
1.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Tue, 01 Feb 2022 21:42:=
50 +0000=20

Software:=20
GNU C 11.1.0=20
GNU Make 4.3=20
Binutils 2.36.1=20
Util-linux 2.37.3=20
Mount 2.37.3=20
Module-init-tools 29=20
E2fsprogs 1.46.5=20
Xfsprogs 5.14.2=20
PPP 2.4.9=20
Bison 3.8.2=20
Flex 2.6.4=20
Linux C++ Library 6.0.29=20
Linux C Library 2.33=20
Dynamic linker (ldd) 2.33=20
Procps 3.3.17=20
Kbd 2.4.0=20
Console-tools 2.4.0=20
Sh-utils 9.0=20
Udev 250=20
Modules Loaded acpi_cpufreq aesni_intel af_alg algif_hash algif_skcipher be=
2net blake2b_generic bluetooth bnep bpf_preload bridge btbcm btintel btrfs =
btrtl btusb ccp cdrom cfg80211 cmac crc16 crc32c_generic crc32c_intel crc32=
_pclmul crct10dif_pclmul cryptd crypto_simd crypto_user dca dm_mod ecdh_gen=
eric edac_mce_amd ext4 fat fuse ghash_clmulni_intel hfs hfsplus i2c_piix4 i=
gb intel_rapl_common intel_rapl_msr ip6table_filter ip6_tables iptable_filt=
er ip_tables irqbypass iwlmvm iwlwifi jbd2 jfs joydev k10temp kvm kvm_amd l=
ibarc4 libcrc32c llc mac80211 mac_hid mbcache mc minix mousedev msdos mxm_w=
mi nls_iso8859_1 nvidia nvidia_drm nvidia_modeset nvidia_uvm pcspkr pinctrl=
_amd raid6_pq rapl rfcomm rfkill rng_core sg snd snd_hda_codec snd_hda_code=
c_hdmi snd_hda_core snd_hda_intel snd_hrtimer snd_hwdep snd_intel_dspcfg sn=
d_intel_sdw_acpi snd_pcm snd_rawmidi snd_seq snd_seq_device snd_seq_dummy s=
nd_timer snd_usb_audio snd_usbmidi_lib soundcore sp5100_tco stp ufs usbhid =
uvcvideo vfat vfio vfio_iommu_type1 vfio_pci vfio_pci_core vfio_virqfd vide=
obuf2_common videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc videodev wmi=
 wmi_bmof xfs xhci_pci xhci_pci_renesas xor x_tables=20

Processor Information:=20
processor : 0=20
vendor_id : AuthenticAMD=20
cpu family : 23=20
model : 113=20
model name : AMD Ryzen 7 3800X 8-Core Processor=20
stepping : 0=20
microcode : 0x8701021=20
cpu MHz : 2200.000=20
cache size : 512 KB=20
physical id : 0=20
siblings : 16=20
core id : 0=20
cpu cores : 8=20
apicid : 0=20
initial apicid : 0=20
fpu : yes=20
fpu_exception : yes=20
cpuid level : 16=20
wp : yes=20
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat p=
se36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp=
 lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid aperfmperf rap=
l pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave=
 avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misali=
gnsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb=
 bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba ibpb stibp v=
mmcall fsgsbase bmi1 avx2 smep bmi2 cqm rdt_a rdseed adx smap clflushopt cl=
wb sha_ni xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_tota=
l cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd arat npt lbrv svm_l=
ock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pf=
threshold avic v_vmsave_vmload vgif v_spec_ctrl umip rdpid overflow_recov s=
uccor smca sme sev sev_es=20
bugs : sysret_ss_attrs spectre_v1 spectre_v2 spec_store_bypass=20
bogomips : 7803.32=20
TLB size : 3072 4K pages=20
clflush size : 64=20
cache_alignment : 64=20
address sizes : 43 bits physical, 48 bits virtual=20
power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]=20

lspci -vvv for the offending NVMe drive after cold boot before trying to ac=
cess it:=20
0e:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. Device 5=
236 (rev 01) (prog-if 02 [NVM Express])=20
Subsystem: Device 1dbe:5236=20
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppin=
g- SERR- FastB2B- DisINTx+=20
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+ <TAbort- <=
MAbort- >SERR- <PERR- INTx-=20
Latency: 0, Cache Line Size: 64 bytes=20
Interrupt: pin A routed to IRQ 45=20
NUMA node: 0=20
IOMMU group: 29=20
Region 0: Memory at fce30000 (64-bit, non-prefetchable) [size=3D16K]=20
Region 4: Memory at fce20000 (64-bit, non-prefetchable) [size=3D64K]=20
Expansion ROM at fce00000 [disabled] [size=3D128K]=20
Capabilities: [40] Power Management version 3=20
Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3cold-=
)=20
Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-=20
Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+=20
Address: 0000000000000000 Data: 0000=20
Masking: 00000000 Pending: 00000000=20
Capabilities: [70] Express (v2) Endpoint, MSI 00=20
DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimi=
ted=20
ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W=20
DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+=20
RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-=20
MaxPayload 512 bytes, MaxReadReq 512 bytes=20
DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-=20
LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us=20
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+=20
LnkCtl: ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+=20
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-=20
LnkSta: Speed 16GT/s (ok), Width x4 (ok)=20
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-=20
DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+=20
10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-=20
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-=20
FRS- TPHComp- ExtTPHComp-=20
AtomicOpsCap: 32bit- 64bit- 128bitCAS-=20
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,=
=20
AtomicOpsCtl: ReqEn-=20
LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 2Retimers+ =
DRS-=20
LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-=20
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- Complianc=
eSOS-=20
Compliance De-emphasis: -6dB=20
LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ Equalizat=
ionPhase1+=20
EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-=20
Retimer- 2Retimers- CrosslinkRes: Upstream Port=20
Capabilities: [b0] MSI-X: Enable+ Count=3D66 Masked-=20
Vector table: BAR=3D0 offset=3D00002000=20
PBA: BAR=3D0 offset=3D00003000=20
Capabilities: [d0] Vital Product Data=20
Product Name: ABCD=20
End=20
Capabilities: [100 v2] Advanced Error Reporting=20
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- EC=
RC- UnsupReq- ACSViol-=20
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- EC=
RC- UnsupReq- ACSViol-=20
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ E=
CRC- UnsupReq- ACSViol-=20
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-=20
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+=20
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChk=
En-=20
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-=20
HeaderLog: 00000000 00000000 00000000 00000000=20
Capabilities: [148 v1] Alternative Routing-ID Interpretation (ARI)=20
ARICap: MFVC- ACS-, Next Function: 0=20
ARICtl: MFVC- ACS-, Function Group: 0=20
Capabilities: [158 v1] Secondary PCI Express=20
LnkCtl3: LnkEquIntrruptEn- PerformEqu-=20
LaneErrStat: 0=20
Capabilities: [178 v1] Physical Layer 16.0 GT/s <?>=20
Capabilities: [19c v1] Lane Margining at the Receiver <?>=20
Capabilities: [1b4 v1] Single Root I/O Virtualization (SR-IOV)=20
IOVCap: Migration-, Interrupt Message Number: 000=20
IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-=20
IOVSta: Migration-=20
Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Function Dependency Link:=
 00=20
VF offset: 256, stride: 256, Device ID: 5208=20
Supported Page Size: 00000553, System Page Size: 00000001=20
Region 0: Memory at 00000000fce34000 (64-bit, non-prefetchable)=20
VF Migration: offset: 00000000, BIR: 0=20
Capabilities: [1f4 v1] Latency Tolerance Reporting=20
Max snoop latency: 1048576ns=20
Max no snoop latency: 1048576ns=20
Capabilities: [1fc v1] L1 PM Substates=20
L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+=
=20
PortCommonModeRestoreTime=3D10us PortTPowerOnTime=3D10us=20
L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-=20
T_CommonMode=3D0us LTR1.2_Threshold=3D32768ns=20
L1SubCtl2: T_PwrOn=3D10us=20
Capabilities: [20c v1] Vendor Specific Information: ID=3D0001 Rev=3D1 Len=
=3D038 <?>=20
Capabilities: [244 v1] Data Link Feature <?>=20
Kernel driver in use: nvme=20

After trying to access it and receiving errors:=20
0e:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. Device 5=
236 (rev ff) (prog-if ff)=20
!!! Unknown header type 7f=20


