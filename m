From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 28 Mar 2017 19:38:33 +0000
Subject: [PATCH 2/2] blk-stat: add a poll_size value to the request_queue
 struct
In-Reply-To: <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
 <1490494692-2416-3-git-send-email-sbates@raithlin.com>
 <44296e0a-fb04-888b-aa00-a9b01709e1b8@grimberg.me>
Message-ID: <25CE7F43-DD1B-42D6-A891-A3D916BD0877@raithlin.com>

>>
>>  In order to bucket IO for the polling algorithm we use a sysfs entry
>>  to set the filter value. It is signed and we will use that as follows:
>>
>>   0   : No filtering. All IO are considered in stat generation
>>   > 0 : Filtering based on IO of exactly this size only.
>>   < 0 : Filtering based on IO less than or equal to -1 time this value.>
>
> I'd say that this is a fairly non-trivial semantic meanning to this...
>
> Is there any use for the size exact match filter? If not then
> I suggest we always make it (<=) in its semantics...

Thanks for the review Sagi. I?d be OK going with <=0 as the exact match would normally be for minimal IO sizes (where <= and = are the same thing). I will see what other feedback I get and aim to do a respin soon?

Stephen
