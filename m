From: john.garry@huawei.com (John Garry)
Date: Wed, 13 Feb 2019 09:18:30 +0000
Subject: [PATCH] scsi: lpfc: fix calls to dma_set_mask_and_coherent()
In-Reply-To: <yq1y36ks7rf.fsf@oracle.com>
References: <20190211150502.9999-1-emilne@redhat.com>
 <20190212080627.GC10547@infradead.org>
 <9572ae3b0131ad1c74d6a775f819437e3d4f1795.camel@redhat.com>
 <yq1y36ks7rf.fsf@oracle.com>
Message-ID: <d1edf987-4b53-ed19-2806-b2fd96c8f974@huawei.com>

On 13/02/2019 03:10, Martin K. Petersen wrote:
>
> Ewan,
>
>> It also appears as if the patches to hptiop, hisi_sas and bfa need to
>> be fixed up.  I don't have a test environment for these, although I
>> might be able to modify the test environment for bfa.  Martin/James,
>> what about the others?
>
> I'm afraid I don't have any of those. But I'm sure John would be happy
> to check hisi_sas.
>

Happy to test. Or I can just send the fix myself. So what is the 
preferred pattern for setting the DMA mask?

John
