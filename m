From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 01:22:53 +0200
Subject: [PATCH] NVMe: Added another device ID with stripe quirk
In-Reply-To: <20170706223955.GA1200@localhost.localdomain>
References: <1499379151-32479-1-git-send-email-david.fugate@intel.com>
 <20170706221754.GA10217@lst.de> <20170706223955.GA1200@localhost.localdomain>
Message-ID: <20170706232253.GA11119@lst.de>

On Thu, Jul 06, 2017@06:39:56PM -0400, Keith Busch wrote:
> That's true for all Intel controllers going forward, but this
> is actually an older controller that pre-dates NOIOB. It's the exact
> same as the 8086:0A54 model, but a particular vendor decided their
> rebranded device needs to be made special with a different DID.

Meh..

> 
> We all agree that's a terrible way to go about this for mutliple reasons,
> but we can't go back in time to tell the decision makers of this folly. So
> I think we need to let this last one go through with the quirk.
> 
> Acked-by: Keith Busch <keith.busch at intel.com>

Reluctantly-accepted-by: Christoph Hellwig <hch at lst.de>
