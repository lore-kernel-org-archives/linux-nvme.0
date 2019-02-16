From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 15 Feb 2019 17:01:41 -0800
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
In-Reply-To: <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
 <1550266894.31902.104.camel@acm.org>
 <11A6C7D0-A26D-410F-8EE3-9AF524DF2050@nutanix.com>
Message-ID: <1550278901.31902.109.camel@acm.org>

On Sat, 2019-02-16@00:53 +0000, Felipe Franciosi wrote:
> On Feb 15, 2019,@9:41 PM, Bart Van Assche <bvanassche@acm.org> wrote:
> > On Fri, 2019-02-15@21:19 +-0000, Felipe Franciosi wrote:
> > > Hi All,
> > > 
> > > I'd like to attend LSF/MM this year and discuss the kernel performance when accessing NVMe devices, specifically (but not limited to) Intel Optane Memory (which boasts very low latency and high
> > > iops/throughput per NVMe controller).
> > > 
> > > Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. For hypervisors, where storage devices can be exclusively accessed with
> > > userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient. That remains true even in the latest versions of
> > > the
> > > kernel.
> > > 
> > > I have presented work focusing on hypervisors in several conferences during this time. Although I appreciate the LSF/MM is more discussion-oriented, I am linking a couple of these presentations
> > > for
> > > reference:
> > > 
> > > Flash Memory Summit 2018
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__www.flashmemorysummit.com_English_Collaterals_Proceedings_2018_20180808-5FSOFT-2D202-2D1-5FFranciosi.pdf&d=DwICgQ&c=s883GpUCOChKOHiocYtGcg&r=
> > > CCrJKVC5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk&m=gpN7ZCCTDgrYuN3cZ0TceD2QUDAUeJEnwR0A-OUNju4&s=adckJANXPcBu177wFlVmO4pB3jPFZOdggibVfmLERr8&e=
> > > 
> > > Linux Piter 2018
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__linuxpiter.com_system_attachments_files_000_001_558_original_20181103-5F-2D-5FAHV-5Fand-5FSPDK.pdf&d=DwICgQ&c=s883GpUCOChKOHiocYtGcg&r=CCrJKV
> > > C5zGot8PrnI-iYe00MdX4pgdQfMRigp14Ptmk&m=gpN7ZCCTDgrYuN3cZ0TceD2QUDAUeJEnwR0A-OUNju4&s=TdfWF887BHpEvwQ__kNNTFNe1uaKoIjDZ-gW4qr6UxE&e=
> > > 
> > > For LSF/MM, instead of focusing on hypervisors, I would like to discuss what can be done to achieve better efficiency and performance when using the kernel. My data include detailed results
> > > considering various scenarios like different NUMA configurations, IRQ affinity and polling modes.
> >  
> > Hi Felipe,
> > 
> > It seems like you missed the performance comparison between SPDK and io_uring
> > Jens posted recently?
> 
> I configured 5.0-rc6 and had a look at the io_uring code. Finally worked out how to use FIO's t/io_uring to submit IO and poll completions without system calls. My _initial_ numbers still show SPDK
> being faster and more efficient.
> 
> Searching the lists, I found a few mentions that Jens published a comparison stating otherwise, but I can't find it. Could you please give me some pointers?

Hi Felipe,

This is probably what you are looking for:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe at kernel.dk/

Bart.
