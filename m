From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Oct 2016 15:39:38 +0200
Subject: Disconnecting nvmet-rdma
In-Reply-To: <fe8993ab-38c9-96a1-0c75-e018de246107@grimberg.me>
References: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>
 <20161019130009.GA5876@lst.de>
 <fe8993ab-38c9-96a1-0c75-e018de246107@grimberg.me>
Message-ID: <20161021133938.GB19067@lst.de>

On Thu, Oct 20, 2016@10:49:43AM +0300, Sagi Grimberg wrote:
> Where do you see indication for that in the code? TIMEWAIT doesn't make
> sense for listener cm_ids.

Nowhere, this was just a wild guess given the pain we had with these
listener IDs before.
