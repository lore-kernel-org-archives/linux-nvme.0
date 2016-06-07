From: keith.busch@intel.com (Keith Busch)
Date: Tue, 7 Jun 2016 18:39:09 -0400
Subject: NVMe over Fabrics support for nvme-cli
In-Reply-To: <20160607184248.GE28414@localhost.localdomain>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
 <20160607184248.GE28414@localhost.localdomain>
Message-ID: <20160607223908.GC30120@localhost.localdomain>

On Tue, Jun 07, 2016@02:42:48PM -0400, Keith Busch wrote:
> Happy to get fabrics in now as I have new features I'd like to add very
> soon, and didn't want you to have to rebase again. The new features are
> vendor extentions and json output. I'll post them to the linux-nvme list
> first in case anyone is interested in reviewing.

Not quite ready to my latest, but I pushed it to a different branch here:

  https://github.com/linux-nvme/nvme-cli/tree/experimental

It adds a "--output-format" option that takes normal, json, or binary types.

The main thing though, is support for plugin extensions, and I made LightNVM
and Intel built-in extensions with specifics to their devices.

It also adds support for dynamically loaded plug-ins. This is so a
3rd party or vendor can extend the program without having their stuff
in-tree. It accomplishes this using the dynamic linking loader (dlopen,
dlsym, and friends) to open and register symbols.
