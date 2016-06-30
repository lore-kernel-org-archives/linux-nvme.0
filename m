From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Jun 2016 19:14:55 -0400
Subject: NVMeoF multi-path setup
In-Reply-To: <20160630225207.GB22293@redhat.com>
References: <CAF1ivSbe+NboO+nbiWfEijHFJPd-AgNa=4AvWT24-HjH8A_izw@mail.gmail.com>
 <1467323858.15863.3.camel@ssi> <20160630225207.GB22293@redhat.com>
Message-ID: <20160630231454.GC18890@localhost.localdomain>

On Thu, Jun 30, 2016@06:52:07PM -0400, Mike Snitzer wrote:
> AFAIK, hch had Intel disable that by default in the hopes of avoiding
> people having dm-multipath "just work" with NVMeoF.  (Makes me wonder
> what other unpleasant unilateral decisions were made because some
> non-existant NVMe specific multipath capabilities would be forthcoming
> but I digress).

For the record, Intel was okay with making SCSI a separate config option,
but I was pretty clear about our wish to let it default to 'Y', which
didn't happen. :)

To be fair, NVMe's SCSI translation is a bit of a kludge, and we have
better ways to get device identification now. Specifically, the block
device provides 'ATTR{wwid}' available to all NVMe namespaces in existing
kernel releases.
