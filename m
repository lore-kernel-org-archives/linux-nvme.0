From: ichavero@chavero.com.mx (=?ISO-8859-1?Q?Iv=E1n?= Chavero)
Date: Sat, 29 Jun 2019 11:56:49 -0500
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <20190522015315epcms2p7dc1561cfbacdbd9615a48d61d3488e48@epcms2p7>
References: <2c9601b1555b0bf731310213a1d78960ea7a6ad5.camel@chavero.com.mx>
 <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
 <20190521142000.GA350@localhost.localdomain>
 <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>
 <20190521220007.GB4302@localhost.localdomain>
 <CGME20190522005114epcas4p2cae7e26ab679da2e44a50b803724a336@epcms2p7>
 <20190522015315epcms2p7dc1561cfbacdbd9615a48d61d3488e48@epcms2p7>
Message-ID: <66c2814fcbb158dae94d22d3e4a4e40c40c7ef2b.camel@chavero.com.mx>

El mi?, 22-05-2019 a las 10:53 +0900, Minwoo Im escribi?:
> > I tried setting:
> > 
> > trace_event=nvme_setup_cmd,nvme_complete_rq
> > 
> > but got this error:
> > 
> > [    0.284016] Failed to enable trace event: nvme_setup_cmd
> > [    0.284043] Failed to enable trace event: nvme_complete_rq
> 
> IMHO, maybe you just can make nvme_core module to be in kernel image
> itself and try it again.  It looks like enabling trace_event has
> occurred before
> the module is loaded onto kernel.
> 
I've compiled the nvme_core driver inside the kernel an i can se the
trace events, i don't really understand it but it does not say anything
that could resemble an error, i'm pasting examples of the two different
outputs i've identified:

         <idle>-0     [000] ..s.   409.334792: nvme_complete_rq: nvme0:
disk=nvme0n1, qid=1, cmdid=0, res=0, retries=0, flags=0x0, status=0
 dmcrypt_write/2-629   [002] ....   409.334808: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=1, cmdid=0, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=23649280, len=0, ctrl=0x0, dsmgmt=0, reftag=0)


...


          <idle>-0     [000] ..s.   409.334737: nvme_complete_rq:
nvme0: disk=nvme0n1, qid=1, cmdid=0, res=0, retries=0, flags=0x0,
status=0
    kworker/2:1H-165   [002] ....   409.334759: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=1, cmdid=0, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=23136987, len=0, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [000] ..s.   409.334792: nvme_complete_rq:
nvme0: disk=nvme0n1, qid=1, cmdid=0, res=0, retries=0, flags=0x0,
status=0
 dmcrypt_write/2-629   [002] ....   409.334808: nvme_setup_cmd: nvme0:
disk=nvme0n1, qid=1, cmdid=0, nsid=1, flags=0x0, meta=0x0,
cmd=(nvme_cmd_write slba=23649280, len=0, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [000] ..s.   409.334837: nvme_complete_rq:
nvme0: disk=nvme0n1, qid=1, cmdid=0, res=0, retries=0, flags=0x0,
status=0


i hope this can be helpful BTW, i'm testing with kernel 5.1.12

Thanks for the help
Iv?n
