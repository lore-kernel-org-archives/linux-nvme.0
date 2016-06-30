From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Jun 2016 18:59:14 -0400
Subject: [PATCHv2 1/3] nvme: Remove RCU namespace protection
In-Reply-To: <20160630145750.GC13842@localhost.localdomain>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-2-git-send-email-keith.busch@intel.com>
 <20160628083137.GA32618@infradead.org>
 <20160628163512.GB8607@localhost.localdomain>
 <20160630064838.GA1608@infradead.org>
 <20160630145750.GC13842@localhost.localdomain>
Message-ID: <20160630225913.GB18890@localhost.localdomain>

On Thu, Jun 30, 2016@10:57:51AM -0400, Keith Busch wrote:
> On Wed, Jun 29, 2016@11:48:38PM -0700, Christoph Hellwig wrote:
> > But we remove it from the list before del_gendisk in
> > nvme_remove_invalid_namespaces and nvme_scan_ns_list already.  I guess
> > that's fine because we're not going to do I/O on them at this point,
> 
> Right, we can safely remove them from the list for those other cases
> precisely because they can't do IO anymore.
> 
> > but what prevents us form doing this two step removal in
> > nvme_remove_namespaces?
> 
> If the controller fails during del_gendisk, we have to kill all
> the request queues and set capacities to 0 to force del_gendisk to
> complete. If the namespace isn't in the ctrl->namespace list, the driver
> can't find the namespace to kill.

BTW, I have addressed your other concerns and ready to post another
version, but holding off on resending until we all understand why it has
to be this way. I'm also open to an alternative, but this is the best
I've come up with. I'd really like to see this fixed in the current rc
cycle; the bugs this is fixing are pretty bad.
