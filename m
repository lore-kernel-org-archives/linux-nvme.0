From: nisha.miller420@gmail.com (Nisha Miller)
Date: Tue, 23 Aug 2016 16:56:11 -0700
Subject: Linux AER reporting
In-Reply-To: <57BB4019.7050008@linux.vnet.ibm.com>
References: <CAG3=cOncMTcyALa=-i1jeA-z4pe22D9CrJ=Rxr2E8HWBsEMOPg@mail.gmail.com>
 <57BB4019.7050008@linux.vnet.ibm.com>
Message-ID: <CAG3=cOn_pMZ5DMtB3K2tDGUL1x3vkn=Vjw9c8X8+ONh8xef+mw@mail.gmail.com>

Hi Keith and Guilherme,

thank you for your replies.

Kernel 4.4.19 does not seem to have nvme driver with support for AER.
It is present in Kernel 4.7 but getting it to work on Centos 7.2 is
turning out to be quite a task. Arch Linux has kernel 4.7 so I will
give that a shot.

I should have mentioned that we get the CSTS = 0xFFFFFFFF only after
millions of writes. When using fio, it runs for over 30 minutes before
the problem crops up.

BTW, I subscribed to linux-nvme list but never got a confirmation
email. I don't get email from the list, but I'm able to post to it.

cheers
Nisha

On Mon, Aug 22, 2016 at 11:10 AM, Guilherme G. Piccoli
<gpiccoli@linux.vnet.ibm.com> wrote:
> On 08/22/2016 12:52 PM, Nisha Miller wrote:
>>
>> Hi all,
>>
>> We have a PCIE SSD controller using NVME. This controller works on
>> Windows and Linux. However, we are seeing a problem under Linux.
>>
>> In the nvme Linux driver in function nvme_kthread() the CSTS register
>> is read once a second to check for controller status failure. In our
>> case we see that occasionally this register is read as 0xFFFFFFFF.
>> Whenever this happens, the kernel just hangs. This seems to be PCIe
>> read error and we are trying to gather further information. How does
>> one use Linux AER with the nvme driver?
>
>
> Nisha, we once saw 0xFFFF on CSTS register after issuing a reset_controller,
> for example. The reason it was that device shutdown was replaced by device
> disable when resetting the controller, following the NVMe spec, but the
> device we were testing that time didn't cope well with this change.
>
> For that, we implemented a quirk to wait a little on reading this register
> in some occasions. The commit info is:
>
>
> 54adc01055 ("nvme/quirk: Add a delay before checking for adapter readiness")
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=54adc01055b75ec8769c5a36574c7a0895c0c0b2
>
>
> I'm really not sure if it's related, but I guess worth a try.
> Cheers,
>
>
> Guilherme
>
>
>>
>> We are using Centos 7.2 with Kernel 3.19.8. PCIe AER has been enabled
>> in the kernel and aerdriver.forceload=y is set in the command line.
>>
>> TIA
>> Nisha Miller
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
>
