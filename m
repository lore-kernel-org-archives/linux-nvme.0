From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 13:03:02 +0200
Subject: [PATCH 1/2] nvmet: Move serial number from controller to subsystem
In-Reply-To: <20170714110004.11886-2-jthumshirn@suse.de>
References: <20170714110004.11886-1-jthumshirn@suse.de>
 <20170714110004.11886-2-jthumshirn@suse.de>
Message-ID: <20170714110302.GA22871@lst.de>

> +	if (!subsys->serial)
> +		get_random_bytes(&subsys->serial, sizeof(subsys->serial));

This should move to nvmet_subsys_alloc instead.
