From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jul 2019 13:31:13 -0700
Subject: [PATCH v3] nvme: fix controller removal race with scan work
In-Reply-To: <f4deb57e-ee86-a980-45c5-6d58ee1116cc@suse.de>
References: <20190725185657.9025-1-sagi@grimberg.me>
 <a5ce0b2d-e4d5-ab79-442c-4c3795fdb0fd@suse.de>
 <93c38a70-3500-b1eb-38c7-41419c8f64c8@grimberg.me>
 <df50ec95-0ca1-58be-1660-101529a72662@suse.de>
 <1bf56b26-a521-8de2-5d52-0c1c9d19fd25@grimberg.me>
 <f4deb57e-ee86-a980-45c5-6d58ee1116cc@suse.de>
Message-ID: <a7a00af3-8818-b036-3154-67a965f7d1c2@grimberg.me>


>>>>> Thing is, I had been notified on a regression caused by commit
>>>>> 525aa5a705d86e ("nvme-multipath: split bios with the ns_head..."),
>>>>> which manifests itself by a spurious I/O error during failover.
>>>>
>>>> Hmm, this is interesting. Not sure how this specific commit would
>>>> introduce such an issue.
>>>>
>>> See? Me neither. Sadly they _have_ bisected it, and this really is the
>>> patch introducing the regression.
>>> Current thinking is that we're dropping all paths during reset, causing
>>> ns_head to be deleted, too.
>>
>> That is impossible, the only thing that would drop paths is either
>> if the user is removing a controller, or the ctrl_loss_tmo expired, both
>> are controller removal and not controller reset.
>>
> Well ... the problem seem to be arising if we get an Namespace Changed 
> AEN during reset.
> In that case we'll call nvme_scan_ns_list(), on which the initial 
> identify will fail for all namespaces, and all of them will be 
> disconnected.

Well that sounds like the wrong behavior. If we are not able to scan
the ns list because we are reconnecting, we should not remove the
namespaces.

What exactly fails? and what falls us to removing the namespaces?
is nvme_identify_ns_list() not returning a failure status code?

Something is still not clear to me.

Perhaps we need this protection in place such that we are not removing
a namespace if we failed namepsace revalidation because we lost
connectivity:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa31da0762b9..5f6970e7ba73 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3428,7 +3428,8 @@ static void nvme_validate_ns(struct nvme_ctrl 
*ctrl, unsigned nsid)

         ns = nvme_find_get_ns(ctrl, nsid);
         if (ns) {
-               if (ns->disk && revalidate_disk(ns->disk))
+               if (ns->disk && revalidate_disk(ns->disk) &&
+                   ctrl->state != NVME_CTRL_LIVE)
                         nvme_ns_remove(ns);
                 nvme_put_ns(ns);
         } else
--

>>> The ns_head will get recreated immediately
>>> afterwards, so userspace wouldn't even notice that.
>>> But if we have a non-empty requeue list that will be flushed only when
>>> doing the final put on the ns_head structure, causing all I/O to fail.
>>
>> Again, we need to understand what is the exact scenario, because if we
>> are losing all the paths, I/O failure is the expected behavior.
>>
> ... Unless we're disconnecting those paths during controller reset, 
> which actually is expected to happen, and will be corrected after reset 
> completes.

Why is that the correct behavior? Doesn't sound like that to me...
If we don't have a communication channel to the target ns scanning will
fail for sure, we should not remove these namespaces because we don't
have a way to get the answer during this time.

>>> So looking at it that way, it _might_ actually be that your patch helps
>>> for that situation, too, seeing that we can't reliably enumerate
>>> namespaces during reset.
>>
>> Can we define clearly what do you mean when you say "enumerate 
>> namespaces during reset"?
>>
> Any call which walks the list of namespaces, either the controller list 
> or the ns_head siblings list.

If we have a case where the sibling list gets emptied during the
controller reset, this patch will not help because nvme_available_path()
traverses it. I think that something else is the problem in the issues
you are seeing.
