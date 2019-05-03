From: kbusch@kernel.org (Keith Busch)
Date: Fri, 3 May 2019 10:16:38 -0600
Subject: [PATCHv3 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <20190503133736.111201-3-hare@suse.de>
References: <20190503133736.111201-1-hare@suse.de>
 <20190503133736.111201-3-hare@suse.de>
Message-ID: <20190503161637.GB30291@localhost.localdomain>

On Fri, May 03, 2019@03:37:36PM +0200, Hannes Reinecke wrote:
> The CNTLID value is required to be unique, and we do rely on this
> for correct operation. So reject any controller for which a non-unique
> CNTLID has been detected.

Looks good. 

Reviewed-by: Keith Busch <keith.busch at intel.com>
