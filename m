From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Feb 2018 07:53:46 -0700
Subject: coalescing in polling mode in 4.9
In-Reply-To: <20180210130817.df352d4336ae0e80ae1755cb@gmail.com>
References: <20180202001028.fee27cf239e3e8a5ae6bd8a4@gmail.com>
 <CGME20180205145924epcas3p2f8156043ec00b51c135ac62c1fa177d7@epcas3p2.samsung.com>
 <20180205150253.GN24417@localhost.localdomain>
 <7d378937-1859-0007-12b3-ca1722d2a5c3@samsung.com>
 <20180205213945.303b3a69a7048d94cecac599@gmail.com>
 <41246a55-9ecc-72e1-c51e-f04195ca35ed@samsung.com>
 <20180210130817.df352d4336ae0e80ae1755cb@gmail.com>
Message-ID: <20180212145346.GB16255@localhost.localdomain>

On Sat, Feb 10, 2018@01:08:17PM -0800, Alex Nln wrote:
> It is quite strange model of IO processing: polling with interrupts. 
> Shouldn't these two be mutual exclusive? Why not to disable
> interrupts at all on a queue while polling?

That's a valid point. There are some limitations preventing this at the
moment. The nvme driver currently does not have a way to know the command
it is submitting is intended to be polled, and if it did, we still need
to determine a policy for creating special queue or queues that have
interrupts disabled and how we register these with the block layer.
