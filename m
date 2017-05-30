From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 May 2017 11:30:03 +0200
Subject: [PATCH 7/7] nvme: provide UUID value to userspace
In-Reply-To: <e850e7d9548348ae46c82230a7077c89073e80f3.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <e850e7d9548348ae46c82230a7077c89073e80f3.1496131397.git.jthumshirn@suse.de>
Message-ID: <20170530093003.GD16736@lst.de>

On Tue, May 30, 2017@10:08:22AM +0200, Johannes Thumshirn wrote:
> Now that we have a way for getting the UUID from a target, provide it
> to userspace as well.
> 
> Unfortunately there is already a sysfs attribute called UUID which is
> a misnomer as it holds the NGUID value. So instead of creating yet
> another wrong name, create a new 'nguid' sysfs attribute for the
> NGUID. For the UUID attribute add a check wheter the namespace has a
> UUID assigned to it and return this or return the NGUID to maintain
> backwards compatibility. This should give userspace a chance to catch
> up.

Eww.  This looks pretty sketchy and at least needs a good comment in
the source.  Maybe even a printk_ratelimited warning.
