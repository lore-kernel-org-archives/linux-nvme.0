From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 11 Jan 2017 08:13:02 -0700
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
Message-ID: <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk>

On 01/11/2017 08:07 AM, Jens Axboe wrote:
> On 01/11/2017 06:43 AM, Johannes Thumshirn wrote:
>> Hi all,
>>
>> I'd like to attend LSF/MM and would like to discuss polling for block drivers.
>>
>> Currently there is blk-iopoll but it is neither as widely used as NAPI in the
>> networking field and accoring to Sagi's findings in [1] performance with
>> polling is not on par with IRQ usage.
>>
>> On LSF/MM I'd like to whether it is desirable to have NAPI like polling in
>> more block drivers and how to overcome the currently seen performance issues.
> 
> It would be an interesting topic to discuss, as it is a shame that blk-iopoll
> isn't used more widely.

Forgot to mention - it should only be a topic, if experimentation has
been done and results gathered to pin point what the issues are, so we
have something concrete to discus. I'm not at all interested in a hand
wavy discussion on the topic.

-- 
Jens Axboe
