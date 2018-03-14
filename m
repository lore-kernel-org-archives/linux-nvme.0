From: sbates@raithlin.com (Stephen  Bates)
Date: Wed, 14 Mar 2018 14:05:06 +0000
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
References: <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <8de5d3dd-a78f-02d5-0eea-4365364143b6@deltatee.com>
 <20180314025639.GA50067@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <45A47A71-B435-4DFA-8925-8EB91CEAB230@raithlin.com>

>I assume you want to exclude Root Ports because of multi-function
>  devices and the "route to self" error.  I was hoping for a reference
>  to that so I could learn more about it.

Apologies Bjorn. This slipped through my net. I will try and get you a reference for RTS in the next couple of days.
    
> While I was looking for it, I found sec 6.12.1.2 (PCIe r4.0), "ACS
> Functions in SR-IOV Capable and Multi-Function Devices", which seems
> relevant.  It talks about "peer-to-peer Requests (between Functions of
> the device)".  Thay says to me that multi-function devices can DMA
> between themselves.
    
I will go take a look. Appreciate the link.

Stephen 
