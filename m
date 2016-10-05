From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Oct 2016 17:47:31 -0400
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
In-Reply-To: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161005214730.GA1053@localhost.localdomain>

On Wed, Oct 05, 2016@12:42:08PM +0300, Sagi Grimberg wrote:
> I ran some tests with this and it seemed to work pretty well with
> my low-end nvme devices. One phenomenon I've encountered was that
> for single core long queue-depth'ed randread workload I saw around
> ~8-10% iops decrease. However when running multi-core IO I didn't
> see any noticeable performance degradation. non-polling Canonical
> randread latency doesn't seem to be affected as well. And also
> polling mode IO is not affected as expected.
> 
> So in addition for review and feedback, this is a call for testing
> and benchmarking as this touches the critical data path.

Hi Sagi,

Just reconfirming your findings with another data point, I ran this on
controllers with 3D Xpoint media, and single depth 4k random read latency
increased almost 7%. I'll try see if there's anything else we can do to
bring that in.
