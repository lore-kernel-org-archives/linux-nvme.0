From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 24 Jul 2018 20:48:16 -0600
Subject: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <70619fc4-3b98-4213-0d4e-aa7aa248f88d@interlog.com>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
 <86e23e58-6f80-7957-30f7-8b0ce8cb50ce@wdc.com>
 <20180725011543.GA14596@localhost.localdomain>
 <70619fc4-3b98-4213-0d4e-aa7aa248f88d@interlog.com>
Message-ID: <20180725024816.GB14596@localhost.localdomain>

On Tue, Jul 24, 2018@09:56:35PM -0400, dgilbert@interlog.com wrote:
> No LLD should be calling scsi_finish_command() IMO.

Agreed. I don't even think scsi's error handler should directly call it
either, but detangling that may take some time, if ever.
