From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 16:23:36 -0700
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <ae685e0e-8ae2-dca3-844f-fd3147847447@mellanox.com>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain> <yq17eaqbg4c.fsf@oracle.com>
 <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>
 <20190521143540.GB1639@localhost.localdomain>
 <ccd37b33-6fa3-8435-9ac4-9c62f4525c1a@grimberg.me>
 <20190524140753.GC15192@localhost.localdomain>
 <fe7bd12e-99ac-e038-f096-7697186051d7@grimberg.me>
 <ae685e0e-8ae2-dca3-844f-fd3147847447@mellanox.com>
Message-ID: <1825f9cf-fa66-4232-12f9-3e27c73a7395@grimberg.me>


> Sagi,
> 
> my original patch showed the namespaces and not the mpath device since I 
> developed it in non mpath environment.
> 
> Afterwards, Keith asked me to test it on mpath env and I changed my V1 
> to show the mpath device (in case of mpath configuration) and "IO-ble" 
> block device in case of non mpath configuration.
> 
> I thought that this was Keith intention but afterwards we agreed to 
> print the "IO-ble" namespace in all the cases (Also Christoph agreed on 
> that).

What's IO-ble?

> So I'll update the patchset to show always the "IO-ble" namespace and 
> not mpath slaves that a user can't do anything interested with them.

But a namespace in a multipath environment is not associated with a
controller. I don;t understand how you can display that without
confusing the user even more.

Unless they are not nested under controllers but under subsystems, that
is fine, and aligned with the spec.

>> Maybe for starters, when passing a namespace handle to list-subsys, the
>> output should display only the slave devices from each controller.
> 
> I see "nvme list-subsys" as "nvme list" (without any params passed). I 
> don't see why one will pass namespace handle to it.

Because the user wants to be able to associate controller(s) with
namespaces (which is exactly what keith listed in the change log!).

That user could have simply run: 'nvme list-subsys /dev/nvme0n1' and it
would immediately be able to associate the controller to format.

Overall, I don't understand what this display is buying us.
