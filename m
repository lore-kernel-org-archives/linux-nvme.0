From: vedant@lath.in (Vedant Lath)
Date: Wed, 11 Nov 2015 03:13:06 +0530
Subject: nvme: controller resets
In-Reply-To: <3736f57d17ee808526a8f35bb4c50eea@localhost>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <3dda89a86dbd6c8ede4057884c43170c@localhost>
 <CAKajsGMkdckHbYyb8XY=ByYsHF0=-cNA2o5RnTN0XKVSopyiDQ@mail.gmail.com>
 <3736f57d17ee808526a8f35bb4c50eea@localhost>
Message-ID: <CAKajsGPLmCiVc4it0bY1qAeLKmrMQMM0FRKcJoAntFb_nE1erA@mail.gmail.com>

On Wed, Nov 11, 2015@3:04 AM, Stephan G?nther <guenther@tum.de> wrote:
> Mine:
>
> | NVME Identify Controller:
> | vid     : 0x106b
> | ssvid   : 0x106b
> | sn      : C025xxxxxxxxxxxxxx
> | mn      : APPLE SSD AP0512H
> | fr      : 5.841.01
>
> I have reports of other guys with firmware 5.831.01 and 5.844.01. Both
> have the same problems.

That's a different firmware revision than mine. Mine is 7.831.01. But
the minor version and patch number is same. :/ Maybe the first digit
is indicative of the MacBook it is built for?

I have a feeling that this SSD's NVMe implementation is more like a
draft implementation of the NVMe standard. I am hopeful that future
firmware upgrades will make it fully compliant with NVMe.

> Are using a MacBook8,1 oder MacBook7,1?

I am using a MacBookAir7,1. It is the 11" MacBook Air (Early 2015)
model with 256 GB SSD.
