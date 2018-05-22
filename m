From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 22 May 2018 10:34:03 -0600
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
 <20180521231131.6685-4-keith.busch@intel.com>
 <e7a287827b4c00151bb7714deca7ea6453177504.camel@wdc.com>
 <20180522141507.GQ5528@localhost.localdomain>
 <d73bd0b081dbf2156e7b20df4f85e1db38785b0b.camel@wdc.com>
Message-ID: <20180522163403.GA8388@localhost.localdomain>

On Tue, May 22, 2018@04:29:07PM +0000, Bart Van Assche wrote:
> Please have another look at the current code that handles request timeouts
> and completions. The current implementation guarantees that no double
> completions can occur but your patch removes essential aspects of that
> implementation.

How does the current implementation guarantee a double completion doesn't
happen when the request is allocated for a new command?
