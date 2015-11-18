From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 18 Nov 2015 05:55:30 -0800
Subject: [RFC PATCH] nvme: add HW API tags
In-Reply-To: <564B5F15.5010700@linux.intel.com>
References: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>
 <20151117150534.GA2604@infradead.org>
 <564B5F15.5010700@linux.intel.com>
Message-ID: <20151118135530.GA9473@infradead.org>

On Tue, Nov 17, 2015@07:08:37PM +0200, Eliezer Tamir wrote:
> HW validation would like to use parts of the real Linux driver to
> exercise the HW, instead of writing their own driver.
> 
> This is a very custom environment (not a full OS) and the code needs to
> be preprocessed for it. The hwapi tag tells our preprocessor which
> functions must be left in.
> 
> We thought that this would be less intrusive than moving the code to a
> separate file, which would force some unneeded changes to the code.

Just mark them manually when you generate your validation workload.
These functions will regularly change, so your code calling it will
change as well anyway.
