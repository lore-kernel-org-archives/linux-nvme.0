From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Jan 2018 19:21:06 -0700
Subject: [PATCH 1/2] NVMe-CLI WDC-Plugin Add drive-essentials command
In-Reply-To: <20180118192138.32745-1-jeff.lien@wdc.com>
References: <20180118192138.32745-1-jeff.lien@wdc.com>
Message-ID: <20180119022106.GB12043@localhost.localdomain>

Thanks, Jeff. All applied.

I made minor modifications to account for recent changes to the internal
API, but the update should faithfully reflect your intention.

I think it may have been a mistake to not create a new get-log interface
so that the common use doesn't need to provide the LSP/LPO parameters. I
will try to get around to simplifying that before tagging another release,
but we'll see.
