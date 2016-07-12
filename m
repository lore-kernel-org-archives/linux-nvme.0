From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jul 2016 08:38:29 -0700
Subject: [PATCH] nvme-loop: add configfs dependency
In-Reply-To: <20160710121417.GA21551@lst.de>
References: <20160707090144.3061799-1-arnd@arndb.de>
 <577E68A5.8080709@kernel.dk> <20160710121417.GA21551@lst.de>
Message-ID: <57850EF5.9040506@fb.com>

On 07/10/2016 05:14 AM, Christoph Hellwig wrote:
> On Thu, Jul 07, 2016@08:35:17AM -0600, Jens Axboe wrote:
>> Thanks Arnd, applied.
>
> Actually I think we should replace the select with the depends.  In
> fact I though I had done that a while ago, but I must have messed it up.
>
> Btw - do you plan to grab patches directly from the list now or
> do you want me to queue them up?  There are a few more pending on
> the list that should go in:

If I come across them and they have been reviewed by others too, or are 
obvious, then I'll grab them myself. Explicit pointers always welcome, 
as I don't monitor the list closely...

> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DJune_005150.html&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=bgqP-UoFFzFT3ClF6DBpyUwoJ6lPKGSA3OVJ2EjxPVc&s=vIJnf_HSLe_wa5Xlw8ciQ8Sue2IAJMHSxu3CtitaTbY&e=
> (whole series)
>
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DJuly_005290.html&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=bgqP-UoFFzFT3ClF6DBpyUwoJ6lPKGSA3OVJ2EjxPVc&s=Z0Nkz6fXe6JrYCzwldDutoL2bEed99kWD8VkA0x-bdU&e=
> (needs the attribution fixed to be from Ming)
>
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_pipermail_linux-2Dnvme_2016-2DJuly_005318.html&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=bgqP-UoFFzFT3ClF6DBpyUwoJ6lPKGSA3OVJ2EjxPVc&s=lgZaUxNvX7Pp7iYIB1CcpItKvekVsmMebSvFddG6GEg&e=

Sorry for the FB mangling of those URLs, but I folded these in.

-- 
Jens Axboe
