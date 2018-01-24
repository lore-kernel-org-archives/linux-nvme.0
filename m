From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Jan 2018 15:47:12 -0700
Subject: Report long suspend times of NVMe devices (mostly
 firmware/device issues)
In-Reply-To: <fd0eb2c3-56c3-0e81-cfba-1ffa6a872efd@molgen.mpg.de>
References: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>
 <20180122213024.GR12043@localhost.localdomain>
 <fd0eb2c3-56c3-0e81-cfba-1ffa6a872efd@molgen.mpg.de>
Message-ID: <20180124224711.GF14790@localhost.localdomain>

On Wed, Jan 24, 2018@11:29:12PM +0100, Paul Menzel wrote:
> Am 22.01.2018 um 22:30 schrieb Keith Busch:
> > The nvme spec guides toward longer times than that. I don't see the
> > point of warning users about things operating within spec.
> 
> I quickly glanced over NVM Express revision 1.3 specification [1] but
> searching for *second *, I could not find something about this. Could you
> please point me to the section?

Section 7.6.2:

  It is recommended that the host wait a minimum of the RTD3 Entry
  Latency reported in the Identify Controller data structure for the
  shutdown operations to complete; if the value reported in RTD3 Entry
  Latency is 0h, then the host should wait for a minimum of one second.

So if the controller is new enough, it will report it's RTD3 Entry.
The maximum allowed by spec is something like 4000 seconds.

For controllers that pre-date this field, we're supposed to wait a
"minimum" of one second.

The spec does not recommend a maximum time in either case.

> In my opinion, it?s a good thing to point users to devices holding up
> suspend.

If a device shutdown exceeds its reported constraints, then absolutely,
and we do log a warning for that already.

Picking an arbitrary time below spec recommendations is just guaranteed
to create alarmed people demanding answers to a warning about behavior
that is entirely normal.
