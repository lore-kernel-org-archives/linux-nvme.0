From: tj@kernel.org (Tejun Heo)
Date: Wed, 9 Oct 2013 11:46:06 -0400
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <1381178881.1536.28.camel@bwh-desktop.uk.level5networks.com>
Message-ID: <20131009154606.GC22495@htj.dyndns.org>

On Mon, Oct 07, 2013@09:48:01PM +0100, Ben Hutchings wrote:
> > There is one major flaw in min-max approach - the generic MSI layer
> > will have to take decisions on exact number of MSIs to request, not
> > device drivers.
> [...
> 
> No, the min-max functions should be implemented using the same loop that
> drivers are expected to use now.

Wheee... earlier in the thread I thought you guys were referring to
yourselves in the third person and was getting a bit worried. :)

-- 
tejun
