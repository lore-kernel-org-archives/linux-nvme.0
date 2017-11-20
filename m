From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Nov 2017 09:18:09 +0100
Subject: [PATCH v2 1/3] nvme-rdma: don't suppress send completions
In-Reply-To: <921c4331-9456-3783-423a-9c5c5e405131@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-2-sagi@grimberg.me> <20171109091858.GA16966@lst.de>
 <921c4331-9456-3783-423a-9c5c5e405131@grimberg.me>
Message-ID: <20171120081809.GB27552@lst.de>

On Thu, Nov 09, 2017@01:08:04PM +0200, Sagi Grimberg wrote:
> Probably only those that support in-capsule data (which I hear
> SRP does too these days).

SRP-2 adds inline data, and Bart's out of tree code has been supporting
that for a long time.

> There is one case I still don't want to signal send completion, thats
> the AEN request. It doesn't have a request structure, and preferred not
> to check on it for every send completion, and its not racing anything
> (mentioned this above).
>
> I can change that though if there is a strong desire.

I don't really like having a special case just for this slow path
special case.  So if we can avoid it without too much overhead let's
do it, otherwise we can keep it as-is.
