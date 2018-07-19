From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:46:02 +0200
Subject: [PATCH 5/5] nvme-multipath: parse entire ANA log page in
 nvme_set_ns_ana_state()
In-Reply-To: <20180716105837.101125-6-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-6-hare@suse.de>
Message-ID: <20180719144602.GB20422@lst.de>

On Mon, Jul 16, 2018@12:58:37PM +0200, Hannes Reinecke wrote:
> We need to parse the entire ANA log page, otherwise later namespaces
> will not be updates with the new ANA state.

nvme_set_ns_ana_state is only used if we looks for exactly one
namespace, there are no later namespaces to be updated.
