From: mwilck@suse.com (Martin Wilck)
Date: Thu, 05 Apr 2018 21:35:10 +0200
Subject: [PATCH] nvmet: fix space padding in serial number
In-Reply-To: <20180405191941.318707-1-daniel.verkamp@intel.com>
References: <20180405191941.318707-1-daniel.verkamp@intel.com>
Message-ID: <1522956910.22625.26.camel@suse.com>

On Thu, 2018-04-05@12:19 -0700, Daniel Verkamp wrote:
> Commit 42de82a8b544 previously attempted to fix this, and it did
> correctly pad the MN and FR fields with spaces, but the SN field
> still
> contains 0 bytes.  The current code fills out the first 16 bytes with
> hex2bin, leaving the last 4 bytes zeroed.  Rather than adding a lot
> of
> error-prone math to avoid overwriting SN twice, just set the whole
> thing
> to spaces up front (it's only 20 bytes).
> 
> Fixes: 42de82a8b544 ("nvmet: don't report 0-bytes in serial number")
> Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>

Reviewed-by: Martin Wilck <mwilck at suse.com>

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
