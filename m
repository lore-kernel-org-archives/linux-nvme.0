From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jul 2019 23:27:17 +0200
Subject: [PATCH rfc] nvme-tcp: support simple polling
In-Reply-To: <70b60d78-1a77-ddb0-3414-e0c26d657e4f@grimberg.me>
References: <20190703210804.23137-1-sagi@grimberg.me>
 <20190709202201.GB8405@lst.de>
 <70b60d78-1a77-ddb0-3414-e0c26d657e4f@grimberg.me>
Message-ID: <20190709212717.GA9636@lst.de>

On Tue, Jul 09, 2019@02:26:04PM -0700, Sagi Grimberg wrote:
>> Looks good enough to me, especially now that we need to explicitly opt
>> into polling queues.
>
> Cool, so unless we have any objections, lets let it sit in 5.3?

Well, the 5.3 merge window is over, I'm not sure how happy Jens would
be about this new feature.
