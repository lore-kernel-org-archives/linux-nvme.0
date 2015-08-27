From: keith.busch@intel.com (Keith Busch)
Date: Thu, 27 Aug 2015 12:44:11 +0000 (UTC)
Subject: driver for apple storage controller 106b:2001
In-Reply-To: <867299369.1895690.1440660234198.JavaMail.zimbra@sol1.com.au>
References: <929615901.1885031.1440642840254.JavaMail.zimbra@sol1.com.au>
 <2064995530.1885067.1440642920364.JavaMail.zimbra@sol1.com.au>
 <CAHxQtxMLPSpn3iZjFVv+f2wngpHG4yBBEq-ZxsrwiBdARB1Frw@mail.gmail.com>
 <232457292.1895635.1440660003028.JavaMail.zimbra@sol1.com.au>
 <867299369.1895690.1440660234198.JavaMail.zimbra@sol1.com.au>
Message-ID: <alpine.LNX.2.00.1508271235480.3969@localhost.lm.intel.com>

On Thu, 27 Aug 2015, Wes Cilldhaire wrote:
> When I have time (and I've made a backup!) I'm happy to tinker with
> hardcoding some parameters or adding options to override them in the driver
> to see if we can force the driver to talk to this controller.  I fear though
> that if these bytes really are swapped around in the protocol setup there are
> surely other such quirks laying in wait... and I am by no means an
> experienced driver writer


The visual class code similarity is not an indicator to how simimilar
it is to NVMe's host-controller interface. The 0180 prefix is just a
Mass Storage Controller. Lots of proprietary controllers use that. This
106b:2001 looks like it is using a proprietary interface and requires
a completely different driver. You may need to check with the vendor.


> Cheers,
> Wes
>
> ----- Original Message -----
>> From: "Wes Cilldhaire" <wes at sol1.com.au>
>> To: "Julien Grossholtz" <julien.grossholtz at gmail.com>
>> Sent: Thursday, 27 August, 2015 5:20:03 PM
>> Subject: Re: driver for apple storage controller 106b:2001
>>
>> Hi Julien,
>>
>> This original message did make it on to the mailing list by the way, I can
>> see it in the archive here:
>>
>> http://lists.infradead.org/pipermail/linux-nvme/2015-August/002196.html
>>
>> No one besides myself has responded to this thread yet though...
>>
>>
>>
>>
>> ----- Original Message -----
>> From: "Julien Grossholtz" <julien.grossholtz at gmail.com>
>> To: "Wes Cilldhaire" <wes at sol1.com.au>
>> Sent: Thursday, 27 August, 2015 5:13:56 PM
>> Subject: Re: driver for apple storage controller 106b:2001
>>
>> Hi Wes,
>>
>> I'm not able to post on the mailing list. I don't know why. This is a
>> message I planned to send. I have some informations that could be usefull.
>> Could you please send an email to the list with the informations/questions
>> contained into the following email ?
>>
>> About your question, I don't think anyone worked on the issue for now...
>>
>> Thank you,
>>
>> Julien
>>
>>
>>
>> Here are the fatcs/questions. You can copy paste or reformulate if you
>> want. I don't care :
>>
>> - The issue is the same on some 2015 Macbook air. Not all of them, only
>> those who are claiming to have an
>> NVMExpress controler under OSX.
>>
>> - On a forum a someone tried with a 3.16 kernel and had a different
>> behaviour : he had some delay
>> after the echo "106b 2001" > /sys/bus/pci/drivers/nvme/new_id
>> I'm not sure it is really usefull but anyway here is it's dmesg output :
>>
>> $ echo "106b 2001" | sudo tee /sys/bus/pci/drivers/nvme/new_id
>> 106b 2001
>> $ dmesg
>> [  136.279863] irq 16: nobody cared (try booting with the "irqpoll" option)
>> [  136.279872] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.16.0-30-generic
>> #40~14.04.1-Ubuntu
>> [  136.279875] Hardware name: Apple Inc. MacBook8,1/Mac-BE0E8AC46FE800CC,
>> BIOS MB81.88Z.0164.B02.1503241252
>> 03/24/2015
>> [  136.279877]  ffff880262992ca4 ffff88026ec83e58 ffffffff81762590
>> ffff880262992c00
>> [  136.279882]  ffff88026ec83e80 ffffffff810cd672 ffff880262992c00
>> 0000000000000010
>> [  136.279886]  0000000000000000 ffff88026ec83ec0 ffffffff810cdbac
>> 0000000000000000
>> [  136.279890] Call Trace:
>> [  136.279893]  <IRQ>  [<ffffffff81762590>] dump_stack+0x45/0x56
>> [  136.279906]  [<ffffffff810cd672>] __report_bad_irq+0x32/0xd0
>> [  136.279910]  [<ffffffff810cdbac>] note_interrupt+0x24c/0x2a0
>> [  136.279914]  [<ffffffff810cb29e>] handle_irq_event_percpu+0xae/0x1a0
>> [  136.279917]  [<ffffffff810cb3cd>] handle_irq_event+0x3d/0x60
>> [  136.279921]  [<ffffffff810ce771>] handle_fasteoi_irq+0x81/0x150
>> [  136.279927]  [<ffffffff810155ee>] handle_irq+0x1e/0x30
>> [  136.279931]  [<ffffffff8176dabf>] do_IRQ+0x4f/0xf0
>> [  136.279936]  [<ffffffff8176b96d>] common_interrupt+0x6d/0x6d
>> [  136.279937]  <EOI>  [<ffffffff815fb8a2>] ? cpuidle_enter_state+0x52/0xc0
>> [  136.279947]  [<ffffffff815fb898>] ? cpuidle_enter_state+0x48/0xc0
>> [  136.279952]  [<ffffffff815fb9c7>] cpuidle_enter+0x17/0x20
>> [  136.279957]  [<ffffffff810b528d>] cpu_startup_entry+0x31d/0x450
>> [  136.279961]  [<ffffffff8104526d>] start_secondary+0x21d/0x2e0
>> [  136.279963] handlers:
>> [  136.279969] [<ffffffffc048b5f0>] nvme_irq [nvme]
>> [  136.279972] Disabling IRQ #16
>> [  195.662642] nvme: probe of 0000:03:00.0 failed with error -4
>>
>>
>> This only means there was no handler for an interrupt right ? Is it an
>> interrupt your are usually taking care
>> of on Intel CPUs regarding NVNE ?
>>
>> - Some people are running windows on his Macbook. The Windows driver is
>> only displayed as a
>> "APPLE SSD AP0512 SCSI Disk Device" (I have some screenshots to share if
>> needed). So maybe it is not an NVME
>> device at all ? How could we check if it is a PCIe device instead ?
>>
>> - One last remark :
>> 134217728 -> 0x0800 0000 -> 0b00001000 00000000 00000000 00000000
>> But 0b00001000 00000000 is 2048.
>> It may be a byte order issue ? or endianess ? It may be similar with the
>> controler type error : 02 80 01 -> 02 08 01
>> Could we force the page size to 2048 to see what it gives ?
>>
>> 2015-08-27 4:35 GMT+02:00 Wes Cilldhaire <wes at sol1.com.au>:
>>
>>> I'm having this issue on stable mainline too, does anyone know if it's
>>> been addressed at all?  Is it worth testing from git yet or has no
>>> work been done on this so far?  Are we still after information?  Or
>>> are Apple simply violating spec and this won't ever work?
>>>
>>> Cheers,
>>> Wes
>>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
