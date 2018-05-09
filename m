From: sbates@raithlin.com (Stephen  Bates)
Date: Wed, 9 May 2018 12:38:53 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
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
 <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
 <20180508163206.7d3bf383@w520.home>
 <CAPcyv4i1ksiu1pExF=EE21P2Wz1a9LaDaG247oG_WSbYgcR93g@mail.gmail.com>
 <2ce7908d-1422-55f8-aeba-94ccce2cb484@deltatee.com>
Message-ID: <BFD17865-3125-469C-B736-9A60D9B35B63@raithlin.com>

Hi Logan

>    Yeah, I'm having a hard time coming up with an easy enough solution for
>    the user. I agree with Dan though, the bus renumbering risk would be
>    fairly low in the custom hardware seeing the switches are likely going
>    to be directly soldered to the same board with the CPU.
    
I am afraid that soldered down assumption may not be valid. More and more PCIe cards with PCIe switches on them are becoming available and people are using these to connect servers to arrays of NVMe SSDs which may make the topology more dynamic.

Stephen
