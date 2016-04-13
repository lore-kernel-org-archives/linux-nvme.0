From: axboe@fb.com (Jens Axboe)
Date: Wed, 13 Apr 2016 00:03:29 -0600
Subject: [PATCH v2] nvme: Avoid reset work on watchdog timer function
 during error recovery
In-Reply-To: <570DD7A8.9050607@fb.com>
References: <1460503929-22613-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <570DD7A8.9050607@fb.com>
Message-ID: <570DE131.1050308@fb.com>

On 04/12/2016 11:22 PM, Jens Axboe wrote:
> On 04/12/2016 05:32 PM, Guilherme G. Piccoli wrote:
>> This patch adds a check on nvme_watchdog_timer() function to avoid the
>> call to reset_work() when an error recovery process is ongoing on
>> controller. The check is made by looking at pci_channel_offline()
>> result.
>>
>> If we don't check for this on nvme_watchdog_timer(), error recovery
>> mechanism can't recover well, because reset_work() won't be able to
>> do its job (since we're in the middle of an error) and so the
>> controller is removed from the system before error recovery mechanism
>> can perform slot reset (which would allow the adapter to recover).
>>
>> In this patch we also have splitted the huge condition expression in
>> nvme_watchdog_timer() by introducing an auxiliary function to help
>> make the code more readable.
>
> Added for 4.7, thanks.

And dropped again, please at least verify that patches don't introduce 
new warnings. You're adding a nssro bool, that then never gets used. Did 
you test this version?

-- 
Jens Axboe
