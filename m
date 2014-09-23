From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Tue, 23 Sep 2014 13:10:46 +0530
Subject: Question on IOStat accounting
In-Reply-To: <alpine.LRH.2.03.1409170820490.4696@AMR>
References: <067e01cfd273$76dbc4e0$64934ea0$@samsung.com>
 <alpine.LRH.2.03.1409170820490.4696@AMR>
Message-ID: <08f801cfd701$b1b8c850$152a58f0$@samsung.com>

Re-posting as I think my mail was blocked due to company security policy
banner in the previous mail :(

If nvme_submit_bio_queue() fails to queue the IOD, the BIO gets queued in
the sq_cong BIO list.
But we don't start accounting for this immediately even though the BIO is
now queued up with the Driver.
Any particular reason for this? Is it because it's a rare scenario we're
talking about here?


> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Keith Busch
> Sent: Wednesday, September 17, 2014 7:58 PM
> To: Indraneel Mukherjee
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: Question on IOStat accounting
> 
> On Wed, 17 Sep 2014, Indraneel Mukherjee wrote:
> > In the current implementation of IO accounting in the nvme driver,
> > accounting is started once IOD is successfully prepared.
> > Thereafter 2 cases can happen, either IO gets successfully submitted
> > to device or it can get queued up in the IOD list if there is a failure.
> >
> > So what's the definition of iostat here? In-flight in the device or
> > in-flight in the driver ? Is there a need to make this consistent?
> 
> It seems consistent with other block drivers. Usually stats are handled
above the
> device driver at the request layer, but bio-based drivers handle the stats
on their
> own.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
