From: mb@lightnvm.io (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Sat, 27 Jul 2019 17:25:24 +0200
Subject: [PATCH 4/5] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <20190725152926.GF3018@minwoo-desktop>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-5-minwoo.im.dev@gmail.com>
 <a40ea502-e293-e07c-9f7b-e5f9cc118adf@lightnvm.io>
 <20190725152926.GF3018@minwoo-desktop>
Message-ID: <CAOA7RkOe_pOvuSJZVhYkm8c=pC6bOu1g4Y0cN7wARrcMqoCEVA@mail.gmail.com>

Hi Minwoo,

Something like this would do:

Total chunks in namespace: %d
...
SLBA: 0xee40000  WP: 0x12345678  CNLB: 0x12345 WLI: XXX   State: FREE
      Type: SEQWRITE_REQ   Attrs: 0x00
...

Thank you,
Matias

On Thu, Jul 25, 2019@5:29 PM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
>
> On 19-07-24 14:27:10, Matias Bj?rling wrote:
> > Could you squash patch 2, 3 and 4 together (4 being the main patch) - They
> > belong together to implement one feature.
> >
> > As a side-note, we have the same command for ZNS (that will be pushed when
> > the ZNS TP is ratified) - In that, we've also added support for supplying
> > start lba and number of chunks (zones) to return. Could you add that as well
> > to this? Then there is coherency between the two?
>
> Matias,
>
> I just had a deep look at your slide about the ZNS which can be found at
> [1].  Sorry, I misunderstood your meaning here.
>
> This patch already introduced the SLBA in its chunk, but no nr_chunks in
> a single summary line.  Do you want me to print it like:
>
>         root at host:~/nvme-cli.git# nvme lnvm chunk-log /dev/nvme0n1
>         nr_chunks: 480
>          [    0] { cs: 0x2, ct: 0x1, wli: 2, slba: 0x0000000000000000, cnlb: 0x0000000000001000, wp: 0x0000000000001000 }
>          [    1] { cs: 0x2, ct: 0x1, wli: 1, slba: 0x0000000000001000, cnlb: 0x0000000000001000, wp: 0x0000000000001000 }
>          [    2] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x0000000000002000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>          [    3] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x0000000000003000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>          [    4] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x0000000000004000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>          [    5] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x0000000000005000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>          [    6] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x0000000000006000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>         ...
>          [  478] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x00000000001fa000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>          [  479] { cs: 0x1, ct: 0x1, wli: 0, slba: 0x00000000001fb000, cnlb: 0x0000000000001000, wp: 0x0000000000000000 }
>
> Thanks!
>
> [1] https://nvmexpress.org/wp-content/uploads/NVMeAnnualMeeting2019-ZNSv3.pptx
