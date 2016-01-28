From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Thu, 28 Jan 2016 01:09:42 -0800
Subject: [LSF/MM TOPIC] NVMe target support
In-Reply-To: <20160128085210.GB18023@infradead.org>
References: <1453956103.6746.195.camel@haakon3.risingtidesystems.com>
 <20160128085210.GB18023@infradead.org>
Message-ID: <1453972182.6746.248.camel@haakon3.risingtidesystems.com>

On Thu, 2016-01-28@00:52 -0800, Christoph Hellwig wrote:
> I think the frame is wrong, nevermind that I doubt I'll be able to
> discuss anything NVMe Fabrics related before the spec is public.  Which
> I doubt is in time for LSF/MM.

That fine, but NVMe_OF is certainly not going to be the only fabric
driver out there.

So what I'd like to discuss wrt this topic is what existing common code
relates to vhost-nvme, based on other's fabric driver work already out
there.
