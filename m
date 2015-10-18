From: axboe@fb.com (Jens Axboe)
Date: Sun, 18 Oct 2015 11:01:41 -0600
Subject: [PATCH] Update target repo for nvme patch contributions
In-Reply-To: <20151016234700.GA13234@localhost.localdomain>
References: <1445017711-4371-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20151016234700.GA13234@localhost.localdomain>
Message-ID: <5623D075.1070708@fb.com>

On 10/16/2015 05:47 PM, Busch, Keith wrote:
> Since willy has taken a spectator role on linux-nvme in favor of
> new storage developments, it seems prudent to set the tree to a more
> active one.
>
> This is not in drivers/block anymore, so question to Jens: do you want
> to take on maintenance for driver/nvme? We've been doing it this way
> de-facto for the past year, so if you're okay with listing your tree
> for nvme, that's definitely okay with me too.
>
> I'll just throw out for the next merge window that I'm happy to herd all
> the nvme patches out there into a pull request in a public tree if that
> would help.
>
> I've started this one, so far just with Christoph's latest, plus a fix
> from me from the fallout:
>
>    https://urldefense.proofpoint.com/v2/url?u=http-3A__git.infradead.org_users_kbusch_linux-2Dnvme.git&d=BQIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=aICLTTOdCBTmG8HlMbNQ5wFPxDvDGNR6EObxM8q3NJo&s=hNfXdogGq_cC562SAYK73S7g_kH2BJMuzIJwN1OZsp4&e=
>
> I'll be happy to add patches from other developers that appear to have
> been left behind as well.

I'm fine with taking on a more official role, if you sign up with me. I 
could do a separate nvme branch/tree as well, or we could just keep 
folding into for-xx/drivers like we've been doing the last year.

-- 
Jens Axboe
