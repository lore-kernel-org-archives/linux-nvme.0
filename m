From: keith.busch@intel.com (Keith Busch)
Date: Tue, 8 Dec 2015 00:00:29 +0000
Subject: [PATCH] NVMe: Export NVMe attributes to sysfs group
In-Reply-To: <20151207233112.GB26585@infradead.org>
References: <1449530455-25485-1-git-send-email-keith.busch@intel.com>
 <20151207233112.GB26585@infradead.org>
Message-ID: <20151208000029.GC31067@localhost.localdomain>

On Mon, Dec 07, 2015@03:31:12PM -0800, Christoph Hellwig wrote:
> We really need to expose the NGUID on the namespace at the same time.
> Otherwise people will use this information to incorrectly provide a
> serial number of the block devices in udev because not better
> information is available.

I'm planning to tackle that next. NGUID can not be in the same attribute
group. It needs to be in a new namespace group instead.

Right now all I got is the NGUID/EUI64. Any opinion on what to name the
attribute? I was going with "id". The systemd developers didn't provide
a very strong opinion, and I think they were confusing "serial" as a
unique identifier.

While I'm in this area, are there other namespace attributes anyone is
interested in exposing?
