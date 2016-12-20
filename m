From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 20 Dec 2016 10:52:41 -0700
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161220154639.GA16393@infradead.org>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
 <20161220061744.GB4765@infradead.org>
 <20161220154916.GC10634@localhost.localdomain>
 <20161220154639.GA16393@infradead.org>
Message-ID: <20161220175239.GA2426@sbauer-Z170X-UD5>

On Tue, Dec 20, 2016@07:46:39AM -0800, Christoph Hellwig wrote:
> On Tue, Dec 20, 2016@10:49:16AM -0500, Keith Busch wrote:
> > On Mon, Dec 19, 2016@10:17:44PM -0800, Christoph Hellwig wrote:
> > > As far as I can tell Security Send / Receive has always been intended to
> > > apply to the whole controller, even if that's something I would not
> > > personally think is a good idea.
> > 
> > NVMe security commands required the namespace ID since the very
> > beginning. It's currently documented in figure 42 of section 5,
> > "Namespace Identifier Used" column.
> 
> Oh, for some reason I read a no there when looking it up.
> Good to know, although TCG spec still seem to ignore it.

Before I submit another version I want to address a few design issues we seem
to be walking around a bit:

The other reviews you gave for the series are fine and will be implemented,
thank you for that.

The main development issue seems to be how the drivers/block layer interact
with the core sed.

1) We will move the core from lib/ back to block/ and add CONFIGS in kconfig.

2) Do we want to continue passing around a sed_context to the core? Instead of
   a block_device struct like we did in previous versions.

 2a) If we do wish to do wish to continue passng sed_contexts to the core I
 have to add a new variable to the block_device structure for our sed_context.
 Will this be acceptable? It wasn't acceptable for the file struct. The reason
 I need a new variable in the struct is:
 On the ioctl path, if we intercept the SED call in the block layer ioctl and
 have the call chain be:
 uland -> blk_ioctl -> sed_ioctl() -> sedcore -> sec_send/recv -> nvme
 then I need to be able to pass a sed_ctx struct in blk_ioctl to sed-ioctl and
 the only  way is to have it sitting in our block_device structure.

 The other way which was sorta nack'd last time is the following call chain:
 uland -> blk_ioctl -> nvme_ioctl -> sed_ioctl -> sedcore -> send/rcv -> nvme

 In this call chain in nvme_ioctl we have access to our block device struct
 and from there we can do blkdev->bd_disk->private_data to get our ns and then
 eventually our sed_ctx to pass to sed_ioctl. I could add the ns to the sec_data
 pointer in sed_context. This would give us access to ns without having to pass
 around a block device or store it anywhere.

 In the first scenario I can't work at all with opaque pointers like we can in
 the drivers itself (private_data). I don't know what they are, the drivers have
 the domain knowledge of what type they actually stored in private_data. That's
 why I need an explicit member in the block_device for the first scenario.

3) For NVMe we need access to our ns ID. It's in the block_device behind a few
pointers. What I can do is if we want to continue with the first ioctl path
described above is something like:

sed_ioctl(struct block_device *bdev, ...)
{
  sed_context *ctx = bdev->sed_ctx;
  ctx->sed_data = bdev->bd_disk->private_data;
  switch(cmd) {
  ...
  ...
  return some_opal_cmd(ctx);
  }
}

While this works for NVMe I don't know if this is acceptible for *all* users.
Since this is in a generic ioctl that is supposed to work with all drivers, who
knows what the hell they're putting in private_data and whether its useful for
their implementation of sec_send/recv.

I think that's all I have for now. If I think of anything throughout the day I'll
reply to to this email.
