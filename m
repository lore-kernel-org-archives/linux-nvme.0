From: arjan@linux.intel.com (Arjan van de Ven)
Date: Tue, 19 Feb 2013 08:30:23 -0800
Subject: [PATCH 2/2] nvme: fix the placement of set_current_state to
 TASK_INTERRUPTIBLE
In-Reply-To: <20130219150538.GA4530@linux.intel.com>
References: <51103A15.8010508@linux.intel.com>
 <20130219150538.GA4530@linux.intel.com>
Message-ID: <5123A89F.9010608@linux.intel.com>

On 2/19/2013 7:05 AM, Matthew Wilcox wrote:
> On Mon, Feb 04, 2013@02:45:41PM -0800, Arjan van de Ven wrote:
>> the nvme driver has a kthread that processes certain events periodically.
>> However, the kthread also gets woken for certain urgent actions.
>>
>> The current code does not use the current_state logic correctly;
>> it calls set_current_state(TASK_INTERRUPTIBLE); right before doing
>> a schedule_timeout(), with the result that there is a race condition
>> where a wakeup can get lost, and thus delayed by one second.
>>
>> This patch moves the set_current_state(TASK_INTERRUPTIBLE); to before
>> the place where the queue of outstanding work is checked, to close
>> the race condition
>
> The thing is, that's not a queue of outstanding work, that's the list
> of devices that exist in the system.  Your patch makes the kthread do
> all of its work in the TASK_INTERRUPTIBLE state, which I don't think is
> right either (is it?)

eh why not?
it counts to load average, but frankly, you're using CPU... you count anyway
