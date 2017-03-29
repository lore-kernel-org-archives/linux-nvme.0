From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 29 Mar 2017 19:50:51 +0300
Subject: [PATCH v3 0/4] Introduce a new helper for parsing ipv[4|6]:port
 to socket address
In-Reply-To: <17d44419-a9db-1822-985e-619083e999b9@grimberg.me>
References: <1489063793-12838-1-git-send-email-sagi@grimberg.me>
 <55ad78fd-266f-09b9-417d-b6cf7b723879@grimberg.me>
 <17d44419-a9db-1822-985e-619083e999b9@grimberg.me>
Message-ID: <a484e88e-317c-42a6-f7c2-69b77cb8486a@grimberg.me>


>> Hi Dave,
>>
>> This set got review tags from two kernel maintainers but this is your
>> realm so I wouldn't be comfortable moving forward with this without
>> your feedback.
>
> Would it be possible to get a review from one of the netdev folks
> on patch 1/4?

Hi everyone,

Still no feedback...

This patchset is targeted to 4.12 as it adds IPv6 support to
nvme over fabrics drivers which is desired by some linux users.

Given that I'm in v3 by now, and accumulated reviews from two kernel
maintainers, Unless someone is strongly against it, I'll be queuing this 
from the nvme tree to 4.12.

Cheers,
Sagi.
