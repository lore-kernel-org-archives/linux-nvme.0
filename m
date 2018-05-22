From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 22 May 2018 08:03:38 -0600
Subject: [PATCH 3/6] nvme: Move all IO out of controller reset
In-Reply-To: <20180522014626.GA20430@ming.t460p>
References: <20180518163823.27820-3-keith.busch@intel.com>
 <20180518230357.GC18334@ming.t460p>
 <20180521142219.GC5528@localhost.localdomain>
 <20180521145850.GA19099@ming.t460p>
 <20180521150331.GI5528@localhost.localdomain>
 <20180521153425.GC19099@ming.t460p>
 <20180521154433.GJ5528@localhost.localdomain>
 <20180521160452.GD19099@ming.t460p>
 <20180521162354.GM5528@localhost.localdomain>
 <20180522014626.GA20430@ming.t460p>
Message-ID: <20180522140337.GO5528@localhost.localdomain>

On Tue, May 22, 2018@09:46:32AM +0800, Ming Lei wrote:
> It isn't a good practice to rely on timing for avoiding race, IMO.

Sure thing, and it's easy enough to avoid this one.
 
> OK, please fix other issues mentioned in the following comment together,
> then I will review further and see if it can work well.
> 
> https://marc.info/?l=linux-block&m=152668465710591&w=2

Will do, v2 coming up by end of today.
