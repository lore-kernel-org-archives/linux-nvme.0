From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 1 Mar 2018 23:14:46 +0000
Subject: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
In-Reply-To: <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-2-logang@deltatee.com>
 <20180301173752.GE13722@bhelgaas-glaptop.roam.corp.google.com>
 <b81503c2-9f07-b5f6-df06-64d1fdc53386@deltatee.com>
 <20180301230032.GA74737@bhelgaas-glaptop.roam.corp.google.com>
 <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
Message-ID: <9B84B347-2CCF-4250-89ED-B29892E76597@raithlin.com>

> I'm pretty sure the spec disallows routing-to-self so doing a P2P 
> transaction in that sense isn't going to work unless the device 
> specifically supports it and intercepts the traffic before it gets to 
> the port.

This is correct. Unless the device intercepts the TLP before it hits the root-port then this would be considered a "route to self" violation and an error event would occur. The same holds for the downstream port on a PCI switch (unless route-to-self violations are disabled which violates the spec but which I have seen done in certain applications).
    
Stephen
    
    
    
