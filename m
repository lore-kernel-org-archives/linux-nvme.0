From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Feb 2019 11:18:39 -0700
Subject: KXG60ZNV256G not recognized
In-Reply-To: <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
References: <8bc60c39-9c07-f9cd-497c-b6dc9a836403@uni-siegen.de>
 <ef3bbe97-8d3b-89bc-4149-60673b1da388@suse.de>
 <c60ce637-b50c-2ead-d4fb-6cac3d812e74@uni-siegen.de>
 <1a626bba-4e02-426b-182e-2e863c6a5f77@uni-siegen.de>
 <05361ecc-7a7d-1a31-1c72-dac670badc24@suse.de>
 <e64c744b-8db6-ab66-af92-6ba9a347dc2e@uni-siegen.de>
 <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
Message-ID: <20190213181838.GA7852@localhost.localdomain>

On Wed, Feb 13, 2019@06:04:39PM +0000, Mario.Limonciello@dell.com wrote:
> 
> If you go into BIOS setup and choose SATA mode change from 
> "RAID ON" to "AHCI".
> 
> I know it's an NVME disk, and you're changing SATA mode, but it adjusts
> relevant settings on the PCH whether you were using a SATA disk or NVME.

Right, "RAID" mode has the PCH compbine multiple devices into one. AHCI
mode doesn't capture other devices behind the SATA controller, so the
NVMe device is visible.
