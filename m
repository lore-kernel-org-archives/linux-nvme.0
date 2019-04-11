From: kbusch@kernel.org (Keith Busch)
Date: Thu, 11 Apr 2019 09:27:33 -0600
Subject: [PATCH 0/2] nvme: Check size of command structures
In-Reply-To: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
References: <20190411151832.26481-1-minwoo.im.dev@gmail.com>
Message-ID: <20190411152732.GA7312@localhost.localdomain>

On Fri, Apr 12, 2019@12:18:30AM +0900, Minwoo Im wrote:
> Many command structures have been added in linux/nvme.h wihtout
> BUILD_BUG_ON() check.  It also needs to be assured to avoid unintended
> growth of structures.

We're already protected from accidentally increasing a command size since
'struct nvme_command' unionizes them all. Its size would be the largest
command in the union and we do check it's 64 bytes. Unintended shrinkage,
though, that would require individual command type checks, so okay.
