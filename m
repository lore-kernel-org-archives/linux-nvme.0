From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 5 Oct 2018 09:39:36 -0600
Subject: [PATCH v9 11/13] nvme-pci: Add a quirk for a pseudo CMB
In-Reply-To: <20181005071044.GB23834@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-12-logang@deltatee.com> <20181005071044.GB23834@lst.de>
Message-ID: <4f844956-fe91-0ace-4f8e-4da3a747e593@deltatee.com>



On 2018-10-05 1:10 a.m., Christoph Hellwig wrote:
> On Thu, Oct 04, 2018@03:27:45PM -0600, Logan Gunthorpe wrote:
>> Introduce a quirk to use CMB-like memory on older devices that have
>> an exposed BAR but do not advertise support for using CMBLOC and
>> CMBSIZE.
>>
>> We'd like to use some of these older cards to test P2P memory.
> 
> I can't sat that I really like adding support for non-standardized
> "features" (vs bugs) in the nvme driver.
> 

I can live with this patch being dropped.

Logan
