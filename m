From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 19 Nov 2015 15:12:23 -0700
Subject: [PATCH] nvme: allow queues the chance to quiesce after freezing
 them
In-Reply-To: <20151119214156.GA22690@localhost.localdomain>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
 <20151119214156.GA22690@localhost.localdomain>
Message-ID: <20151119221223.GA3516@localhost.localdomain>

> I think all we really want is skip notifying completions on a
> "suspended" queue. We can tell by the value of the cq-vector,
> and it's already lock protected.
> 
Good catch. I wish I had made that relationship :)
(Though I was hoping somebody would figure out a less hacky way of doing it than I did)

> It also sounds like we need to poll the cq after the delete completes
> to catch successful completions before we force cancel the rest.
>
> This appears to work for me. Does it pass your test?

Passes my tests as well so you can add my tb:
Tested-by: Jon Derrick <jonathan.derrick at intel.com>

Re: Christoph
>This looks reasonable.  I ran into stray ->q_db derference a lot during reset testing, but after my abort and reset rewrites ([1] for th latest
version) I couldn't reproduce it any more. 

Sorry this was against 4.3 (and was reproducible on 4.4-rc1). I will give your repo a test shortly
