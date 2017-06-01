From: keith.busch@intel.com (Keith Busch)
Date: Thu, 1 Jun 2017 08:47:26 -0400
Subject: [PATCH v2 6/8] nvme: provide UUID value to userspace
In-Reply-To: <20170601111750.20880-7-jthumshirn@suse.de>
References: <20170601111750.20880-1-jthumshirn@suse.de>
 <20170601111750.20880-7-jthumshirn@suse.de>
Message-ID: <20170601124726.GF2845@localhost.localdomain>

On Thu, Jun 01, 2017@01:17:48PM +0200, Johannes Thumshirn wrote:
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

Sorry for the naming clash. Not sure why I didn't use the obvious name
for this file in the first place.

FWIW, tools should have been using the 'wwid' attribute, which returns
either EUI64 or NGUID so a unique identifier can be gotten from a
single file without checking for the existence of either. That should
help not break backward compatibility, but I've no idea if anything
actually relies on 'uuid' returning the NGUID.
