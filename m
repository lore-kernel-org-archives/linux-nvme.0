From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Feb 2018 10:12:28 -0700
Subject: [PATCH v2] NVMe-CLI Fix fw_log Command json output
In-Reply-To: <20180205163559.25925-1-jeff.lien@wdc.com>
References: <20180205163559.25925-1-jeff.lien@wdc.com>
Message-ID: <20180205171228.GB31110@localhost.localdomain>

On Mon, Feb 05, 2018@10:35:59AM -0600, Jeff Lien wrote:
> Currently, the json output for the fw_log command slot number
> is zero based while the normal output is one based.  This patch
> will change the json output to one based.  It will also only
> print the revisions for the valid slots.

Thanks, applied.
