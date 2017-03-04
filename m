From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 03 Mar 2017 18:38:45 -0800
Subject: [nvmet/nvmetcli]- bug/break in setting a host on NVMe Target?
In-Reply-To: <1488591203.4759.20.camel@linux.intel.com>
References: <1488591203.4759.20.camel@linux.intel.com>
Message-ID: <1488595125.4759.26.camel@linux.intel.com>

On Fri, 2017-03-03@17:33 -0800, J Freyensee wrote:
> Christoph,
> 
> I think something might have broke being able to use nvmetcli to set up a
> host
> nqn name interactively?

Also seeing a similar issue for /ports, I didn't have a problem setting ports/
by hand-writing a .json file but ./nvmetcli is having a problem doing it
interactively.
