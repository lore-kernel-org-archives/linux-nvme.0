From: eliezer.tamir@linux.intel.com (Eliezer Tamir)
Date: Fri, 20 Nov 2015 15:04:42 +0200
Subject: [RFC PATCH] nvme: add HW API tags
In-Reply-To: <20151118135530.GA9473@infradead.org>
References: <20151117144817.90025.53888.stgit@coronium.jer.intel.com>
 <20151117150534.GA2604@infradead.org> <564B5F15.5010700@linux.intel.com>
 <20151118135530.GA9473@infradead.org>
Message-ID: <564F1A6A.6020401@linux.intel.com>


On 18/11/2015 15:55, Christoph Hellwig wrote:
> On Tue, Nov 17, 2015@07:08:37PM +0200, Eliezer Tamir wrote:
>> HW validation would like to use parts of the real Linux driver to
>> exercise the HW, instead of writing their own driver.
>>
>> This is a very custom environment (not a full OS) and the code needs to
>> be preprocessed for it. The hwapi tag tells our preprocessor which
>> functions must be left in.
>>
>> We thought that this would be less intrusive than moving the code to a
>> separate file, which would force some unneeded changes to the code.
> 
> Just mark them manually when you generate your validation workload.
> These functions will regularly change, so your code calling it will
> change as well anyway.

That is a valid point. However, I hope to find a better solution than
making a manual list whenever the tool is used.

Marking manually will not work well, because the people that use the
tools are HW experts, not Linux guys.

Even tough the functions themselves change regularly, the list of
functions to include would change much less thank that.
The code calling the imported code would sometimes break and need
fixing, but this would mostly happen only when you change the
interface, not the implementation.

The rules for maintaining the tags would be very simple:
If you replace a tagged function, the new function needs the tag.
If you split a tagged function into two both should have it.
