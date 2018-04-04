From: keith.busch@intel.com (Keith Busch)
Date: Wed, 4 Apr 2018 09:56:09 -0600
Subject: nvme_free_ns_head: ida_remove called for id=1 which is not
 allocated
In-Reply-To: <7302eff4-cf8b-e479-112b-c9a366b598dc@gmail.com>
References: <6fe0bfff-0ca3-a752-6faa-3d36796977e0@gmail.com>
 <20180403210734.GC4485@localhost.localdomain>
 <7302eff4-cf8b-e479-112b-c9a366b598dc@gmail.com>
Message-ID: <20180404155609.GF4485@localhost.localdomain>

On Wed, Apr 04, 2018@10:51:33AM -0500, Alex G. wrote:
> On 04/03/2018 04:07 PM, Keith Busch wrote:
> > On Tue, Apr 03, 2018@12:46:34PM -0500, Alex G. wrote:
> >> I noticed a new and interesting error. While it's ominous, it doesn't
> >> seem to cause any ill side-effects. This is reproduced with
> >> firmware-first error handling, so I'm not sure if it's even an issue of
> >> concern to nvme_core. Log files attached
> > 
> > Does this reproduce if you're not using CONFIG_NVME_MULTIPATH?
> 
> I'm not seeing it with 'CONFIG_NVME_MULTIPATH is not set' after running
> this overnight.

Thanks. There are different code paths the two modes may take. I don't
see anything obviously wrong yet, so just wanted to narrow the scope of
the search down.
