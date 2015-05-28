From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 May 2015 21:31:00 +0000 (UTC)
Subject: Problems writing to intel P3700 NVMe drive
In-Reply-To: <CAFMq3wGafXvcB0jO4myzYA83trOfCyoo8rNVTNa1qTD7okytDQ@mail.gmail.com>
References: <CAFMq3wEyk9PMbD8Cgn5trJyDjaOKpMzR-TNzbx0zXN=Mms573Q@mail.gmail.com>
 <00c601d098cd$41255e30$c3701a90$@storageio.com>
 <CAFMq3wE7PzKs=dYxxUhFsHeTkR0CT8mh6NVfrk-9mKxdisoDTg@mail.gmail.com>
 <00cd01d098d1$94047010$bc0d5030$@storageio.com>
 <CAFMq3wEa=kxznE77oFdg03QBHqszmH5-Vvmmm9pW1nkPUZi_Og@mail.gmail.com>
 <CA+At7pWf6Ge3pc7=aeiqz=iWxtYJSPVdM_W2XW9pL4d22q432Q@mail.gmail.com>
 <000a01d098ee$b52ce0c0$1f86a240$@storageio.com>
 <CAFMq3wH67yMqWGcde77kiyWJ6_ieZjVyhc8L-oq1e_b4x5mS7w@mail.gmail.com>
 <alpine.LNX.2.00.1505282059400.15930@localhost.lm.intel.com>
 <CAFMq3wGafXvcB0jO4myzYA83trOfCyoo8rNVTNa1qTD7okytDQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1505282123410.15930@localhost.lm.intel.com>

Using 'pcie_bus_perf' will work just fine in most cases, selecting the
highest capable settings so as not to penalize other h/w. Though all
your controllers had the same max payload capabilities anyway, so they
should all be the same from the max TLP perspective.

On Thu, 28 May 2015, Pavilion Storage wrote:
> The root cause might be a bug in the kernel where pcie devices are
> configured. Setting it to 128B will work, but may not perform to the
> best capabilities allowed by the device and RC. If we have multiple
> drives from different manufacturers in the system, we may penalize the
> drive that has the hardware capability to handle higher MPSS.
>
> thx
> Kishore
>
>
> On Thu, May 28, 2015@2:03 PM, Keith Busch <keith.busch@intel.com> wrote:
>> Perhaps not a desirable/permanent solution, but for everyone's benefit,
>> we can work-around the problem with kernel parameter:
>>
>>   pci=pcie_bus_safe
>>
>> Using 'pcie_bus_perf' instead may also work, though your original
>> solution of just using x86 sounded perfectly reasonable to me. :)
>>
>> On Thu, 28 May 2015, Pavilion Storage wrote:
>>>
>>> Thanks to Keith Busch for the providing the clues.
>>> The problem was that the PCIe MPSS on the drive and the CPU root
>>> complex did not match and that caused a problem. Setting it to a
>>> common value fixed the problem.
>>> Kishore
>
