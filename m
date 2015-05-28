From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 28 May 2015 00:18:44 -0700
Subject: [NVME-CLI] Status Update
In-Reply-To: <36F6EBABA23FEF4391AF72944D228901B6BE2CD7@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D228901B6BE2CD7@BBYEXM01.pmc-sierra.internal>
Message-ID: <20150528071844.GA25896@infradead.org>

On Wed, May 27, 2015@10:28:20PM +0000, Stephen Bates wrote:
> Hi All
> 
> I just wanted to send out an update on the nvme-cli tool that Keith and I have been maintaining. We have performed a few upgrades over the past few months and based on traffic this tool seems to be getting some amount of usage. 
> 
> 1. Code is available here - https://github.com/linux-nvme/nvme-cli
> 2. Code is now Apache licensed (except for the nvme.h file which of course has to be GPL). Hopefully this will encourage adoption.

How can you use a GPL header in an otherwise Apache licenced program?
That's contrictory licensing that makes distributing the tool basically
impossible.
