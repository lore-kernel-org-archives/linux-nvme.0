From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 22 May 2018 16:29:07 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180522141507.GQ5528@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
 <20180522141507.GQ5528@localhost.localdomain>
Message-ID: <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>

On Tue, 2018-05-22@08:15 -0600, Keith Busch wrote:
> This shouldn't be introducing any new concorrent calls to
> __blk_mq_complete_request if they don't already exist. The timeout work
> calls it only if the driver's timeout returns BLK_EH_HANDLED, which means
> the driver is claiming the command is now done, but the driver didn't call
> blk_mq_complete_request as indicated by the request's IN_FLIGHT state.
> 
> In order to get a second call to __blk_mq_complete_request(), then,
> the driver would have to end up calling blk_mq_complete_request()
> in another context. But there's nothing stopping that from happening
> today, and would be bad if any driver actually did that: the request
> may have been re-allocated and issued as a new command, and calling
> blk_mq_complete_request() the second time introduces data corruption.

Hello Keith,

Please have another look at the current code that handles request timeouts
and completions. The current implementation guarantees that no double
completions can occur but your patch removes essential aspects of that
implementation.

Thanks,

Bart.
