From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 09 Aug 2019 11:13:49 +1000
Subject: [PATCH v4 0/4] nvme-pci: Support for Apple 201+ (T2 chip)
In-Reply-To: <ae14ef26-b4a5-1ef2-e2a9-581e813893fe@grimberg.me>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
 <ae14ef26-b4a5-1ef2-e2a9-581e813893fe@grimberg.me>
Message-ID: <885b0189e457095b73c8fd7fa7aaa1946d5c614f.camel@kernel.crashing.org>

On Thu, 2019-08-08@16:52 -0700, Sagi Grimberg wrote:
> > This series combines the original series and an updated version of
> > the
> > shared tags patch, and is rebased on nvme-5.4.
> > 
> > This adds support for the controller found in recent Apple machines
> > which is basically a SW emulated NVME controller in the T2 chip.
> > 
> > The original reverse engineering work was done by
> > Paul Pawlowski <paul at mrarm.io>.
> 
> Thanks, pulled to nvme-5.4

Thanks !

Cheers,
Ben.
