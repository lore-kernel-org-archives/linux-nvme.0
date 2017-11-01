From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 1 Nov 2017 15:17:06 +0000
Subject: [PATCH v2 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
In-Reply-To: <1509547836.2530.1.camel@wdc.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-3-bart.vanassche@wdc.com>
 <1509547836.2530.1.camel@wdc.com>
Message-ID: <CAKv+Gu_-pqqVn5QeuM_OR0itQS-v5uFATt-ZzNDmPy8CHSLrGg@mail.gmail.com>

On 1 November 2017@14:50, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Mon, 2017-10-16@15:49 -0700, Bart Van Assche wrote:
>> Use the sgl_alloc() and sgl_free() functions instead of open coding
>> these functions.
>>
>> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel at linaro.org>
>> Cc: Herbert Xu <herbert at gondor.apana.org.au>
>
> Ard and/or Herbert, can you please have a look at this patch and let us know
> whether or not it looks fine to you?
>

The patch itself does not look unreasonable, but I can't find
sgl_alloc() anywhere in the source tree. Given that you have cc'ed me
on this patch only, I can only assume that you are adding this as part
of the series, but without any context, I can't really review this,
sorry.
