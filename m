From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 6 Jan 2018 16:38:56 +0800
Subject: BUG: NULL pointer at IP: blk_mq_map_swqueue+0xbc/0x200 on
 4.15.0-rc2
In-Reply-To: <6769265a-4dc0-2f23-a65d-17bde591c483@kernel.dk>
References: <799322399.34367785.1512659684033.JavaMail.zimbra@redhat.com>
 <1443577037.35143768.1512717869183.JavaMail.zimbra@redhat.com>
 <20171211035844.GB22819@ming.t460p>
 <20171212083502.GA10646@infradead.org>
 <20171212091658.GA8529@ming.t460p>
 <6769265a-4dc0-2f23-a65d-17bde591c483@kernel.dk>
Message-ID: <20180106083855.GA27437@ming.t460p>

On Fri, Jan 05, 2018@09:39:48AM -0700, Jens Axboe wrote:
> On 12/12/17 2:16 AM, Ming Lei wrote:
> > On Tue, Dec 12, 2017@12:35:02AM -0800, Christoph Hellwig wrote:
> >> On Mon, Dec 11, 2017@11:58:45AM +0800, Ming Lei wrote:
> >>> As we talked offline, this IP points to cpumask_set_cpu(), seems this
> >>> case may happen when one CPU isn't mapped to any hw queue, could you test
> >>> the following patch to see if it helps your issue?
> >>
> >> This looks odd as mq_map should be pre-zeroed.  If it isn't we have
> >> a few more problems..
> > 
> > This happens in case of updating nr_hw_queue, for example, when the
> > number becomes 5 from 12, then the table has to be zeroed for avoiding
> > obsolete mapping if one CPU isn't mapped to any hw queue.
> 
> Do you have a proper complete patch for this?

Please see the latest version:

	https://marc.info/?l=linux-block&m=151522728023803&w=2

Thanks,
Ming
