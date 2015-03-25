From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Mar 2015 20:09:56 +0000 (UTC)
Subject: NVMe controller reset
In-Reply-To: <BN1PR0401MB093109D5A517B461FC5893D8F20B0@BN1PR0401MB0931.namprd04.prod.outlook.com>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
 <BN1PR0401MB093179FFC1C61856942C2DD0F2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <B58D82457FDA0744A320A2FC5AC253B93BA99F32@fmsmsx104.amr.corp.intel.com>
 <31FEE40556302F408590926A3C4AC65FED54F404@BBYEXM01.pmc-sierra.internal>
 <alpine.LNX.2.00.1503232045420.32385@localhost.lm.intel.com>
 <31FEE40556302F408590926A3C4AC65FED550BAB@BBYEXM01.pmc-sierra.internal>
 <alpine.LNX.2.00.1503251458451.32385@localhost.lm.intel.com>
 <BN1PR0401MB093109D5A517B461FC5893D8F20B0@BN1PR0401MB0931.namprd04.prod.outlook.com>
Message-ID: <alpine.LNX.2.00.1503252006360.32385@localhost.lm.intel.com>

On Wed, 25 Mar 2015, Brandon Schulz wrote:
> One question I would pose is: Do we need to re-enumerate the namespaces after we do a reset?  It seems to me that there are situations where the set of namespaces on a device may change during a controller reset.  How would that best be handled?

Right now you should remove and rescan if the namespace inventory
list has changed. Something like this:

   # echo 1 > /sys/class/nvme/nvme0/device/remove
   # echo 1 > /sys/bus/pci/rescan

If the characteristics of an existing namespace changed, like from
a format operation, you can issue a BLKRRPART ioctl to the affected
namespace for it to be revalidated.
