From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Dec 2017 15:42:57 -0700
Subject: [PATCH] NVMe: Format fix when going from 4k sector size to 512
 bytes
In-Reply-To: <20171214204936.17793-1-jeff.lien@wdc.com>
References: <20171214204936.17793-1-jeff.lien@wdc.com>
Message-ID: <20171214224257.GE26752@localhost.localdomain>

On Thu, Dec 14, 2017@02:49:36PM -0600, Jeff Lien wrote:
> If you format a device with a 4k sector size back to 512 bytes,
> the queue limit values for physical block size and IO sizes were
> not getting updated; only the logical block size was being
> updated.  This patch adds code to update the physical block
> and IO sizes.

That's true, though I always considered that to be a happy accident. As
far as I know, most NVMe SSDs advertising a 512 byte logical block are
only emulating that size, and are natively 4k or larger.
