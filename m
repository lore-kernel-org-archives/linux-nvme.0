From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Aug 2019 11:18:57 -0700
Subject: [PATCH rfc v2 3/6] nvme: make nvme_identify_ns propagate errors
 back
In-Reply-To: <05c77c73-6bf6-ecc8-ec6a-99f924ea6916@suse.de>
References: <20190803024955.29508-1-sagi@grimberg.me>
 <20190803024955.29508-4-sagi@grimberg.me>
 <05c77c73-6bf6-ecc8-ec6a-99f924ea6916@suse.de>
Message-ID: <87055a67-3411-c31b-8fc8-7652d0fe4f5a@grimberg.me>


> I'd prefer using PTR_ERR() here; that would avoid the **id parameter.
> (I'm really biased against this calling model, returning an error _and_
> a structure.

I can do that, shouldn't be a problem.

> You can never be sure that both match, and you always get
> into weird error handling routines.)

Well, the semantics is clear. If the call succeeded, id was allocated
and if not, id wasn't allocated. Not sure how this is confusing or
weird.
