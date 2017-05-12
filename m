From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 12 May 2017 16:49:01 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
In-Reply-To: <1494599685838.3433@Dell.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <1494597516613.95190@Dell.com>
 <CALCETrUVb8KqOOzW7fXDWCyCiXj6jpPm-w=XZ-FXrh_rfdDkJQ@mail.gmail.com>
 <1494599685838.3433@Dell.com>
Message-ID: <CALCETrUh0TB6b5UKfYjFLVcciYppTrPGyJNhpj5W0Z7vgngyMw@mail.gmail.com>

On Fri, May 12, 2017@7:34 AM,  <Mario.Limonciello@dell.com> wrote:
>>Yes, mostly.  I've written the patch, but I was planning to target it
>>at 4.12 or 4.13 but not -stable.  It's mostly just a cleanup and has
>>no real power saving benefit since the RSTe timeouts are so absurdly
>>conservative that I doubt PS4 will happen in practical usage.
> OK.
>
>>Perhaps
>>in suspend-to-idle?  (For suspend-to-idle, I suspect we should really
>>be using D3 instead.  Do we already do that?)
>
> Well I think this will depend upon what the SSD "will" support.

I thought it was basically impossible for the SSD to fail to support
D3.  Afterall, cutting the power due to runtime D3 is more or less the
same thing (from the SSD's POV) as cutting the power during S3 or full
power off.

I've contemplated adding runtime D3 support to the nvme driver, but it
would probably be barely a win and quite slow.

When Linux suspends-to-idle, does it call driver suspend callbacks and
kick devices into D3?  It should work, but I don't know what actually
happens.
