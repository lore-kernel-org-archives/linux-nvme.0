From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Aug 2014 08:32:00 -0600 (MDT)
Subject: [PATCH] NVMe: Fix partition detection issue(Hot Remove followed
 by Hot Add)
In-Reply-To: <00ce01cfbe15$45f887e0$d1e997a0$@samsung.com>
References: <060001cfb175$a1c44c00$e54ce400$@samsung.com>
 <alpine.LRH.2.03.1408211209220.4696@AMR>
 <00ce01cfbe15$45f887e0$d1e997a0$@samsung.com>
Message-ID: <alpine.LRH.2.03.1408220827480.4696@AMR>

On Fri, 22 Aug 2014, Indraneel Mukherjee wrote:
>> You definitely don't want to make this parameter writeable; changing it
>> after the minors were setup will cause breakage.
>
> Won't nvme_minors be changeable only while loading the module as it's a
> module param? Driver should be able to handle this without any breakage.
> Idea is to provide a way to change this without compiling every time.

The module parameter permissions are for the sysfs entry that gets
created when the module is loaded. You'll still be able to set it to any
valid value when the you load the module, but you don't want to change
the vlaue after the fact since it will screw up your calculation for
removing your IDR index.
