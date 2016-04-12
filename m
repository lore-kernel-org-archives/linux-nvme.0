From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 12 Apr 2016 17:13:33 -0300
Subject: [PATCH 2/2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <20160412200216.GA4183@localhost.localdomain>
References: <1460405751-8884-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1460405751-8884-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <BL2PR04MB163667E7A08D934896BBA7192950@BL2PR04MB163.namprd04.prod.outlook.com>
 <201604121948.u3CJmrdR002584@d03av01.boulder.ibm.com>
 <20160412200216.GA4183@localhost.localdomain>
Message-ID: <570D56ED.7010203@linux.vnet.ibm.com>

On 04/12/2016 05:02 PM, Keith Busch wrote:
> On Tue, Apr 12, 2016@02:48:46PM -0500, Murali N Iyer wrote:
>> Jeff, David,
>>
>> You might not see the issue 100% of the time if you don't activate the
>> different slot. Try with any kernel that provides "reset_controller" interface.
>> RHEL 7.2, Ubuntu 16.04 etc. does.
>>
>> Example: you are running with FW slot #1
>>
>> # nvme fw-log /dev/nvme4
>> Firmware Log for device:/dev/nvme4
>> afi : 0x11
>> frs1 : 0x3430315050494d4b (KMIPP104)
>> frs2 : 0x3430315050494d4b (KMIPP104)
>> frs3 : 0x3430315050494d4b (KMIPP104)
>> frs4 : 0x3430315050494d4b (KMIPP104)
>>
>> # echo 1 > /sys/class/nvme/nvme4/reset_controller ==.> This might work most of
>> the time
>>
>> Now, activate slot #4 and then reset_controller
>>
>> # nvme fw-activate /dev/nvme4 -a 2 -s 4
>> Success activating firmware action:2 slot:4
>>
>> # echo 1 > /sys/class/nvme/nvme4/reset_controller ==> This generates EEH
>
> As older kernels did not export the reset_controller interface, unloading
> and reloading the driver with modprobe should reproduce the sequence
> you're describing. The method is not as convenient, but should be enough
> for a 3rd party with the same controller to confirm results.
>

Thanks Murali and Keith for the detailed explanation.

Cheers,


Guilherme
