From: snitzer@redhat.com (Mike Snitzer)
Date: Tue, 12 Jan 2016 21:59:33 -0500
Subject: [PATCH v3 07/12] md: suspend i/o during runtime
 blk_integrity_unregister
In-Reply-To: <CAPcyv4i8ynO8xjyML86k2cM-djvvKvSAS-dgR2XcaUwhgYC0dg@mail.gmail.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20151021172001.6456.95293.stgit@dwillia2-desk3.amr.corp.intel.com>
 <874mei8bu8.fsf@notabene.neil.brown.name>
 <CAPcyv4i8ynO8xjyML86k2cM-djvvKvSAS-dgR2XcaUwhgYC0dg@mail.gmail.com>
Message-ID: <20160113025933.GA30612@redhat.com>

On Tue, Jan 12 2016 at  9:24pm -0500,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jan 12, 2016@6:14 PM, NeilBrown <neilb@suse.com> wrote:
> >
> > Hi Dan,
> >
> > Somewhat belatedly I am testing this code, and it deadlocks.  Which is
> > obvious once I think about it.
> >
> > raid10_add_disk() is called from
> >   raid10d -> md_check_recovery -> remove_and_add_spares
> >
> > so this call to mddev_suspend() will block raid10d until all pending IO
> > completes.  But raid10d might be needed to complete some IO -
> > particularly in the case of errors.  I don't know exactly what is
> > deadlocking in my test, but it doesn't surprise me that something does.
> 
> Ugh.
> 
> > Can you explain in more detail what needs to be synchronised here?  If
> > the synchronisation doesn't happen, what can do wrong?
> > Because I cannot imagine what this might actually be protecting against.
> 
> My thinking is that if the integrity profile changes while i/o is in
> flight we can get spurious errors.  For example when enabling
> integrity a checksum for in-flight commands will be missing, so wait
> for those to complete.

DM avoids this because it doesn't allow changing the integrity profile
once one is established.
