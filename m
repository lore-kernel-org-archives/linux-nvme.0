From: eliezer.tamir@linux.intel.com (Eliezer Tamir)
Date: Tue, 17 Nov 2015 19:08:37 +0200
Subject: [RFC PATCH] nvme: add HW API tags
In-Reply-To: <20151117150534.GA2604@infradead.org>
References: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>
 <20151117150534.GA2604@infradead.org>
Message-ID: <564B5F15.5010700@linux.intel.com>


On 17/11/2015 17:05, Christoph Hellwig wrote:
> On Tue, Nov 17, 2015@04:48:17PM +0200, Eliezer Tamir wrote:

>> These tags are used by pre-silicon HW testing, marking functions that
>> access the HW. They are defined out for normal driver compilation.
>> (this patch applies to Linus' master)
> 
> I don't really think something like this has any business in the driver.
> But if you can explain what you're trying to do we might be able to
> help to archive it in a different way.

HW validation would like to use parts of the real Linux driver to
exercise the HW, instead of writing their own driver.

This is a very custom environment (not a full OS) and the code needs to
be preprocessed for it. The hwapi tag tells our preprocessor which
functions must be left in.

We thought that this would be less intrusive than moving the code to a
separate file, which would force some unneeded changes to the code.

Thanks,
Eliezer
