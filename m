From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 May 2019 16:00:07 -0600
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>
References: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
 <20190521142000.GA350@localhost.localdomain>
 <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>
Message-ID: <20190521220007.GB4302@localhost.localdomain>

On Tue, May 21, 2019@04:34:44PM -0500, Iv?n Chavero wrote:
> I think that the real error is this one:
> 
> print_req_error: operation not supported error, dev nvme0n1, sector
> 386138112 flags 4801

Weird. There are not very many statuses that translate to a "not
supported" from nvme, and none of them really make sense for a device
to return only during early boot. Let's see if that error is coming
from the drive or somewhere else.

Could you append the following kernel parameter:

  trace_event=nvme_setup_cmd,nvme_complete_rq

Then get the output from after the errors?

  cat /sys/kernel/debug/tracing/trace
