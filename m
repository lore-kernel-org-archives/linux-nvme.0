From: kbusch@kernel.org (Keith Busch)
Date: Wed, 15 May 2019 08:14:48 -0600
Subject: [RFC/PATCH nvme-cli] nvme list- separate controllers from
 namespaces
In-Reply-To: <EB8F1E865882C64ABCEDE282942116B98F467B@FMSMSX102.amr.corp.intel.com>
References: <EB8F1E865882C64ABCEDE282942116B98F467B@FMSMSX102.amr.corp.intel.com>
Message-ID: <20190515141448.GA21433@localhost.localdomain>

On Wed, May 01, 2019@08:09:55PM +0000, Tay, Kelly wrote:
> Separated controllers from namespaces on nvme list
> -controller that is not enumerating namespaces is still represented to resolve confusion around missing devices
> -prevents duplicate printing of data
> 
> Signed-off-by: Kelly Tay <kelly.tay at intel.com>

The only problem is that we've lost the serial number on the namespace
output, and since multipathing naming conventions doesn't mean
/dev/nvme0 is the controller for namespace /dev/nvme0n1, it is just
going to be that much more confusing for people to match up which
namespace goes with which controller.

I'd still like to take this anyway, but I may have to make some
modifications on top of this. Perhaps a ',' separate lest of controllers
that go with the namespace would be okay.
