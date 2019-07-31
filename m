From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 31 Jul 2019 13:37:28 -0700
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <695cad74-aaed-d1aa-9381-b4430cd27925@suse.de>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <993aee4e-9f9e-4af1-07e6-69218a12bc1b@suse.de>
 <886831d7-7035-7c38-7b1f-9945c222564e@grimberg.me>
 <695cad74-aaed-d1aa-9381-b4430cd27925@suse.de>
Message-ID: <b3731d28-fdb7-988a-7b3a-019e86f66f0c@grimberg.me>


>> Exactly because of the race that you are indicating. We can't reliably
>> know if the controller is resetting (or will be starting a reset soon)
>> so we go ahead with the revalidate knowing that if the controller is
>> resetting it will fail. That is why the state check is after (this tells
>> us if the revalidation failed because of a reset or something else).
> 
> Okay, fair enough.
> 
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Hannes,

Can we understand if this addresses the issues you have reported?

 From the cover-letter:
Hey Hannes,

Here is two patches that to my understanding of the issues you describe
in your patchset: "nvme: flush rescan worker before resetting" and your
report of "spurious I/O errors during failover".

[...]

Can you please apply the following two patches and report if
they address the issues you are seeing? And if not, can you please
report a call trace of the hanged threads?

And, given that your are in a multipath environment, can you apply
these on top of: "nvme: fix controller removal race with scan work"?
