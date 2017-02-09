From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Feb 2017 15:57:13 +0100
Subject: [PATCH] block: sed-opal: reduce stack size of ioctl handler
In-Reply-To: <20170208221221.GA10983@sbauer-Z170X-UD5>
References: <20170208211546.2789607-1-arnd@arndb.de>
 <20170208215827.GA9733@sbauer-Z170X-UD5>
 <20170208221221.GA10983@sbauer-Z170X-UD5>
Message-ID: <CAK8P3a17jfnGGtrb=AmY2_8R2CP8sBoUCC9NQD1w2sd_SFvOBg@mail.gmail.com>

On Wed, Feb 8, 2017@11:12 PM, Scott Bauer <scott.bauer@intel.com> wrote:
> On Wed, Feb 08, 2017@02:58:28PM -0700, Scott Bauer wrote:
>> Thank you for the report. We want to keep the function calls agnostic to userland.
>> In the future we will have in-kernel callers and I don't want to have to do any
>> get_fs(KERNEL_DS) wizardry.
>>
>> Instead I think we can use a union to lessen the stack burden. I tested this patch just now
>> with config_ksasan and was able to build.
>
> Nack on this patch, it only really masks the issue. Keith pointed out we have a call chain
> up to this ioctl then deeper down into nvme then the block layer. If we use 25% of the stack
> just for this function it's still too dangerous and we'll run into corruption later on and not
> remember this fix. I'll come up with another solution.

I think there are two issues that cause the stack frame to explode
with KASAN, and
your patch addresses one but not the other:

1. checks for variables being accessed after they go out of scope.
This is solved by the
   union at the start of the function, as they never go out of scope now.

2. checks for array overflows when passing a local variable by
reference to another
   function that is not inlined.

To solve the second problem while keeping the in-kernel interface, the
approach that
David suggesteed would work, or you could have a wrapper around each function to
do the copy_from_user in a more obvious but verbose way as I had in my version.

With David's approach, you could actually replace the switch() with a
lookup table
as well.

    Arnd
