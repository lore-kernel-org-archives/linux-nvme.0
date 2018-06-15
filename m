From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Jun 2018 02:37:32 -0700
Subject: [PATCH] nvme-cli: Implemented virtualization management admin
 command
In-Reply-To: <20180614232422.5570-1-revanth.rajashekar@intel.com>
References: <20180614232422.5570-1-revanth.rajashekar@intel.com>
Message-ID: <20180615093732.GD10928@infradead.org>

On Thu, Jun 14, 2018@05:24:22PM -0600, Revanth Rajashekar wrote:
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>

How has this been tested?  Especially the flexible resource assignments
really need some kernel support so that the host driver can stop
using the resources.
