From: bmarzins@redhat.com (Benjamin Marzinski)
Date: Mon, 25 Jan 2016 19:49:00 -0600
Subject: [dm-devel] dm-multipath low performance with blk-mq
In-Reply-To: <20160125214016.GA10060@redhat.com>
References: <569E11EA.8000305@dev.mellanox.co.il>
 <20160119224512.GA10515@redhat.com>
 <20160125214016.GA10060@redhat.com>
Message-ID: <20160126014900.GR24960@octiron.msp.redhat.com>

On Mon, Jan 25, 2016@04:40:16PM -0500, Mike Snitzer wrote:
> On Tue, Jan 19 2016 at  5:45P -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > On Mon, Jan 18 2016 at  7:04am -0500,
> > Sagi Grimberg <sagig@dev.mellanox.co.il> wrote:
> 
> Would still appreciate answers to my 2 questions above (did you modify
> md->tag_set.nr_hw_queues and can you share your fio job?)

The number of CPUs (if it's not obvious from the fio job) and any
relevant information about the memory architecture (is this a NUMA
system? How many nodes?) might also help reproducing this.

-Ben
