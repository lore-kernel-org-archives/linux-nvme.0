From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 6 Sep 2018 15:05:09 -0600
Subject: Devices expected?
In-Reply-To: <DE927C68B458BE418D582EC97927A9288003E585@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9288003E585@ORSMSX113.amr.corp.intel.com>
Message-ID: <20180906210508.GA31480@localhost.localdomain>

On Thu, Sep 06, 2018@08:26:55PM +0000, Gruher, Joseph R wrote:
> In general, my question is whether this is expected behavior?  If a
> bug, is it fixed in a newer kernel?  We are trying to track some disk
> stats and the unexpected (at least from our perspective) behavior in
> /proc/diskstats is causing us some confusion.  Thanks!

With the exception of the 'lsblk' error message, I think all your results
are expected when CONFIG_NVME_MUTLIPATH=y.
