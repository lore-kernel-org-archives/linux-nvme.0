From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 2 May 2018 09:56:09 -0600
Subject: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
Message-ID: <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>

Hi Christian,

On 5/2/2018 5:51 AM, Christian K?nig wrote:
> it would be rather nice to have if you could separate out the functions 
> to detect if peer2peer is possible between two devices.

This would essentially be pci_p2pdma_distance() in the existing 
patchset. It returns the sum of the distance between a list of clients 
and a P2PDMA provider. It returns -1 if peer2peer is not possible 
between the devices (presently this means they are not behind the same 
root port).

Logan
