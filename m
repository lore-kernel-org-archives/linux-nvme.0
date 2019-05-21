From: kbusch@kernel.org (Keith Busch)
Date: Tue, 21 May 2019 08:58:40 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <55f15756-0385-f9c4-a916-079a6b12a5c1@mellanox.com>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain>
 <yq17eaqbg4c.fsf@oracle.com>
 <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>
 <20190521143540.GB1639@localhost.localdomain>
 <55f15756-0385-f9c4-a916-079a6b12a5c1@mellanox.com>
Message-ID: <20190521145840.GC1639@localhost.localdomain>

On Tue, May 21, 2019@05:51:25PM +0300, Max Gurtovoy wrote:
> 
> On 5/21/2019 5:35 PM, Keith Busch wrote:
> > On Tue, May 21, 2019@02:54:53AM -0700, Max Gurtovoy wrote:
> > > maybe we can improve it and print also the namespace during the "nvme
> > > list-subsys" command.
> > > 
> > > something like:
> > > 
> > > [root at server50 ~]# nvme list-subsys
> > > nvme-subsys0 - NQN=testsubsystem_0
> > > \
> > >   ?+- nvme0 rdma traddr=11.212.140.146 trsvcid=4420
> > >   ?\
> > >   ? +- nvme0n1 SN=cf8bbff661502c51 Model=Linux
> > >   ? +- nvme0n2 SN=cf8bbff661502c51 Model=Linux
> > > 
> > > 
> > > and we'll get subsys/ctrl/ns relations in 1 cmd.
> > > 
> > > thoughts ?
> > Yes, this is very useful! I'd like to add this as soon as possible.
> > Do you have a patch, or is this just an example?  The only change I'd
> > recommend is remove SN and Model since those are controller properties
> > rather than from the namespace.
> 
> This is just an example but I can prepare something in a couple of days.
> 
> Let me know what do you prefer (and which attrs to print there)

Let's just get the namespace handles (ex nvme0n1) displaying with each
of their controllers within a subsystem. Showing just this relationship
will be immediately helpful. We can can add verbose flags to get more
details in the future.
