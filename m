From: dmngaie@gmail.com (Dennis Mungai)
Date: Sat, 1 Apr 2017 10:13:48 +0300
Subject: Linux 4.9.8 + NVMe CiB Issue
In-Reply-To: <CAHkw+LfMkJCdvc_bETjiXUbYtLuZKoaGXCGE1Hmo9K7=L7OOxw@mail.gmail.com>
References: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>
 <20170215211240.GA23472@localhost.localdomain>
 <CAHkw+Lfy-3b+Dg4Bwfg1ViBSNrWsiiuBSXJTcu2VQNdfBRcB0g@mail.gmail.com>
 <CAHkw+LfthNu5Bs5xFNw3YRNmTHxFpea1E_W--f4ZVvd_gnMs0g@mail.gmail.com>
 <CAHkw+Lem6EzvxwPYK+5R02rdDARzNxjCKGZXc-vDzLcdj8FJnQ@mail.gmail.com>
 <CAHkw+Ldp4C+we2sCJ1EjcAquA0JcCwf91T0Pq0DThmRU3EwLVQ@mail.gmail.com>
 <20170310002745.GH14329@localhost.localdomain>
 <CAHkw+LdOnTdwpSR8=aefeLk51aUCg9NzsDSJdT1t-S97jP0tng@mail.gmail.com>
 <20170331140744.GJ20181@localhost.localdomain>
 <CAHkw+LfMkJCdvc_bETjiXUbYtLuZKoaGXCGE1Hmo9K7=L7OOxw@mail.gmail.com>
Message-ID: <CAKKYfmG3fLg2x0PDzCZYqGbjgAiMVP_pz_Nctz=KjndDEfVe3Q@mail.gmail.com>

And to add a few comments on this:

NVMe drives run hot, and one of their safety mechanisms is to first
throttle (which drops IO performance ) in an attempt to lower
operating temperature, and secondly, if all else fails, shut down
completely.

The problem the user is encountering here has to do with cooling. Let
me explain:

As a systems builder, one thing I've noticed with worrying concern is
how quickly NVMe SSDs heat up significantly under load, yet so little
is done by vendors to include either proper heat sink assemblies or
throttling mechanisms in hardware (I'm looking at you, Samsung and
Toshiba!), compounded with hilarious firmware bugs such as declaring
support for asynchronous trim when in fact it's not supported,
resulting in unneeded blacklists.

The solution here, for the end user is simple:

1. On installation, deploy the NVMe SSDs in such a way that they have
adequate cooling and airflow. And if that's not possible, acquire a
PCIe adapter as their clearance guarantees airflow which is critical
for cooling.

2. Use a third party silicon cooling strip on the drive. They act as
good heat sinks that can keep the drive running under prolonged load.
A simple Google search will show you what to get .

And for manufacturers

1. Implement heat sink shields on these drives. Samsung has done an
excellent job on the 960 Evo and Pro NVMes, and even in a closed up
space such as a gaming laptop, the heat sink assembly keeps the drive
below the thermal throttling point.

2. Firmware: Please implement throttling mechanisms that trip at
reasonable temperatures. I've seen a drive out here (hint: Phison
controller based) set to trip at 85 degrees, meaning that it often
tends to shut down first before the thermal throttle kicks in.

These hints might help.

Regards,

Dennis.

On 31 March 2017@17:33, Marc Smith <marc.smith@mcc.edu> wrote:
> Exactly! =)
>
> Thanks for your help.
>
>
> --Marc
>
> On Fri, Mar 31, 2017@10:07 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Fri, Mar 31, 2017@09:26:32AM -0400, Marc Smith wrote:
>>> NVMe drives are hitting their maximum operating temperature and then
>>> shutting down.
>>
>> That's not cool.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
