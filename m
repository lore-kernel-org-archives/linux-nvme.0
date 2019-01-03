From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 3 Jan 2019 11:21:06 +0800
Subject: [PATCH V2 3/3] nvme pci: introduce module parameter of
 'default_queues'
In-Reply-To: <4d8f963e-df7d-b2d9-3bf8-4852dfe6808e@oracle.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-4-ming.lei@redhat.com>
 <CABhMZUVU-XcvBC9OjNw9=4gsmspy+Bc4urkb5fSo-7JeDO9m=Q@mail.gmail.com>
 <20190101054735.GB17588@ming.t460p>
 <CABhMZUXoZkMGd3+54KxXU4nX-h=sbO5SBm-893ZHc3WU6BvN1w@mail.gmail.com>
 <20190103021237.GA25044@ming.t460p>
 <4d8f963e-df7d-b2d9-3bf8-4852dfe6808e@oracle.com>
Message-ID: <20190103032105.GH25044@ming.t460p>

On Thu, Jan 03, 2019@10:52:49AM +0800, Shan Hai wrote:
> 
> 
> On 2019/1/3 ??10:12, Ming Lei wrote:
> > On Wed, Jan 02, 2019@02:11:22PM -0600, Bjorn Helgaas wrote:
> >> [Sorry about the quote corruption below.  I'm responding with gmail in
> >> plain text mode, but seems like it corrupted some of the quoting when
> >> saving as a draft]
> >>
> >> On Mon, Dec 31, 2018@11:47 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> &gt;
> >> &gt; On Mon, Dec 31, 2018@03:24:55PM -0600, Bjorn Helgaas wrote:
> >> &gt; &gt; On Fri, Dec 28, 2018@9:27 PM Ming Lei <ming.lei@redhat.com> wrote:
> >> &gt; &gt; &gt;
> >> &gt; &gt; &gt; On big system with lots of CPU cores, it is easy to
> >> consume up irq
> >> &gt; &gt; &gt; vectors by assigning defaut queue with
> >> num_possible_cpus() irq vectors.
> >> &gt; &gt; &gt; Meantime it is often not necessary to allocate so many
> >> vectors for
> >> &gt; &gt; &gt; reaching NVMe's top performance under that situation.
> >> &gt; &gt;
> >> &gt; &gt; s/defaut/default/
> >> &gt; &gt;
> >> &gt; &gt; &gt; This patch introduces module parameter of 'default_queues' to try
> >> &gt; &gt; &gt; to address this issue reported by Shan Hai.
> >> &gt; &gt;
> >> &gt; &gt; Is there a URL to this report by Shan?
> >> &gt;
> >> &gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021863.html
> >> &gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021862.html
> >> &gt;
> >> &gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021872.html
> >>
> >> It'd be good to include this.  I think the first is the interesting
> >> one.  It'd be nicer to have an https://lore.kernel.org/... URL, but it
> >> doesn't look like lore hosts linux-nvme yet.  (Is anybody working on
> >> that?  I have some archives I could contribute, but other folks
> >> probably have more.)
> >>
> >> </ming.lei at redhat.com></ming.lei at redhat.com>
> >>>>
> >>>> Is there some way you can figure this out automatically instead of
> >>>> forcing the user to use a module parameter?
> >>>
> >>> Not yet, otherwise, I won't post this patch out.
> >>>
> >>>> If not, can you provide some guidance in the changelog for how a user
> >>>> is supposed to figure out when it's needed and what the value should
> >>>> be?  If you add the parameter, I assume that will eventually have to
> >>>> be mentioned in a release note, and it would be nice to have something
> >>>> to start from.
> >>>
> >>> Ok, that is a good suggestion, how about documenting it via the
> >>> following words:
> >>>
> >>> Number of IRQ vectors is system-wide resource, and usually it is big enough
> >>> for each device. However, we allocate num_possible_cpus() + 1 irq vectors for
> >>> each NVMe PCI controller. In case that system has lots of CPU cores, or there
> >>> are more than one NVMe controller, IRQ vectors can be consumed up
> >>> easily by NVMe. When this issue is triggered, please try to pass smaller
> >>> default queues via the module parameter of 'default_queues', usually
> >>> it have to be >= number of NUMA nodes, meantime it needs be big enough
> >>> to reach NVMe's top performance, which is often less than num_possible_cpus()
> >>> + 1.
> >>
> >> You say "when this issue is triggered."  How does the user know when
> >> this issue triggered?
> > 
> > Any PCI IRQ vector allocation fails.
> > 
> >>
> >> The failure in Shan's email (021863.html) is a pretty ugly hotplug
> >> failure and it would take me personally a long time to connect it with
> >> an IRQ exhaustion issue and even longer to dig out this module
> >> parameter to work around it.  I suppose if we run out of IRQ numbers,
> >> NVMe itself might work fine, but some other random driver might be
> >> broken?
> > 
> > Yeah, seems that is true in Shan's report.
> > 
> > However, Shan mentioned that the issue is only triggered in case of
> > CPU hotplug, especially "The allocation is caused by IRQ migration of
> > non-managed interrupts from dying to online CPUs."
> > 
> > I still don't understand why new IRQ vector allocation is involved
> > under CPU hotplug since Shan mentioned that no IRQ exhaustion issue
> > during booting.
> > 
> 
> Yes, the bug can be reproduced easily by CPU-hotplug.
> We have to separate the PCI IRQ and CPU IRQ vectors first of all. We know that
> the MSI-X permits up to 2048 interrupts allocation per device, but the CPU,
> X86 as an example, could provide maximum 255 interrupt vectors, and the sad fact
> is that these vectors are not all available for peripheral devices.
> 
> So even though the controllers are luxury in PCI IRQ space and have got
> thousands of vectors to use but the heavy lifting is done by the precious CPU
> irq vectors.
> 
> The CPU-hotplug causes IRQ vectors exhaustion problem because the interrupt
> handlers of the controllers will be migrated from dying cpu to the online cpu
> as long as the driver's irq affinity is not managed by the kernel, the drivers
> smp_affinity of which can be set by procfs interface belong to this class.
> 
> And the irq migration does not do irq free/realloc stuff, so the irqs of a
> controller will be migrated to the target CPU cores according to its irq
> affinity hint value and will consume a irq vector on the target core.

