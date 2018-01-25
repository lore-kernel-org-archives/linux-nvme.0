From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 25 Jan 2018 11:02:19 +0100
Subject: [LSF/MM TOPIC] few MM topics
In-Reply-To: <bee1d564-b4b8-ed0c-edfa-f6df6a24fe21@oracle.com>
References: <20180124092649.GC21134@dhcp22.suse.cz>
 <bee1d564-b4b8-ed0c-edfa-f6df6a24fe21@oracle.com>
Message-ID: <20180125100219.GO28465@dhcp22.suse.cz>

On Wed 24-01-18 10:23:20, Mike Kravetz wrote:
> On 01/24/2018 01:26 AM, Michal Hocko wrote:
[...]
> > - It seems there is some demand for large (> MAX_ORDER) allocations.
> >   We have that alloc_contig_range which was originally used for CMA and
> >   later (ab)used for Giga hugetlb pages. The API is less than optimal
> >   and we should probably think about how to make it more generic.
> 
> This is also of interest to me.  I actually started some efforts in this
> area.  The idea (as you mention above) would be to provide a more usable
> API for allocation of contiguous pages/ranges.  And, gigantic huge pages
> would be the first consumer.
> 
> alloc_contig_range currently has some issues with being used in a 'more
> generic' way.  A comment describing the routine says "it's the caller's
> responsibility to guarantee that we are the only thread that changes
> migrate type of pageblocks the pages fall in.".  This is true, and I think
> it also applies to users of the underlying routines such as
> start_isolate_page_range.  The CMA code has a mechanism that prevents two
> threads from operating on the same range concurrently.  The other users
> (gigantic page allocation and memory offline) happen infrequently enough
> that we are unlikely to have a conflict.  But, opening this up to more
> generic use will require at least a more generic synchronization mechanism.

Yes, that is exactly my concern and the current state of art that has to
change. I am not yet sure how. So any discussion seems interesting.
-- 
Michal Hocko
SUSE Labs
