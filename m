From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Mon, 5 Feb 2018 16:49:11 +0000
Subject: [PATCH] NVMe-CLI Fix command failures in regress script
In-Reply-To: <20180202213829.GL24417@localhost.localdomain>
References: <20180202195021.8560-1-jeff.lien@wdc.com>
 <20180202202930.GK24417@localhost.localdomain>
 <MWHPR04MB102561D215C063C6967513F4EAF90@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20180202213829.GL24417@localhost.localdomain>
Message-ID: <MWHPR04MB1025A39C17C55A89D61A6E58EAFE0@MWHPR04MB1025.namprd04.prod.outlook.com>

Keith,
That doesn't seem to happen with our nvme device.  Below is what I get when I run the regress script as is.  Am I missing something on the invocation?

./regress -d /dev/nvme0 -l -w
WARNING: Write mode enabled, this might trash your drive!
NVME_VERSION = 1.5.79.ga75e.dirty
  RUN   nvme list                                                            : PASSED!
  RUN   nvme id-ctrl /dev/nvme0                                              : PASSED!
  RUN   nvme id-ns -raw-binary /dev/nvme0                                    : FAILED!
Failed running command: 
   nvme id-ns -raw-binary /dev/nvme0
  RUN   nvme list-ns -n 1 /dev/nvme0                                         : PASSED!
  RUN   nvme get-ns-id /dev/nvme0                                            : PASSED!
  RUN   nvme get-log /dev/nvme0 --log-id=2 --log-len=512                     : PASSED!
  RUN   nvme fw-log /dev/nvme0                                               : PASSED!
  RUN   nvme fw-log /dev/nvme0 -b                                            : PASSED!
  RUN   nvme smart-log /dev/nvme0                                            : PASSED!
  RUN   nvme error-log /dev/nvme0                                            : PASSED!
  RUN   nvme get-feature /dev/nvme0 -f 7                                     : PASSED!
  RUN   nvme flush /dev/nvme0                                                : FAILED!
Failed running command: 
   nvme flush /dev/nvme0
  RUN   dd if=/dev/urandom of=temp.rand.write bs=4k count=1                  : PASSED!
  RUN   nvme write /dev/nvme0 --start-block=0 --block-count=0 --data-size=4  : FAILED!
Failed running command: 
   nvme write /dev/nvme0 --start-block=0 --block-count=0 --data-size=4k --data temp.rand.write
  RUN   nvme read /dev/nvme0 --start-block=0 --block-count=0 --data-size=4k  : FAILED!
Failed running command: 
   nvme read /dev/nvme0 --start-block=0 --block-count=0 --data-size=4k --data temp.rand.read --latency
  RUN   diff temp.rand.read temp.rand.write                                  : FAILED!
Failed running command: 
   diff temp.rand.read temp.rand.write


Jeff Lien

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Friday, February 2, 2018 3:38 PM
To: Jeffrey Lien
Cc: linux-nvme at lists.infradead.org; David Darrington
Subject: Re: [PATCH] NVMe-CLI Fix command failures in regress script

On Fri, Feb 02, 2018@09:33:12PM +0000, Jeffrey Lien wrote:
> Keith,
> Then should we remove the commands that require a namespace id (ie id-ns, flush, write, and read)?  

If you provide a block device, nvme-cli will automatically figure out the nsid if you didn't provide one.
