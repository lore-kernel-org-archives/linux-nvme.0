From: jsmart2021@gmail.com (James Smart)
Date: Mon, 11 Mar 2019 11:10:26 -0700
Subject: general protection fault in skb_put
In-Reply-To: <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>
References: <000000000000032b7f0583d16e0e@google.com>
 <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
 <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com>
Message-ID: <a68b264c-d573-87ef-13fb-883c6b0a710c@gmail.com>

On 3/11/2019 9:40 AM, Dmitry Vyukov wrote:
> On Mon, Mar 11, 2019 at 5:20 PM 'James Smart' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
>>
>> On 3/11/2019 6:20 AM, syzbot wrote:
>>> syzbot has bisected this bug to:
>>>
>>> commit 97faec531460c949d7120672b8c77e2f41f8d6d7
>>> Author: James Smart <jsmart2021 at gmail.com>
>>> Date:   Thu Sep 13 23:17:38 2018 +0000
>>>
>>>      nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
>>>
>>> bisection log:
>>> https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
>>> start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute
>>> to ..
>>> git tree:       linux-next
>>> final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
>>> dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
>>> userspace arch: amd64
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
>>>
>>> Reported-by: syzbot+65788f9af9d54844389e at syzkaller.appspotmail.com
>>> Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc
>>> transport device")
>>
>> can someone contact me as to what this thing is doing and how to
>> interpret all the logs.  nvme_fc isn't remotely in any of the logs and
>> doesn't use skb's unless the underlying udev_uevents are using them.
> 
> Hi James,
> 
> What exactly is unclear/needs interpretation? syzbot did what is
> commonly known as kernel/git bisection process. This is a new feature
> so there can be some rough edges. Hopefully we can improve the
> representation together.
> 
> Thanks
> 
Everything is unclear. You're telling me that an error occurred and that 
you reduced it to the git submit where the error starts appearing.

Usually there would be something in the base crash, which I'm looking at 
in https://syzkaller.appspot.com/x/report.txt?x=111f55db200000 which 
would point back at something in the patch or related to it. There are 
no relationships.  I can't quite figure out what the base test actually 
did that generated the failure to see if there's any possible relationship.

Everything in the base crash stacktrace points to an issue in the 
bluetooth uart driver doing all the logging - not the patch called out. 
So this looks like a failure of your infrastructure.

-- james
