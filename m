From: kernel@jbeekman.nl (Jethro Beekman)
Date: Mon, 20 Jun 2016 11:24:24 -0700
Subject: [PATCH 0/2] Add Opal unlock support to NVMe.
In-Reply-To: <20160426213349.GA17078@intel.com>
References: <20160426213349.GA17078@intel.com>
Message-ID: <576834D8.9050101@jbeekman.nl>

On Tue Apr 26 14:33:49 PDT 2016, Rafael Antognolli wrote:
>> > I think the OPAL code should be a generic library outside the NVMe
>> > code so that we can use it for SATA and SAS as well, just with a
>> > little glue code for the Security Send / Receive commands to wire
>> > it up to NVMe.
>> 
>> NVDIMMs would benefit from that as well.
> 
> Yes, I can definitely change it to be that generic.

Hi Rafael,

Did you make any progress making this generic? I ran into the same thing for ATA
security:

  http://lists.infradead.org/pipermail/linux-nvme/2016-June/005116.html

I think the kernel would benefit from some sort of generic drive security state
tracker. Would you like to join forces on this?

Jethro Beekman
