From: keith.busch@intel.com (Keith Busch)
Date: Mon, 14 Jan 2019 11:02:07 -0700
Subject: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52 some
 day
In-Reply-To: <20190114170338.GA27149@localhost.localdomain>
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
 <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com>
 <20190114170338.GA27149@localhost.localdomain>
Message-ID: <20190114180207.GC27149@localhost.localdomain>

[+linux-nvme at lists.infradead.org]

On Mon, Jan 14, 2019@10:03:39AM -0700, Keith Busch wrote:
> [+Ming]
> On Mon, Jan 14, 2019@08:31:45AM -0600, Bjorn Helgaas wrote:
> > [+cc Dou, Jens, Thomas, Christoph, linux-pci, LKML]
> > 
> > On Sun, Jan 13, 2019@11:24 PM fin4478 fin4478 <fin4478@hotmail.com> wrote:
> > >
> > > Hi,
> > >
> > > A regression from the 4.20 kernel: I have the Asgard 256GB nvme drive
> > > and my custom non debug 1000Hz timer kernel 5.0 started to throw a
> > > couple of warning messages at boot. My system works ok:
> 
> I think Ming's patch here fixes this:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2019-January/021902.html

User fin4478 <fin4478 at hotmail.com> informs me Ming's patch above fixes
the warnings, but responding to the mailing lists from that email account
are blocked for "security or policy reasons" and requested I forward
the successful test result.

Christoph, Jens: may we queue this up for -rc3?
