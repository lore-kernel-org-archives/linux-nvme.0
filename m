From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jun 2017 15:58:48 -0400
Subject: [PATCH] nvme-cli: Extended Data Structure in resv-report
In-Reply-To: <MWHPR06MB2496402FDC8379115F3885B88CDD0@MWHPR06MB2496.namprd06.prod.outlook.com>
References: <MWHPR06MB2496402FDC8379115F3885B88CDD0@MWHPR06MB2496.namprd06.prod.outlook.com>
Message-ID: <20170628195847.GA3110@localhost.localdomain>

On Wed, Jun 28, 2017@07:40:02PM +0000, Schremmer, Steven wrote:
> Allow user to specify cdw11 value to request Extended Data
> Structure. Update resv_report show and json functions to decode
> the returned data.
> 
> Signed-off-by: Steve Schremmer <steve.schremmer at netapp.com>

Looks great, applied.

Also, thanks for the fix to the nvme_reservation structure.
