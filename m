From: keith.busch@intel.com (Keith Busch)
Date: Thu, 6 Jul 2017 18:39:56 -0400
Subject: [PATCH] NVMe: Added another device ID with stripe quirk
In-Reply-To: <20170706221754.GA10217@lst.de>
References: <1499379151-32479-1-git-send-email-david.fugate@intel.com>
 <20170706221754.GA10217@lst.de>
Message-ID: <20170706223955.GA1200@localhost.localdomain>

On Fri, Jul 07, 2017@12:17:54AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 06, 2017@04:12:31PM -0600, David Wayne Fugate wrote:
> > Adds a fourth Intel controller which has the "stripe" quirk.
> 
> NVMe has stadardized a way to communicate this information through
> the Namespace Optimal IO Boundary (NOIOB) field in the Identify
> Namespace structure, and Keith and Amber at Intel helped to define
> this, so please actually implement it in your controllers.

That's true for all Intel controllers going forward, but this
is actually an older controller that pre-dates NOIOB. It's the exact
same as the 8086:0A54 model, but a particular vendor decided their
rebranded device needs to be made special with a different DID.

We all agree that's a terrible way to go about this for mutliple reasons,
but we can't go back in time to tell the decision makers of this folly. So
I think we need to let this last one go through with the quirk.

Acked-by: Keith Busch <keith.busch at intel.com>
