From: asb@cin.ufpe.br (Angelo Brito)
Date: Mon, 2 Jun 2014 17:51:34 -0300
Subject: A NVME command always generates some additional commands?
In-Reply-To: <alpine.LRH.2.03.1406021342500.11244@AMR>
References: <CAMjVwgQZQ9R+FD2sPhdLraGhdf-8OrwZngMTQVfVMh1__5QFhg@mail.gmail.com>
 <alpine.LRH.2.03.1406021342500.11244@AMR>
Message-ID: <CAMjVwgSN3YHDc3E4wkHzLRqjFnrGkE7A-CxNExQ1QCyRAQaAYg@mail.gmail.com>

Thanks Keith!

I just needed a confirmation that it was an expected behavior!


Regards,
Angelo Silva Brito.
Graduate in Engenharia da Computa??o - UFPE
http://about.me/angelobrito
_________________________________________________


On Mon, Jun 2, 2014@5:08 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, 2 Jun 2014, Angelo Brito wrote:
>>
>> We are developing a NVMe device and your device is under tests right
>> now. So we are monitoring what is requested, what is executed and what
>> are the answers. Then every time we request a NVMe I/O Command some
>> additional 23 I/O Read Commands are generated to read some blocks next
>> to the end of our memory or next to the start. Is it an expected
>> behavior? I didn't find a reason at the driver for these commands to
>> be generated.
>
>
> Reads are generated everytime you close a block device opened for writing.
