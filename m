From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 00:17:54 +0200
Subject: [PATCH] NVMe: Added another device ID with stripe quirk
In-Reply-To: <1499379151-32479-1-git-send-email-david.fugate@intel.com>
References: <1499379151-32479-1-git-send-email-david.fugate@intel.com>
Message-ID: <20170706221754.GA10217@lst.de>

On Thu, Jul 06, 2017@04:12:31PM -0600, David Wayne Fugate wrote:
> Adds a fourth Intel controller which has the "stripe" quirk.

NVMe has stadardized a way to communicate this information through
the Namespace Optimal IO Boundary (NOIOB) field in the Identify
Namespace structure, and Keith and Amber at Intel helped to define
this, so please actually implement it in your controllers.
