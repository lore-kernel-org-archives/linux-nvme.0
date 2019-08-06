From: hare@suse.de (Hannes Reinecke)
Date: Tue, 6 Aug 2019 08:33:21 +0200
Subject: [PATCH rfc v2 3/6] nvme: make nvme_identify_ns propagate errors
 back
In-Reply-To: <87055a67-3411-c31b-8fc8-7652d0fe4f5a@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-4-sagi@grimberg.me>
 <05c77c73-6bf6-ecc8-ec6a-99f924ea6916@suse.de>
 <87055a67-3411-c31b-8fc8-7652d0fe4f5a@grimberg.me>
Message-ID: <0d57a9e7-b375-e669-a32d-76a517c36319@suse.de>

On 8/5/19 8:18 PM, Sagi Grimberg wrote:
> 
>> I'd prefer using PTR_ERR() here; that would avoid the **id parameter.
>> (I'm really biased against this calling model, returning an error _and_
>> a structure.
> 
> I can do that, shouldn't be a problem.
> 
>> You can never be sure that both match, and you always get
>> into weird error handling routines.)
> 
> Well, the semantics is clear. If the call succeeded, id was allocated
> and if not, id wasn't allocated. Not sure how this is confusing or
> weird.
>
... In theory, yes. But there is no implicit guarantee that this is the
case; you always have _two_ return values which might be conflicting.
Hence I prefer the PTR_ERR() approach; that way we'll only ever having
one return value.

(Plus it'll be easier for me to backport :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
