From: tj@kernel.org (Tejun Heo)
Date: Wed, 9 Oct 2013 11:43:23 -0400
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
References: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
 <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>
Message-ID: <20131009154323.GB22495@htj.dyndns.org>

Hello,

On Wed, Oct 09, 2013@02:57:16PM +0200, Alexander Gordeev wrote:
> On Mon, Oct 07, 2013@02:01:11PM -0400, Tejun Heo wrote:
> > Hmmm... yean, the race condition could be an issue as multiple msi
> > allocation might fail even if the driver can and explicitly handle
> > multiple allocation if the quota gets reduced inbetween.
> 
> BTW, should we care about the quota getting increased inbetween?
> That would entail.. kind of pci_get_msi_limit() :), but IMHO it is
> not worth it.

I think we shouldn't.  If the resource was low during a point in time
during allocation, it's fine to base the result on that - the resource
was actually low and which answer we return is just a question of
timing and both are correct.  The only reason the existing race
condition is problematic is because it may fail even if the resource
never falls below the failure point.

Thanks.

-- 
tejun
