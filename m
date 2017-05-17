From: jsmart2021@gmail.com (James Smart)
Date: Wed, 17 May 2017 11:49:10 -0700
Subject: [PATCH v2 02/15] lpfc: Fix system crash when port is reset.
In-Reply-To: <73cdc776-8eea-b63b-89af-ffa9829e1f9d@linux.vnet.ibm.com>
References: <20170515222052.26004-1-jsmart2021@gmail.com>
 <20170515222052.26004-3-jsmart2021@gmail.com>
 <73cdc776-8eea-b63b-89af-ffa9829e1f9d@linux.vnet.ibm.com>
Message-ID: <c2bf3df0-e65e-2f1c-5bb7-cb5b62697e30@gmail.com>

On 5/16/2017 5:26 AM, Guilherme G. Piccoli wrote:
> On 05/15/2017 07:20 PM, James Smart wrote:
>> The driver panic when using the els_wq during port reset.
>>
>> Check for NULL els_wq before dereferencing.
>
> James/Dick, if possible please take a look on:
> https://marc.info/?l=linux-scsi&m=149487670315697
>
> For some reason that email didn't get threaded as I expect. And also I
> forgot to include James' Gmail address, sorry.
>
> Thanks in advance,
>
>
> Guilherme

Gilherme,

Your patch is still needed.  Can you repost your patch with a new 
subject and add my signature:

Signed-off-by: James Smart <james.smart at broadcom.com>

Sorry, I didn't see it to roll it into the set.

-- james
