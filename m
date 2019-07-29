From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 30 Jul 2019 00:05:43 +0200
Subject: [Regression] Commit "nvme/pci: Use host managed power state for
 suspend" has problems
In-Reply-To: <868a042a9422463fa1166653982bb985@AUSX13MPC105.AMER.DELL.COM>
References: <2332799.izEFUvJP67@kreacher> <2428826.VBuqOhikiK@kreacher>
 <20190725195258.GA7307@localhost.localdomain> <15043168.halW6uqc8m@kreacher>
 <D33632F4-E119-4833-816C-79084DA03DE4@canonical.com>
 <CAJZ5v0imsVS-eDB+Lmd5qzAfmb0UpJ5AwV_Vf+v8D21KAtqTOg@mail.gmail.com>
 <868a042a9422463fa1166653982bb985@AUSX13MPC105.AMER.DELL.COM>
Message-ID: <CAJZ5v0gibD_oboFt7x7VjUTe4mw+mZxHcOiFEEcWdw8dUZ5RXw@mail.gmail.com>

On Mon, Jul 29, 2019@5:53 PM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael at kernel.org>
> > Sent: Saturday, July 27, 2019 7:55 AM
> > To: Kai-Heng Feng
> > Cc: Rafael J. Wysocki; Keith Busch; Busch, Keith; Christoph Hellwig; Sagi Grimberg;
> > linux-nvme at lists.infradead.org; Limonciello, Mario; Linux PM; LKML
> > Subject: Re: [Regression] Commit "nvme/pci: Use host managed power state for
> > suspend" has problems
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Fri, Jul 26, 2019 at 4:03 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > >@04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > > On Thursday, July 25, 2019 9:52:59 PM CEST Keith Busch wrote:
> > > >> On Thu, Jul 25, 2019@09:48:57PM +0200, Rafael J. Wysocki wrote:
> > > >>> NVME Identify Controller:
> > > >>> vid     : 0x1c5c
> > > >>> ssvid   : 0x1c5c
> > > >>> sn      : MS92N171312902J0N
> > > >>> mn      : PC401 NVMe SK hynix 256GB
> > > >>> fr      : 80007E00
> > > >>> rab     : 2
> > > >>> ieee    : ace42e
> > > >>> cmic    : 0
> > > >>> mdts    : 5
> > > >>> cntlid  : 1
> > > >>> ver     : 10200
> > > >>> rtd3r   : 7a120
> > > >>> rtd3e   : 1e8480
> > > >>> oaes    : 0x200
> > > >>> ctratt  : 0
> > > >>> oacs    : 0x17
> > > >>> acl     : 7
> > > >>> aerl    : 3
> > > >>> frmw    : 0x14
> > > >>> lpa     : 0x2
> > > >>> elpe    : 255
> > > >>> npss    : 4
> > > >>> avscc   : 0x1
> > > >>> apsta   : 0x1
> > > >>> wctemp  : 352
> > > >>> cctemp  : 354
> > > >>> mtfa    : 0
> > > >>> hmpre   : 0
> > > >>> hmmin   : 0
> > > >>> tnvmcap : 0
> > > >>> unvmcap : 0
> > > >>> rpmbs   : 0
> > > >>> edstt   : 10
> > > >>> dsto    : 0
> > > >>> fwug    : 0
> > > >>> kas     : 0
> > > >>> hctma   : 0
> > > >>> mntmt   : 0
> > > >>> mxtmt   : 0
> > > >>> sanicap : 0
> > > >>> hmminds : 0
> > > >>> hmmaxd  : 0
> > > >>> nsetidmax : 0
> > > >>> anatt   : 0
> > > >>> anacap  : 0
> > > >>> anagrpmax : 0
> > > >>> nanagrpid : 0
> > > >>> sqes    : 0x66
> > > >>> cqes    : 0x44
> > > >>> maxcmd  : 0
> > > >>> nn      : 1
> > > >>> oncs    : 0x1f
> > > >>> fuses   : 0x1
> > > >>> fna     : 0
> > > >>> vwc     : 0x1
> > > >>> awun    : 7
> > > >>> awupf   : 7
> > > >>> nvscc   : 1
> > > >>> acwu    : 7
> > > >>> sgls    : 0
> > > >>> mnan    : 0
> > > >>> subnqn  :
> > > >>> ioccsz  : 0
> > > >>> iorcsz  : 0
> > > >>> icdoff  : 0
> > > >>> ctrattr : 0
> > > >>> msdbd   : 0
> > > >>> ps    0 : mp:6.00W operational enlat:5 exlat:5 rrt:0 rrl:0
> > > >>>           rwt:0 rwl:0 idle_power:- active_power:-
> > > >>> ps    1 : mp:3.80W operational enlat:30 exlat:30 rrt:1 rrl:1
> > > >>>           rwt:1 rwl:1 idle_power:- active_power:-
> > > >>> ps    2 : mp:2.40W operational enlat:100 exlat:100 rrt:2 rrl:2
> > > >>>           rwt:2 rwl:2 idle_power:- active_power:-
> > > >>> ps    3 : mp:0.0700W non-operational enlat:1000 exlat:1000 rrt:3 rrl:3
> > > >>>           rwt:3 rwl:3 idle_power:- active_power:-
> > > >>> ps    4 : mp:0.0070W non-operational enlat:1000 exlat:5000 rrt:3 rrl:3
> > > >>>           rwt:3 rwl:3 idle_power:- active_power:-
> > > >>
> > > >> Hm, nothing stands out as something we can use to determine if we should
> > > >> skip the nvme specific settings or allow D3. I've no other ideas at the
> > > >> moment for what we may check.
> > > >
> > > > Well, do ASPM settings matter here?
> > >
> > > Seems like it's a regression in the firmware.
> > >
> > > The issue happens in version 80007E00 but not version 80006E00.
> >
> > So you mean the NVMe firmware, to be entirely precise.
>
> Yes.
>
> >
> > > I am not sure how to downgrade it under Linux though.
> >
> > Me neither.
>
> I'll ask the storage team to ask Hynix to make both these FW available on LVFS.
> Fwupd can upgrade and downgrade firmware when the binaries are made available.
>
> They could potentially be pulled directly out of the Windows executables too, but I don't
> know how to identify them myself.

Well, thanks, but I'm not quite convinced that the NVMe is the reason
why my 9380 cannot reach SLP_S0 and this is my production system, so
I'd rather not do NVMe firmware downgrade experiments on it. :-)



>
> >
> > > The firmware changelog [1] is very interesting:
> > > - Improves the performance of the solid-state drive (SSD) by distributing
> > > power into the SSD efficiently according to the power state of the system.
> > >
> > > [1]
> > >
> > https://www.dell.com/support/home/us/en/04/drivers/driversdetails?driverid=m
> > cxm8
> >
> > Huh.
> >
> > It looks like something else prevents the PCH on my 9380 from reaching
> > the right state for S0ix, though.  I still need to find out what it
> > is.
