From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Mar 2018 08:03:45 -0700
Subject: [PATCH] Revert "nvme: create 'slaves' and 'holders' entries for
 hidden controllers"
In-Reply-To: <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
References: <20180307131358.20275-1-hch@lst.de>
 <1c1332d4-1d92-af8f-974c-2eafcde741f2@suse.de>
Message-ID: <20180307150344.GE30975@localhost.localdomain>

On Wed, Mar 07, 2018@02:40:39PM +0100, Hannes Reinecke wrote:
> The nice thing about the holders/slave is that one can discover the
> topology, and potentially figure out any issues (like one path going
> down etc).

I also thought the sysfs hierarchy was useful, but it sounds like causes
more problems than it solves. :(

> How do we detect the topology now?
> Does nvme cli has the functionality?

Not in the way you'd probably like. It can provide all the information
you'd need to put it together, but it doesn't provide a convenient
method to get or visualize it. I'll add a note on the project to fix
that.
