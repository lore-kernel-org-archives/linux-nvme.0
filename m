From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 8 May 2018 16:10:19 -0600
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180508160336.0935ddde@w520.home>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508144341.0441b676@w520.home>
 <a524127a-3557-3dff-971c-dfe94ba5a01c@deltatee.com>
 <20180508152631.50fd583c@w520.home>
 <354F7407-0DC7-470C-B9AA-74FDF9C46B08@raithlin.com>
 <20180508160336.0935ddde@w520.home>
Message-ID: <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>



On 08/05/18 04:03 PM, Alex Williamson wrote:
> If IOMMU grouping implies device assignment (because nobody else uses
> it to the same extent as device assignment) then the build-time option
> falls to pieces, we need a single kernel that can do both.  I think we
> need to get more clever about allowing the user to specify exactly at
> which points in the topology they want to disable isolation.  Thanks,


Yeah, so based on the discussion I'm leaning toward just having a
command line option that takes a list of BDFs and disables ACS for them.
(Essentially as Dan has suggested.) This avoids the shotgun.

Then, the pci_p2pdma_distance command needs to check that ACS is
disabled for all bridges between the two devices. If this is not the
case, it returns -1. Future work can check if the EP has ATS support, in
which case it has to check for the ACS direct translated bit.

A user then needs to either disable the IOMMU and/or add the command
line option to disable ACS for the specific downstream ports in the PCI
hierarchy. This means the IOMMU groups will be less granular but
presumably the person adding the command line argument understands this.

We may also want to do some work so that there's informative dmesgs on
which BDFs need to be specified on the command line so it's not so
difficult for the user to figure out.

Logan
