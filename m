From: minwoo.im@samsung.com (Minwoo Im)
Date: Wed, 22 May 2019 10:53:15 +0900
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <2c9601b1555b0bf731310213a1d78960ea7a6ad5.camel@chavero.com.mx>
References: <2c9601b1555b0bf731310213a1d78960ea7a6ad5.camel@chavero.com.mx>
 <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
 <20190521142000.GA350@localhost.localdomain>
 <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>
 <20190521220007.GB4302@localhost.localdomain>
 <CGME20190522005114epcas4p2cae7e26ab679da2e44a50b803724a336@epcms2p7>
Message-ID: <20190522015315epcms2p7dc1561cfbacdbd9615a48d61d3488e48@epcms2p7>

> I tried setting:
> 
> trace_event=nvme_setup_cmd,nvme_complete_rq
> 
> but got this error:
> 
> [    0.284016] Failed to enable trace event: nvme_setup_cmd
> [    0.284043] Failed to enable trace event: nvme_complete_rq

IMHO, maybe you just can make nvme_core module to be in kernel image
itself and try it again.  It looks like enabling trace_event has occurred before
the module is loaded onto kernel.
