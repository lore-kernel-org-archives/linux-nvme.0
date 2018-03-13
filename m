From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 13 Mar 2018 12:40:13 -0600
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
Message-ID: <a01a0ef4-3b0a-b169-2628-cb8fbe51867c@deltatee.com>



On 12/03/18 09:28 PM, Sinan Kaya wrote:
> Maybe, dev parameter should also be struct pci_dev so that you can get rid of
> all to_pci_dev() calls in this code including find_parent_pci_dev() function.

No, this was mentioned in v2. find_parent_pci_dev is necessary because 
the calling drivers aren't likely to have a bunch of struct pci_dev's 
for all the devices they are working with lying around. It's a much 
nicer from an API stand point to take struct devs and not worth it just 
to have a PCI API only taking struct pci_devs.

Logan
