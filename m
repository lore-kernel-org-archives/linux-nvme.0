From: ichavero@chavero.com.mx (=?ISO-8859-1?Q?Iv=E1n?= Chavero)
Date: Tue, 21 May 2019 19:50:34 -0500
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <20190521220007.GB4302@localhost.localdomain>
References: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
 <20190521142000.GA350@localhost.localdomain>
 <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>
 <20190521220007.GB4302@localhost.localdomain>
Message-ID: <2c9601b1555b0bf731310213a1d78960ea7a6ad5.camel@chavero.com.mx>

El mar, 21-05-2019 a las 16:00 -0600, Keith Busch escribi?:
> On Tue, May 21, 2019@04:34:44PM -0500, Iv?n Chavero wrote:
> > I think that the real error is this one:
> > 
> > print_req_error: operation not supported error, dev nvme0n1, sector
> > 386138112 flags 4801
> 
> Weird. There are not very many statuses that translate to a "not
> supported" from nvme, and none of them really make sense for a device
> to return only during early boot. Let's see if that error is coming
> from the drive or somewhere else.
> 
> Could you append the following kernel parameter:
> 
>   trace_event=nvme_setup_cmd,nvme_complete_rq
> 
> Then get the output from after the errors?
> 
>   cat /sys/kernel/debug/tracing/trac


I tried setting: 

trace_event=nvme_setup_cmd,nvme_complete_rq

but got this error:

[    0.284016] Failed to enable trace event: nvme_setup_cmd
[    0.284043] Failed to enable trace event: nvme_complete_rq

and also 

trace_event=nvme:*

and got this:

[    0.283308] Failed to enable trace event: nvme:*

what else could i check to see what's the problem??

thanks
