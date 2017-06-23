From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Jun 2017 12:37:04 -0400
Subject: [PATCH nvme-cli v2] nvme-cli: add ns-descs subcommand
In-Reply-To: <20170623073635.3069-1-jthumshirn@suse.de>
References: <20170623073635.3069-1-jthumshirn@suse.de>
Message-ID: <20170623163704.GB9221@localhost.localdomain>

On Fri, Jun 23, 2017@09:36:35AM +0200, Johannes Thumshirn wrote:
> NVMe 1.3 defines the "Namespace Identification Descriptor" command in
> NVMe Identify NS. This command returns a list of so called Namespace
> Identificastion Descriptors which currently can either be a EUI-64,
> a NGUID or a UUID.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks! Applied.
