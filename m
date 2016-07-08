From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Jul 2016 12:06:36 -0400
Subject: NVME Power State Modification
In-Reply-To: <1467935716944.14813@edt.com>
References: <1467935716944.14813@edt.com>
Message-ID: <20160708160635.GA26619@localhost.localdomain>

On Thu, Jul 07, 2016@11:55:17PM +0000, Haleigh Novak wrote:
> I am currently working with the nvme power states - I need to keep everything in the nvme module,?and I have a couple of questions:?

What do you want the module to do with power states, and when do you
want it to change the states?
 
> (1) Is it actually?possible to modify the power states of the nvme?

If you are just trying to test how the device responds, you can issue
the set feature command from user space.
