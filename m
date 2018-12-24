From: shan.hai@oracle.com (Shan Hai)
Date: Mon, 24 Dec 2018 11:05:33 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <CACVXFVPNSE4wM5C0bZgvYOx+mLsjRSQRk9_wv2V=+VVGGY7G7A@mail.gmail.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
 <CACVXFVMTxwM5EDZbrcVi=Dhy0Q=DN_yL77gTohY7AtKOpFb+uA@mail.gmail.com>
 <aa86c9e2-ccb1-7156-6903-52c5e539d36c@oracle.com>
 <CACVXFVMKBO1U6TuhSrnKbPKKaY=xBfCn45Z_5wpNA5+e2bC5DA@mail.gmail.com>
 <0cf40b16-206c-5a63-4ce1-8cc220e45712@oracle.com>
 <CACVXFVPNSE4wM5C0bZgvYOx+mLsjRSQRk9_wv2V=+VVGGY7G7A@mail.gmail.com>
Message-ID: <3b6e64af-fbd7-713c-6b1f-b5efa0df86fb@oracle.com>



On 2018/12/24 ??10:46, Ming Lei wrote:
> On Mon, Dec 24, 2018@10:12 AM Shan Hai <shan.hai@oracle.com> wrote:
>>
>>
>>
>> On 2018/12/24 ??9:47, Ming Lei wrote:
>>> On Mon, Dec 24, 2018@9:02 AM Shan Hai <shan.hai@oracle.com> wrote:
>>>>
>>>> Hi Minglei,
>>>>
>>>> On 2018/12/23 ??8:38, Ming Lei wrote:
>>>>> Hi Shanhai,
>>>>>
>>>>> On Fri, Dec 21, 2018@2:05 PM Shan Hai <shan.hai@oracle.com> wrote:
>>>>>> The num_possible_cpus() number of io queues by default would cause
>>>>>> irq vector shortage problem on a large system when hotplugging cpus,
>>>>>> add a module parameter to set number of io queues according to the
>>>>>> system configuration to fix the issue.
>>>>> Yeah, the default nr_io_queues is num_possible_cpus(), which can be a bit
>>>>> big on some systems which supports small number of irq vectors.
>>>>>
>>>>> But nvme_setup_irqs() may decrease nr_io_queues and try to allocate
>>>>> again until it succeeds.
>>>>>
>>>>> Could you share us what the actual issue is?
>>>>
>>>>
>>>> On an 8-way NUMA with total 384 CPUs system installed with multiple NVME
>>>> storage devices the CPU
>>>>
>>>> offline operation will fail when the online CPU numbers drop to a
>>>> certain value, the failure is caused by
>>>>
>>>> cpu interrupt vector exhaustion because the irqs of the NVME have to be
>>>> migrated to the online CPUs.
>>>
>>> I can understand there is issue when the whole system has very limited
>>> irq vectors,
>>> then some NVMe may consume too many irq vectors, and the remained NVMe
>>> may not get any irq vectors left. Is this your case?
>>>
>>
>> The problem only occurs on cpu offlining.
>>
>>> But I don't understand ' the irqs of the NVME have to be  migrated to
>>> the online CPUs.',
>>> in theory one IRQ vector is enough to drive NVMe, so could you explain it a bit?
>>>
>>
>> Oops, it's not the migration of the NVME interrupts, sorry.
>> The interrupt migration failure occurs on other multi-queue devices
>> like NICs which has not use managed irq feature yet, so the migration
>> of interrupts of theses devices will fail because the NVMEs consume
>> much more vectors.
> 
> OK, I guess NICs may allocate irq vectors in case of migration.
> 
> BTW, do you have any logs about this failure? So we can easily recognize
> this kind of issue if it is reported by someone else.
> 

OK, I'll include a log in the comments of the v2 patches, thanks for the
suggestion.

> Yeah, for NVMe, in case of big system with lots CPU cores, it looks not fair
> to do the 1:1 mapping, because actually one IRQ vector is allocated for each
> CPU core, and it shouldn't take so many CPUs just for serving IO.
> 
> So far, looks it is fine to introduce module parameter to limit the allocation
> for this issue, even though it isn't flexible.
> 
> Another candidate approach might be to support it via multi queue mapping
> style, we may introduce one new parameter of 'default_queues' for this purpose,
> just like 'write_queues' and 'poll_queues'.
> 

Agreed, but it needs more efforts on rebuilding cpu to hw queue mappings
etc. in my opinion, I will think about is anyway.

Thanks
Shan Hai

> Thanks,
> Ming Lei
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
