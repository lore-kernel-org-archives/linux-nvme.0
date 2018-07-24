From: okaya@kernel.org (Sinan Kaya)
Date: Mon, 23 Jul 2018 17:40:02 -0700
Subject: [PATCH v2 2/2] PCI: NVMe device specific reset quirk
In-Reply-To: <20180724001310.7671.41243.stgit@gimli.home>
References: <20180724000944.7671.64284.stgit@gimli.home>
 <20180724001310.7671.41243.stgit@gimli.home>
Message-ID: <abc86e6b-7df5-a84c-7e98-107c605812c6@kernel.org>

On 7/23/2018 5:13 PM, Alex Williamson wrote:
> + * The NVMe specification requires that controllers support PCIe FLR, but
> + * but some Samsung SM961/PM961 controllers fail to recover after FLR (-1
> + * config space) unless the device is quiesced prior to FLR.

Does disabling the memory bit in PCI config space as part of the FLR 
reset function help? (like the very first thing)

Can we do that in the pcie_flr() function to cover other endpoint types
that might be pushing traffic while code is trying to do a reset?
