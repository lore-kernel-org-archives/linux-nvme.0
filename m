From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 17:23:42 -0700
Subject: [PATCH] nvme: Add fault injection feature
In-Reply-To: <1516666161-3716-1-git-send-email-thomas.tai@oracle.com>
References: <1516666161-3716-1-git-send-email-thomas.tai@oracle.com>
Message-ID: <20180123002341.GU12043@localhost.localdomain>

On Mon, Jan 22, 2018@07:09:21PM -0500, Thomas Tai wrote:
> 
> Once the error injection is enabled, BLK_STS_IOERR will be
> injected into the nvme_setup_cmd. Following example shows
> how to inject an error.

That doesn't seem like a very interesting place to inject an
error. Woudln't nvme_end_request be more interesting?
