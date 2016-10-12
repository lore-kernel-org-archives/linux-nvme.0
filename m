From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Oct 2016 12:57:56 -0700
Subject: [PATCH 6/7 v2] nvme-fabrics: Add target FC transport support
In-Reply-To: <20161012094203.GA6340@infradead.org>
References: <57f82b13.7EhsIjBV7j7hnac1%james.smart@broadcom.com>
 <20161012094203.GA6340@infradead.org>
Message-ID: <876cd6b3-5c57-4784-86f0-ecf3a45e9be0@broadcom.com>



On 10/12/2016 2:42 AM, Christoph Hellwig wrote:

>
>> +	/*
>> +	 * beware: nvmet layer hangs waiting for a completion if
>> +	 * connect command failed
>> +	 */
>> +	flush_workqueue(queue->work_q);
> Can you elaborate on what the issue?

large carry over from code that was used as reference, although I saw it 
happen (when connect capsule was merged with the transport connect 
message).  I'll eliminate it or bring it forward.


>
>> +	/*
>> +	 * TODO: handle fused cmds back-to-back
>> +	 */
> Do you also plan to implement fused command support in the core?

no. once again, there are FC-NVME requirements, which if linux nvmet 
isn't supporting I could ignore. And hoping anyone who modifies nvmet 
knows a transport has to change too.  At least there will be a comment 
there indicating why the functionality isn't present.



Ok on the other comments.

-- james
