From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:32:03 +0200
Subject: [PATCH v4 0/8] Implement NVMe Namespace Descriptor Identification
In-Reply-To: <20170604103649.22130-1-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
Message-ID: <20170605053203.GB19480@lst.de>

On Sun, Jun 04, 2017@12:36:41PM +0200, Johannes Thumshirn wrote:
> The Namespace Identification Descriptor list is the only way a target
> can identify itself via the newly introduced UUID to the host (instead
> of the EUI-64 or NGUID).

s/instead/in addition/

> While I was already touching the relevant code paths, I decided to
> also include the EUI-64 in the 'Identify Namespace' command response.

Not anymore :)
