From: xuehua@marvell.com (Xuehua Chen)
Date: Thu, 7 Jan 2016 17:38:21 +0000
Subject: Maximum NVMe IO command size > 1MB?
In-Reply-To: <20160106225457.GA23888@localhost.localdomain>
References: <cc642ee3fec8476b9034e1ee397e8f42@SC-EXCH01.marvell.com>
 <20160106193127.GA20732@localhost.localdomain>
 <680a6c16f5464419b7e1974d04026951@SC-EXCH01.marvell.com>
 <ba6abd8303c84156b1c530dcbf101f40@SC-EXCH01.marvell.com>,
 <20160106225457.GA23888@localhost.localdomain>
Message-ID: <db5ba696fc464726a126742f6cd973f0@SC-EXCH01.marvell.com>

Thanks, will try raising it and see how it go. 
________________________________________
From: Keith Busch [keith.busch@intel.com]
Sent: Wednesday, January 6, 2016 2:54 PM
To: Xuehua Chen
Cc: linux-nvme at lists.infradead.org
Subject: Re: Maximum NVMe IO command size > 1MB?

On Wed, Jan 06, 2016@09:56:24PM +0000, Xuehua Chen wrote:
> Hi, Keith,
>
> I wonder whether this could be caused by BIO_MAX_PAGES defined as 256, which means 1MB at most.
> What do you think?

I think you got it. You're running O_DIRECT, and fs/direct-io.c,
dio_new_bio() allocates up to BIO_MAX_PAGES.

I can't tell where the value for came from (looks like it was there from
the very first git commit), but maybe you can propose raising it if you
set BIO_MAX_PAGES higher without issue.
