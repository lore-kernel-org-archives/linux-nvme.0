From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Apr 2017 09:12:25 -0400
Subject: PRP1 not min page size aligned in read/write cmds
In-Reply-To: <CAG3=cOn1rZHQ7dETovf5n=_3QRSMOrZFC+PibNJiQeH0kr2ZWA@mail.gmail.com>
References: <CAG3=cOn1rZHQ7dETovf5n=_3QRSMOrZFC+PibNJiQeH0kr2ZWA@mail.gmail.com>
Message-ID: <20170405131225.GR20181@localhost.localdomain>

On Tue, Apr 04, 2017@06:28:30PM -0700, Nisha Miller wrote:
> We have specified Min page size as 4K in our FW. So we expect that all
> read/write commands sent to FW will operate on multiples of 4K blocks.
> However we observe that sometimes we receive read/write commands where
> the PRP1 address is not 4K aligned, e.g 0x84CD5CD50. Is this normal or
> expected?

Yes, the first PRP entry and any list pointer may have an offset. The
remaining entries can not. See section 4.3, figure 14 in NVMe 1.2.1 spec.
