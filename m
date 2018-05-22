From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 22 May 2018 16:48:01 +0000
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180522163403.GA8388@localhost.localdomain>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
 <20180522141507.GQ5528@localhost.localdomain>
 <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
 <20180522163403.GA8388@localhost.localdomain>
Message-ID: <9ddccf3d36f114b1e358f88bf360db87fd9d8246.camel@wdc.com>

On Tue, 2018-05-22@10:34 -0600, Keith Busch wrote:
> On Tue, May 22, 2018@04:29:07PM +0000, Bart Van Assche wrote:
> > Please have another look at the current code that handles request timeouts
> > and completions. The current implementation guarantees that no double
> > completions can occur but your patch removes essential aspects of that
> > implementation.
> 
> How does the current implementation guarantee a double completion doesn't
> happen when the request is allocated for a new command?

Hello Keith,

If a request is completes and is reused after the timeout handler has set
aborted_gstate and before blk_mq_terminate_expired() is called then the latter
function will skip the request because restarting a request causes the
generation number in rq->gstate to be incremented. From blk_mq_rq_update_state():

	if (state == MQ_RQ_IN_FLIGHT) {
		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
		new_val += MQ_RQ_GEN_INC;
	}

Bart.
