From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 06 Oct 2013 08:46:26 +1100
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
Message-ID: <1381009586.645.141.camel@pasglop>

On Sat, 2013-10-05@16:20 +0200, Alexander Gordeev wrote:
> So my point is - drivers should first obtain a number of MSIs they *can*
> get, then *derive* a number of MSIs the device is fine with and only then
> request that number. Not terribly different from memory or any other type
> of resource allocation ;)

What if the limit is for a group of devices ? Your interface is racy in
that case, another driver could have eaten into the limit in between the
calls.

Ben.
