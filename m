From: sbates@raithlin.com (Stephen  Bates)
Date: Thu, 10 May 2018 18:41:09 +0000
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <20180510144137.GA3652@redhat.com>
References: <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
 <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
 <4e0d0b96-ab02-2662-adf3-fa956efd294c@deltatee.com>
 <2fc61d29-9eb4-d168-a3e5-955c36e5d821@amd.com>
 <94C8FE12-7FC3-48BD-9DCA-E6A427E71810@raithlin.com>
 <20180510144137.GA3652@redhat.com>
Message-ID: <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>

Hi Jerome

>    Note on GPU we do would not rely on ATS for peer to peer. Some part
>    of the GPU (DMA engines) do not necessarily support ATS. Yet those
>    are the part likely to be use in peer to peer.

OK this is good to know. I agree the DMA engine is probably one of the GPU components most applicable to p2pdma.
    
>    We (ake GPU people aka the good guys ;)) do no want to do peer to peer
>    for performance reasons ie we do not care having our transaction going
>    to the root complex and back down the destination. At least in use case
>    i am working on this is fine.

If the GPU people are the good guys does that make the NVMe people the bad guys ;-). If so, what are the RDMA people??? Again good to know.
    
>    Reasons is that GPU are giving up on PCIe (see all specialize link like
>    NVlink that are popping up in GPU space). So for fast GPU inter-connect
>    we have this new links. 

I look forward to Nvidia open-licensing NVLink to anyone who wants to use it ;-). Or maybe we'll all just switch to OpenGenCCIX when the time comes.
    
>    Also the IOMMU isolation do matter a lot to us. Think someone using this
>    peer to peer to gain control of a server in the cloud.
    
I agree that IOMMU isolation is very desirable. Hence the desire to ensure we can keep the IOMMU on while doing p2pdma if at all possible whilst still delivering the desired performance to the user.

Stephen    
