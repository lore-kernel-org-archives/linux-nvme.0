From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 15 Jun 2018 08:21:58 -0600
Subject: [PATCH] nvme-cli: Implemented virtualization management admin
 command
In-Reply-To: <20180615093732.GD10928@infradead.org>
References: <20180614232422.5570-1-revanth.rajashekar@intel.com>
 <20180615093732.GD10928@infradead.org>
Message-ID: <20180615142158.GD8129@localhost.localdomain>

On Fri, Jun 15, 2018@02:37:32AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018@05:24:22PM -0600, Revanth Rajashekar wrote:
> > Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
> 
> How has this been tested?  Especially the flexible resource assignments
> really need some kernel support so that the host driver can stop
> using the resources.

I'm not sure this can be sufficiently tested without some prep-patches
adding Identify Primary Controller Capabilities and Identify Secondary
Controler List commands.

But what do we need from the primary controller driver to support this?

Flexible resources assigned to a primary controller are are not
actually used or released until you do a controller reset following your
virtualization management commands, so the driver will automatically
react to the new assignment.

For a secondary controller's flexible resource assignement, you can only
assign flexible resources from the primary controller when the secondary
is offline, so the resources should be discovered by the driver when
the controller is brought online again.

Neither appear to have a requirement for the driver to be aware these
management commands are happening.
