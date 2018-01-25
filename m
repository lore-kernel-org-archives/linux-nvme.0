From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 Jan 2018 10:33:26 -0700
Subject: [PATCH] nvme-cli: Implement nvme_get_log13
In-Reply-To: <20180122203534.22765-1-scott.bauer@intel.com>
References: <20180122203534.22765-1-scott.bauer@intel.com>
Message-ID: <20180125173326.GA19484@localhost.localdomain>

On Mon, Jan 22, 2018@01:35:34PM -0700, Scott Bauer wrote:
> This fixes a portion of 722c71bb:
> nvme/vendor: Add get log LSP/LSO fields from 1.3 spec
> 
> This fixes up the code so it can use the same interface
> log we've had for awhile. People who wish to pass log
> specific parameters can use the new API.

Thanks, Scott. Applied.
