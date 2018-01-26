From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 26 Jan 2018 06:09:40 -0800
Subject: [LSF/MM TOPIC] nvme multipath parity with dm-multipath
In-Reply-To: <5172fd3f-ce8a-3744-4f49-bf42dc961371@suse.de>
References: <5172fd3f-ce8a-3744-4f49-bf42dc961371@suse.de>
Message-ID: <20180126140940.GA2797@infradead.org>

On Thu, Jan 25, 2018@07:37:58PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> Native NVMe multipathing is missing some features which are required to
> achieve full parity with dm-multipath:
> 
> - Auto discovery (which already will be discussed in another topic)

Doesn't sound like a multi-path topic to me.

> - Failover handling in an all-paths-down scenario: dm-multiath goes to
>   great lengths to ensure that failover _can_ happen; with nvme native
>   multipathing this is only guaranteed if the reconnection timer is
>   still running. Once that expired and the controller is being torn down
>   we have to use userspace interaction to get the connection back, which
>   is not going to work with an all-paths-down scenario

So extend the timer to infinite if you worry about userspace
interactions.

> - The infamous queue_if_no_path setting is missing. Currently we will
>   hold on to every I/O until the connection is re-established, ie
>   the equivalent of queue_if_no_path enabled with dm-multipath.
>   However, for clustered environs we need to transport the I/O error
>   back to the application so that the cluster can failover to another
>   node.

Please send a patch.

> - FC has a fast_io_fail_tmo, which allows the transport to terminate
>   the I/O earlier; we need to check if a similar mechanism is required
>   for nvme.

I already asked for it to be made generic.  Help on implementing it
is welcome.
