From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 Jan 2019 20:57:21 -0700
Subject: [PATCH] nvme: fix out-of-bounds access during irq vectors
 allocation
In-Reply-To: <0a01d310-c949-af4e-edc0-44859fb277c5@kernel.dk>
References: <1547694610-31879-1-git-send-email-chenhc@lemote.com>
 <0a01d310-c949-af4e-edc0-44859fb277c5@kernel.dk>
Message-ID: <95eb3f38-0f55-dc99-94a0-d5a2b88c0e4c@kernel.dk>

On 1/16/19 8:51 PM, Jens Axboe wrote:
> On 1/16/19 8:10 PM, Huacai Chen wrote:
>> While reducing irq_queues in the do-while loop in nvme_setup_irqs(),
>> the reduction of irq_sets[] is behind irq_queues. Below is an example.
>>
>> On a 8 cpu platform, with default setting, nvme_setup_irqs() begin with
>> irq_queues = 8 (but when allocating irq vectors it will become 9 due to
>> the admin queue), affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0]
>> = 8. If MSI-X resources are not enough, then the do-while loop will
>> reduce irq vectors:
>>
>> The 1st time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 9, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
>> The 2nd time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 8, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
>> The 3rd time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 7, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 7
>>
>> However, this will cause an out of bounds access in __pci_enable_msix()
>> --> ... --> irq_create_affinity_masks() --> irq_build_affinity_masks().
>>
>> In the 2nd round of reduction, let's pay attention to the calling of
>> irq_build_affinity_masks(affd, curvec, this_vecs, curvec, node_to_cpumask, masks):
>>
>> The number of elements in masks is 8 (depends on nvecs which is equal to
>> irq_queues), curvec is 1 (depends on affd.pre_vectors), then
>> irq_build_affinity_masks() will access 8 elements in masks (depends on
>> this_vecs which is equal to affd.sets[0]), and the last element is out
>> of bounds.
>>
>> So the root cause is affd.sets[] + affd.pre_vectors should not be larger
>> than vectors to be allocated. In this patch we introduce alloc_queues to
>> indicate how many queues to allocate (not reuse irq_queues), and so we
>> can adjust affd.set[] correctly (depends on irq_queues) to avoid out of
>> bounds access.
>>
>> After this patch:
>>
>> The 1st time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 8, alloc_queues = 9, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 8
>> The 2nd time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 7, alloc_queues = 8, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 7
>> The 3rd time call pci_alloc_irq_vectors_affinity(),
>> irq_queues = 6, alloc_queues = 7, affd.pre_vectors = 1, affd.nr_sets = 1, affd.sets[0] = 6
> 
> We currently have this one queued up:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=c45b1fa2433c65e44bdf48f513cb37289f3116b9
> 
> can you check if it fixes the issue for you?

Nevermind, took a closer look, and this looks like a different issue.

-- 
Jens Axboe
