From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 26 Apr 2017 00:22:48 -0700
Subject: [PATCH] nvme-scsi: Use correct byte ordering for eui64 in Dev ID
 VPD
In-Reply-To: <20170425201809.1683-1-jonathan.derrick@intel.com>
References: <20170425201809.1683-1-jonathan.derrick@intel.com>
Message-ID: <20170426072248.GA8552@infradead.org>

On Tue, Apr 25, 2017@02:18:09PM -0600, Jon Derrick wrote:
> NVME specifies an EUI64/NGUID in little-endian format, while SCSI
> specifies that the Device Identification VPD use big-endian for EUI
> formats. The current code copies this bytestream directly from the
> Identification Namespace page, meaning we just need to reverse the
> bytestream when passing it on to the VPD.

This will break existing setups that rely on VPD 0x83 for device
identification (which I think includes older SuSE distros).

And once you change the setup anyway please stop using this buggy
SCSI emulation.
