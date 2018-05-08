From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 8 May 2018 13:13:40 -0600
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
Message-ID: <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>



On 08/05/18 10:50 AM, Christian K?nig wrote:
> E.g. transactions are initially send to the root complex for 
> translation, that's for sure. But at least for AMD GPUs the root complex 
> answers with the translated address which is then cached in the device.
> 
> So further transactions for the same address range then go directly to 
> the destination.

Sounds like you are referring to Address Translation Services (ATS).
This is quite separate from ACS and, to my knowledge, isn't widely
supported by switch hardware.

Logan
