From: mauricfo@linux.vnet.ibm.com (Mauricio Faria de Oliveira)
Date: Mon, 8 Aug 2016 10:38:17 -0300
Subject: [PATCH v4 0/3] dma-mapping, powerpc, nvme: introduce the
 DMA_ATTR_NO_WARN attribute
In-Reply-To: <20160805100108.8f09fb7c1e63cd4ca06b16bd@linux-foundation.org>
References: <1470092390-25451-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20160804150145.fb5690e9a873121db1dfa0b1@linux-foundation.org>
 <57A3DB17.3060603@linux.vnet.ibm.com>
 <20160804180501.f80c9b919341c486e2a95894@linux-foundation.org>
 <57A487CC.3040205@linux.vnet.ibm.com>
 <20160805100108.8f09fb7c1e63cd4ca06b16bd@linux-foundation.org>
Message-ID: <57A88B49.7080406@linux.vnet.ibm.com>

On 08/05/2016 02:01 PM, Andrew Morton wrote:
> Bah.  What about WARN__ON_ONCE()?  Or much heavier ratelimiting?

The problem w/ the WARN_ON_ONCE macro for this case is that it applies
once per _function_ (because of its static variable), not per _device_.

So, after the message happens for a particular device, it won't happen
for any other devices.  This would still conflict with the reasons the
other patch (use dynamic debug) was rejected [1].

The other problem w/ WARN_ON_ONCE (even if it could be used per device)
is that it masks/hides some events:  if you reach it with requests that
are OK to fail (i.e., retry), it will be silent for requests that are
not OK to fail (e.g., the blk_integrity-related call on nvme) -- and it
could be helpful for debugging.

I believe that ratelimiting would fall into the same category as above
(masks events since it hits the threshold with the OK-to-fail requests,
and then misses the not-OK-to-fail requests).

The other problem with ratelimiting would be, in case of continuously
working on high loads with the devices (e.g., nvme drive) - which is
acceptable - the messages would still eventually be printed, and since
it will happen every time the threshold is OK to print it again, it's
only a repetition with a greater period.



... the difficult point with the problem this patch addresses is not
to be heavy handed;  it's interesting to find some balance to still
reach the message when it might be useful, and provide some form of
control to the device driver (for when it knows it is OK for requests
to fail).  Given that the driver can have multiple callsites (with
different or no failure handling), unfortunately I found it hard to
make this arch-specific (but that is what I really aimed for first).

If you see other approaches that could help with it, I'd be happy to
write something simpler/more discreet.

Thanks for the suggestions and discussions.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-June/144196.html

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
