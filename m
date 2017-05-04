From: jsmart2021@gmail.com (James Smart)
Date: Thu, 4 May 2017 08:07:11 -0700
Subject: [PATCH] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <a531ab03-f3d8-355c-80ec-9f66437ae67e@grimberg.me>
References: <20170502185458.3495-1-jsmart2021@gmail.com>
 <fa1b98e7-9751-885e-a2b0-a1918779cf2a@grimberg.me>
 <ce7a80c3-e746-cffc-7624-b013a94bca73@gmail.com>
 <a531ab03-f3d8-355c-80ec-9f66437ae67e@grimberg.me>
Message-ID: <dc09239d-962f-a48b-692b-375f65757489@gmail.com>

On 5/3/2017 9:55 AM, Sagi Grimberg wrote:
> This sort of discussion really calls for a unification of control and
> the error handling flows for all transports, with a single state
> machine semantics. I'm currently looking into it, but I suspect it'll
> take me a little while...

I don't think it has to be that drastic, but at least a common 
understanding of what the states mean/span should be known.

-- james
