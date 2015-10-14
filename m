From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 14 Oct 2015 16:31:38 -0700
Subject: [PATCH 10/11] block: move blk_integrity to request_queue
In-Reply-To: <yq1si5djcq3.fsf@sermon.lab.mkp.net>
References: <20151014022757.34443.25800.stgit@dwillia2-desk3.jf.intel.com>
 <20151014022852.34443.87630.stgit@dwillia2-desk3.jf.intel.com>
 <yq1si5djcq3.fsf@sermon.lab.mkp.net>
Message-ID: <CAPcyv4hbTNy9j-TufuwYhwc70GfoALrPgq680jfx8fbau+jg9g@mail.gmail.com>

On Wed, Oct 14, 2015 at 3:40 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Dan" == Dan Williams <dan.j.williams at intel.com> writes:
>
> Dan> Given that a request_queue is pinned while i/o is in flight and
> Dan> that a gendisk is allowed to have a shorter lifetime, move
> Dan> blk_integrity to request_queue to satisfy requests arriving after
> Dan> the gendisk has been torn down.
>
> There was a really good reason why the integrity stuff was hanging off
> of gendisk but it's been so long that I can't remember what it was. And
> whatever it was, it is probably no longer valid.
>
> Do you have a git tree I can use to run my DIF/DIX qual on?

git://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm for-4.4/blk-integrity
