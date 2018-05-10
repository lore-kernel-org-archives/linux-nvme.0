From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 10 May 2018 13:10:15 -0600
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all
 devices behind switches
In-Reply-To: <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
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
 <B525870A-B25E-46BB-B501-DAA39F1741DC@raithlin.com>
Message-ID: <20180510131015.4ad59477@w520.home>

On Thu, 10 May 2018 18:41:09 +0000
"Stephen  Bates" <sbates at raithlin.com> wrote:    
> >    Reasons is that GPU are giving up on PCIe (see all specialize link like
> >    NVlink that are popping up in GPU space). So for fast GPU inter-connect
> >    we have this new links.   
> 
> I look forward to Nvidia open-licensing NVLink to anyone who wants to use it ;-).

No doubt, the marketing for it is quick to point out the mesh topology
of NVLink, but I haven't seen any technical documents that describe the
isolation capabilities or IOMMU interaction.  Whether this is included
or an afterthought, I have no idea.

> >    Also the IOMMU isolation do matter a lot to us. Think someone using this
> >    peer to peer to gain control of a server in the cloud.  


From that perspective, do we have any idea what NVLink means for
topology and IOMMU provided isolation and translation?  I've seen a
device assignment user report that seems to suggest it might pretend to
be PCIe compatible, but the assigned GPU ultimately doesn't work
correctly in a VM, so perhaps the software compatibility is only so
deep. Thanks,

Alex
