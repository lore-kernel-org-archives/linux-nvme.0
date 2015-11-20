From: m@bjorling.me (=?windows-1252?Q?Matias_Bj=F8rling?=)
Date: Fri, 20 Nov 2015 22:26:27 +0100
Subject: nvme lightnvm comments
In-Reply-To: <20151120164709.GA9931@infradead.org>
References: <20151120105022.GA22131@infradead.org>
 <564EFEBC.3040603@bjorling.me> <20151120164709.GA9931@infradead.org>
Message-ID: <564F9003.5080109@bjorling.me>

On 11/20/2015 05:47 PM, Christoph Hellwig wrote:
> On Fri, Nov 20, 2015@12:06:36PM +0100, Matias Bj?rling wrote:
>>>   2) please build the lightnvm.o object conditionally in the makefile
>>
>> Then the functions
>>
>> nvme_nvm_register
>> nvme_nvm_unregister
>> nvme_nvm_register
>>
>> have to be #ifdef'ed in the pci file. Do you want that instead? It was on
>> purpose the other way around, so that the nvme_nvm_* functions was null
>> functions if lightnvm isn't compiled in.
>
> Just keep the stubs as inlines in the header.
>


That'll do.

Do you have any plans for exposing the completion_entry on 
req_completion in the driver? I'm interested in the fields ->result and 
->rsvd in struct nvme_completion. They contain the completion bits for 
each of the PPA entries. Which I'll need higher up in the stack to 
perform correct retries and so forth.
