From: harryxiyou@gmail.com (harryxiyou)
Date: Tue, 2 Sep 2014 19:57:27 -0400
Subject: NVMe multi-core process
In-Reply-To: <CAMjVwgRgax5bvaXAQMvKq-5R1Ea7GyzRc3QzGeUrdo9mnjRPEw@mail.gmail.com>
References: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>
 <CAD+1EGNpF2=zoZ2kTF21ud_6VHC+nZq5jFW3p3y=NkaN0tNP4g@mail.gmail.com>
 <CAMjVwgRgax5bvaXAQMvKq-5R1Ea7GyzRc3QzGeUrdo9mnjRPEw@mail.gmail.com>
Message-ID: <CAD+1EGOhceqzdryUmxLyowGJxCJSJzMZ7Q_4ZLnxHQAFqp7vxw@mail.gmail.com>

On Mon, Sep 1, 2014@4:52 PM, Angelo Brito <asb@cin.ufpe.br> wrote:
> Hi Harry,

Dear Angelo,

>
> In which version of the driver have you seen this code?

I run NVMe upon ESXi 5.x so I use following codes that I changed it a little
http://git.infradead.org/users/kbusch/vmklinux-nvme

> I am working with the kernels 3.10 and 3.15 and never seen more than
> the Admin Queue and SQ1.
> All my machines have multiple cores and one of them has multiple CPU.

Yeah, it real supports multi-core.


Thanks, Harry
