From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 30 Nov 2018 10:12:06 -0700
Subject: [GIT PULL] nvme fixes for 4.20
In-Reply-To: <20181130162633.GA16933@infradead.org>
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
 <20181130162633.GA16933@infradead.org>
Message-ID: <08296696-8fd5-1c99-1df2-39ccda11dea7@kernel.dk>

On 11/30/18 9:26 AM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018@08:26:24AM -0700, Jens Axboe wrote:
>> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
>>> Various fixlets all over, including throwing in a 'default y' for the
>>> multipath code, given that we want people to actually enable it for full
>>> functionality.
>>
>> Why enable it by default? 99.9% of users aren't going to care. That
>> seems like an odd choice.
> 
> Because its small, and if you don't have it you are going to run into
> problems pretty soon.

Let's do it for 4.21...

> Anyway, to get the fixes out ASAP here is the updated request without
> it:

Pulled, thanks.

-- 
Jens Axboe
