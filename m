From: mlin@kernel.org (Ming Lin)
Date: Mon, 18 Apr 2016 10:37:42 -0700
Subject: [PATCH] nvme: add helper nvme_cleanup_cmd()
In-Reply-To: <20160418152800.GB4640@localhost.localdomain>
References: <1460871346-10811-1-git-send-email-mlin@kernel.org>
 <20160418152800.GB4640@localhost.localdomain>
Message-ID: <CAF1ivSbpzSOvqjSnvZVQpR_KvOYXvvh7hh_ZcUXteG2YBG1t2g@mail.gmail.com>

On Mon, Apr 18, 2016@8:28 AM, Keith Busch <keith.busch@intel.com> wrote:
> On Sat, Apr 16, 2016@10:35:46PM -0700, Ming Lin wrote:
>> From: Ming Lin <ming.l at ssi.samsung.com>
>>
>> This hides command cleanup into core.c and fabrics drivers will
>> also use it.
>
> Can we just make this a static inline in nvme.h instead of adding a
> new export?

OK to me. I'll send a new one if no objection.
