From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 24 Aug 2018 13:11:06 -0600
Subject: [PATCH] nvme-cli: Fix the displayed metadata length value on Big
 Endian systems.
In-Reply-To: <1535135667-32608-1-git-send-email-jeff.lien@wdc.com>
References: <1535135667-32608-1-git-send-email-jeff.lien@wdc.com>
Message-ID: <20180824191106.GA26522@localhost.localdomain>

On Fri, Aug 24, 2018@01:34:27PM -0500, Jeff Lien wrote:
> On BE systems, the metadata length value displayed as part of the
> format in the nvme list command is byte swapped.  So a value of 0
> appears just fine but a value of 8 bytes is displayed as 0x0800.
> This patch fixes that is the value is correct for both LE and BE
> systems.
> 
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>

Thanks, applied.
