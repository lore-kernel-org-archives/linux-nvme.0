From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Jun 2019 09:28:03 -0700
Subject: [PATCH V5 1/5] nvme: Make trace common for host and target both
In-Reply-To: <20190604103931.GA14832@minwooim-desktop>
References: <20190601072143.21233-1-minwoo.im.dev@gmail.com>
 <20190601072143.21233-2-minwoo.im.dev@gmail.com>
 <20190601085016.GA6375@lst.de> <20190602014737.GA28933@minwooim-desktop>
 <20190604072853.GG15680@lst.de> <20190604103931.GA14832@minwooim-desktop>
Message-ID: <cd01c5d9-e43a-7d81-ebca-11e1cfa3eddc@grimberg.me>


>>>> I'd much prefer to have different implementations for host vs target for
>>>> now instead of introducing a common library.  Maybe we could revisit
>>>> that later if we end up having a lot of shared code.
>>>
>>> As you know, nvmet handles not only nvme fabrics commands, but normal
>>> commands in nvmet_req_init() and nvmet_req_complete().  Which means that
>>> we already have a lot of shared codes in parsing point of view.
>>>
>>> The host/trace.c provides parsing admin commands which can be used by
>>> nvmet also.  I guess it's enough to be shared for host and target both.
>>>
>>> I hope you can correct me if I missed someting here.
>>
>> I'm not against sharing per se, but I'm really worried about either
>> building that code in the core kernel, or even just a new module, as
>> that'll waste at least 8k and will cause more cache misses when
>> tracing.  So for now my preference would be to just duplicate the code
>> at least at the binary level.
> 
> If that factor that you mentioned is much more important than the code
> duplications, I can make them duplicated.
> 
> I'll prepare the next version based on your suggestion.

Makes sense to me
