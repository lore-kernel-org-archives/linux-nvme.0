From: bmarzins@redhat.com (Benjamin Marzinski)
Date: Tue, 26 Jan 2016 15:40:35 -0600
Subject: [dm-devel] dm-multipath low performance with blk-mq
In-Reply-To: <20160126160324.GA24665@redhat.com>
References: <569E11EA.8000305@dev.mellanox.co.il>
 <20160119224512.GA10515@redhat.com>
 <20160125214016.GA10060@redhat.com>
 <20160126160324.GA24665@redhat.com>
Message-ID: <20160126214035.GU24960@octiron.msp.redhat.com>

On Tue, Jan 26, 2016@11:03:24AM -0500, Mike Snitzer wrote:
> 
> Christoph, any chance you could rebase your 'nvme-loop.2' on v4.5-rc1?
> 
> Or point me to a branch that is more current...

Failing that, you could try using the null_blk device directly. It
doesn't provide enough information for multipathd to set up a device on
it, but you could manually create one with dmsetup. Without multipathd
you won't get failback working, but it should be good fine for
performance work.

-Ben

> 
> --
> dm-devel mailing list
> dm-devel at redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
