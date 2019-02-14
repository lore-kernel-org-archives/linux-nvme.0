From: pokorra@uni-siegen.de (Gerd Pokorra)
Date: Thu, 14 Feb 2019 12:41:51 +0100
Subject: KXG60ZNV256G not recognized
In-Reply-To: <20190214083323.GB24653@infradead.org>
References: <402e84e1-160f-d335-4054-710b73fbbb4c@suse.de>
 <553537fc-3320-751d-8532-9735cdf1336a@uni-siegen.de>
 <20190213180050.GA26226@infradead.org>
 <267176a4277b45d6b7b8a7eddf1f8123@ausx13mpc120.AMER.DELL.COM>
 <20190213181838.GA7852@localhost.localdomain>
 <e970bfdcf6fb403ebdd395cc87bde80a@ausx13mpc120.AMER.DELL.COM>
 <20190213190012.GA8898@infradead.org>
 <4bd15523d31948328c2c50693a08bd2c@ausx13mpc120.AMER.DELL.COM>
 <20190213212253.GA8027@localhost.localdomain>
 <4eb55f6c57c74db497a3dc1fe830e993@ausx13mpc120.AMER.DELL.COM>
 <20190214083323.GB24653@infradead.org>
Message-ID: <80f1bc15-51b7-d901-5191-1f99eed324d9@uni-siegen.de>

Hello,

in the BIOS I set 'System Configuration' -> 'SATA Operation' from

 ? 'RAID On' to 'AHCI'.

After that I installed Windows new. Then I installed Ubuntu 18.04.1 
Sever. The installation works fine. I get the Dual-Boot menu and was 
able to create a partition for Linux on the NVMe SSD. This is what the 
owner of the laptop requested me to do for him.

Thank you for your great support!!!

-- Gerd


Am 14.02.2019 um 09:33 schrieb Christoph Hellwig:
> On Wed, Feb 13, 2019 at 09:56:38PM +0000, Mario.Limonciello at dell.com wrote:I
>>> Pre-boot settings like you already have are preferable, right? Otherwise
>>> it's a little more difficult to use the NVMe as your boot drive.
>> The SMM thing I mentioned would basically just be modifying those pre-boot settings
>> so the next boot it could DTRT for Linux.
>>
>> It's definitely just a band-aid to the problem.
> So it is a one time setting?  If it was permanent it might at least
> be useful for a little tool in the installer to offer that choice.
> But either way it doesn't help to make the broken intel platforms to
> just work.
>
>> Christoph - are you looking for a whitepaper explaining this beyond the ACHI BAR
>> remapping documentation that was shared?
>> http://www.intel.com/content/www/us/en/chipsets/100-series-chipset-datasheet-vol-2.html
>>
>> I think if we can have start with a list of actionable things needed for another
>> go at this and an acceptable design architecture before this thing is revisited again
>> to have a chance at solving it.  Are you amenable to a host bridge?
> See the last mail for the functionality that is currently broken and
> which needs to work.  Preferably without changes in the NVMe driver
> itself, as that is not the place to work around intentionally buggy
> platforms.
>
>>> Whatever answer we, in the Linux kernel community, come up with,
>>> leaving storage inaccessible is not an acceptable answer.
>> The thing that lives in the kernel now (aecec8b60422118b52e3347430ba9382e57d6d76)
>> really does a disservice to people trying to use Linux today:
>>> 	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
>>> 	dev_warn(&pdev->dev, "Switch your BIOS from RAID to AHCI mode to use them.\n");
> Yes, we really need to ammend this message to tell people to complain
> to Intel and their platform vendor for fucking up things this badly.
