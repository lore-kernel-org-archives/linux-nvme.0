From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 5 Oct 2018 12:33:41 -0700
Subject: [PATCH] nvme: Update node paths after adding new path
In-Reply-To: <20181005185708.GA24524@localhost.localdomain>
References: <20181005154937.24198-1-keith.busch@intel.com>
 <1c5827c1-6f2b-f45e-5370-26b3a49a3d33@grimberg.me>
 <20181005185708.GA24524@localhost.localdomain>
Message-ID: <7e9660bc-7d92-e5fe-06cf-3c32557f103a@grimberg.me>


> 
> The new path's local node may be closer to other nodes who's path is
> currently set to something else.
> 
> Consider the following simplified example of nodes A through D:
> 
>    -----    -----    -----    -----
>    | A |<-->| B |<-->| C |<-->| D |
>    -----    -----    -----    -----
> 
> Let's say we start with a single optimized path that is local to node
> "D". That path will initially be the "current_path" for all nodes.
> 
> Now attach a new path local to node "A". Updating just node A's
> current_path misses updating B away from D, even though A is closer
> than D.
> 

Git it,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
