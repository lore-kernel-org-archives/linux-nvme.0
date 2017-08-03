From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 3 Aug 2017 09:55:56 +0200
Subject: [PATCH v2 01/13] mpt3sas: Update MPI Header
In-Reply-To: <4492534a-9c30-94c5-eae7-dc17f0e9d057@suse.de>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <4492534a-9c30-94c5-eae7-dc17f0e9d057@suse.de>
Message-ID: <20170803075556.GA4333@linux-x5ow.site>

On Thu, Aug 03, 2017@08:24:59AM +0200, Hannes Reinecke wrote:
> > +	U32
> > +		IOCLogInfo;                     /*0x10 */
> > +	U16
> > +		ErrorResponseCount;             /*0x14 */
> > +	U16
> > +		Reserved4;                      /*0x16 */
> > +} MPI26_NVME_ENCAPSULATED_ERROR_REPLY,
> > +	*PTR_MPI26_NVME_ENCAPSULATED_ERROR_REPLY,
> > +	Mpi26NVMeEncapsulatedErrorReply_t,
> > +	*pMpi26NVMeEncapsulatedErrorReply_t;
> > +
> > +
> > +#endif
> > +
> > +
> Very odd indentation.
> Please reformat to have type and variable on one line.

And use Linux types and no CamelCase and no typedefs (especially not for
pointers), you're not on Windows here.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
