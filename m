From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 18:24:42 +0200
Subject: [PATCH] nvme: free pre-allocated queue if create ioq goes wrong
In-Reply-To: <CAA7jztfVUq2hCoTbjjCw69f3Z77chwZmrADNU3+w2d4zBCcWfg@mail.gmail.com>
References: <1515914131-12725-1-git-send-email-minwoo.im.dev@gmail.com>
 <d4a85f57-a499-a580-ba39-8eea6e5c9712@grimberg.me>
 <CAA7jztfVUq2hCoTbjjCw69f3Z77chwZmrADNU3+w2d4zBCcWfg@mail.gmail.com>
Message-ID: <d7b86468-bccb-0779-693a-3e4a01763fb2@grimberg.me>



On 01/14/2018 11:41 AM, Minwoo Im wrote:
> Sagi,
> 
> On Sun, Jan 14, 2018@6:18 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>> Minwoo,
>>
>>> If either create-sq or create-cq is failed with an NVMe status,
>>> nvme_init_queue() is invoked which was not expected to be called in
>>> nvme_create_queue().
>>> To prevent this inconsistency of queue_count, free queue(s) already
>>> allocated in nvme_create_io_queues() when it goes wrong in
>>> nvme_create_queue().
>>
>>
>> The fix looks good, but I think it would be better to cleanup the queue
>> in the call site where nvme_alloc_queue is called, having it here is a
>> bit awkward IMO.
> 
> Thanks for your kind review.
> 
> I agree with that allocation and freeing should be in the same place
> because it looks much more consistent in code.
> 
> What about below code?

Looks better, please send a proper patch, thanks.
