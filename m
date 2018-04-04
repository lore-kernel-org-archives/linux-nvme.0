From: mr.nuke.me@gmail.com (Alex G.)
Date: Wed, 4 Apr 2018 10:51:33 -0500
Subject: nvme_free_ns_head: ida_remove called for id=1 which is not
 allocated
In-Reply-To: <20180403210734.GC4485@localhost.localdomain>
References: <6fe0bfff-0ca3-a752-6faa-3d36796977e0@gmail.com>
 <20180403210734.GC4485@localhost.localdomain>
Message-ID: <7302eff4-cf8b-e479-112b-c9a366b598dc@gmail.com>

On 04/03/2018 04:07 PM, Keith Busch wrote:
> On Tue, Apr 03, 2018@12:46:34PM -0500, Alex G. wrote:
>> I noticed a new and interesting error. While it's ominous, it doesn't
>> seem to cause any ill side-effects. This is reproduced with
>> firmware-first error handling, so I'm not sure if it's even an issue of
>> concern to nvme_core. Log files attached
> 
> Does this reproduce if you're not using CONFIG_NVME_MULTIPATH?

I'm not seeing it with 'CONFIG_NVME_MULTIPATH is not set' after running
this overnight.
