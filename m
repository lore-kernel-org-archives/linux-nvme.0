From: dongli.zhang@oracle.com (Dongli Zhang)
Date: Sat, 6 Apr 2019 02:44:00 -0700 (PDT)
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
Message-ID: <398407a1-b270-512a-5894-eebe4c851cc4@oracle.com>



On 04/06/2019 07:36 AM, Keith Busch wrote:
> On Fri, Apr 5, 2019@5:04 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Looking at current peak testing, I've got around 1.2% in queue enter
>> and exit. It's definitely not free, hence my question. Probably safe
>> to assume that we'll double that cycle counter, per IO.
> 
> Okay, that's not negligible at all. I don't know of a faster reference
> than the percpu_ref, but that much overhead would have to rule out
> having a per hctx counter.
> 

If there is no faster reference to enable waiting for all inflight requests to
complete, is it possible to re-map (migrate) those requests to other hctx whose
cpus (ctx) are still online, e.g., to extract the bio and re-map those bio to
other ctx (e.g., cpu0)?

One drawback I can see is if 63 out of 64 cpus are suddenly offline, cpu0 would
be stuck.

Dongli Zhang
