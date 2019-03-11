From: dvyukov@google.com (Dmitry Vyukov)
Date: Mon, 11 Mar 2019 17:40:27 +0100
Subject: general protection fault in skb_put
In-Reply-To: <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
References: <000000000000032b7f0583d16e0e@google.com>
 <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
Message-ID: <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>

On Mon, Mar 11, 2019 at 5:20 PM 'James Smart' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On 3/11/2019 6:20 AM, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 97faec531460c949d7120672b8c77e2f41f8d6d7
> > Author: James Smart <jsmart2021 at gmail.com>
> > Date:   Thu Sep 13 23:17:38 2018 +0000
> >
> >     nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
> >
> > bisection log:
> > https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
> > start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute
> > to ..
> > git tree:       linux-next
> > final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
> > kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
> > userspace arch: amd64
> > syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
> >
> > Reported-by: syzbot+65788f9af9d54844389e at syzkaller.appspotmail.com
> > Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc
> > transport device")
>
> can someone contact me as to what this thing is doing and how to
> interpret all the logs.  nvme_fc isn't remotely in any of the logs and
> doesn't use skb's unless the underlying udev_uevents are using them.

Hi James,

What exactly is unclear/needs interpretation? syzbot did what is
commonly known as kernel/git bisection process. This is a new feature
so there can be some rough edges. Hopefully we can improve the
representation together.

Thanks
