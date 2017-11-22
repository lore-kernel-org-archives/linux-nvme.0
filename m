From: kevin@umd.edu (Kevin M. Hildebrand)
Date: Wed, 22 Nov 2017 12:56:39 -0500
Subject: NVMe array support
Message-ID: <CAJmU7Q=P0cnSU1U0nVu3Tk8_kAajVEra1OWUPxCt8ZD3Qio9cA@mail.gmail.com>

I've got eight Samsung PM1725a NVMe drives I'm trying to combine into
an array to be able to aggregate the performance of having multiple
drives.  My initial experiments have yielded abysmal performance in
most cases.  I've tried creating RAID 0 arrays with MD raid, ZFS, and
a few others and most of the time I'm getting somewhere around the
performance of a single drive, even though I've got more than one.
The only way I can get decent performance is when writing to the array
in direct mode (O_DIRECT).  I've been using fio, fdt, and dd for
running tests.  Has anyone successfully created software arrays of
NVMe drives and been able to get usable performance from them?  The
drives are all in a DELL R940 server, which has 4 Skylake CPUs, and
all of the drives are connected to a single CPU, with full PCI
bandwidth.

Sorry if this isn't the right place to send this message, I'm having a
hard time finding anyone that's doing this.

If anyone's doing this successfully, I'd love to hear more about your
configuration.

Thanks!
Kevin

--
Kevin Hildebrand
University of Maryland
Division of IT
