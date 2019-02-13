From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 13 Feb 2019 11:51:39 +0100
Subject: KXG60ZNV256G not recognized
In-Reply-To: <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
References: <19873dbf-4c19-5cab-d5fb-c63f6cb72101@uni-siegen.de>
 <facf2124-d29c-2151-2419-db9b0776f3cd@suse.de>
 <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
Message-ID: <ef3bbe97-8d3b-89bc-4149-60673b1da388@suse.de>

On 13/02/2019 11:45, Gerd Pokorra wrote:
> Hello Johannes,
> 
> I attached the whole output of 'lspci -vvv' as file lspci.out.

OK, I can't find an NVMe device in there but this one raises concerns:

00:17.0 RAID bus controller: Intel Corporation 82801 Mobile SATA
Controller [RAID mode] (rev 10)
	DeviceName: Onboard - Other
	Subsystem: Dell Device 0832
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at b43b0000 (32-bit, non-prefetchable) [size=32K]
	Region 1: Memory at b43bc000 (32-bit, non-prefetchable) [size=256]
	Region 2: I/O ports at 4090 [size=8]
	Region 3: I/O ports at 4080 [size=4]
	Region 4: I/O ports at 4060 [size=32]
	Region 5: Memory at b4300000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] MSI-X: Enable- Count=34 Masked-
		Vector table: BAR=0 offset=00000000
		PBA: BAR=1 offset=00000000
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
	Kernel driver in use: ahci

Please check your BIOS if the NVMe is in the AHCI remapped NVMe device mode?

Your dmesg should contain an entry like:
Found %d remapped NVMe devices.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
