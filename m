From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 4 Jan 2018 18:09:43 -0700
Subject: [PATCH 04/12] pci-p2p: Clear ACS P2P flags for all client devices
In-Reply-To: <20fdb5bb-0236-c093-ed53-e12664022f53@deltatee.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-5-logang@deltatee.com>
 <20180104215721.GF189897@bhelgaas-glaptop.roam.corp.google.com>
 <20180104153551.3118f71b@t450s.home>
 <20fdb5bb-0236-c093-ed53-e12664022f53@deltatee.com>
Message-ID: <99420cc9-48fd-5692-8426-bd5c2ec0dcf7@deltatee.com>



On 04/01/18 05:00 PM, Logan Gunthorpe wrote:
> 
> 
> On 04/01/18 03:35 PM, Alex Williamson wrote:
>> Yep, flipping these ACS bits invalidates any IOMMU groups that depend
>> on the isolation of that downstream port and I suspect also any peers
>> within the same PCI slot of that port and their downstream devices.? The
>> entire sub-hierarchy grouping needs to be re-evaluated.? This
>> potentially affects running devices that depend on that isolation, so
>> I'm not sure how that happens dynamically.? A boot option might be
>> easier.? Thanks,
> 

Also, considering this further: if you can point me to a way to tell if
a device is in an IOMMU group it should be pretty easy to disallow a
device that has been assigned to a group from being used in P2P
transactions.

Logan
