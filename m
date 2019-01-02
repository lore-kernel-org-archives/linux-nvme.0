From: bjorn.helgaas@gmail.com (Bjorn Helgaas)
Date: Wed, 2 Jan 2019 14:11:22 -0600
Subject: [PATCH V2 3/3] nvme pci: introduce module parameter of
 'default_queues'
In-Reply-To: <20190101054735.GB17588@ming.t460p>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-4-ming.lei@redhat.com>
 <CABhMZUVU-XcvBC9OjNw9=4gsmspy+Bc4urkb5fSo-7JeDO9m=Q@mail.gmail.com>
 <20190101054735.GB17588@ming.t460p>
Message-ID: <CABhMZUXoZkMGd3+54KxXU4nX-h=sbO5SBm-893ZHc3WU6BvN1w@mail.gmail.com>

[Sorry about the quote corruption below.  I'm responding with gmail in
plain text mode, but seems like it corrupted some of the quoting when
saving as a draft]

On Mon, Dec 31, 2018@11:47 PM Ming Lei <ming.lei@redhat.com> wrote:
&gt;
&gt; On Mon, Dec 31, 2018@03:24:55PM -0600, Bjorn Helgaas wrote:
&gt; &gt; On Fri, Dec 28, 2018@9:27 PM Ming Lei <ming.lei@redhat.com> wrote:
&gt; &gt; &gt;
&gt; &gt; &gt; On big system with lots of CPU cores, it is easy to
consume up irq
&gt; &gt; &gt; vectors by assigning defaut queue with
num_possible_cpus() irq vectors.
&gt; &gt; &gt; Meantime it is often not necessary to allocate so many
vectors for
&gt; &gt; &gt; reaching NVMe's top performance under that situation.
&gt; &gt;
&gt; &gt; s/defaut/default/
&gt; &gt;
&gt; &gt; &gt; This patch introduces module parameter of 'default_queues' to try
&gt; &gt; &gt; to address this issue reported by Shan Hai.
&gt; &gt;
&gt; &gt; Is there a URL to this report by Shan?
&gt;
&gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021863.html
&gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021862.html
&gt;
&gt; http://lists.infradead.org/pipermail/linux-nvme/2018-December/021872.html

It'd be good to include this.  I think the first is the interesting
one.  It'd be nicer to have an https://lore.kernel.org/... URL, but it
doesn't look like lore hosts linux-nvme yet.  (Is anybody working on
that?  I have some archives I could contribute, but other folks
probably have more.)

</ming.lei at redhat.com></ming.lei at redhat.com>
> >
> > Is there some way you can figure this out automatically instead of
> > forcing the user to use a module parameter?
>
> Not yet, otherwise, I won't post this patch out.
>
> > If not, can you provide some guidance in the changelog for how a user
> > is supposed to figure out when it's needed and what the value should
> > be?  If you add the parameter, I assume that will eventually have to
> > be mentioned in a release note, and it would be nice to have something
> > to start from.
>
> Ok, that is a good suggestion, how about documenting it via the
> following words:
>
> Number of IRQ vectors is system-wide resource, and usually it is big enough
> for each device. However, we allocate num_possible_cpus() + 1 irq vectors for
> each NVMe PCI controller. In case that system has lots of CPU cores, or there
> are more than one NVMe controller, IRQ vectors can be consumed up
> easily by NVMe. When this issue is triggered, please try to pass smaller
> default queues via the module parameter of 'default_queues', usually
> it have to be >= number of NUMA nodes, meantime it needs be big enough
> to reach NVMe's top performance, which is often less than num_possible_cpus()
> + 1.

You say "when this issue is triggered."  How does the user know when
this issue triggered?

The failure in Shan's email (021863.html) is a pretty ugly hotplug
failure and it would take me personally a long time to connect it with
an IRQ exhaustion issue and even longer to dig out this module
parameter to work around it.  I suppose if we run out of IRQ numbers,
NVMe itself might work fine, but some other random driver might be
broken?

Do you have any suggestions for how to make this easier for users?  I
don't even know whether the dev_watchdog() WARN() or the bnxt_en error
is the important clue.

Bjorn
