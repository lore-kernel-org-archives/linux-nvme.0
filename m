From: nvme@elfenteich.de (Carina Willbold)
Date: Mon, 16 May 2016 19:55:15 +0200
Subject: Accessing the NVMe flash drive of the April 2016 MacBook 12"
 (A1534) [SOLVED]
In-Reply-To: <20160516144653.GA10776@localhost.localdomain>
References: <10c3272709f4fc720d862c81da85e6e9@speicherleck.de>
 <eaaba356177409f3a40afc33d938d42c@speicherleck.de>
 <21472d94e79a410912937ae5722c2fb4@speicherleck.de>
 <20160516144653.GA10776@localhost.localdomain>
Message-ID: <21f8acc3ad1b38406b1f7ce45aed139d@www.speicherleck.de>

Dear Keith,

Am 2016-05-16 16:46, schrieb Keith Busch:
> On Mon, May 16, 2016@04:59:51AM +0200, Carina Willbold wrote:
[ Trying to get the flash disk on the new MacBook recognized ]
>> I can now happily confirm that accessing the flash drive works using 
>> kernel
>> 4.6.0-rc7 and manually binding using:
>>
>>     echo 106b 2003 > /sys/bus/pci/drivers/nvme/new_id
>>
>> No controller resets or other IO errors occur even with (moderately)
>> drive-intense activities like compiling and installing packages.
>>
>> I'll submit a patch which will make the manual binding superfluous 
>> tomorrow.
>
> It was starting to sound like you might need to copy the current 
> Apple
> driver quirk for the 0x2001 device, but if it's working without, you
> can just append the VID/DID to nvme's pci_device_id table.

yes, thought so too, but it's working without. I can confirm that the 
flash drive works fine and is automatically detected with the (trivial) 
patch given in the other mail. The patch is against 4.6, but it applies 
cleanly against the current linux-next and axboe/linux-block.

In my boot scripts, I had to include a short sleep because I was too 
lazy to properly wait for the device files to come into existence.

Thank you for your answer!

LLAP,
Carina
