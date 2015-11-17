From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 17 Nov 2015 07:05:34 -0800
Subject: [RFC PATCH] nvme: add HW API tags
In-Reply-To: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>
References: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>
Message-ID: <20151117150534.GA2604@infradead.org>

On Tue, Nov 17, 2015@04:48:17PM +0200, Eliezer Tamir wrote:
> The purpose of this RFC patch is to seek feedback on the way we want
> to tag upstream driver functions for silicon validation use.
> 
> These tags are used by pre-silicon HW testing, marking functions that
> access the HW. They are defined out for normal driver compilation.
> (this patch applies to Linus' master)

I don't really think something like this has any business in the driver.
But if you can explain what you're trying to do we might be able to
help to archive it in a different way.
