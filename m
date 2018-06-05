From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 5 Jun 2018 12:35:13 +0000
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
In-Reply-To: <20180605142318.7d566c27@pentland.suse.de>
References: <20180605082905.1740-1-hare@suse.de>
 <20180605111746.GA5802@lst.de> <20180605142318.7d566c27@pentland.suse.de>
Message-ID: <3c752b110b15ae35dcf772cc350e729d54b2d52b.camel@wdc.com>

On Tue, 2018-06-05@14:23 +0200, Hannes Reinecke wrote:
> On Tue, 5 Jun 2018 13:17:46 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> > And what updates the state once all your inaccessible or change
> > state groups become optimized?
> 
> ANA AENs?
> Someone told me we should rely on ANA AENS or the system is hosed
> anyway :-)

Is there a standard for AENs over NVMeOF? If so, how many receive buffers
should the initiator reserve for AENs? Which credit mechanism should be used
for AEN communication?

Thanks,

Bart.
