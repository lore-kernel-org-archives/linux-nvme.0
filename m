From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 09:17:23 -0700
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190524140753.GC15192@localhost.localdomain>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain> <yq17eaqbg4c.fsf@oracle.com>
 <040beeb5-d328-d5b0-f165-51bbd40f4c23@mellanox.com>
 <20190521143540.GB1639@localhost.localdomain>
 <ccd37b33-6fa3-8435-9ac4-9c62f4525c1a@grimberg.me>
 <20190524140753.GC15192@localhost.localdomain>
Message-ID: <fe7bd12e-99ac-e038-f096-7697186051d7@grimberg.me>


>> Your use-case was "I want to understand what is my controller for
>> /dev/nvme0n1". This information is already available in nvme list
>> subsys. Why do you need the mpath-slave devices listed as well?
> 
> The current 'list-subsys' does not show us any namespaces, actually.
> You have to dig through sysfs on your own to see which namespaces belong
> to which controllers, but Max has added a more user friendly way to
> view this.

I was referring to your example in the change log:
"For example,
I want to format /dev/nvme0n1 and /dev/nvme0n2, so I'll run:

   # nvme format /dev/nvme0

to hit up all namespaces attached to nvme0. The problem is that nvme0's
namespaces may not even be those desired namespaces, and now I've lost
data on devices I wished to preserve."

You can still run: nvme list-subsys for each namespace and understand
which controller contains each volume so you can format correctly.

I personally think that this display, while more informative, is not
intuitive to read, mainly because we don't get a display of the mapping
between the mpath and slave devices.

Maybe for starters, when passing a namespace handle to list-subsys, the
output should display only the slave devices from each controller.
