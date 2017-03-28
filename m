From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 28 Mar 2017 19:58:55 +0000
Subject: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
In-Reply-To: <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
 <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>
 <88815dc6-04b2-0915-597d-1e335b6d2ba2@kernel.dk>
Message-ID: <C52E2CE3-0F92-40EA-902F-A9B70B145F1A@raithlin.com>

>> 
>> Thanks for the review Sagi. I?d be OK going with <=0 as the exact
>> match would normally be for minimal IO sizes (where <= and = are the
>> same thing). I will see what other feedback I get and aim to do a
>> respin soon?
>
> No tunables for this, please. There's absolutely no reason why we should
> need it.

Jens ? by this you mean you want to only bucket IO that are exactly the minimum block size supported by the underlying block device? I was envisioning we might want to relax that in certain cases (e.g. bucket 4KB and below going to a 512B device).

Stephen
