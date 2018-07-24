From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 24 Jul 2018 14:25:41 +0000
Subject: data corruption with 'splt' workload to XFS on DM cache with its
 3 underlying devices being on same NVMe device
In-Reply-To: <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
References: <20180723163357.GA29658@redhat.com>
 <e761830f-e3f7-3e88-1697-b4b150e84e5f@suse.de>
Message-ID: <bc63227473a19cb23d6b2bb38eefa564dfec1ffc.camel@wdc.com>

On Tue, 2018-07-24@08:00 +0200, Hannes Reinecke wrote:
> So, have you tested that request-based multipathing works on a partition 
> _at all_? I'm not sure if partition mapping is done correctly here; we 
> never remap the start of the request (nor bio, come to speak of it), so 
> it looks as if we would be doing the wrong things here.
> 
> Have you checked that partition remapping is done correctly?

I think generic_make_request() takes care of partition remapping by calling
blk_partition_remap(). generic_make_request() is called by submit_bio(). Is
that sufficient to cover all dm drivers?

Bart.
