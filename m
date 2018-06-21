From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 21 Jun 2018 14:32:11 -0600
Subject: [PATCH] NVMe-CLI Fix id-ns fpi field when Human Readable option
 selected.
In-Reply-To: <20180621185817.1297-1-jeff.lien@wdc.com>
References: <20180621185817.1297-1-jeff.lien@wdc.com>
Message-ID: <20180621203211.GB26993@localhost.localdomain>

On Thu, Jun 21, 2018@01:58:17PM -0500, Jeff Lien wrote:
> Currently when fpi = 0, the Format Progress Indicator Remaining is
> 100% and should be 0%.  This patch fixes that condition.
> 
> Signed-off-by: Jeff Lien <jeff.lien at wdc.com>

Thanks for the catch, patch applied.
