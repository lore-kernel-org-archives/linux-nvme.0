From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 17:25:42 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
 <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
 <20160517152359.GC14260@localhost.localdomain>
 <20160517153003.GA18529@localhost.localdomain>
 <CAF1ivSaEg2wiH3hwpRmeK7ua69ERT5MP8MqZyuc6Dtb2fes6gg@mail.gmail.com>
 <20160517210706.GB19325@localhost.localdomain>
 <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>
Message-ID: <20160517212542.GC19325@localhost.localdomain>

On Tue, May 17, 2016@02:09:34PM -0700, Ming Lin wrote:
> On Tue, May 17, 2016@2:07 PM, Keith Busch <keith.busch@intel.com> wrote:
> > Great, thanks. I was getting good results with this as well.
> 
> Thanks for the fix. Could you send the patch formally?

Will do. Sending shortly.

> > Bummer. Is your controller using sparse namespaces? The kernel message
> > before the bug appears to indicate that.
> 
> No. Only 1 namespace.

Something must be corrupt then. The below line shows an unallocated
namespace is failing to identify itself, but if you only report 1 ns,
we shouldn't have been able to get here from a simple nvme reset.

I think your resets are occuring faster than we anticipated and you've
uncovered another bug. It looks like these may cause trouble if reset
occurs during active scan work.

> >> [   44.985454] block (null): nvme_revalidate_disk: Identify failure
