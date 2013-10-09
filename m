From: agordeev@redhat.com (Alexander Gordeev)
Date: Wed, 9 Oct 2013 14:57:16 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131007180111.GC2481@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
Message-ID: <20131009125715.GC32733@dhcp-26-207.brq.redhat.com>

On Mon, Oct 07, 2013@02:01:11PM -0400, Tejun Heo wrote:
> Hmmm... yean, the race condition could be an issue as multiple msi
> allocation might fail even if the driver can and explicitly handle
> multiple allocation if the quota gets reduced inbetween.

BTW, should we care about the quota getting increased inbetween?
That would entail.. kind of pci_get_msi_limit() :), but IMHO it is
not worth it.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
