From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 08:45:31 -0700
Subject: Simplify block integrity registration v2
In-Reply-To: <20151021072245.GA12393@infradead.org>
References: <yq1fv16gtus.fsf@sermon.lab.mkp.net>
 <1445309132-31824-1-git-send-email-martin.petersen@oracle.com>
 <20151021072245.GA12393@infradead.org>
Message-ID: <CAPcyv4geMJXWjL6zhnCWyGA9QTz_7oyo898t8r__j39BaD=Ozw@mail.gmail.com>

On Wed, Oct 21, 2015@12:22 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Oct 19, 2015@10:45:27PM -0400, Martin K. Petersen wrote:
>> Changes since last version:
>>
>>  - Patch 2/5: Zero template to prevent problems on SCSI devices w/ ATO=0
>>  - Patch 5/5: Add Mike's SoB
>
> Can you post a series that also includes Dan series so that we have one
> coherent batch of both?

I could send out this branch that's rebased on Jens' latest for-4.4/drivers.

https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/log/?h=for-4.4/blk-integrity