Could anyone explain a bit why one extra irq vector is required under
this situation? Given the 'controller' has been assigned IRQ vector
before.

Or Shan, could you share us where the source code is for the extra
vector allocation?

> 
> If we try to offline 360 cores out of total 384 cores on a NUMA system attached
> with 6 NVMe and 6 NICs we are out of luck and observe a kernel panic due to the
> failure of I/O.
> 
> > Maybe Shan has ideas about the exactdirect reason, it is really caused
> > by IRQ vector exhaustion, or is there IRQ vector leak in the NIC
> > driver triggered by CPU hotplug? Or other reason?
> > 
> >>
> >> Do you have any suggestions for how to make this easier for users?  I
> >> don't even know whether the dev_watchdog() WARN() or the bnxt_en error
> >> is the important clue.
> > 
> > If the root cause is that we run out of PCI IRQ vectors, at least I saw
> > such aarch64 system(NR_IRQS is 96, and CPU cores is 64, with NVMe).
> > 
> > IMO, only PCI subsystem has the enough knowledge(how many PCI devices, max
> > vectors for each device, how many IRQ vectors in the system, ...) to figure
> > out if NVMe may take too many vectors. So long term goal may be to limit the
> > max allowed number for NVMe or other big consumer.
> > 
> 
> As I said above we have to separate PCI vs CPU irq vector space.

Strictly speaking, IRQ vector should be system wide(IRQ controller doesn't belong
to CPU in concept) resource, which is exactly what I mean. The whole supported
IRQ vector space should be visible by PCI subsystem, and there may be other IRQ
consumption from non-PCI bus, but in reality the number can't be too big.

thanks, 
Ming
