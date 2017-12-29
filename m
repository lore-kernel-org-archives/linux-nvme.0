From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 10:44:40 +0100
Subject: [PATCH 1/3] nvme/pci: Start request after doorbell ring
In-Reply-To: <f980d842-7995-61cf-ece2-36af67b626dc@grimberg.me>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-2-keith.busch@intel.com>
 <45a16b4c-fbc0-106d-df37-439374c7b5dc@kernel.dk>
 <118beb1f-54eb-c65d-1c9c-4775ebde1fa8@kernel.dk>
 <20171221210250.GA2975@localhost.localdomain>
 <f980d842-7995-61cf-ece2-36af67b626dc@grimberg.me>
Message-ID: <20171229094440.GB24043@lst.de>

On Mon, Dec 25, 2017@12:12:52PM +0200, Sagi Grimberg wrote:
>
>>> But that does bring up the fact if we should always be doing the
>>> nvme_process_cq(nvmeq) after IO submission. For direct/hipri IO,
>>> maybe it's better to make the submission path faster and skip it?
>>
>> Yes, I am okay to remove the opprotunistic nvme_process_cq in the
>> submission path. Even under deeply queued IO, I've not seen this provide
>> any measurable benefit.
>
> +100 for removing it. Never really understood why it gets us anything...

Yes, we should get rid of it.
