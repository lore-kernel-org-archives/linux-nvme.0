From: sreekanth.reddy@broadcom.com (Sreekanth Reddy)
Date: Thu, 3 Aug 2017 15:04:25 +0530
Subject: [PATCH v2 01/13] mpt3sas: Update MPI Header
In-Reply-To: <20170803075556.GA4333@linux-x5ow.site>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <4492534a-9c30-94c5-eae7-dc17f0e9d057@suse.de>
 <20170803075556.GA4333@linux-x5ow.site>
Message-ID: <CAK=zhgoQ0iNRoHGrgk58UspAdbdOwegGUumFdN0B75bUku8N_g@mail.gmail.com>

On Thu, Aug 3, 2017@1:25 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Thu, Aug 03, 2017@08:24:59AM +0200, Hannes Reinecke wrote:
>> > +   U32
>> > +           IOCLogInfo;                     /*0x10 */
>> > +   U16
>> > +           ErrorResponseCount;             /*0x14 */
>> > +   U16
>> > +           Reserved4;                      /*0x16 */
>> > +} MPI26_NVME_ENCAPSULATED_ERROR_REPLY,
>> > +   *PTR_MPI26_NVME_ENCAPSULATED_ERROR_REPLY,
>> > +   Mpi26NVMeEncapsulatedErrorReply_t,
>> > +   *pMpi26NVMeEncapsulatedErrorReply_t;
>> > +
>> > +
>> > +#endif
>> > +
>> > +
>> Very odd indentation.
>> Please reformat to have type and variable on one line.
>
> And use Linux types and no CamelCase and no typedefs (especially not for
> pointers), you're not on Windows here.

We will reformat to have type and variable on one line as suggested by Hannes.

But it will be going have a huge change in the driver, if we want to
remove the CamelCase and typedefs. From legacy days onwards mpi
headers has the CamelCase type variable names and the same variables
are used in the code in large number of places. Also our MPI headers
are common across the OS platforms and so maintaining mpi headers
updates will be more difficult.

Thanks,
Sreekanth

>
> Thanks,
>         Johannes
>
> --
> Johannes Thumshirn                                          Storage
> jthumshirn at suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
> Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
