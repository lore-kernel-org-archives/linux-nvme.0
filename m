From: shan.hai@oracle.com (Shan Hai)
Date: Thu, 3 Jan 2019 10:04:16 +0800
Subject: [PATCH V2 3/3] nvme pci: introduce module parameter of
 'default_queues'
In-Reply-To: <20190102083901.GA26881@ming.t460p>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-4-ming.lei@redhat.com>
 <CABhMZUVU-XcvBC9OjNw9=4gsmspy+Bc4urkb5fSo-7JeDO9m=Q@mail.gmail.com>
 <20190101054735.GB17588@ming.t460p>
 <51a3b7bc-48b1-bfbf-3557-661317c5adc4@oracle.com>
 <20190102073607.GA25590@ming.t460p>
 <d59007c6-af13-318c-5c9d-438ad7d9149d@oracle.com>
 <20190102083901.GA26881@ming.t460p>
Message-ID: <64a017da-5860-7e79-4875-345699e24d2a@oracle.com>


On 2019/1/2 ??4:39, Ming Lei wrote:
> On Wed, Jan 02, 2019@04:26:26PM +0800, Shan Hai wrote:
>>
>>
>> On 2019/1/2 ??3:36, Ming Lei wrote:
>>> On Wed, Jan 02, 2019@10:14:30AM +0800, Shan Hai wrote:
>>>>
>>>>
>>>> On 2019/1/1 ??1:47, Ming Lei wrote:
>>>>> On Mon, Dec 31, 2018@03:24:55PM -0600, Bjorn Helgaas wrote:
>>>>>> On Fri, Dec 28, 2018@9:27 PM Ming Lei <ming.lei@redhat.com> wrote:
>>>>>>>
>>>>>>> On big system with lots of CPU cores, it is easy to consume up irq
>>>>>>> vectors by assigning defaut queue with num_possible_cpus() irq vectors.
>>>>>>> Meantime it is often not necessary to allocate so many vectors for
>>>>>>> reaching NVMe's top performance under that situation.
>>>>>>
>>>>>> s/defaut/default/
>>>>>>
>>>>>>> This patch introduces module parameter of 'default_queues' to try
>>>>>>> to address this issue reported by Shan Hai.
>>>>>>
>>>>>> Is there a URL to this report by Shan?
>>>>>
>>>>> http://lists.infradead.org/pipermail/linux-nvme/2018-December/021863.html
>>>>> http://lists.infradead.org/pipermail/linux-nvme/2018-December/021862.html
>>>>>
>>>>> http://lists.infradead.org/pipermail/linux-nvme/2018-December/021872.html
>>>>>
>>>>>>
>>>>>> Is there some way you can figure this out automatically instead of
>>>>>> forcing the user to use a module parameter?
>>>>>
>>>>> Not yet, otherwise, I won't post this patch out.
>>>>>
>>>>>>
>>>>>> If not, can you provide some guidance in the changelog for how a user
>>>>>> is supposed to figure out when it's needed and what the value should
>>>>>> be?  If you add the parameter, I assume that will eventually have to
>>>>>> be mentioned in a release note, and it would be nice to have something
>>>>>> to start from.
>>>>>
>>>>> Ok, that is a good suggestion, how about documenting it via the
>>>>> following words:
>>>>>
>>>>> Number of IRQ vectors is system-wide resource, and usually it is big enough
>>>>> for each device. However, we allocate num_possible_cpus() + 1 irq vectors for
>>>>> each NVMe PCI controller. In case that system has lots of CPU cores, or there
>>>>> are more than one NVMe controller, IRQ vectors can be consumed up
>>>>> easily by NVMe. When this issue is triggered, please try to pass smaller
>>>>> default queues via the module parameter of 'default_queues', usually
>>>>> it have to be >= number of NUMA nodes, meantime it needs be big enough
>>>>> to reach NVMe's top performance, which is often less than num_possible_cpus()
>>>>> + 1.
>>>>>
>>>>>
>>>>
>>>> Hi Ming,
>>>>
>>>> Since the problem is easily triggered by CPU-hotplug please consider the below
>>>> slightly changed log message:
>>>>
>>>> Number of IRQ vectors is system-wide resource, and usually it is big enough
>>>> for each device. However, the NVMe controllers would consume a large number
>>>> of IRQ vectors on a large system since we allow up to num_possible_cpus() + 1
>>>> IRQ vectors for each controller. This would cause failure of CPU-hotplug
>>>> (CPU-offline) operation when the system is populated with other type of
>>>> multi-queue controllers (e.g. NIC) which have not adopted managed irq feature
>>>> yet in their drivers, the migration of interrupt handlers of these controllers
>>>> on CPU-hotplug will exhaust the IRQ vectors and finally cause the failure of
>>>> the operation. When this issue is triggered, please try to pass smaller default
>>>> queues via the module parameter of 'default_queues', usually it have to be
>>>>> = number of NUMA nodes, meantime it needs be big enough to reach NVMe's top
>>>> performance, which is often less than num_possible_cpus() + 1.
>>>
>>> I suggest not to mention CPU-hotplug in detail because this is just one
>>> typical resource allocation problem, especially NVMe takes too many. And
>>> it can be triggered any time when any device tries to allocate IRQ vectors.
>>>
>>
>> The CPU-hotplug is an important condition for triggering the problem which can
>> be seen when the online CPU numbers drop to certain threshold.
> 
> If online CPU numbers drops, how does that cause more IRQ vectors to be
> allocated for drivers? If one driver needs to reallocate IRQ vectors, it
> has to release the allocated vectors first.
> 

The allocation is caused by IRQ migration of non-managed interrupts from dying
to online CPUs.

>>
>> I don't think the multiple NVMe controllers could use up all CPU IRQ vectors at
>> boot/runtime even on a small number of CPU cores for the reason that the
>> interrupts of NVMe are distributed over the online CPUs and a single controller
>> would not consume multiple vectors of a CPU, because the IRQs are _managed_.
> 
> The 2nd patch in this patchset is exactly for addressing issue on such kind of system,
> and we got reports on one arm64 system, in which NR_IRQS is 96, and CPU cores is 64.
> 

I am not quite familiar with AArch64 architecture but 64 cores provide 96 IRQs,
it's odd to me and probably not popular as CPU-hotplug in my opinion.

Hi Ming,

I am sorry if you see this reply twice in your mailbox, my previous email
was blocked by the list so this is second trial message.

Thanks
Shan Hai

> Thanks,
> Ming
> 
