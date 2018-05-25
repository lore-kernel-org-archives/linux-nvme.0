From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 10:55:57 +0200
Subject: [PATCH 1/3] nvme: centralize discovery controller defaults
In-Reply-To: <20180524141817.127576-2-hare@suse.de>
References: <20180524141817.127576-1-hare@suse.de>
 <20180524141817.127576-2-hare@suse.de>
Message-ID: <20180525085557.GA19433@lst.de>

On Thu, May 24, 2018@04:18:15PM +0200, Hannes Reinecke wrote:
> When connecting to the discovery controller we have certain defaults
> to observe, so centralize them to avoid inconsistencies due to argument
> ordering.

Thanks, applied to nvme-4.18-2.
