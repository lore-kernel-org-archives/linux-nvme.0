From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Tue, 23 May 2017 19:56:13 +0000
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
 <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>
Message-ID: <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>

> -----Original Message-----
> From: Andy Lutomirski [mailto:luto at kernel.org]
> Sent: Tuesday, May 23, 2017 2:35 PM
> To: Kai-Heng Feng <kai.heng.feng at canonical.com>
> Cc: Christoph Hellwig <hch at infradead.org>; Andrew Lutomirski
> <luto at kernel.org>; linux-nvme <linux-nvme at lists.infradead.org>; Limonciello,
> Mario <Mario_Limonciello at Dell.com>
> Subject: Re: NVMe APST high latency power states being skipped
> 
> On Tue, May 23, 2017 at 1:06 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Tue, May 23, 2017 at 3:17 PM, Christoph Hellwig <hch at infradead.org>
> wrote:
> >> On Mon, May 22, 2017@05:04:15PM +0800, Kai-Heng Feng wrote:
> >>> Hi Andy,
> >>>
> >>> Currently, if a power state tradition requires high latency, it may be
> >>> skipped [1] based on the value of ps_max_latency_us in
> >>> nvme_configure_apst():
> >>>
> >>> if (total_latency_us > ctrl->ps_max_latency_us)
> >>>     continue;
> >>>
> >>> Right now ps_max_latency_us defaults to 25000, but some consumer level
> >>> NVMe have much higher latency.
> >>> I understand this value is configurable, but I am wondering if it's
> >>> possible to ignore the latency on consumer devices, probably based on
> >>> chassis type, so consumer devices can get most NVMe power saving out
> >>> of the box?
> >>
> >> What is your proposed change?
> >
> > Ignore the latency limit if it's a mobile device, based on DMI chassis type.
> > I can write a patch for that.
> >
> >> Do you have any numbers on how this
> >> improves power consumption for given workloads and what the performance
> >> impact is on common benchmarks?
> >
> > A SanDisk NVMe has entry latency 1,000,000 and exit latency 100,000.
> > The default latency (25000) does not allow this device enters to
> > non-operational state. The system power consumption is around 13W.
> > Make this SanDisk device able to enter PS4 can get a system with
> > roughly 8W power consumption.
> > The 5W difference is quite good.
> 
> Can you send the actual 'nvme id-ctrl' output?
> 

I happen to have the output of this disk from another email I'm on so
I'll share it while it's Kai Heng's night.  There are several disks mentioned
that have this same concern, here's three of them at the end of this email.

> I suspect that something is screwy here.  This is an entry latency of
> 1 second and an exit latency of 100ms.  This is *atrocious*.  I don't
> care what kind of mobile device this is -- making it unresponsive for
> 1.1 seconds for the round trip will be quite noticeable.  And, with an
> RSTe-like policy, that's 100 *seconds* of delay before going fully to
> sleep.  Also, 5W power difference between deep sleep and less deep
> sleep is also bizarrely large.  The NVMe device shouldn't take 5W of
> power when idle even in the max-power operational state.
> 

There are some configurations that have multiple NVMe disks.
For example the Precision 7520 can have up to 3.

NVME Identify Controller:
vid     : 0x15b7
ssvid   : 0x1b4b
sn      : 163503900124        
mn      : A400 NVMe SanDisk 512GB                 
fr      : A3550012
rab     : 2
ieee    : 001b44
cmic    : 0
mdts    : 5
cntlid  : 0
ver     : 10200
rtd3r   : 182b8
rtd3e   : f4240
oaes    : 0
oacs    : 0x17
acl     : 4
aerl    : 7
frmw    : 0x14
lpa     : 0x2
elpe    : 63
npss    : 4
avscc   : 0x1
apsta   : 0x1
wctemp  : 358
cctemp  : 361
mtfa    : 50
hmpre   : 0
hmmin   : 0
tnvmcap : 0
unvmcap : 0
rpmbs   : 0
sqes    : 0x66
cqes    : 0x44
nn      : 1
oncs    : 0x17
fuses   : 0
fna     : 0
vwc     : 0x1
awun    : 7
awupf   : 7
nvscc   : 1
acwu    : 0
sgls    : 0
ps    0 : mp:8.25W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:5.30W
ps    1 : mp:8.25W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:3.30W
ps    2 : mp:8.25W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:3.30W
ps    3 : mp:0.0500W non-operational enlat:51000 exlat:10000 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    4 : mp:0.0055W non-operational enlat:1000000 exlat:100000 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-


NVME Identify Controller:
vid     : 0x1179
ssvid   : 0x1179
sn      : 667S100ETXYV        
mn      : THNSF5512GPUK NVMe SED TOSHIBA 512GB    
fr      : 5KDA5103
rab     : 1
ieee    : 00080d
cmic    : 0
mdts    : 0
cntlid  : 0
ver     : 0
rtd3r   : 0
rtd3e   : 0
oaes    : 0
oacs    : 0x17
acl     : 3
aerl    : 3
frmw    : 0x2
lpa     : 0x2
elpe    : 127
npss    : 4
avscc   : 0
apsta   : 0x1
wctemp  : 351
cctemp  : 355
mtfa    : 0
hmpre   : 0
hmmin   : 0
tnvmcap : 0
unvmcap : 0
rpmbs   : 0
sqes    : 0x66
cqes    : 0x44
nn      : 1
oncs    : 0x1e
fuses   : 0
fna     : 0x4
vwc     : 0x1
awun    : 255
awupf   : 0
nvscc   : 0
acwu    : 0
sgls    : 0
ps    0 : mp:6.00W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:2.40W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:1.90W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0120W non-operational enlat:5000 exlat:25000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0060W non-operational enlat:100000 exlat:70000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-


NVME Identify Controller:
vid     : 0x14a4
ssvid   : 0x1b4b
sn      : TW0YR3K3LOH006A600CN
mn      : CX2-GB1024-Q11 NVMe LITEON 1024GB       
fr      : 4GA11QD 
rab     : 0
ieee    : 002303
cmic    : 0
mdts    : 5
cntlid  : 1
ver     : 10200
rtd3r   : f4240
rtd3e   : f4240
oaes    : 0
oacs    : 0x1f
acl     : 3
aerl    : 3
frmw    : 0x14
lpa     : 0x2
elpe    : 63
npss    : 4
avscc   : 0x1
apsta   : 0x1
wctemp  : 358
cctemp  : 368
mtfa    : 50
hmpre   : 0
hmmin   : 0
tnvmcap : 1024209543168
unvmcap : 0
rpmbs   : 0
sqes    : 0x66
cqes    : 0x44
nn      : 1
oncs    : 0x1f
fuses   : 0
fna     : 0
vwc     : 0x1
awun    : 255
awupf   : 7
nvscc   : 1
acwu    : 0
sgls    : 0
ps    0 : mp:8.00W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:4.00W operational enlat:5 exlat:5 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:2.10W operational enlat:5 exlat:5 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.1000W non-operational enlat:5000 exlat:5000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0100W non-operational enlat:50000 exlat:100000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-
