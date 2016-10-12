From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 12 Oct 2016 10:18:05 -0700
Subject: [PATCH 2/3] fine tune the nvme-discover manpage
In-Reply-To: <1476261953-23119-3-git-send-email-hch@lst.de>
References: <1476261953-23119-1-git-send-email-hch@lst.de>
 <1476261953-23119-3-git-send-email-hch@lst.de>
Message-ID: <1476292685.5410.67.camel@linux.intel.com>

On Wed, 2016-10-12@10:45 +0200, Christoph Hellwig wrote:

(Email bounce, re-sending)

> ?- remove the device argument, which as far as I can tell does not
> ???exist.
> ?- mention the /etc/nvme/hostnqn file, the default host nqn and
> explain
> ???host nqns a bit more
> ?- mention the loopback transport
> ?- be a bit more specific about IP addressing as a concept separate
> from
> ???the RDMA transport
> ?- improve the introduction a bit.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
> ?Documentation/nvme-discover.txt | 37 ++++++++++++++++++++++---------
> ------
> ?1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/nvme-discover.txt b/Documentation/nvme-
> discover.txt
> index 9140f84..96c21f6 100644
> --- a/Documentation/nvme-discover.txt
> +++ b/Documentation/nvme-discover.txt
> @@ -3,12 +3,12 @@ nvme-discover(1)
> ?
> ?NAME
> ?----
> -nvme-discover - Send Get Log Page request to Discovery Controller.
> +nvme-discover - Send Discovery requests to Fabrics Discovery
> Controllers.

I preferred mentioning "Get Log Page" because that is really what is
happening and reflects the NVMe specification, which I was aiming to
push the envelope a bit and help educate and accelerate the learning
curve for people new to these features (map more accurately what is
being described here to the NVMe specification(s).

> ?
> ?SYNOPSIS
> ?--------
> ?[verse]
> -'nvme discover'	[device]
> +'nvme discover'

It was there because nvme-cli works regardless if a device parameter is
there or not (such as /dev/nvme-fabrics/).??Granted it seems a bit
pointless to include it if the same correct behavior works without it,
but it made it common with the rest of the nvme-cli command man pages.

> ?		[--transport=<trtype> | -t <trtype>]
> ?		[--traddr=<traddr>????| -a <traddr>]
> ?		[--trsvcid=<trsvcid>??| -s <trsvcid>]
> @@ -17,17 +17,18 @@ SYNOPSIS
> ?
> ?DESCRIPTION
> ?-----------
> -For a given NVMe Host, send a Discovery Get Log Page request
> -to a Discovery Controller on the network.
> -
> -The [device] parameter is OPTIONAL and will default to
> -/dev/nvme-fabrics if none is given.
> +Send one or more Discovery requests to a NVMe over Fabrics Discovery
> +Controller.

Same blurb on what I said earlier for mentioning "Get Log Page".

> ?
> ?If no parameters are given, then 'nvme discover' will attempt to?
> -find a /etc/nvme/discovery.conf file to use to supply the
> -the discover command options.??If no /etc/nvme/discovery.conf file
> +find a /etc/nvme/discovery.conf file to use to supply a list of
> +Discovery commands to run.??If no /etc/nvme/discovery.conf file
> ?exists, the command will quit with an error.
> ?
> +Otherwise a specific Discovery Controller should be specified using
> the
> +--transport, --traddr and if nessecary the --trsvcid and a Di?covery
> +request will be sent to the specified Discovery Controller.
> +

This is unnecessary to be mentioning the flags here when they have
already been mentioned and shown in "SYNOPSIS" as well as described in
detail below with examples provided after that.??This isn't adding much
additional value and making this slightly harder to maintain if flags
are added/adjusted.

(necessary is misspelled btw).

> ?BACKGROUND
> ?----------
> ?The NVMe-over-Fabrics specification defines the concept of a?
> @@ -61,23 +62,29 @@ OPTIONS
> ?|Value|Definition
> ?|rdma|The network fabric is an rdma network (RoCE, iWARP,
> Infiniband, basic rdma, etc)
> ?|fc??|*WIP* The network fabric is a Fibre Channel network.
> +|loop|Connect to a NVMe over Fabrics target on the local host

Flat out missed that, good catch.

> ?|=================
> ?
> ?-a <traddr>::
> ?--traddr=<traddr>::
> ?	This field specifies the network address of the Discovery
> Controller.
> +	For transports using IP addressing (e.g. rdma) this should
> be an IPv4
> +	address.

We shouldn't be mentioning that this can be specifically a IPv4 address
when there has already been work to support an IPv6 address (for
example) and then this will have to be tweaked again.??I think the
explanation was fine the way it is and should be explained generically
that leaves out specific mentions of IPv4 (plus the examples provided
afterword show using an IPv4 address).

> ?
> ?-s <trsvcid>::
> ?--trsvcid=<trsvcid>::
> -	This field specifies the transport service id.??For IP
> addresses,
> -	this field is the port number. By default, the IP port
> number
> -	is 4420.
> +	This field specifies the transport service id.??For
> transports using IP
> +	addressing (e.g. rdma) this field is the port number. By
> default, the IP
> +	port number for the RDMA transport is 4420.
> ??

This is a little more clear.

> ?-q <hostnqn>::
> ?--hostnqn=<hostnqn>::
> -	This field is the unique NQN of a NVMe Host. This field
> -	will be used by the Discovery Controller to check what NVMe
> -	Target resources are allocated to the NVMe Host for a
> connection.
> +	Overrides the default host NQN that identifies the NVMe
> Host.??If this
> +	option is not specified the default is read from
> /etc/nvme/hostnqn or
> +	autogenerated by the kernel (in that order).

Good start, but I can see an interpretation that this can make it sound
like the kernel will autogenerate hostnqn if this parameter is not
supplied, which would be incorrect because it's already generated upon
NVMe Host module load to be used as a 'catch-all default'.??I think a
further tweak to this could be:

"If this option is not specified, the default is read from
/etc/nvme/hostnqn first and if that does not exist, the autogenerated
NQN value from the NVMe Host kernel module is used next."

> +	The Host NQN uniquely identifies the NVMe Host, and may be
> used by the
> +	the Discovery Controller to control what NVMe Target
> resources are
> +	allocated to the NVMe Host for a connection.

This sounds like it could go in the BACKGROUND section I wrote, which I
admit I didn't not state this as clearly as here, but then again it's
probably ok to keep this blurb here to re-emphasize this important
feature of NVMe devices.

> ?
> ?-r <filename>::
> ?--raw=<filename>::
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
