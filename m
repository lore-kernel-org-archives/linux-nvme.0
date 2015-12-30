From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 30 Dec 2015 13:59:41 -0700
Subject: [PATCH 2/3] NVMe: Generate resource tree for CMB
In-Reply-To: <1451497679-1195-3-git-send-email-jonathan.derrick@intel.com>
References: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
 <1451497679-1195-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20151230205941.GA5808@localhost.localdomain>

> Maintains a resource tree for CMB resources. A sysfs file is exposed
> which is similar to a pci_dev resources file. The top entry is the
> range of the whole CMB resource, and the entries below that are the
> driver-reserved regions (currently only used by SQes).
> 

2 & 3's logs got mixed up when I split them.
If the patches look fine I will resend with better logs.
