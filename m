From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 15:16:06 +0200
Subject: [PATCH v2] nvme: allow 64-bit results in passthru commands
In-Reply-To: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
Message-ID: <20190816131606.GA26191@lst.de>

Sorry for not replying to the earlier version, and thanks for doing
this work.

I wonder if instead of using our own structure we'd just use
a full nvme SQE for the input and CQE for that output.  Even if we
reserve a few fields that means we are ready for any newly used
field (at least until the SQE/CQE sizes are expanded..).

On Fri, Aug 16, 2019@11:47:21AM +0200, Marta Rybczynska wrote:
> It is not possible to get 64-bit results from the passthru commands,
> what prevents from getting for the Capabilities (CAP) property value.
> 
> As a result, it is not possible to implement IOL's NVMe Conformance
> test 4.3 Case 1 for Fabrics targets [1] (page 123).

Not that I'm not sure passing through fabrics commands is an all that
good idea.  But we have pending NVMe TPs that use 64-bit result
values as well, so this seems like a good idea in general.
