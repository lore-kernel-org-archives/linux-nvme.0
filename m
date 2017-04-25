From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 25 Apr 2017 14:55:19 -0600
Subject: [PATCH] nvme-scsi: Use correct byte ordering for eui64 in Dev ID
 VPD
In-Reply-To: <20170425201809.1683-1-jonathan.derrick@intel.com>
References: <20170425201809.1683-1-jonathan.derrick@intel.com>
Message-ID: <894f6326-35e9-583b-80a8-f7df54c683b0@intel.com>

On 04/25/2017 02:18 PM, Jon Derrick wrote:
> NVME specifies an EUI64/NGUID in little-endian format, while SCSI
> specifies that the Device Identification VPD use big-endian for EUI
> formats. The current code copies this bytestream directly from the
> Identification Namespace page, meaning we just need to reverse the
> bytestream when passing it on to the VPD.
> 

This seems to hold true for NGUID devices, but Keith just pointed out to
me that it may not hold true for EUI64 devices. It seems like that case
needs byte swiveling within each field. So I'll NAK for now until I can
figure out if that's the case.
