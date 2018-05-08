From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 8 May 2018 21:35:08 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180508205005.GC15608@redhat.com>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
Message-ID: <F2F18B0F-8083-4A2C-AD21-58E460F5FD1B@raithlin.com>

Hi Jerome

>    I think there is confusion here, Alex properly explained the scheme
>   PCIE-device do a ATS request to the IOMMU which returns a valid
>    translation for a virtual address. Device can then use that address
>    directly without going through IOMMU for translation.

This makes sense and to be honest I now understand ATS and its interaction with ACS a lot better than I did 24 hours ago ;-).

>    ATS is implemented by the IOMMU not by the device (well device implement
>    the client side of it). Also ATS is meaningless without something like
>    PASID as far as i know.
    
I think it's the client side that is what is important to us. Not many EPs support ATS today and it's not clear if many will in the future.  So assuming we want to do p2pdma between devices (some of) which do NOT support ATS how best do we handle the ACS issue? Disabling the IOMMU seems a bit strong to me given this impacts all the PCI domains in the system and not just the domain we wish to do P2P on.

Stephen
