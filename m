From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:27:14 +0200
Subject: [RFC PATCH 1/8] nvme-core: add new interfaces
In-Reply-To: <8dcebc55-0bbb-299f-b715-cdc43faddfce@grimberg.me>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>
 <8dcebc55-0bbb-299f-b715-cdc43faddfce@grimberg.me>
Message-ID: <20180413172714.GA23674@lst.de>

On Wed, Apr 04, 2018@02:52:15PM +0300, Sagi Grimberg wrote:
> What happens when the nvme device unplugs from the system? We have a
> dangling reference to the controller.. Then when/if the device returns
> it will occupy another controller name (instance id is occupied).
>
> Do we know (or want to know) how to handle such a case?

That is annoying but not really any different from someone holding
open the block or char device, isn't it?
