From: jani.nikula@intel.com (Jani Nikula)
Date: Wed, 24 Jan 2018 13:42:08 +0200
Subject: REGRESSION in c5552fde102f ("nvme: Enable autonomous power state
 transitions")
Message-ID: <87shaveb5b.fsf@intel.com>


Hi Andy, all -

So this is an odd one.

I'm getting display FIFO underruns in a very specific setting: Laptop
display switched off, and an external display connected. Other
combinations work fine.

I've bisected this to c5552fde102f ("nvme: Enable autonomous power state
transitions"), and, being baffled by the result, carefully checked
this. There are no problems when running c5552fde102f^, with
nvme_core.default_ps_max_latency_us=0, or after 'echo 0 >
pm_qos_latency_tolerance_us'. With the last one, restoring the original
value of 100000 brings the underruns back.

I have no idea what the root cause mechanism here is, but the bisect is
correct. Perhaps something to do with timing. I'd be happy to provide
further details.

I see that you have quirked one Samsung device. Incidentally, this
Lenovo Yoga 910 (Kabylake, SunrisePoint LP PCH) also has a Samsung NVMe
device, just a different one. Details below. I don't know what the
failure mode in the quirked one is, so I don't know if this could be the
same issue.

BR,
Jani.


$ lspci -vvnn -s 02:00.0
02:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd Device [144d:a804] (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd Device [144d:a801]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	NUMA node: 0
	Region 0: Memory at a1200000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 25.000W
		DevCtl:	Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s, Width x4, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+, EqualizationPhase1+
			 EqualizationPhase2+, EqualizationPhase3+, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable+ Count=33 Masked-
		Vector table: BAR=0 offset=00003000
		PBA: BAR=0 offset=00002000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [158 v1] Power Budgeting <?>
	Capabilities: [168 v1] #19
	Capabilities: [188 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 3145728ns
	Capabilities: [190 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=163840ns
		L1SubCtl2: T_PwrOn=44us
	Kernel driver in use: nvme
	Kernel modules: nvme


-- 
Jani Nikula, Intel Open Source Technology Center
