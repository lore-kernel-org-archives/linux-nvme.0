From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu, 18 Apr 2019 10:25:41 +0300
Subject: [PATCH] nvme: determine the number of IO queues
In-Reply-To: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
 <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
Message-ID: <25e684a4d347181aa6b6dc1e41d1794203bbae03.camel@redhat.com>

On Thu, 2019-04-18@14:21 +0800, Aaron Ma wrote:
> On 4/18/19 1:33 AM, Maxim Levitsky wrote:
> > On Wed, 2019-04-17@20:32 +0300, Maxim Levitsky wrote:
> > > On Wed, 2019-04-17@22:12 +0800, Aaron Ma wrote:
> > > > Some controllers support limited IO queues, when over set
> > > > the number, it will return invalid field error.
> > > > Then NVME will be removed by driver.
> > > > 
> > > > Find the max number of IO queues that controller supports.
> > > > When it still got invalid result, set 1 IO queue at least to
> > > > bring NVME online.
> > > 
> > > To be honest a spec compliant device should not need this.
> > > The spec states:
> > > 
> > > "Number of I/O Completion Queues Requested (NCQR): Indicates the number of
> > > I/O
> > > Completion
> > > Queues requested by software. This number does not include the Admin
> > > Completion
> > > Queue. A
> > > minimum of one queue shall be requested, reflecting that the minimum
> > > support
> > > is
> > > for one I/O
> > > Completion Queue. This is a 0?s based value. The maximum value that may be
> > > specified is 65,534
> > > (i.e., 65,535 I/O Completion Queues). If the value specified is 65,535,
> > > the
> > > controller should return
> > > an error of Invalid Field in Command."
> > > 
> > > 
> > > This implies that you can ask for any value and the controller must not
> > > respond
> > > with an error, but rather indicate how many queues it supports.
> > > 
> > > Maybe its better to add a quirk for the broken device, which needs this?
> 
> Adding quirk only makes the code more complicated.
> This patch doesn't change the default behavior.
> Only handle the NVME error code.
> 
> Yes the IO queues number is 0's based, but driver would return error and
> remove the nvme device as dead.

No, no, the spec says that no matter what the number queues you ask for, unless
it is 65,535, the controller should not fail with an error, but rather indicate
in the return value (in the completion entry) the actual number of queues it
allocated which can be larger or smaller that what you asked for.

If controller returns an error, that means its firmware has a bug, which is not
something unusual but usually those cases are handled with a quirk rather than
with general code change.

But anyway that is just my opinion, as someone who studied and implemented
(hopefully mostly correctly) the spec very recently (I am the author of nvme-
mdev device).

It doesn't really matter to me if this is implemented this or another way as
long as it doesn't break things.

Best regards,
	Maxim Levitsky



> 
> So set it as 1 at least the NVME can be probed properly.
> 
> Regards,
> Aaron
> 
> > I forgot to add the relevant paragraph:
> > 
> > "Note: The value allocated may be smaller or larger than the number of
> > queues
> > requested, often in virtualized
> > implementations. The controller may not have as many queues to allocate as
> > are
> > requested. Alternatively,
> > the controller may have an allocation unit of queues (e.g. power of two) and
> > may
> > supply more queues to
> > host software to satisfy its allocation unit."




> > 
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
