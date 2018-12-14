From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Dec 2018 07:41:59 -0700
Subject: Find Allocation Unit Size
In-Reply-To: <CAHkw+LdJZD6Z3BgSve-Sg2FyrNZ9iaBw1RUehS7o+2mTEpWCjA@mail.gmail.com>
References: <CAHkw+LdJZD6Z3BgSve-Sg2FyrNZ9iaBw1RUehS7o+2mTEpWCjA@mail.gmail.com>
Message-ID: <20181214144159.GB13491@localhost.localdomain>

On Fri, Dec 14, 2018@01:39:42AM -0500, Marc Smith wrote:
> Hi,
> 
> I'm testing some NVMe drives, and playing with creating multiple
> namespaces (via the nvme CLI tool). I've noticed with some values,
> there is rounding that is occurring (or so I assume). I'm using a 4096
> block size, and with values like 200 GiB or 1000 GiB I do not see the
> rounding occur (checking value in bytes against unvmcap after
> creation).
> 
> But other values do seem to round... I suspect this is aligning to the
> allocation unit size, but I'm not sure where to find that value for my
> NVMe drives? Hoping someone could point me in the right direction!
> 
> Thanks in advance.

The spec says a device may have a minimal size granularity for creating
namespaces, but currently doesn't provide a way to discover what that is.`
