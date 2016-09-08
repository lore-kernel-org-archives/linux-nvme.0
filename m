From: axboe@fb.com (Jens Axboe)
Date: Thu, 8 Sep 2016 08:30:38 -0600
Subject: [PATCH] nvme/quirk: Add a delay before checking device ready for
 memblaze device
In-Reply-To: <20160908143658.GA31243@localhost.localdomain>
References: <CAAZN+A3m4z0uOUBWyonpXb2fQTuFhV3vu68Kuy4mdQYwt6WDgA@mail.gmail.com>
 <20160908143658.GA31243@localhost.localdomain>
Message-ID: <d56137f2-77b7-cae7-4048-2e740bd47c7f@fb.com>

On 09/08/2016 08:36 AM, Keith Busch wrote:
> On Thu, Sep 08, 2016@11:36:34AM +0800, Wang Weber wrote:
>> Hi Jens,
>>
>> The following email was sent before, but it seems to be blocked since I
>> received some messages about sending failure. So resend it with Google
>> email account.
>
> You're still sending non plain text email, so it's going to be rejected
> by the mailing list filter. It also mangles your patch such that it
> won't cleanly apply. You have to use plain text for this to work well.

Indeed. And in addition to it being rejected by the reflector, it also
means your patch is mangled.

-- 
Jens Axboe
