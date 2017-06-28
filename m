From: Himanshu.Madhani@cavium.com (Madhani, Himanshu)
Date: Wed, 28 Jun 2017 21:23:54 +0000
Subject: [PATCH v2 1/6] qla2xxx: Add FC-NVMe port discovery and PRLI
 handling
In-Reply-To: <1498684545.2769.17.camel@HansenPartnership.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-2-himanshu.madhani@cavium.com>
 <1498684545.2769.17.camel@HansenPartnership.com>
Message-ID: <85036153-277E-4F9D-9328-665D73B2F68E@cavium.com>

Hi James,

> On Jun 28, 2017,@2:15 PM, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> On Wed, 2017-06-21@13:48 -0700, Madhani, Himanshu wrote:
>> From: Duane Grigsby <duane.grigsby at cavium.com>
>> 
>> Added logic to change the login process into an optional PRIL
>> step for FC-NVMe ports as a separate operation, such that we can
>> change type to 0x28 (NVMe).
>> 
>> Currently, the driver performs the PLOGI/PRLI together as one
>> operation, but if the discovered port is an NVMe port then we
>> first issue the PLOGI and then we issue the PRLI. Also, the
>> fabric discovery logic was changed to mark each discovered FC
>> NVMe port, so that we can register them with the FC-NVMe transport
>> later.
>> 
>> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
>> Signed-off-by: Duane Grigsby <duane.grigsby at cavium.com>
>> Signed-off-by: Anil Gurumurthy <anil.gurumurhty at cavium.com>
> 
> I just got a whole load of bounces from this: you've misspelled Anil's
> email address (h and t transposed).  It looks like a generic cut and
> paste, so could you fix it for next time?
> 
> Thanks,
> 
> James
> 

Sorry about that. Will fix this up for next time.

Thanks,
- Himanshu
