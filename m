From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 8 May 2018 22:25:06 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20905682-9440-7d4b-0260-99d3dc794c3d@deltatee.com>
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
Message-ID: <C3CEE4DB-A001-4E4C-B9B9-4B160E4C5367@raithlin.com>

>    Yeah, so based on the discussion I'm leaning toward just having a
>    command line option that takes a list of BDFs and disables ACS for them.
>    (Essentially as Dan has suggested.) This avoids the shotgun.

I concur that this seems to be where the conversation is taking us.

@Alex - Before we go do this can you provide input on the approach? I don't want to re-spin only to find we are still not converging on the ACS issue....

Thanks

Stephen
    
