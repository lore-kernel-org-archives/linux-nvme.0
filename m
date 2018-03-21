From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 21 Mar 2018 15:02:06 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <20180321205958.GH12909@localhost.localdomain>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
 <20180321205958.GH12909@localhost.localdomain>
Message-ID: <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>

On 3/21/18 2:59 PM, Keith Busch wrote:
> On Fri, Mar 16, 2018@09:26:24AM -0700, Jens Axboe wrote:
>> It's not that I dislike the patch (in fact it makes the code
>> easier to read), but it's pretty late for something that isn't
>> a regression in this series. I can queue it up for some testing,
>> but it's then -rc7 time. I guess we can see how it goes and
>> push the decision until start next week.
> 
> Hi Jens,
> 
> Do you need more time on this one or have you decided where you want
> this fix to go? I'm planning to send the first nvme 4.17 pull request
> this week, so just checking if I should include this one.

Let's ship it for 4.16.

-- 
Jens Axboe
