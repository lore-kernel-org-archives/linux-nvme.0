From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 21 Sep 2018 14:47:00 -0500
Subject: [PATCH v6 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-7-logang@deltatee.com>
 <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
 <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
Message-ID: <20180921194700.GM224714@bhelgaas-glaptop.roam.corp.google.com>

On Fri, Sep 21, 2018@12:03:12PM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 10:41 AM, Bjorn Helgaas wrote:
> >> +away, the one returned will be chosen at random. This function returns the PCI
> > 
> > s/the one returned will be chosen at random/one will be chosen
> > arbitrarily/ ?  (I doubt it's really random)
> 
> You're the second person to ask this, but yes, we really do it randomly.
> Such that if there are multiple drivers getting resources they should be
> evenly distributed. It's not the ideal solution but if it were to do it
> arbitrarily then the code would likely return the same device all the
> time and any additional devices would not get used.

Ah, I see, I should have searched for "random" in that patch and answered
my own question :)  Sorry for the noise.

Bjorn
