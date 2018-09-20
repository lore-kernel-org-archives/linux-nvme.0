From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 20 Sep 2018 09:22:08 -0600
Subject: [PATCH 0/6] nvme-cli: fixup large log page transfer
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920152207.GB30677@localhost.localdomain>

On Thu, Sep 20, 2018@11:09:33AM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> on large installations the MDTS value might prevent the controller to
> transfer the entire log page in one go. This patchset updates nvme_get_log()
> to retrieve the log page in 4k chunks so as having to avoid checking the
> MDTS value.

That looks good. Shoudn't matter for most pages since only a few may
exceed 4k.

> I've also added an 'rae' field to nvme_get_log() to avoid it accidentally
> clearing outstanding AENs.

Thanks for setting that up!

> And the seagate plugin has been cleaned up :-)

I think that code must have been ported from an internal project. :)

> As usual, comments and reviews are welcome.

Looks good to me. Patches applied.
