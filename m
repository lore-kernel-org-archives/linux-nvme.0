From: asb@cin.ufpe.br (Angelo Brito)
Date: Tue, 2 Sep 2014 17:24:16 -0300
Subject: NVMe multi-core process
In-Reply-To: <alpine.LRH.2.03.1409021035010.4696@AMR>
References: <CAD+1EGN1P1=0Le0Z7Cd3WdC5Q3+Eca+SKFpzdfEQwpqg3LhR=w@mail.gmail.com>
 <CAD+1EGNpF2=zoZ2kTF21ud_6VHC+nZq5jFW3p3y=NkaN0tNP4g@mail.gmail.com>
 <CAMjVwgRgax5bvaXAQMvKq-5R1Ea7GyzRc3QzGeUrdo9mnjRPEw@mail.gmail.com>
 <alpine.LRH.2.03.1409021035010.4696@AMR>
Message-ID: <CAMjVwgSasCspsrqMS172oe6YgKPF3yGD6_+5FtuED7rsOknFVg@mail.gmail.com>

Thanks for the feedback Keith!

I have a device here that supports 9 (1 Admin + 8 I/O) Submission
Queues but looking to his doorbell regiters I can see that just SQ1 is
in use. My pc is a Power Edge T600 from Dell which has  24 cores (2
CPU whith 12 cores). We are running on Red Hat Enterprise Linux 6.5
with kernels 3.15 and 3.10.

I have also checked the Get Features for Number of Queues and it
returns 'h00070007 which is zero-based notation. I think something
must be wrong at my configurations. Do you have any ideas of the
reason why the driver never used more than one submission queue?
Some directions on how to debug it would be nice too. ;)

Regards,
Angelo Silva Brito.
Graduate in Engenharia da Computa??o - UFPE
http://about.me/angelobrito
_________________________________________________


On Tue, Sep 2, 2014@1:44 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, 1 Sep 2014, Angelo Brito wrote:
>>
>> In which version of the driver have you seen this code?  I am working with
>> the kernels 3.10 and 3.15 and never seen more than the Admin Queue and
>> SQ1.
>> All my machines have multiple cores and one of them has multiple CPU.
>
>
> The linux-nvme driver from the very beginning has supported an IO
> queue pair for each CPU if the h/w supports at least as many queues and
> interrupt vectors.
