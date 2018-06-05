From: hch@lst.de (hch@lst.de)
Date: Tue, 5 Jun 2018 14:50:36 +0200
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
In-Reply-To: <3c752b110b15ae35dcf772cc350e729d54b2d52b.camel@wdc.com>
References: <20180605082905.1740-1-hare@suse.de>
 <20180605111746.GA5802@lst.de> <20180605142318.7d566c27@pentland.suse.de>
 <3c752b110b15ae35dcf772cc350e729d54b2d52b.camel@wdc.com>
Message-ID: <20180605125036.GB13305@lst.de>

On Tue, Jun 05, 2018@12:35:13PM +0000, Bart Van Assche wrote:
> Is there a standard for AENs over NVMeOF? If so, how many receive buffers
> should the initiator reserve for AENs? Which credit mechanism should be used
> for AEN communication?

Take a look at sections 5.2 and 7.7 of NVMe 1.3.  All that text
actually goes back to 1.0 without major change.
