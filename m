From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Sep 2014 10:44:28 -0600 (MDT)
Subject: NVMe multi-core process
In-Reply-To: <CAMjVwgRgax5bvaXAQMvKq-5R1Ea7GyzRc3QzGeUrdo9mnjRPEw@mail.gmail.com>
References: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>
 <CAD+1EGNpF2=zoZ2kTF21ud_6VHC+nZq5jFW3p3y=NkaN0tNP4g@mail.gmail.com>
 <CAMjVwgRgax5bvaXAQMvKq-5R1Ea7GyzRc3QzGeUrdo9mnjRPEw@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1409021035010.4696@AMR>

On Mon, 1 Sep 2014, Angelo Brito wrote:
> In which version of the driver have you seen this code?  I am working with
> the kernels 3.10 and 3.15 and never seen more than the Admin Queue and SQ1.
> All my machines have multiple cores and one of them has multiple CPU.

The linux-nvme driver from the very beginning has supported an IO
queue pair for each CPU if the h/w supports at least as many queues and
interrupt vectors.
