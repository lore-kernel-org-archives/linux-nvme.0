From: brandon.schulz@hgst.com (Brandon Schulz)
Date: Sun, 17 May 2015 15:04:35 +0000
Subject: [PATCH] NVMe: Automatic namespace rescan
In-Reply-To: <alpine.LNX.2.00.1505152152180.15930@localhost.lm.intel.com>
References: <1431633707-9265-1-git-send-email-keith.busch@intel.com>
 <20150515143746.GA2729@linux.intel.com>
 <alpine.LNX.2.00.1505151440220.15930@localhost.lm.intel.com>
 <alpine.LNX.2.00.1505152152180.15930@localhost.lm.intel.com>
Message-ID: <D17E1649.800B%brandon.schulz@hgst.com>

Agree with your decision that we probably don?t want a bunch of zero
capacity drives if there are gaps in the namespace IDs.  I?d like to see a
version of your original patch get in - we have been carrying a patch
against nvme-legacy internally that does a similar rescan-after-reset but
haven?t had the time to prepare a patch against the current tree yet.

If someone deletes a namespace (vs. detaching it) why wouldn?t you want to
remove the gendisk as well?  This question is  based on your comment in
the original patch: "If namespaces are deleted, this does not go so far as
to delete gendisks; instead, its capacity will be set to 0."  I believe
users would expect to see the device representing the namespace go away if
they deleted the namespace.

Brandon

On 5/15/15, 4:59 PM, "Keith Busch" <keith.busch@intel.com> wrote:

>On Fri, 15 May 2015, Keith Busch wrote:
>> On Fri, 15 May 2015, Matthew Wilcox wrote:
>>> Pondering if it's worth keeping the list sorted so we can break out
>>>early
>>> if the namespace isn't in the list?
>>
>> The list is actually already sorted since this doesn't allow gaps in
>> NSIDs. If a namespace is not attached, the driver creates a 0 capacity
>> block device for it and appends it to the list, so it's always in
>> ascending order.
>>
>> Is this a bad idea? Let's say a controller supports 128 namespaces,
>> but only NSID 128 is attached, we'd see 127 zero capacity /dev/nvme#n#
>> block devs.
>
>Decided we don't want a bunch of zero capacity drives if there are gaps
>in attached NSIDs. There could be millions after all. But it's not so
>simple since the nvmeq's hctx points to hctx from a single namespace's
>request_queue, and that's not right. I'll take a stab at decoupling that
>next week. In the mean time, this patch is dead.
>
>_______________________________________________
>Linux-nvme mailing list
>Linux-nvme at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-nvme
