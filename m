From: jikos@kernel.org (Jiri Kosina)
Date: Mon, 27 May 2019 11:29:19 +0200 (CEST)
Subject: [5.2-rc1 regression]: nvme vs. hibernation
In-Reply-To: <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
Message-ID: <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>

On Sat, 25 May 2019, Dongli Zhang wrote:

> Looks this has been discussed in the past.
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> 
> I created a fix for a case but not good enough.
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html

That removes the warning, but I still seem to have ~1:1 chance of reboot 
(triple fault?) immediately after hibernation image is read from disk. 
Seems like that has been going all the way down to 4.19, which seems to be 
rock stable. It's a bit hard to bisect, as I am not really 100% sure 
whether this is one issue or two intermixed ones, and it doesn't reproduce 
completely reliably.

-- 
Jiri Kosina
SUSE Labs
