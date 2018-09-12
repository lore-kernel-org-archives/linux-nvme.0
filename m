From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 12 Sep 2018 20:13:30 +0200
Subject: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
Message-ID: <20180912181330.GC15031@kroah.com>

On Wed, Sep 12, 2018@05:08:52PM +0200, Arnd Bergmann wrote:
> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
> 
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
> 
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
> 
> Signed-off-by: Arnd Bergmann <arnd at arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh at linuxfoundation.org>
