From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Nov 2018 08:31:11 -0700
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181126133839.GA4348@dingwall.me.uk>
References: <20181126133839.GA4348@dingwall.me.uk>
Message-ID: <20181126153110.GM26707@localhost.localdomain>

On Mon, Nov 26, 2018@01:38:39PM +0000, James Dingwall wrote:
> Hi,
> 
> We have also encountered this issue but the devices have a customised
> firmware from Lenovo:
> 
> # nvme id-ctrl /dev/nvme0
> NVME Identify Controller:
> vid : 0x8086
> ssvid : 0x8086
> sn : BTHH82250N1X1P0E
> mn : INTEL SSDPEKKF010T8L
> fr : L08P
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803692?comments=all
> 
> I tried to force install the Intel firmware but that did not work.  I
> was fobbed off by Lenovo support with a 'we don't support Linux' even
> after pointing out the upstream Intel fix.  Is there any possibility
> of being able to work around this in the nvme code?
> 
> Thanks,
> James

Hi James,

According to the resolution discussion here:

  https://downloadcenter.intel.com/download/28320/Known-Issue-Intel-SSD-760p-Pro-7600p-Series-SubNQN-Conflict-on-Linux

  "
  If you purchased your Intel? SSD from an OEM, your firmware version may
  have a different naming. Contact your local OEM representative for
  latest firmware revisions.
  "

Sounds like Lenovo will need to merge the Intel update into their
specific firmware if they haven't already done so.

Thansk,
Keith
