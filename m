From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 20:02:15 +0300
Subject: [PATCH rfc 5/6] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <20161005135237.ia5yqv3k73jgszed@linux-x5ow.site>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-6-git-send-email-sagi@grimberg.me>
 <20161005135237.ia5yqv3k73jgszed@linux-x5ow.site>
Message-ID: <27b72354-439c-392c-226f-76c522f15877@grimberg.me>


>> Given that the code is simple enough it seems better
>> then passing a tag by reference for each call site.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>>  drivers/nvme/host/pci.c | 36 +++++++++++++++++++++---------------
>>  1 file changed, 21 insertions(+), 15 deletions(-)
>>
>
> I don't really see how the call by value vs. call by reference change is a
> better trade-off than open coding __nvme_process_cq(), as we'd have to
> duplicate any possible fix for this function then (yes I see it's quite
> simple but I have some doubt it's 100% bugfree).

I just figured it'd be nicer to remove the tag that we carry in all
the call sites because we want to reuse the code in nvme_poll(). It
made better sense before, but now that its simpler (for me at least)
we can lose it.

Having said that, we can easily remove this patch if we're not all
on board...
