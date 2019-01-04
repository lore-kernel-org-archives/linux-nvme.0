From: mwilck@suse.de (Martin Wilck)
Date: Fri, 04 Jan 2019 16:17:31 +0100
Subject: [PATCHv2] nvme-multipath: round-robin I/O policy
In-Reply-To: <bb159cba-ce3a-32ca-d79c-3dece6a71fd0@suse.com>
References: <20181221141330.96599-1-hare@suse.de>
 <833821226d78f0e947b14434c188d64d4838337a.camel@suse.de>
 <bb159cba-ce3a-32ca-d79c-3dece6a71fd0@suse.com>
Message-ID: <34088d585b47fdb764821b32d5c7bbb168ede900.camel@suse.de>

On Fri, 2019-01-04@15:24 +0100, Hannes Reinecke wrote:
> On 1/4/19 3:06 PM, Martin Wilck wrote:
> > 
> > Also, if no OPTIMIZED paths are found in the first iteration, I'd
> > find
> > it cleaner to restrict the search to NONOPTIMIZED paths in the
> > second
> > round (rather than looking at both OPTIMIZED and NONOPTIMIZED),
> > similar
> > to a pathgroup switch in traditional multipathing. The behavior
> > would
> > then come down to a PG switch with "immediate" fallback in
> > multipath-
> > tools terms.
> > 
> Concurrency is the key. We're running lockless here, so the path
> state 
> might change at any time.
> Only checking for non-optimized would cause us to miss any paths
> which 
> went to 'optimized' in between checks.

How likely is that, given the path-search loop is supposed to be very
fast? Your paths could just as easily change state again before you
actually come to submit IO to them. If you take this sort of argument
seriously, you can never be sure about the state of the path you're
trying to use, no matter how often you check; while in practice, such
concurrent state changes will occur no more than once in a million I/O
submissions. Or am I missing something?

Anyway it was just a nit; so fine with me.

Thanks,
Martin
