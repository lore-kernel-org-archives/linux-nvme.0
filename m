From: kbusch@kernel.org (Keith Busch)
Date: Fri, 24 May 2019 17:30:14 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <1825f9cf-fa66-4232-12f9-3e27c73a7395@grimberg.me>
References: <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain>
 <yq17eaqbg4c.fsf@oracle.com>
 <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>
 <20190521143540.GB1639@localhost.localdomain>
 <ccd37b33-6fa3-8435-9ac4-9c62f4525c1a@grimberg.me>
 <20190524140753.GC15192@localhost.localdomain>
 <fe7bd12e-99ac-e038-f096-7697186051d7@grimberg.me>
 <ae685e0e-8ae2-dca3-844f-fd3147847447@mellanox.com>
 <1825f9cf-fa66-4232-12f9-3e27c73a7395@grimberg.me>
Message-ID: <20190524233014.GC17343@localhost.localdomain>

On Fri, May 24, 2019@04:23:36PM -0700, Sagi Grimberg wrote:
> 
> > Sagi,
> > 
> > my original patch showed the namespaces and not the mpath device since I
> > developed it in non mpath environment.
> > 
> > Afterwards, Keith asked me to test it on mpath env and I changed my V1
> > to show the mpath device (in case of mpath configuration) and "IO-ble"
> > block device in case of non mpath configuration.
> > 
> > I thought that this was Keith intention but afterwards we agreed to
> > print the "IO-ble" namespace in all the cases (Also Christoph agreed on
> > that).
> 
> What's IO-ble?

Just means "not hidden".
 
> > So I'll update the patchset to show always the "IO-ble" namespace and
> > not mpath slaves that a user can't do anything interested with them.
> 
> But a namespace in a multipath environment is not associated with a
> controller. I don;t understand how you can display that without
> confusing the user even more.
>
> Unless they are not nested under controllers but under subsystems, that
> is fine, and aligned with the spec.

The virtual device "head" is associated with a subsystem where its
device names comes from, but that head has namespace paths, which are
controllers, and this is just showing that topology.

It would not make sense to nest the block device names under the
subsystem because the substem may have many paths/controllers, but the
namespaces are accessible only under a subset of those paths.
